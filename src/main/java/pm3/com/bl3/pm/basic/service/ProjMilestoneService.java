package com.bl3.pm.basic.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.model.UserModel;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.basic.dao.ProjMilestoneDao;
import com.bl3.pm.basic.dao.po.ProjMilestonePO;
import com.bl3.pm.process.dao.CheckMainDao;
import com.bl3.pm.task.dao.TaskDao;
import com.bl3.pm.task.dao.TaskGroupDao;
import com.bl3.pm.task.dao.po.TaskGroupPO;
import com.bl3.pm.task.service.TaskGroupService;
import com.bl3.pm.task.service.TaskService;
import com.google.common.collect.Lists;

/**
 * <b>bs_proj_milestone[bs_proj_milestone]业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-01-23 17:29:37
 */
 @Service
 public class ProjMilestoneService{
 	private static Logger logger = LoggerFactory.getLogger(ProjMilestoneService.class);
 	@Autowired
	private ProjMilestoneDao projMilestoneDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private CheckMainDao checkMainDao;
	@Autowired
	private IdService idService;
	@Autowired
	private TaskGroupService taskGroupService;
	@Autowired
	private TaskGroupDao taskGroupDao;
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskDao taskDao;
	/**
	 * 任务分组状态 （正常）
	 */
	public static String TASK_GROUP_STATE_NORMAL = "1001";
	public static Integer DEFAULT_ROOT_ID=0;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
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
		
		httpModel.setViewPath("pm3/basic/projMilestone/codes/projMilestone_layout.jsp");
	}
	/**
	 * 获取里程碑导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))){
			return;
		} 
		if (inDto.getString("type").equals("all")) {
			inDto.put("team_user_id", "");
		} else {
			String userid = httpModel.getUserModel().getId().toString();
			inDto.put("team_user_id", userid);
		}
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		if(list.size()==0){
			return;
		}
		// 获得排序号
		inDto.setOrder("sort_no");
		List<ProjMilestonePO> aosModulePOs = projMilestoneDao.list(inDto);
		//TreeNode treeSubNode = new TreeNode();
		List<Dto> modelDtos = Lists.newArrayList();
		for (ProjMilestonePO aosModulePO : aosModulePOs) {
			modelDtos.add(aosModulePO.toDto());
		}
		String treeJson = ProjMilestoneService.toTreeModalAsyncLoad(modelDtos);
		httpModel.setOutMsg(treeJson);
	}
	/**
	 * 将后台树结构转换为前端树模型 (异步加载)
	 * 
	 * @return
	 */
	public static String toTreeModalAsyncLoad(List<Dto> treeModels) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		for (Dto model : treeModels) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(model.getString("milest_code"));
			treeNode.setText(model.getString("milest_name"));
			String is_leaf_ = model.getString("is_leaf");
			treeNode.setLeaf(AOSCons.YES.equals(is_leaf_) ? true : false);
			treeNodes.add(treeNode);
		}
		return AOSJson.toJson(treeNodes);
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		ProjMilestonePO projMilestonePO=new ProjMilestonePO();
		projMilestonePO.setMilest_id(idService.nextValue("seq_bs_proj_milestone").intValue());
		projMilestonePO.copyProperties(inDto);
		projMilestoneDao.insert(projMilestonePO);
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 里程碑修改查询
	 * 
	 * @param httpModel
	 */
	public void queryEditMilestonData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		ProjMilestonePO projmilestonepo = new ProjMilestonePO();
		projmilestonepo.copyProperties(inDto);
		List<Dto>subDelList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.ChooseTreeProjData", inDto);
		if(subDelList.size()>0){
			for(Dto parentDto:subDelList){
				if(AOSUtils.isEmpty(parentDto.getString("group_id"))){
									
				}else{
					outDto.put("group_id", parentDto.getString("group_id"));
				}
				if(AOSUtils.isEmpty(parentDto.getString("plan_begin_date"))){
					
				}else{
					outDto.put("plan_begin_date", parentDto.getString("plan_begin_date").substring(0,10));
				}
				if(AOSUtils.isEmpty(parentDto.getString("plan_end_date"))){

				}else{
					outDto.put("plan_end_date", parentDto.getString("plan_end_date").substring(0,10));
				}
				if(AOSUtils.isEmpty(parentDto.getString("real_begin_date"))){
					outDto.put("real_begin_date", "");
				}else{
					outDto.put("real_begin_date", parentDto.getString("real_begin_date").substring(0,10));
				}
				if(AOSUtils.isEmpty(parentDto.getString("real_end_date"))){
					outDto.put("real_end_date", "");
				}else{
					outDto.put("real_end_date", parentDto.getString("real_end_date").substring(0,10));
				}
				if(AOSUtils.isEmpty(parentDto.getString("real_jobamount"))){
					
				}else{
					outDto.put("real_jobamount", parentDto.getString("real_jobamount"));
				}
				if(AOSUtils.isEmpty(parentDto.getString("plan_jobamount"))){
					
				}else{
					outDto.put("plan_jobamount", parentDto.getString("plan_jobamount"));
					
				}
				outDto.put("earned_value", parentDto.getString("earned_value"));
				outDto.put("plan_wastage", parentDto.getString("plan_wastage"));
				outDto.put("milest_id", parentDto.getString("milest_id"));
				outDto.put("milest_name", parentDto.getString("milest_name"));
				outDto.put("parent_id", parentDto.getString("parent_id"));
				outDto.put("is_leaf", parentDto.getString("is_leaf"));
				outDto.put("sort_no", parentDto.getString("sort_no"));
				outDto.put("type", parentDto.getString("type"));
				outDto.put("comment", parentDto.getString("comment"));
				outDto.put("create_user_id", parentDto.getString("create_user_id"));
				outDto.put("create_time", parentDto.getString("create_time"));
				outDto.put("update_user_id", parentDto.getString("update_user_id"));
				outDto.put("update_time", parentDto.getString("update_time"));
				outDto.put("state", parentDto.getString("state"));
			 }
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 查询名称
	 * @param httpModel
	 */
	public void queryMilestonName(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.queryMilestonName", inDto);
		outDto.put("milest_name", beginList.get(0).getString("milest_name"));
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 里程碑时间查询
	 * 
	 * @param httpModel
	 */
	public void queryMilestonData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		ProjMilestonePO projmilestonepo = new ProjMilestonePO();
		projmilestonepo.copyProperties(inDto);
		//项目启动时间
		List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.queryStarttime", inDto);
		//如果是第一级节点
		if(projmilestonepo.getMilest_code().equals("1")){
			outDto.put("plan_begin_date", beginList.get(0).getString("begin_time").substring(0,10));
			outDto.put("plan_end_date", beginList.get(0).getString("begin_time").substring(0,10));
		}
		//选中的节点
		List<Dto>subDelList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.ChooseTreeData", inDto);
		List<Dto>maxorderList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.queryMaxOrder", inDto);
		Integer sort_no=maxorderList.get(0).getInteger("sort_no");
		outDto.put("sort_no", sort_no);
		if(subDelList.size()>0){
			for(Dto parentDto:subDelList){
				outDto.put("plan_begin_date", parentDto.getString("plan_begin_date").substring(0,10));
				outDto.put("plan_end_date", parentDto.getString("plan_end_date").substring(0,10));
				outDto.put("plan_wastage", parentDto.getString("plan_wastage"));
				
			 }
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 项目周时间查询
	 * 
	 * @param httpModel
	 */
	public void queryTimeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		List<Dto>lcbList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryTimeData", inDto);
		if(lcbList.size()==0){
				List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryBegintime", inDto);
				Dto firstDto=beginList.get(0);
				//如果为第一级查项目启动时间，有就取表中时间
				inDto.put("begin_time", firstDto.getString("begin_time"));
				//查询是星期几
				List<Dto>wList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeektime", inDto);
				Dto wbdto=wList.get(0);
				List<Dto>sList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeekSaturday", inDto);
				Dto sdto=sList.get(0);
				if(wbdto.getInteger("w_day")>0&&wbdto.getInteger("w_day")<=6){
					outDto.put("plan_end_date", sdto.getString("saturday"));
				}else{
					outDto.put("plan_end_date", inDto.getString("begin_time").substring(0,10)+" 17:30:00");
				}
				outDto.put("plan_begin_date", inDto.getString("begin_time"));
			
		}else{
			for(Dto lcbDto:lcbList){
				List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryBegintime", inDto);
				Dto firstDto=beginList.get(0);
					if(lcbDto.getString("is_leaf").equals("1")){
							inDto.put("begin_time", lcbDto.getString("begin_date"));
					}else{
						//查询同级目录下从最大的时间开始
							inDto.put("begin_time", firstDto.getString("begin_time"));
						}
					//查询是星期几
					List<Dto>wList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeektime", inDto);
					Dto wbdto=wList.get(0);
					List<Dto>sList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeekSaturday", inDto);
					Dto sdto=sList.get(0);
					if(wbdto.getInteger("w_day")>0&&wbdto.getInteger("w_day")<=6){
						outDto.put("plan_end_date", sdto.getString("saturday"));
					}else{
						outDto.put("plan_end_date", inDto.getString("begin_time").substring(0,10)+" 17:30:00");
					}
					outDto.put("plan_begin_date", inDto.getString("begin_time"));
					if(lcbDto.getDate("plan_end_date").compareTo(outDto.getDate("end_date"))<0){
						outDto.put("plan_end_date", lcbDto.getString("end_date"));
					}else{
						continue;
					}
					
				}
			
		}
//		//查询天数
		List<Dto>wastList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWastDay", outDto);
		Dto tsdto=wastList.get(0);
		outDto.put("plan_wastage", tsdto.getInteger("plan_wastage"));
		if(outDto.getDate("plan_end_date").compareTo(outDto.getDate("plan_begin_date"))<0){
			httpModel.setOutMsg("不能超过该项目的计划周期范围");
			return;
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 保存里程碑树
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void saveProjMilestone(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		outDto.put("outMsg", false);
		inDto.put("plan_begin_date", inDto.getString("plan_begin_date")+" 08:30:00");
		inDto.put("plan_end_date", inDto.getString("plan_end_date")+" 17:30:00");
		ProjMilestonePO projmilestonepo = new ProjMilestonePO();
		projmilestonepo.copyProperties(inDto);
		//判断是否有重复的排序号
		List<Dto>orderList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.querySameOrderList", inDto);
		for(Dto orderDto :orderList){
			String sort_no=orderDto.getString("sort_no");
			if(sort_no.equals(inDto.get("sort_no"))){
				outDto.setAppMsg("存在相同的排序号，请重新填写!");
				outDto.setAppCode("0");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
			}
		}
		List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.queryStarttime", inDto);
		String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ProjMilestoneDao.getNextCode", inDto);
		Dto firstDto=beginList.get(0);
		//第一级开始时间要大于等于启动时间
			if(projmilestonepo.getPlan_begin_date().compareTo(firstDto.getDate("begin_time"))<0){
				outDto.setAppMsg("开始时间不能小于启动时间");
				outDto.setAppCode("0");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
		}
			
		List<ProjMilestonePO> subDelList = projMilestoneDao.like(Dtos.newDto("milest_code", projmilestonepo.getParent_id()));
		for(ProjMilestonePO parentPO:subDelList){
			if(projmilestonepo.getParent_id().equals("1")){
				continue;
			}
			List<Dto>uDto=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.selectParentData", parentPO);
				if(uDto.size()>0){
					if(projmilestonepo.getPlan_begin_date().compareTo(uDto.get(0).getDate("plan_begin_date"))<0){
						outDto.setAppMsg("开始时间不能小于上级节点的开始时间");
						outDto.setAppCode("0");
						httpModel.setOutMsg(AOSJson.toJson(outDto));
						return;
					}
					if(projmilestonepo.getPlan_end_date().compareTo(uDto.get(0).getDate("plan_end_date"))>0){
						outDto.setAppMsg("结束时间不能大于上级节点的结束时间");
						outDto.setAppCode("0");
						httpModel.setOutMsg(AOSJson.toJson(outDto));
						return;
					}
					if(projmilestonepo.getPlan_begin_date().compareTo(uDto.get(0).getDate("plan_end_date"))>0){
						outDto.setAppMsg("开始时间不能大于上级节点的结束时间");
						outDto.setAppCode("0");
						httpModel.setOutMsg(AOSJson.toJson(outDto));
						return;
					}
				}
			
		}
		Dto insertDto=Dtos.newDto();
		projmilestonepo.setState("1");
		UserModel userModel = httpModel.getUserModel();
		insertDto.put("user_id", userModel.getId());
		insertDto.put("group_from", 0);
		insertDto.put("state", TASK_GROUP_STATE_NORMAL);
		insertDto.put("sort_no", projmilestonepo.getSort_no());
		insertDto.put("proj_id", projmilestonepo.getProj_id());
		insertDto.put("plan_wastage", projmilestonepo.getPlan_wastage());
		insertDto.put("group_name", projmilestonepo.getMilest_name());
		insertDto.put("plan_begin_time", projmilestonepo.getPlan_begin_date());
		insertDto.put("plan_end_time", projmilestonepo.getPlan_end_date());
		Integer group_id = taskGroupService.create(insertDto);
		projmilestonepo.setGroup_id(group_id); 	            
		projmilestonepo.setMilest_code(max_code);
		projmilestonepo.setIs_leaf(SystemCons.IS.YES);
		projmilestonepo.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time = AOSUtils.getDateTime();
		projmilestonepo.setCreate_time(create_time);
		projMilestoneDao.insert(projmilestonepo);
		ProjMilestonePO updatePO = new ProjMilestonePO();
		updatePO.setMilest_code(projmilestonepo.getParent_id());
		updatePO.setIs_leaf(SystemCons.IS.NO);
		projMilestoneDao.updateByKey(updatePO);
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		outDto.put("token", token);
		outDto.put("milest_name", inDto.getString("milest_name"));
		 httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 结束里程碑
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateOver(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjMilestonePO projMilestonePO=new ProjMilestonePO();
		inDto.put("plan_begin_date", inDto.getString("plan_begin_date")+" 08:30:00");
		inDto.put("plan_end_date", inDto.getString("plan_end_date")+" 17:30:00");
		inDto.put("real_begin_date", inDto.getString("real_begin_date")+" 08:30:00");
		inDto.put("real_end_date", inDto.getString("real_end_date")+" 17:30:00");
		projMilestonePO.copyProperties(inDto);
		projMilestonePO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time = AOSUtils.getDateTime();
		projMilestonePO.setUpdate_time(update_time);
		projMilestonePO.setState("2");
		projMilestoneDao.updateByKey(projMilestonePO);
		httpModel.setOutMsg("结束成功");
	}
	
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("plan_begin_date", inDto.getString("plan_begin_date")+" 08:30:00");
		inDto.put("plan_end_date", inDto.getString("plan_end_date")+" 17:30:00");
		inDto.put("real_begin_date", inDto.getString("real_begin_date")+" 08:30:00");
		inDto.put("real_end_date", inDto.getString("real_end_date")+" 17:30:00");
		Dto outDto=Dtos.newDto();
		outDto.put("outMsg", false);
		ProjMilestonePO projMilestonePO=new ProjMilestonePO();
		projMilestonePO.copyProperties(inDto);
		//查询已存在重复的数据
		List<Dto>beforeList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.querybeforeSort", inDto);
		//判断传进来的是否有重复的排序号
		List<Dto>afterList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.querySameOrder", inDto);
		String bf_sort_no=beforeList.get(0).getString("sort_no");
		if(AOSUtils.isEmpty(afterList)){
			
		}else{
			String af_sort_no=afterList.get(0).getString("sort_no");
			if(!bf_sort_no.equals(inDto.getString("sort_no"))&&inDto.getString("sort_no").equals(af_sort_no)){
				outDto.setAppMsg("存在相同的排序号，请重新填写!");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
			}
		}
				
		List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.queryStarttime", inDto);
		Dto firstDto=beginList.get(0);
		//第一级开始时间要大于等于启动时间
		if(projMilestonePO.getPlan_begin_date().compareTo(firstDto.getDate("begin_time"))<0){
//			httpModel.setOutMsg("开始时间不能小于启动时间");
			outDto.setAppMsg("开始时间不能小于启动时间");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		List<ProjMilestonePO> subDelList = projMilestoneDao.like(Dtos.newDto("milest_code", projMilestonePO.getParent_id()));
		for(ProjMilestonePO parentPO:subDelList){
			List<Dto>uDto=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.selectParentData", parentPO);
			if(uDto.size()>0){
				if(projMilestonePO.getPlan_begin_date().compareTo(uDto.get(0).getDate("plan_begin_date"))<0){
//					httpModel.setOutMsg("开始时间不能小于上级节点的开始时间");
					outDto.setAppMsg("开始时间不能小于上级节点的开始时间");
					httpModel.setOutMsg(AOSJson.toJson(outDto));
					return;
				}
				if(projMilestonePO.getPlan_end_date().compareTo(uDto.get(0).getDate("plan_end_date"))>0){
//					httpModel.setOutMsg("结束时间不能大于上级节点的结束时间");
					outDto.setAppMsg("结束时间不能大于上级节点的结束时间");
					httpModel.setOutMsg(AOSJson.toJson(outDto));
					return;
				}
				if(projMilestonePO.getPlan_begin_date().compareTo(uDto.get(0).getDate("plan_end_date"))>0){
//					httpModel.setOutMsg("开始时间不能大于上级节点的结束时间");
					outDto.setAppMsg("开始时间不能大于上级节点的结束时间");
					httpModel.setOutMsg(AOSJson.toJson(outDto));
					return;
				}
			}
//			if(!projMilestonePO.getParent_id().equals("1")){
//			if(parentPO.getEnd_date().compareTo(projMilestonePO.getEnd_date())<0){
//				outDto.setAppMsg("结束时间不能超过计划范围");
//				httpModel.setOutMsg(AOSJson.toJson(outDto));
//				return;
//				}
//			}
		}
		List<ProjMilestonePO> leafList = projMilestoneDao.like(Dtos.newDto("milest_code", projMilestonePO.getMilest_code()));
		if(leafList.size()>1){
			if(projMilestonePO.getPlan_end_date().compareTo(leafList.get(0).getPlan_end_date())<0){
				outDto.setAppMsg("计划时间范围不能小于子节点");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
			}
		}
		projMilestonePO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time = AOSUtils.getDateTime();
		projMilestonePO.setUpdate_time(update_time);
		projMilestoneDao.updateByKey(projMilestonePO);
		
		Dto updateDto=Dtos.newDto();
		Dto taDto=Dtos.newDto();
		ProjMilestonePO upPO = projMilestoneDao.selectByKey(inDto.getString("id"));
		//查询是否存在该任务分组
		TaskGroupPO taPO = taskGroupDao.selectByKey(upPO.getGroup_id());
		
		//查询是否存在该任务分组下的任务数据
		taDto.put("group_id", projMilestonePO.getGroup_id());
		taDto.put("state", TASK_GROUP_STATE_NORMAL);
		if (AOSUtils.isNotEmpty(taPO)) {
			//启用时插入任务分组
			if(upPO.getState().equals("1")){
				UserModel userModel = httpModel.getUserModel();
				updateDto.put("user_id", userModel.getId());
				updateDto.put("group_from", 0);
				updateDto.put("state", TASK_GROUP_STATE_NORMAL);
				updateDto.put("proj_id", projMilestonePO.getProj_id());
				updateDto.put("plan_wastage", projMilestonePO.getPlan_wastage());
				updateDto.put("group_name", projMilestonePO.getMilest_name());
				updateDto.put("plan_begin_time", projMilestonePO.getPlan_begin_date());
				updateDto.put("plan_end_time", projMilestonePO.getPlan_end_date());
				updateDto.put("group_id", upPO.getGroup_id());
				updateDto.put("sort_no", projMilestonePO.getSort_no());
		        updateTask(updateDto);
			}
		}
		
		httpModel.setOutMsg("修改成功");
	}
	
	/**
	 * 修改任务节点
	 * 
	 * @param updateDto
	 */
	@Transactional
	public void updateTask(Dto updateDto) {
		TaskGroupPO taskGroupPO = new TaskGroupPO();
		taskGroupPO.copyProperties(updateDto);
		taskGroupDao.updateByKey(taskGroupPO);
	}
	/**
	 * 修改状态
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void updateState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto taDto=Dtos.newDto();
		Dto pDto=Dtos.newDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			ProjMilestonePO upPO = projMilestoneDao.selectByKey(String.valueOf(id));
			upPO.copyProperties(inDto);
			if (AOSUtils.isEmpty(upPO)) {
				continue;
			}
			List<ProjMilestonePO> subDelList = projMilestoneDao.likeCode(Dtos.newDto("milest_code", id));
			for (ProjMilestonePO subDelPO : subDelList) {
				if (upPO.getMilest_code().length() > 7 && upPO.getState().equals("1")) {
					List<ProjMilestonePO> pList = projMilestoneDao.list(
							(Dtos.newDto("milest_code", upPO.getMilest_code().substring(0, upPO.getMilest_code().length() - 3))));
					String p_state = pList.get(0).getState();
					if (p_state.equals("0")) {
						httpModel.setOutMsg("先启用父模块,才能启用子模块！");
						return;
					}
				}
				subDelPO.setState(inDto.getString("state"));
				Dto insertDto=Dtos.newDto();
				//查询是否存在该任务分组
				TaskGroupPO taPO = taskGroupDao.selectByKey(subDelPO.getGroup_id());
				//查询是否存在该任务分组下的任务数据
				taDto.put("group_id", subDelPO.getGroup_id());
				taDto.put("state", TASK_GROUP_STATE_NORMAL);
				if (AOSUtils.isEmpty(taPO)) {
					//启用时插入任务分组
					if(upPO.getState().equals("1")){
						List<Dto>uDto=sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.selectParentData", subDelPO);
						if(uDto.size()>0 && AOSUtils.isNotEmpty( uDto.get(0).get("group_id"))){
							insertDto.put("parent_id", uDto.get(0).get("group_id"));
						}
						UserModel userModel = httpModel.getUserModel();
						insertDto.put("user_id", userModel.getId());
						insertDto.put("group_from", 0);
						insertDto.put("state", TASK_GROUP_STATE_NORMAL);
						insertDto.put("proj_id", subDelPO.getProj_id());
						insertDto.put("plan_wastage", subDelPO.getPlan_wastage());
						insertDto.put("group_name", subDelPO.getMilest_name());
						insertDto.put("plan_begin_time", subDelPO.getPlan_begin_date());
						insertDto.put("plan_end_time", subDelPO.getPlan_end_date());
						ProjMilestonePO inPO = subDelPO;
						Integer group_id = taskGroupService.create(insertDto);
						inPO.setGroup_id(group_id); 
						inPO.setUpdate_user_id(httpModel.getUserModel().getId());
						Date update_time = AOSUtils.getDateTime();
						inPO.setUpdate_time(update_time);
						inPO.setState(inDto.getString("state"));
			            projMilestoneDao.updateByKey(inPO);
					}
				}
				
			}
		}
		httpModel.setOutMsg("启用成功");
	}
	
	/**
	 * 停用和删除无效的任务数据
	 * 
	 */
	public void updateStopState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			ProjMilestonePO upPO = projMilestoneDao.selectByKey(String.valueOf(id));
			if(upPO.getState().equals("0")){
				outDto.setAppCode("1");
				outDto.setAppMsg("请勿重复停用!");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
			}
			upPO.copyProperties(inDto);
				if (AOSUtils.isEmpty(upPO)) {
					continue;
				}
				
			List<ProjMilestonePO> subDelList = projMilestoneDao.like(Dtos.newDto("milest_code", id));
			for (ProjMilestonePO subDelPO : subDelList) {
				//查询是否存在该任务分组
				TaskGroupPO taPO = taskGroupDao.selectByKey(subDelPO.getGroup_id());
				//查询是否存在该任务分组下的任务数据
				Dto taDto=Dtos.newDto();
				taDto.put("group_id", subDelPO.getGroup_id());
				taDto.put("state", TASK_GROUP_STATE_NORMAL);
				//查询是否在任务分组下存在任务数据
				List<Dto> taskDto = sqlDao.list("com.bl3.pm.basic.dao.ProjMilestoneDao.selectTaskData", taDto);
							//存在无分支的任务数据可以删除
						if(AOSUtils.isNotEmpty(taPO)&&AOSUtils.isEmpty(taskDto)){
							if(subDelPO.getGroup_id().equals(taPO.getGroup_id())){
								sqlDao.delete("com.bl3.pm.basic.dao.ProjMilestoneDao.deleteTaGroup", subDelPO);
							}
						}else{
							outDto.setAppCode("0");
							outDto.setAppMsg("该节点存在详细任务数据,无法停用!");
							continue;
						}
						subDelPO.setState(inDto.getString("state"));
						projMilestoneDao.updateByKey(subDelPO);
			}
			ProjMilestonePO updatePo=new ProjMilestonePO();
			updatePo.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time = AOSUtils.getDateTime();
			updatePo.setUpdate_time(update_time);
			updatePo.setMilest_code(upPO.getMilest_code());
//			upPO.setState(inDto.getString("state"));
			projMilestoneDao.updateByKey(updatePo);
		}
		
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		ProjMilestonePO projmilestonepo = new ProjMilestonePO();
		projmilestonepo.copyProperties(inDto);
		
		String[] selectionIds = httpModel.getInDto().getRows();
		ProjMilestonePO aosPO = (ProjMilestonePO) sqlDao.selectOne(
				"com.bl3.pm.basic.dao.ProjMilestoneDao.checkRootNode",
				Dtos.newDto("ids", StringUtils.join(selectionIds, ",")));
		if (AOSUtils.isNotEmpty(aosPO)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，根节点[{0}]不能删除。", aosPO.getMilest_name()));
		} else {
			for (String id : selectionIds) {
				ProjMilestonePO delPO = projMilestoneDao.selectByKey(String.valueOf(id));
				if (AOSUtils.isEmpty(delPO)) {
					continue;
				}
				if(delPO.getState().equals("1")){
					outDto.setAppMsg("存在已启用的数据无法删除。");
					httpModel.setOutMsg(AOSJson.toJson(outDto));
					return;
				}else{
					inDto.put("milest_code", id);
					//根据code查check_Id
					List<Dto>dtolist=sqlDao.list("com.bl3.pm.process.dao.CheckMainDao.queryCheckData", inDto);
					if(dtolist.size()>0){
						for(Dto sdto : dtolist){
							checkMainDao.updateDeStateByKey(sdto.getInteger("check_id"));
							checkMainDao.deleteDetailByKey(sdto.getInteger("check_id"));
						}
						
					}
				}
				List<ProjMilestonePO> subDelList = projMilestoneDao.like(Dtos.newDto("milest_code", id));
				for (ProjMilestonePO subDelPO : subDelList) {
					subDelPO.setState(projmilestonepo.getState());
					projMilestoneDao.updateByKey(subDelPO);
				}
				// 更需父节点的是否叶子节点属性
				if (projMilestoneDao.rows(Dtos.newDto("parent_id", delPO.getParent_id())) == 0) {
					ProjMilestonePO updatePO = new ProjMilestonePO();
					updatePO.setMilest_code(delPO.getParent_id());
					updatePO.setIs_leaf(SystemCons.IS.YES);
					projMilestoneDao.updateByKey(updatePO);
				}

			}
			outDto.setAppMsg("成功删除里程碑数据。");
		}
	
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjMilestonePO projMilestonePO=projMilestoneDao.selectByKey(inDto.getString("id"));
		httpModel.setOutMsg(AOSJson.toJson(projMilestonePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if (inDto.getString("root").equals("true")) {
			inDto.put("milest_code", "");
		}
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		List<ProjMilestonePO> projMilestonePOs = projMilestoneDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projMilestonePOs, inDto.getPageTotal()));
	}
 }
