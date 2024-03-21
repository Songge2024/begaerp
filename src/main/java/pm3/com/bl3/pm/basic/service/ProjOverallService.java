package com.bl3.pm.basic.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.basic.dao.ProjOverallDao;
import com.bl3.pm.basic.dao.po.ModuleDividePO;
import com.bl3.pm.basic.dao.po.ProjOverallPO;
import com.bl3.pm.task.dao.po.TaskGroupPO;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSListUtils;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;
import aos.system.common.utils.SystemUtils;

@Service
public class ProjOverallService {
	private static Logger logger = LoggerFactory.getLogger(ProjOverallService.class);
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ProjOverallDao projOverallDao;
	public static Integer DEFAULT_ROOT_ID=0;
	
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id = "";
		String proj_name="";
		if(getDto.get("proj_id")!=null){
			proj_id = getDto.get("proj_id").toString();
		    proj_name= getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/process/projOverall/projOverall.jsp");
	}
	
	/**
	 * 统一保存
	 * 
	 * @param httpModel
	 */
	public void saveGrid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_user_id = httpModel.getUserModel().getId();
		List<Dto> modifies = inDto.getRows();
		if(modifies.isEmpty()){
			httpModel.setOutMsg("请先选择需保存的检查项!");
			return;
		}
		for (Dto dto : modifies) {
			dto.put("update_user_id", update_user_id);
			projOverallDao.saveGrid(dto);
			int group_id = dto.getInteger("group_id");
			Date plan_begin_time = dto.getDate("plan_begin_time");
			Date plan_end_time = dto.getDate("plan_end_time");
			List<Dto> parentId = sqlDao.list("com.bl3.pm.basic.dao.ProjOverallDao.selectParentId", group_id);
			for(Dto dtos : parentId){
				dtos.put("plan_begin_time", plan_begin_time);
				dtos.put("plan_end_time", plan_end_time);
				projOverallDao.saveCascade(dtos);
				int group_ids = dtos.getInteger("group_id");
				List<Dto> parentSecondId = sqlDao.list("com.bl3.pm.basic.dao.ProjOverallDao.selectParentId", group_ids);
				for(Dto dtoss : parentSecondId){
					dtoss.put("plan_begin_time", plan_begin_time);
					dtoss.put("plan_end_time", plan_end_time);
					projOverallDao.saveparentSecondId(dtoss);
				}
			}
			int parent_id = dto.getInteger("parent_id");
			//判断父节点是否为0
			if(parent_id == 0){
				return;
			}
			//查出父节点不为0 的上级集合
			List<Dto> groupID = sqlDao.list("com.bl3.pm.basic.dao.ProjOverallDao.selectGroupID", parent_id);
			//判断两者之间时间的大小
			for(Dto groupId : groupID){
				int parent_ids = groupId.getInteger("parent_id");
				if(parent_ids == 0){
					return;
				}
				Date group_plan_end_time = groupId.getDate("plan_end_time");
				if(plan_end_time.getTime() > group_plan_end_time.getTime()){
					groupId.put("plan_end_time", plan_end_time);
					projOverallDao.saveGrid(groupId);
				}
				List<Dto> groupIDs = sqlDao.list("com.bl3.pm.basic.dao.ProjOverallDao.selectGroupIDs", parent_ids);
				for(Dto groupIds : groupIDs){
					int parent_second_id = groupIds.getInteger("parent_id");
					if(parent_second_id == 0){
						return;
					}
					Date parent_plan_end_time = groupIds.getDate("plan_end_time");
					if(plan_end_time.getTime() > parent_plan_end_time.getTime()){
						if(plan_end_time.getTime() > group_plan_end_time.getTime()){
							groupIds.put("plan_end_time", plan_end_time);
							projOverallDao.saveGrid(groupIds);
						}
					}
				}
			}
		}
		httpModel.setOutMsg("保存成功");
	}
	
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		inDto.setOrder("sort_no");
		inDto.remove("group_id");
		List<ProjOverallPO> list = projOverallDao.list(inDto);
		List<ProjOverallPO> groups = AOSListUtils.select(list, ProjOverallPO.class, "SELECT * FROM :AOSList WHERE group_id != 0 and state !='1003'", null);
		List<TreeNode> nodesDtos = Lists.newArrayList();
		for (ProjOverallPO groupPO : groups) {
			int group_id = groupPO.getGroup_id();
			Dto queryDto=Dtos.newDto();
			//查询子任务
			List<ProjOverallPO> taskGroupList = getChildrenGroups(group_id);
			List<Integer> group_ids = new ArrayList<Integer>();
			for(ProjOverallPO taskGroupPO : taskGroupList){
				group_ids.add(taskGroupPO.getGroup_id());
			}
			//获取平均数
			queryDto.put("group_ids", group_ids);
			queryDto.put("proj_id", groupPO.getProj_id());
			Integer task_percent = (Integer)sqlDao.selectOne("com.bl3.pm.basic.dao.ProjOverallDao.getAVGGroupId", queryDto);
			TreeNode treeNode = new TreeNode();
			treeNode.setId("" + groupPO.getGroup_id());
			if(AOSUtils.isEmpty(groupPO.getPlan_begin_time())){
				treeNode.setText(groupPO.getGroup_name());
			}else{
				String text=groupPO.getGroup_name()+"("+AOSUtils.date2String(groupPO.getPlan_begin_time(),"yyyy/MM/dd")+"-"+AOSUtils.date2String(groupPO.getPlan_end_time(),"yyyy/MM/dd")+")";
				if(AOSUtils.isNotEmpty(task_percent)){
					treeNode.setText(text+"<span style='color:green;font-weight:bold;'>("+task_percent+"%)</span>");
				}else{
					treeNode.setText(text);
				}
			}
			treeNode.setParentId("" + groupPO.getParent_id());
			treeNode.setIcon(groupPO.getIcon_name());
			treeNode.setLeaf(StringUtils.equals(groupPO.getIs_leaf(), SystemCons.IS.YES) ? true : false);
			treeNode.setExpanded(StringUtils.equals(groupPO.getIs_auto_expand(), SystemCons.IS.YES) ? true : false);
			treeNode.setA(groupPO.getCascade_id());
			nodesDtos.add(treeNode);
		}
		// 所有项目默认parent_id=0
		TreeNode rootNode = new TreeNode();
		rootNode.setId(""+DEFAULT_ROOT_ID);
		Dto queryDto=Dtos.newDto();
		queryDto.put("proj_id", inDto.get("proj_id"));
		Integer task_percent = (Integer)sqlDao.selectOne("com.bl3.pm.basic.dao.ProjOverallDao.getAVGGroupId", queryDto);
		
		if(AOSUtils.isNotEmpty(task_percent)){
			rootNode.setText("WBS"+"<span style='color:green;font-weight:bold;'>("+task_percent+"%)</span>");
		}else{
			rootNode.setText("WBS");
		}
		
		rootNode.setLeaf(false);
		rootNode.setIcon("home.png");
		rootNode.setExpanded(true);
		SystemUtils.transTreeNodesToOne(nodesDtos, rootNode);
		httpModel.setOutMsg(AOSJson.toJson(rootNode));
	}
	
	/**
	 * 全部导出
	 * 
	 * @param group_id
	 * @return
	 */
	public void exportALLExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> dtos = sqlDao.list("com.bl3.pm.basic.dao.ProjOverallDao.exportALLExcel", inDto);
		//List<Dto> groups = AOSListUtils.select(dtos, Dto.class, "SELECT * FROM :AOSList WHERE group_id != 0 and state !='1003'", null);
		//List<Dto> overallPO = Lists.newArrayList();
		for(Dto dto : dtos){
			int group_id = dto.getInteger("group_id");
			Dto queryDto=Dtos.newDto();
			List<ProjOverallPO> projOverallList = getChildrenGroups(group_id);
			List<Integer> group_ids = new ArrayList<Integer>();
			for(ProjOverallPO projOveralPO : projOverallList){
				group_ids.add(projOveralPO.getGroup_id());
			}
			queryDto.put("group_ids", group_ids);
			queryDto.put("proj_id", dto.getString("proj_id"));
			Integer task_percent = (Integer)sqlDao.selectOne("com.bl3.pm.basic.dao.ProjOverallDao.getAVGGroupId", queryDto);
			//Dto projOverallPO = Dtos.newDto();
			dto.put("percent",task_percent);
			//projOverallPO.put("percent",task_percent);
			//overallPO.add(projOverallPO);
		}

		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();
		pDto.put("reportTitle", "项目总体情况");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/projOverall.xlsx");
		exporter.setFilename("项目总体情况.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	public List<ProjOverallPO> getChildrenGroups(Integer group_id){
		ProjOverallPO delPO = projOverallDao.selectByKey(group_id);
		if (AOSUtils.isEmpty(delPO)) {
			return null;
		}
		List<Integer> groupIdList = new ArrayList<Integer>();
		groupIdList.add(group_id);
		List<ProjOverallPO> taskGroupList = new ArrayList<ProjOverallPO>();
		taskGroupList.add(delPO);
		//获得当前分组及其子分组
		return findChildren(groupIdList, taskGroupList);
	}
	
	public List<ProjOverallPO> findChildren(List<Integer> parent_ids,List<ProjOverallPO> taskGroupList){
		Dto inDto = Dtos.newDto();
		inDto.put("parent_ids", parent_ids);
		List<ProjOverallPO> poList=projOverallDao.listChildrenByParentDto(inDto);
		List<Integer> groupList =projOverallDao.listChildrenByParentId(inDto);
		if (AOSUtils.isNotEmpty(groupList)) {
			taskGroupList.addAll(poList);
			return findChildren(groupList, taskGroupList);
		}else{
			return taskGroupList;
		}
	}
	
	/**
	 * 页面查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))){
			return;
		}
		List<ProjOverallPO> projOverallPOs = projOverallDao.likePage(inDto);
		List<ProjOverallPO> groups = AOSListUtils.select(projOverallPOs, ProjOverallPO.class, "SELECT * FROM :AOSList WHERE group_id != 0 and state !='1003'", null);
		List<ProjOverallPO> overallPO = Lists.newArrayList();
		for(ProjOverallPO groupPO : groups){
			int group_id = groupPO.getGroup_id();
			Dto queryDto=Dtos.newDto();
			List<ProjOverallPO> projOverallList = getChildrenGroups(group_id);
			List<Integer> group_ids = new ArrayList<Integer>();
			for(ProjOverallPO projOveralPO : projOverallList){
				group_ids.add(projOveralPO.getGroup_id());
			}
			queryDto.put("group_ids", group_ids);
			queryDto.put("proj_id", groupPO.getProj_id());
			Integer task_percent = (Integer)sqlDao.selectOne("com.bl3.pm.basic.dao.ProjOverallDao.getAVGGroupId", queryDto);
			ProjOverallPO projOverallPO = new ProjOverallPO();
			groupPO.setPercent(task_percent);
			projOverallPO.setPercent(task_percent);
			overallPO.add(projOverallPO);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(projOverallPOs, inDto.getPageTotal()));
	}
}
