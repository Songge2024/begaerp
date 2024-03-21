package com.bl3.pm.queryanalysis.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.queryanalysis.dao.TaskWorkCompleteDao;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

@Service
public class TaskWorkCompleteService {
	private static Logger logger = LoggerFactory.getLogger(TaskWorkCompleteService.class);
	@Autowired
	private TaskWorkCompleteDao taskWorkCompleteDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		httpModel.setAttribute("update_task_time", dateString);
		Integer user_id = httpModel.getUserModel().getId();
        String principal_org_name = (String) sqlDao.selectOne("TaskWorkCompleteDao.principalOrgName", user_id);
        httpModel.setAttribute("principal_org_name", principal_org_name);
        int principal_org_id = (int) sqlDao.selectOne("TaskWorkCompleteDao.principalOrgID", user_id);
        httpModel.setAttribute("principal_org_id", principal_org_id);
		httpModel.setViewPath("pm3/queryanalysis/taskWorkComplete.jsp");
	}
	
	/**
	 * 获取部门导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TreeNode> treeNodes = Lists.newArrayList();
		List<Dto> orgSelectBox = sqlDao.list("TaskWorkCompleteDao.orgSelectBox", null);
		for (Dto dto : orgSelectBox) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getInteger("id").toString());
			treeNode.setText(dto.getString("name"));
			treeNode.setParentId(dto.getInteger("parent_id").toString());
			treeNode.setIcon(dto.getString("icon_name"));
			//这个决定是否在节点上初选复选框，true为初始选中
			treeNode.setChecked(false);
			treeNode.setLeaf(StringUtils.equals(dto.getString("is_leaf"), SystemCons.IS.YES) ? true : false );
			treeNode.setExpanded(StringUtils.equals(dto.getString("is_auto_expand"), SystemCons.IS.YES) ? true : false );
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	public void exportALLExcel(HttpModel httpModel) throws ParseException {
		Dto inDto = httpModel.getInDto();
		String subordinate_departments_id = inDto.getString("subordinate_departments_id");
		if(AOSUtils.isNotEmpty(subordinate_departments_id)) {
			List<String> subordinate_departments_idList = Arrays.asList(subordinate_departments_id.split(","));
			inDto.put("subordinate_departments_id", subordinate_departments_idList);
		}
		String taskUpdateTime = inDto.getString("update_task_time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		Date dt = sdf.parse(taskUpdateTime);  
		
		//判断当前日期是否为周一
		Calendar cal=Calendar.getInstance();
		cal.setTime(dt); 
		int week=cal.get(Calendar.DAY_OF_WEEK)-1;
		//当前日期为周一时
		if(week == 1) {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -3);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		} 
		//当前日期为周日
		else if(week == 0) {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -2);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		}
		//其他时间
		else {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -1);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		}
		List<Dto> dtos = sqlDao.list("TaskWorkCompleteDao.exportALLExcel", inDto);
		for(int k=0;k<dtos.size();k++){
			Dto faPO = dtos.get(k);
			//判断任务更新状态
			if(Integer.valueOf(faPO.get("ygx_num").toString()) == 1 ) {
				faPO.put("ygx_num", "已更新");
			}else if(Integer.valueOf(faPO.get("ygx_num").toString()) ==0 ) {
				faPO.put("ygx_num", "未更新");
			}else {
				faPO.put("ygx_num", "未更新");
			}
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "任务更新情况");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/taskWorkComplete.xlsx");
		exporter.setFilename("任务更新情况.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	/**
	 * 分页查询
	 * @param httpModel
	 * @throws ParseException
	 */
	public void page(HttpModel httpModel) throws ParseException {
		Dto inDto = httpModel.getInDto();
		String subordinate_departments_id = inDto.getString("subordinate_departments_id");
		if(AOSUtils.isNotEmpty(subordinate_departments_id)) {
			List<String> subordinate_departments_idList = Arrays.asList(subordinate_departments_id.split(","));
			inDto.put("subordinate_departments_id", subordinate_departments_idList);
		}
		
		String taskUpdateTime = inDto.getString("update_task_time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		Date dt = sdf.parse(taskUpdateTime);  
		
		//判断当前日期是否为周一
		Calendar cal=Calendar.getInstance();
		cal.setTime(dt); 
		int week=cal.get(Calendar.DAY_OF_WEEK)-1;
		//当前日期为周一时
		if(week == 1) {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -3);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		} 
		//当前日期为周日
		else if(week == 0) {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -2);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		}
		//其他时间
		else {
			Calendar rightNow = Calendar.getInstance();  
			rightNow.setTime(dt);  
			rightNow.add(Calendar.DAY_OF_MONTH, -1);  
			Date dt1 = rightNow.getTime();  
			String reStr = sdf.format(dt1); 
			inDto.put("yesterDate", reStr);
		}

		List<Dto> taskWorkloadReportList = sqlDao.list("TaskWorkCompleteDao.taskWorkloadReportListPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskWorkloadReportList));
	}
}
