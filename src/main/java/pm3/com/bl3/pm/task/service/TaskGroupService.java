 package com.bl3.pm.task.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bl3.pm.task.dao.TaskGroupDao;
import com.bl3.pm.task.dao.po.TaskGroupPO;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSListUtils;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.model.UserModel;
import aos.system.common.utils.SystemCons;
import aos.system.common.utils.SystemUtils;

/**
 * <b>ta_task_group[ta_task_group]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2017-12-11 15:35:41
 */
@Service
public class TaskGroupService {
	private static Logger logger = LoggerFactory.getLogger(TaskGroupService.class);
	@Autowired
	private TaskGroupDao taskGroupDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	TaskService taskService;
	@Autowired
	private IdService idService;
	public static Integer DEFAULT_ROOT_ID=0;
	/**
	 * 任务分组状态 （正常）
	 */
	public static String TASK_GROUP_STATE_NORMAL = "1001";
	/**
	 * 任务分组状态 （锁定）
	 */
	public static String TASK_GROUP_STATE_LOCKED = "1002";
	/**
	 * 任务分组状态 （删除）
	 */
	public static String TASK_GROUP_STATE_DELETE = "1003";

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/task/taskGroup_list.jsp");
	}
	/**
	 * 创建分组
	 * @param insertDto
	 * @return
	 */
	@Transactional
	public Integer create(Dto insertDto){
		TaskGroupPO taskGroupPO = new TaskGroupPO();
		taskGroupPO.copyProperties(insertDto);
		Integer group_id=idService.nextValue("seq_ta_task_group").intValue();
		taskGroupPO.setGroup_id(group_id);
		// 默认分组父节点编码为0
		Integer parent_id = AOSUtils.isEmpty(taskGroupPO.getParent_id()) ? DEFAULT_ROOT_ID : taskGroupPO.getParent_id();
		// 获得父类相关信息
		TaskGroupPO parentGroupPO = taskGroupDao.selectByKey(parent_id);
		Dto queryDto=Dtos.newDto();
		queryDto.put("parent_id", parent_id);
		queryDto.put("proj_id", insertDto.get("proj_id"));
		String max_cascade_id = (String) sqlDao.selectOne("TaskGroup.getMaxCascadeId", queryDto);
		if (AOSUtils.isEmpty(max_cascade_id)) {
			String temp = ""+DEFAULT_ROOT_ID;
			if (AOSUtils.isNotEmpty(parentGroupPO)) {
				temp = parentGroupPO.getCascade_id();
			}
			max_cascade_id = temp + ".000";
		}
		//新增分组
		String cascade_id = SystemUtils.genCascadeTreeId(max_cascade_id, 999);
		taskGroupPO.setCascade_id(cascade_id);
		taskGroupPO.setParent_id(parent_id);
		taskGroupPO.setIs_leaf(SystemCons.IS.YES);
		taskGroupPO.setCreate_user_id(insertDto.getInteger("user_id"));
		taskGroupPO.setPlan_wastage(insertDto.getBigDecimal("plan_wastage"));
		taskGroupPO.setCreate_time(AOSUtils.getDateTime());
		taskGroupPO.setState(insertDto.getString("state"));
		taskGroupPO.setGroup_from(insertDto.getInteger("group_from"));
		taskGroupPO.setIs_auto_expand(SystemCons.IS.YES);
		taskGroupPO.setProj_id(insertDto.containsKey("proj_id") ? insertDto.getString("proj_id") : parentGroupPO.getProj_id());
		taskGroupPO.setModule_id(insertDto.containsKey("module_id") ? insertDto.getString("module_id") : parentGroupPO.getModule_id());
		taskGroupPO.setDemand_id(insertDto.containsKey("demand_id") ? insertDto.getString("demand_id") : parentGroupPO.getDemand_id());
		taskGroupDao.insert(taskGroupPO);
		//修改父类节点为枝节点
		parentGroupPO.setIs_leaf(SystemCons.IS.NO);
		parentGroupPO.setIs_auto_expand(SystemCons.IS.YES);
		parentGroupPO.setUpdate_time(AOSUtils.getDateTime());
		parentGroupPO.setUpdate_user_id(insertDto.getInteger("user_id"));
		taskGroupDao.updateByKey(parentGroupPO);
		return group_id;
	}
	/**
	 * 根据分组编码获得当前分组及其子分组
	 * @param group_id
	 * @return
	 */
	public List<TaskGroupPO> getChildrenGroups(Integer group_id){
		TaskGroupPO delPO = taskGroupDao.selectByKey(group_id);
		if (AOSUtils.isEmpty(delPO)) {
			return null;
		}
		List<Integer> groupIdList = new ArrayList<Integer>();
		groupIdList.add(group_id);
		List<TaskGroupPO> taskGroupList = new ArrayList<TaskGroupPO>();
		taskGroupList.add(delPO);
		//获得当前分组及其子分组
		return findChildren(groupIdList, taskGroupList);
		//return taskGroupDao.like(Dtos.newDto("cascade_id", delPO.getCascade_id()));
		
	}
	
	public List<TaskGroupPO> findChildren(List<Integer> parent_ids,List<TaskGroupPO> taskGroupList){
		Dto inDto = Dtos.newDto();
		inDto.put("parent_ids", parent_ids);
		List<TaskGroupPO> poList=taskGroupDao.listChildrenByParentDto(inDto);
		List<Integer> groupList =taskGroupDao.listChildrenByParentId(inDto);
		if (AOSUtils.isNotEmpty(groupList)) {
			taskGroupList.addAll(poList);
			return findChildren(groupList, taskGroupList);
		}else{
			return taskGroupList;
		}
	}
	
	/**
	 * 删除分组
	 * @param user_id
	 * @param group_id
	 * @return
	 */
	public Dto delete(Integer user_id,Integer group_id){
		Dto outDto=Dtos.newOutDto();

		 List<TaskGroupPO> childrenGroupList=getChildrenGroups(group_id);
		 if (AOSUtils.isEmpty(childrenGroupList)) {
				outDto.setAppCode(AOSCons.ERROR);
				outDto.setAppMsg(AOSUtils.merge("操作失败，分组不存在。"));
				return outDto;
		}
		String[] group_ids=AOSListUtils.selectPropValues(childrenGroupList, "group_id", false);
		//删除分组下所有任务
		outDto=taskService.deleteByGroup(user_id, group_ids);
		if(outDto.getAppCode().equals(AOSCons.ERROR)){
			return outDto;
		}
		for (TaskGroupPO childrenGroupPO : childrenGroupList) {
			// 逻辑删除分组
			childrenGroupPO.setState(TASK_GROUP_STATE_DELETE);;
			childrenGroupPO.setUpdate_time(AOSUtils.getDateTime());
			childrenGroupPO.setUpdate_user_id(user_id);
			taskGroupDao.updateByKey(childrenGroupPO);
		}
		outDto.setAppMsg("删除分组成功");
		return outDto;
	}
	/**
	 * 根据分组获得任务
	 * @param group_id
	 * @return
	 */
	public TaskGroupPO get(Integer group_id){
		return taskGroupDao.selectByKey(group_id);
	}
	/**
	 * 根据分组获得任务
	 * @param group_id
	 * @return
	 */
	public TaskGroupPO selectOne(Dto queryDto){
		return taskGroupDao.selectOne(queryDto);
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void create(HttpModel httpModel) {
		UserModel userModel = httpModel.getUserModel();
		Dto inDto = httpModel.getInDto();
		inDto.put("user_id", userModel.getId());
		inDto.put("group_from", 0);
		inDto.put("state", TASK_GROUP_STATE_NORMAL);
		create(inDto);
		httpModel.setOutMsg("新增成功");
	}

	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TaskGroupPO taskGroupPO = new TaskGroupPO();
		taskGroupPO.copyProperties(inDto);
		taskGroupDao.updateByKey(taskGroupPO);
		httpModel.setOutMsg("修改成功");
	}

	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void delete(HttpModel httpModel) {
		UserModel userModel = httpModel.getUserModel();
		Dto outDto = Dtos.newOutDto();
		String[] taskGroup_ids = httpModel.getInDto().getRows();
		for (String group_id : taskGroup_ids) {
			if(Integer.valueOf(group_id)!=DEFAULT_ROOT_ID){
				outDto=delete(userModel.getId(), Integer.valueOf(group_id));
				if(!outDto.getAppCode().equals(AOSCons.SUCCESS)){
					break;
				}
			}
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 导入
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		try{
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if(!isMultipart){
				return;
			}
			try{
				MultipartHttpServletRequest multipartRequest = null;
				if(httpModel.getRequest() instanceof MultipartHttpServletRequest){
					try{
						multipartRequest=(MultipartHttpServletRequest) httpModel.getRequest();
					}catch(Exception ex){
						ex.getMessage();
					}
				}
				if(multipartRequest!=null){
					Map<String,MultipartFile> fileMap =multipartRequest.getFileMap();
					for(Map.Entry<String,MultipartFile> entity:fileMap.entrySet()){
						//得到上传的文件
						MultipartFile myfile=entity.getValue();
						//创建字段名
						String metaData = "firstName,secondName,thirdName,fourthName,plan_begin_time,plan_end_time";
						//HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						int id = inDto.getInteger("id");
							//读取当前excel的sheet数量
							int number = workbook.getNumberOfSheets();
							int i = 0;
							while (i<number) {
								ExcelReader excelReader = new ExcelReader(metaData,myfile.getInputStream());
								List<Dto> exclelist = excelReader.read(1,0,i);
								List<Dto> oneTaskGroup = new ArrayList<Dto>();
								List<Dto> twoTaskGroup = new ArrayList<Dto>();
								List<Dto> threeTaskGroup = new ArrayList<Dto>();
								List<Dto> fourTaskGroup = new ArrayList<Dto>();
								//对所有数据进行分类
								for(Dto dto : exclelist){
									if(AOSUtils.isEmpty(dto.getString("secondName"))&&AOSUtils.isEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
										oneTaskGroup.add(dto);
									}else if(AOSUtils.isNotEmpty(dto.getString("secondName")) && AOSUtils.isEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
										twoTaskGroup.add(dto);
									}else if(AOSUtils.isNotEmpty(dto.getString("secondName")) && AOSUtils.isNotEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
										threeTaskGroup.add(dto);
									}else{
										fourTaskGroup.add(dto);
									}
								}
								//对一级数据进行新增
								for(Dto dto : oneTaskGroup){
									TaskGroupPO taskGroupPO = new TaskGroupPO();
									//转换时间戳
									SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
									String plan_begin_time = dto.getString("plan_begin_time");
									double begin = Double.parseDouble(plan_begin_time);
									Date date_begin = HSSFDateUtil.getJavaDate(begin);
									plan_begin_time = sdf.format(date_begin);
									dto.put("plan_begin_time", plan_begin_time);
									String plan_end_time = dto.getString("plan_end_time");
									double end = Double.parseDouble(plan_end_time);
									Date date_end = HSSFDateUtil.getJavaDate(end);
									plan_end_time = sdf.format(date_end);
									dto.put("plan_end_time", plan_end_time);
									
									Dto queryDto=Dtos.newDto();
									
									//Integer parent_id = taskGroupDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
									Integer parent_id = inDto.getInteger("id");
									// 获得父类相关信息
									TaskGroupPO parentGroupPO = taskGroupDao.selectByFirstName(dto.getString("firstName"),inDto.getString("proj_id"));
									taskGroupPO.copyProperties(dto);
									queryDto.put("parent_id", parent_id);
									queryDto.put("proj_id", inDto.get("proj_id"));
									String max_cascade_id = (String) sqlDao.selectOne("TaskGroup.getMaxCascadeId", queryDto);
									if (AOSUtils.isEmpty(max_cascade_id)) {
										String temp = ""+DEFAULT_ROOT_ID;
										if (AOSUtils.isNotEmpty(parentGroupPO)) {
											temp = parentGroupPO.getCascade_id();
										}
										max_cascade_id = temp + ".000";
									}
									//新增分组
									String cascade_id = SystemUtils.genCascadeTreeId(max_cascade_id, 999);
									Integer group_id=idService.nextValue("seq_ta_task_group").intValue();
									taskGroupPO.setGroup_id(group_id);
									taskGroupPO.setGroup_name(dto.getString("firstName"));
									taskGroupPO.setCreate_time(new Date());
									taskGroupPO.setCreate_user_id(user_id);
									taskGroupPO.setGroup_from(0);
									taskGroupPO.setState(TASK_GROUP_STATE_NORMAL);
									taskGroupPO.setProj_id(inDto.getString("proj_id"));
									taskGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									taskGroupPO.setParent_id(parent_id);
									taskGroupPO.setCascade_id(cascade_id);
									taskGroupPO.setIs_leaf(SystemCons.IS.YES);
									List<Date> lDate = findDates(dto.getDate("plan_begin_time"),dto.getDate("plan_end_time"));
									int plan_wastage = lDate.size();
									taskGroupPO.setPlan_wastage(BigDecimal.valueOf(plan_wastage));
									taskGroupDao.insert(taskGroupPO);
								}
								//对二级数据进行新增
								for(Dto dto : twoTaskGroup){
									TaskGroupPO taskGroupPO = new TaskGroupPO();
									//转换时间戳
									SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
									String plan_begin_time = dto.getString("plan_begin_time");
									double begin = Double.parseDouble(plan_begin_time);
									Date date_begin = HSSFDateUtil.getJavaDate(begin);
									plan_begin_time = sdf.format(date_begin);
									dto.put("plan_begin_time", plan_begin_time);
									String plan_end_time = dto.getString("plan_end_time");
									double end = Double.parseDouble(plan_end_time);
									Date date_end = HSSFDateUtil.getJavaDate(end);
									plan_end_time = sdf.format(date_end);
									dto.put("plan_end_time", plan_end_time);
									
									Dto queryDto=Dtos.newDto();
									
									Integer parent_id = taskGroupDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
									// 获得父类相关信息
									TaskGroupPO parentGroupPO = taskGroupDao.selectByFirstName(dto.getString("firstName"),inDto.getString("proj_id"));
									taskGroupPO.copyProperties(dto);
									queryDto.put("parent_id", parent_id);
									queryDto.put("proj_id", inDto.get("proj_id"));
									String max_cascade_id = (String) sqlDao.selectOne("TaskGroup.getMaxCascadeId", queryDto);
									if (AOSUtils.isEmpty(max_cascade_id)) {
										String temp = ""+DEFAULT_ROOT_ID;
										if (AOSUtils.isNotEmpty(parentGroupPO)) {
											temp = parentGroupPO.getCascade_id();
										}
										max_cascade_id = temp + ".000";
									}
									//新增分组
									String cascade_id = SystemUtils.genCascadeTreeId(max_cascade_id, 999);
									Integer group_id=idService.nextValue("seq_ta_task_group").intValue();
									taskGroupPO.setGroup_id(group_id);
									taskGroupPO.setGroup_name(dto.getString("secondName"));
									taskGroupPO.setCreate_time(new Date());
									taskGroupPO.setCreate_user_id(user_id);
									taskGroupPO.setGroup_from(0);
									taskGroupPO.setState(TASK_GROUP_STATE_NORMAL);
									taskGroupPO.setProj_id(inDto.getString("proj_id"));
									taskGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									taskGroupPO.setParent_id(parent_id);
									taskGroupPO.setCascade_id(cascade_id);
									taskGroupPO.setIs_leaf(SystemCons.IS.YES);
									List<Date> lDate = findDates(dto.getDate("plan_begin_time"),dto.getDate("plan_end_time"));
									int plan_wastage = lDate.size();
									taskGroupPO.setPlan_wastage(BigDecimal.valueOf(plan_wastage));
									taskGroupDao.insert(taskGroupPO);
									//修改父类节点为枝节点
									parentGroupPO.setIs_leaf(SystemCons.IS.NO);
									parentGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									parentGroupPO.setUpdate_time(new Date());
									parentGroupPO.setUpdate_user_id(user_id);
									taskGroupDao.updateByKey(parentGroupPO);
								}
								//对三级数据进行新增
								for(Dto dto : threeTaskGroup){
									TaskGroupPO taskGroupPO = new TaskGroupPO();
									//转换时间戳
									SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
									String plan_begin_time = dto.getString("plan_begin_time");
									double begin = Double.parseDouble(plan_begin_time);
									Date date_begin = HSSFDateUtil.getJavaDate(begin);
									plan_begin_time = sdf.format(date_begin);
									dto.put("plan_begin_time", plan_begin_time);
									String plan_end_time = dto.getString("plan_end_time");
									double end = Double.parseDouble(plan_end_time);
									Date date_end = HSSFDateUtil.getJavaDate(end);
									plan_end_time = sdf.format(date_end);
									dto.put("plan_end_time", plan_end_time);
									
									Dto queryDto=Dtos.newDto();
									Integer first_id = taskGroupDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
									Integer parent_id = taskGroupDao.selectSecond_id(first_id, dto.getString("secondName"));
									// 获得父类相关信息
									TaskGroupPO parentGroupPO = taskGroupDao.selectByKey(parent_id);
									taskGroupPO.copyProperties(dto);
									queryDto.put("parent_id", parent_id);
									queryDto.put("proj_id", inDto.get("proj_id"));
									String max_cascade_id = (String) sqlDao.selectOne("TaskGroup.getMaxCascadeId", queryDto);
									if (AOSUtils.isEmpty(max_cascade_id)) {
										String temp = ""+DEFAULT_ROOT_ID;
										if (AOSUtils.isNotEmpty(parentGroupPO)) {
											temp = parentGroupPO.getCascade_id();
										}
										max_cascade_id = temp + ".000";
									}
									//新增分组
									String cascade_id = SystemUtils.genCascadeTreeId(max_cascade_id, 999);
									Integer group_id=idService.nextValue("seq_ta_task_group").intValue();
									taskGroupPO.setGroup_id(group_id);
									taskGroupPO.setGroup_name(dto.getString("thirdName"));
									taskGroupPO.setCreate_time(new Date());
									taskGroupPO.setCreate_user_id(user_id);
									taskGroupPO.setGroup_from(0);
									taskGroupPO.setState(TASK_GROUP_STATE_NORMAL);
									taskGroupPO.setProj_id(inDto.getString("proj_id"));
									taskGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									taskGroupPO.setParent_id(parent_id);
									taskGroupPO.setCascade_id(cascade_id);
									taskGroupPO.setIs_leaf(SystemCons.IS.YES);
									List<Date> lDate = findDates(dto.getDate("plan_begin_time"),dto.getDate("plan_end_time"));
									int plan_wastage = lDate.size();
									taskGroupPO.setPlan_wastage(BigDecimal.valueOf(plan_wastage));
									taskGroupDao.insert(taskGroupPO);
									//修改父类节点为枝节点
									parentGroupPO.setIs_leaf(SystemCons.IS.NO);
									parentGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									parentGroupPO.setUpdate_time(new Date());
									parentGroupPO.setUpdate_user_id(user_id);
									taskGroupDao.updateByKey(parentGroupPO);
								}
								//对四级数据进行新增
								for(Dto dto : fourTaskGroup){
									TaskGroupPO taskGroupPO = new TaskGroupPO();
									//转换时间戳
									SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
									String plan_begin_time = dto.getString("plan_begin_time");
									double begin = Double.parseDouble(plan_begin_time);
									Date date_begin = HSSFDateUtil.getJavaDate(begin);
									plan_begin_time = sdf.format(date_begin);
									dto.put("plan_begin_time", plan_begin_time);
									String plan_end_time = dto.getString("plan_end_time");
									double end = Double.parseDouble(plan_end_time);
									Date date_end = HSSFDateUtil.getJavaDate(end);
									plan_end_time = sdf.format(date_end);
									dto.put("plan_end_time", plan_end_time);
									
									Dto queryDto=Dtos.newDto();
									Integer first_id = taskGroupDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
									Integer second_id = taskGroupDao.selectSecond_id(first_id,dto.getString("secondName"));
									Integer parent_id = taskGroupDao.selectSecond_id(second_id, dto.getString("thirdName"));
									// 获得父类相关信息
									TaskGroupPO parentGroupPO = taskGroupDao.selectByKey(parent_id);
									taskGroupPO.copyProperties(dto);
									queryDto.put("parent_id", parent_id);
									queryDto.put("proj_id", inDto.get("proj_id"));
									String max_cascade_id = (String) sqlDao.selectOne("TaskGroup.getMaxCascadeId", queryDto);
									if (AOSUtils.isEmpty(max_cascade_id)) {
										String temp = ""+DEFAULT_ROOT_ID;
										if (AOSUtils.isNotEmpty(parentGroupPO)) {
											temp = parentGroupPO.getCascade_id();
										}
										max_cascade_id = temp + ".000";
									}
									//新增分组
									String cascade_id = SystemUtils.genCascadeTreeId(max_cascade_id, 999);
									Integer group_id=idService.nextValue("seq_ta_task_group").intValue();
									taskGroupPO.setGroup_id(group_id);
									taskGroupPO.setGroup_name(dto.getString("fourthName"));
									taskGroupPO.setCreate_time(new Date());
									taskGroupPO.setCreate_user_id(user_id);
									taskGroupPO.setGroup_from(0);
									taskGroupPO.setState(TASK_GROUP_STATE_NORMAL);
									taskGroupPO.setProj_id(inDto.getString("proj_id"));
									taskGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									taskGroupPO.setParent_id(parent_id);
									taskGroupPO.setCascade_id(cascade_id);
									taskGroupPO.setIs_leaf(SystemCons.IS.YES);
									List<Date> lDate = findDates(dto.getDate("plan_begin_time"),dto.getDate("plan_end_time"));
									int plan_wastage = lDate.size();
									taskGroupPO.setPlan_wastage(BigDecimal.valueOf(plan_wastage));
									taskGroupDao.insert(taskGroupPO);
									//修改父类节点为枝节点
									parentGroupPO.setIs_leaf(SystemCons.IS.NO);
									parentGroupPO.setIs_auto_expand(SystemCons.IS.YES);
									parentGroupPO.setUpdate_time(new Date());
									parentGroupPO.setUpdate_user_id(user_id);
									taskGroupDao.updateByKey(parentGroupPO);
								}
								i++;
							}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}catch (Exception e) {
			//message= "导入失败！";
			e.printStackTrace();
		}
		String message="{success:true,msg:'导入成功！'}";
		httpModel.setOutMsg(message);
	}
	/**
	 * 查询自定义下拉组件数据 (项目经理工作台任务节点)
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto>list=sqlDao.list("com.bl3.pm.task.dao.TaskGroupDao.listComboBoxData", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 根据任务分组树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		inDto.setOrder("sort_no");
		inDto.remove("group_id");
		List<TaskGroupPO> list = taskGroupDao.list(inDto);
		List<TaskGroupPO> groups = AOSListUtils.select(list, TaskGroupPO.class, "SELECT * FROM :AOSList WHERE group_id != 0 and state !='1003'", null);
		List<TreeNode> nodesDtos = Lists.newArrayList();
		for (TaskGroupPO groupPO : groups) {
			int group_id = groupPO.getGroup_id();
			Dto queryDto=Dtos.newDto();
			//查询子任务
			List<TaskGroupPO> taskGroupList = getChildrenGroups(group_id);
			List<Integer> group_ids = new ArrayList<Integer>();
			for(TaskGroupPO taskGroupPO : taskGroupList){
				group_ids.add(taskGroupPO.getGroup_id());
			}
			//获取平均数
			queryDto.put("group_ids", group_ids);
			queryDto.put("proj_id", groupPO.getProj_id());
			Integer task_percent = (Integer)sqlDao.selectOne("Task.getAVGGroupId", queryDto);
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
		Integer task_percent = (Integer)sqlDao.selectOne("Task.getAVGGroupId", queryDto);
		
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
	 * 根据任务分组树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void treeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		inDto.setOrder("sort_no");
		inDto.remove("group_id");
		List<TaskGroupPO> list = taskGroupDao.list(inDto);
		List<TaskGroupPO> groups = AOSListUtils.select(list, TaskGroupPO.class, "SELECT * FROM :AOSList WHERE group_id != 0 and state !='1003'", null);
		List<TreeNode> nodesDtos = Lists.newArrayList();
		for (TaskGroupPO groupPO : groups) {
			int group_id = groupPO.getGroup_id();
			Dto queryDto=Dtos.newDto();
			//查询子任务
			List<TaskGroupPO> taskGroupList = getChildrenGroups(group_id);
			List<Integer> group_ids = new ArrayList<Integer>();
			for(TaskGroupPO taskGroupPO : taskGroupList){
				group_ids.add(taskGroupPO.getGroup_id());
			}
			//获取平均数
			queryDto.put("group_ids", group_ids);
			queryDto.put("proj_id", groupPO.getProj_id());
			Integer task_percent = (Integer)sqlDao.selectOne("Task.getAVGGroupId", queryDto);
			TreeNode treeNode = new TreeNode();
			treeNode.setId("" + groupPO.getGroup_id());
			treeNode.setText(groupPO.getGroup_name());
			treeNode.setParentId("" + groupPO.getParent_id());
			treeNode.setIcon(groupPO.getIcon_name());
			treeNode.setLeaf(StringUtils.equals(groupPO.getIs_leaf(), SystemCons.IS.YES) ? true : false);
			treeNode.setExpanded(StringUtils.equals(groupPO.getIs_auto_expand(), SystemCons.IS.NO) ? true : false);
			treeNode.setA(groupPO.getCascade_id());
			nodesDtos.add(treeNode);
		}
		// 所有项目默认parent_id=0
		TreeNode rootNode = new TreeNode();
		rootNode.setId(""+DEFAULT_ROOT_ID);
		Dto queryDto=Dtos.newDto();
		queryDto.put("proj_id", inDto.get("proj_id"));
		Integer task_percent = (Integer)sqlDao.selectOne("Task.getAVGGroupId", queryDto);
		rootNode.setText("WBS"+"<span style='color:green;font-weight:bold;'>("+task_percent+"%)</span>");
		rootNode.setLeaf(false);
		rootNode.setIcon("home.png");
		rootNode.setExpanded(true);
		SystemUtils.transTreeNodesToOne(nodesDtos, rootNode);
		httpModel.setOutMsg(AOSJson.toJson(rootNode));
	}

	/**
	 * 根据编码获得分组信息
	 * 
	 * @param httpModel
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		httpModel.setOutMsg(AOSJson.toJson(get(inDto.getInteger("group_id"))));
	}
	
	public long factorial(long i){
		if(i==0) return 1; 
		else return i*factorial(i-1);
	}
	
	public static void main(String[] args) {
		System.out.println("测试："+new TaskGroupService().factorial(10));
	}
	
	/**
     * 获取某段时这里写代码片间内的所有日期
     * @param dBegin
     * @param dEnd
     * @return
     */
    public static List<Date> findDates(Date dBegin, Date dEnd) {
         List<Date> lDate = new ArrayList<Date>();
         lDate.add(dBegin);
         Calendar calBegin = Calendar.getInstance();
         // 使用给定的 Date 设置此 Calendar 的时间
         calBegin.setTime(dBegin);
         Calendar calEnd = Calendar.getInstance();
         // 使用给定的 Date 设置此 Calendar 的时间
         calEnd.setTime(dEnd);
         // 测试此日期是否在指定日期之后
         while (dEnd.after(calBegin.getTime()))  {
          // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
              calBegin.add(Calendar.DAY_OF_MONTH, 1);
              lDate.add(calBegin.getTime());
         }
         return lDate;
    }
}