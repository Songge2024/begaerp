package com.bl3.pm.task.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.security.action.PutAllAction;
import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSListUtils;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.model.UserModel;
import aos.system.common.utils.SystemCons;
import net.sf.json.JSONArray;

import com.bl3.pm.basic.service.ProjCommonsService;
import com.bl3.pm.basic.service.ThemeService;
import com.bl3.pm.task.dao.TaskDao;
import com.bl3.pm.task.dao.TaskFileUploadDao;
import com.bl3.pm.task.dao.po.TaskFileUploadPO;
import com.bl3.pm.task.dao.po.TaskFileUploadTempPO;
import com.bl3.pm.task.dao.po.TaskGroupPO;
import com.bl3.pm.task.dao.po.TaskPO;
import com.google.gson.Gson;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

/**
 * <b>ta_task[ta_task]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2017-12-11 15:35:41
 */
@Service
public class TaskService {
	private static Logger logger = LoggerFactory.getLogger(TaskService.class);
	@Autowired
	private TaskDao taskDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private TaskGroupService taskGroupService;
	@Autowired 
	private ProjCommonsService projCommonsService; 
	@Autowired
	private IdService idService;
	@Autowired
	private TaskLogsService taskLogsService;
	@Autowired
	private TaskFileUploadDao taskFileUploadDao;

	/**
	 * 草稿
	 */
	public static String TASK_STATE_1001 = "1001";
	/**
	 * 已发布
	 */
	public static String TASK_STATE_1002 = "1002";
	/**
	 * 已接收
	 */
	public static String TASK_STATE_1003 = "1003";
	/**
	 * 已完成
	 */
	public static String TASK_STATE_1004 = "1004";
	/**
	 * 已关闭
	 */
	public static String TASK_STATE_1005 = "1005";
	/**
	 * 已删除
	 */
	public static String TASK_STATE_1006 = "1006";
	/**
	 * 已暂停
	 */
	public static String TASK_STATE_1007 = "1007";
	
	/**
	 * 项目组成员任务初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initPmUserTaskView(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("proj_id", httpModel.getInDto().getString("proj_id"));
//		httpModel.setAttribute("proj_name", httpModel.getInDto().getString("proj_name"));
		List<Dto>projNameList=sqlDao.list("Home.queryProjName", inDto);
		httpModel.setAttribute("proj_name", projNameList.get(0).getString("proj_name"));
		httpModel.setAttribute("states", httpModel.getInDto().getString("states"));
		httpModel.setAttribute("id", httpModel.getInDto().getString("id"));
		httpModel.setAttribute("create_time", inDto.get("create_time"));
		httpModel.setAttribute("plan_begin_time", inDto.get("plan_begin_time"));
		httpModel.setAttribute("plan_end_time", inDto.get("plan_end_time"));
		httpModel.setViewPath("pm3/task/task_manager.jsp");
	}
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
		String proj_id  = "";
		String proj_name = "";
		if(getDto.get("proj_id")!=null){
	    proj_id = getDto.get("proj_id").toString();
	    proj_name = getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/task/user_task_list.jsp");
	}

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void viewInit(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		httpModel.setAttribute("proj_id", inDto.getString("proj_id"));
		httpModel.setAttribute("task_id", inDto.getString("task_id"));
		httpModel.setAttribute("task_code", inDto.getString("task_code"));
		httpModel.setAttribute("task_name", inDto.getString("task_name"));
		//httpModel.setAttribute("task_desc", inDto.getString("task_desc"));
		//httpModel.setAttribute("remark", inDto.getString("remark"));
		System.out.println(inDto.getString("task_desc")+"-----------------------");
//		httpModel.setViewPath("pm3/task/user_task_view.jsp");
		httpModel.setViewPath("pm3/task/user_portal_view.jsp");
	}
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void myTaskViewInit(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		httpModel.setAttribute("proj_id", inDto.getString("proj_id"));
		httpModel.setAttribute("task_id", inDto.getString("task_id"));
		httpModel.setAttribute("task_code", inDto.getString("task_code"));
		httpModel.setAttribute("task_name", inDto.getString("task_name"));
		//httpModel.setAttribute("task_desc", inDto.getString("task_desc"));
		//httpModel.setAttribute("remark", inDto.getString("remark"));
		System.out.println(inDto.getString("task_desc")+"-----------------------");
		httpModel.setViewPath("pm3/task/user_myTask_view.jsp");
	}
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void taskViewInit(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		httpModel.setAttribute("proj_id", inDto.getString("proj_id"));
		httpModel.setAttribute("task_id", inDto.getString("task_id"));
		httpModel.setAttribute("task_code", inDto.getString("task_code"));
		httpModel.setAttribute("task_name", inDto.getString("task_name"));
		//httpModel.setAttribute("task_desc", inDto.getString("task_desc"));
		//httpModel.setAttribute("remark", inDto.getString("remark"));
		System.out.println(inDto.getString("task_desc")+"-----------------------");
		httpModel.setViewPath("pm3/task/user_taskTrack_view.jsp");
	}

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void managerInit(HttpModel httpModel) {
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
	     
	     Dto putDto=Dtos.newDto();
		 putDto.put("team_user_id", httpModel.getUserModel().getId());
		 putDto.put("proj_id",proj_id);
		 putDto.put("permission_code", "task_manager");
		 //int con =(int) sqlDao.selectOne("WeeklyStorage.impowerIssue", putDto);
		 int con = (int) sqlDao.selectOne("WeeklyStorage.getRoleTypePermissionPersonCount", putDto);
		 httpModel.setAttribute("con", con);
		}else{
			httpModel.setAttribute("con", '0');
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/task/task_manager.jsp");
		
	}
	
	//获取编码号
	public void getTemp_task_id(HttpModel httpModel){
//		 String ta= dateToStamp("ta");
		 String ta = "ta" + idService.code("task","yyMMdd","999");
		 httpModel.setOutMsg(ta);
	}
	
	/**
	   *  将时间转换为时间戳 ,入参规则 :测试 qa,任务  ta,过程pr,需求re. 
     * @return 21位的订单号。可以用来作为主题类型编码。
     */    
    public  String dateToStamp(String s){
	 	String  getD= AOSUtils.getDateTimeStr("yyyy");
	 	String getD_=getD.substring(2, 4);
	 	String  getD__= AOSUtils.getDateTimeStr("MMddHHmmss");
	 	AOSUtils.random();
	 	AOSUtils.random();
	 	AOSUtils.random();
	 	StringBuilder str=new StringBuilder();
	 	str.append(s);
	 	str.append(getD_);
	 	str.append(getD__);
	 	str.append(AOSUtils.random());
	 	str.append(AOSUtils.random());
        return str.toString();
    }

	/**
	 * 创建任务
	 * 
	 * @param insertDto
	 * @return
	 */
	public Integer create(Integer user_id,String username,Dto insertDto) {
		Dto outDto = Dtos.newOutDto();
		TaskPO taskPO = new TaskPO();
		String plan_end_time_=insertDto.getString("plan_end_time");
		Date plan_end_time=AOSUtils.stringToDate(plan_end_time_.replaceAll("T", " "));
		String plan_begin_time_=insertDto.getString("plan_begin_time");
		Date plan_begin_time=AOSUtils.stringToDate(plan_begin_time_.replaceAll("T", " "));
		taskPO.copyProperties(insertDto);
		Integer task_id = idService.nextValue("seq_ta_task").intValue();
		taskPO.setTask_id(task_id);
		// 生成任务code
		taskPO.setTask_code("T-" + idService.code("task","yyMMdd","999"));
		taskPO.setGrade(insertDto.getInteger("grade"));// 默认分数10
		taskPO.setState(insertDto.getString("state"));// 默认新增草稿模式
		//Date plan_end_time=computeEndDate(plan_begin_time, ""+taskPO.getPlan_wastage());
		taskPO.setPlan_begin_time(plan_begin_time);
		taskPO.setPlan_end_time(plan_end_time);
		if(AOSUtils.isEmpty(insertDto.getInteger("group_name_all_id"))){
			taskPO.setGroup_id(insertDto.getInteger("group_id"));
		}else{
			taskPO.setGroup_id(insertDto.getInteger("group_name_all_id"));
		}
		taskPO.setAssign_user_id(user_id);// 设置指派人编码
		taskPO.setCreate_user_id(user_id);// 设置创建人编码
		//taskPO.setCreate_time(AOSUtils.getDateTime());
		taskPO.setCreate_time(new Date());
		taskDao.insert(taskPO);
		outDto.put("task_id", task_id);
		return task_id;
	}

	/**
	 * 删除指定任务
	 * 
	 * @param group_id
	 */
	public Dto delete(Integer user_id,String username, Integer task_id) {
		Dto outDto = Dtos.newOutDto();
		TaskPO taskPO = taskDao.selectByKey(task_id);
		// 逻辑删除任务
		taskPO.setState(TASK_STATE_1006);
//		taskPO.setUpdate_time(AOSUtils.getDateTime());
		taskPO.setUpdate_time(new Date());
		taskPO.setUpdate_user_id(user_id);
		taskDao.updateByKey(taskPO);
		Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "创建了" + taskPO.getTask_name());
		logsDto.put("state", TASK_STATE_1006);
		logsDto.put("task_id", task_id);
		taskLogsService.create(user_id, logsDto);
		return outDto;
	}

	/**
	 * 根据分组删除任务
	 * 
	 * @param user_id
	 * @param group_id
	 */
	public Dto deleteByGroup(Integer user_id, String[] group_ids) {
		Dto outDto = Dtos.newOutDto();
		Dto queryDto = Dtos.newDto();
		// 查询已启用的任务
		String[] states = { TASK_STATE_1002, TASK_STATE_1003, TASK_STATE_1004, TASK_STATE_1005 };
		queryDto.put("group_ids", StringUtils.join(group_ids, ","));
		queryDto.put("states", StringUtils.join(states, ","));
		List<TaskPO> notFinishList = sqlDao.list("Task.selectByGroups", queryDto);
		if (notFinishList.size() > 0) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，非草稿任务不能删除"));
			return outDto;
		}
		Dto updateDto = Dtos.newDto();
		updateDto.put("state", TASK_STATE_1006);
		updateDto.put("update_user_id", user_id);
		updateDto.put("update_time", AOSUtils.getDateTimeStr());
		updateDto.put("group_ids", StringUtils.join(group_ids, ","));

		sqlDao.update("Task.deleteByGroups", updateDto);
		outDto.setAppMsg("批量删除任务成功");
		return outDto;
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		UserModel userModel = httpModel.getUserModel();
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		String handler_user_id = inDto.getString("handler_user_id");
		String handler_user_id_=handler_user_id.replace("[","");
		String _handler_user_id_=handler_user_id_.replace("]","");
		String[] handler_user_ids=_handler_user_id_.split(",");
//		List<Integer> handler_user_ids=AOSJson.getList(inDto.getString("handler_user_id"), Integer.class);
		if(!inDto.containsKey("group_id")){
			httpModel.setOutMsg("分组编码不能为空");
			return;
		};
		if(AOSUtils.isEmpty(inDto.getInteger("group_name_all_id"))){
			Integer task_group_id= inDto.getInteger("group_id");
			TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
			if(AOSUtils.isEmpty(taskGroupPO)){
				httpModel.setOutMsg("分组不存在");
				return;
			}
		}else{
			Integer task_group_id= inDto.getInteger("group_name_all_id");
			TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
			if(AOSUtils.isEmpty(taskGroupPO)){
				httpModel.setOutMsg("分组不存在");
				return;
			}
		}
		if(AOSUtils.isEmpty(handler_user_ids)){
			Dto outDto = Dtos.newOutDto();
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("未获取到指派人信息!");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		//
		for (String handler_users_id : handler_user_ids) {
			if(handler_users_id == null){
				httpModel.setOutMsg("指派人未获取到！");
				return;
			}
			Dto insertDto=Dtos.newDto();
			insertDto.putAll(inDto);
			insertDto.put("grade", 10);// 默认分数
			insertDto.put("state", TASK_STATE_1001);// 默认草稿状态
			insertDto.put("handler_user_id", handler_users_id);
			Integer task_id=create(user_id,username,insertDto);
			// 对象验证
			// ValidatorUtils.validateEntity(taskPO, AddGroup.class);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "创建了" + insertDto.getString("task_name"));
			logsDto.put("state", TASK_STATE_1001);
			logsDto.put("task_id", task_id);
			taskLogsService.create(user_id, logsDto);
			
			//将上传的附件分配给每个任务指派人
			if(AOSUtils.isNotEmpty(inDto.getString("temp_task_id"))) {
				List<TaskFileUploadTempPO> taskFileUploadTempPO = sqlDao.list("com.bl3.pm.task.dao.TaskFileUploadTempDao.taskFileUploadDto", inDto);
				for(TaskFileUploadTempPO taskFileUploadTempPOs : taskFileUploadTempPO) {
					TaskFileUploadPO taskFileUploadPO = new TaskFileUploadPO();
					taskFileUploadPO.setCreate_time(taskFileUploadTempPOs.getCreate_time());
					taskFileUploadPO.setCreate_user_id(taskFileUploadTempPOs.getCreate_user_id());
					taskFileUploadPO.setProj_id(taskFileUploadTempPOs.getProj_id());
					taskFileUploadPO.setTask_file_type(taskFileUploadTempPOs.getTask_file_type());
					taskFileUploadPO.setFile_code(taskFileUploadTempPOs.getFile_code());
					taskFileUploadPO.setFile_title(taskFileUploadTempPOs.getFile_title());
					taskFileUploadPO.setFile_size(taskFileUploadTempPOs.getFile_size());
					taskFileUploadPO.setState(taskFileUploadTempPOs.getState());
					taskFileUploadPO.setTask_id(task_id);
					taskFileUploadDao.insert(taskFileUploadPO);
				}
			}
		}
		httpModel.setOutMsg("新增成功");
	}

	/**
	 * 发布任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void publish(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		UserModel userModel = httpModel.getUserModel();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String[] task_ids = inDto.getRows();
		List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(task_ids, ",")));
		// 获得选择记录中待发布的任务
		String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1001 + "' ";
		List<TaskPO> publishList = AOSListUtils.select(list, TaskPO.class, sql, null);
		for (TaskPO taskPO : publishList) {
			taskPO.setState(TASK_STATE_1002);
//			taskPO.setUpdate_time(AOSUtils.getDateTime());
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(userModel.getId());
			taskPO.setAssign_user_id(userModel.getId());
			taskDao.updateByKey(taskPO);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.date2String(new Date(), "yyyy-MM-dd HH:mm:ss") + "发布了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1002);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
		}
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		outDto.setAppMsg(AOSUtils.merge("发布任务成功，本次发布[{0}]个任务。", publishList.size()));
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 批量发布
	 * 
	 * @param httpModel
	 */
	@Transactional	
	public void batchPublishing(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		UserModel userModel = httpModel.getUserModel();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String[] selectionIds = inDto.getRows();
		for (String task_ids : selectionIds) {
			List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", task_ids));
			// 获得选择记录中待发布的任务
			String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1001 + "' ";
			List<TaskPO> publishList = AOSListUtils.select(list, TaskPO.class, sql, null);
			for (TaskPO taskPO : publishList) {
				taskPO.setState(TASK_STATE_1002);
				taskPO.setUpdate_time(new Date());
				taskPO.setUpdate_user_id(userModel.getId());
				taskPO.setAssign_user_id(userModel.getId());
				taskDao.updateByKey(taskPO);
				//记录任务日志
				Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.date2String(new Date(), "yyyy-MM-dd HH:mm:ss") + "发布了" + taskPO.getTask_name());
				logsDto.put("state", TASK_STATE_1002);
				logsDto.put("task_id", taskPO.getTask_id());
				taskLogsService.create(user_id, logsDto);
			}
			outDto.setAppMsg(AOSUtils.merge("批量发布任务成功。", publishList.size()));
			httpModel.setOutMsg(AOSJson.toJson(outDto));
		}
	}
	
	/**
	 * 新增并发布
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void create_publish(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		UserModel userModel = httpModel.getUserModel();
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		String handler_user_id = inDto.getString("handler_user_id");
		String handler_user_id_=handler_user_id.replace("[","");
		String _handler_user_id_=handler_user_id_.replace("]","");
		String[] handler_user_ids=_handler_user_id_.split(",");
//		List<Integer> handler_user_ids=AOSJson.getList(inDto.getString("handler_user_id"), Integer.class);
		if(!inDto.containsKey("group_id")){
			httpModel.setOutMsg("分组编码不能为空");
			return;
		};
		if(AOSUtils.isEmpty(inDto.getInteger("group_name_all_id"))){
			Integer task_group_id= inDto.getInteger("group_id");
			TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
			if(AOSUtils.isEmpty(taskGroupPO)){
				httpModel.setOutMsg("分组不存在");
				return;
			}
		}else{
			Integer task_group_id= inDto.getInteger("group_name_all_id");
			TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
			if(AOSUtils.isEmpty(taskGroupPO)){
				httpModel.setOutMsg("分组不存在");
				return;
			}
		}
		String [] tasks= new String[handler_user_ids.length];
		int b = -1;
		for (String handler_users_id : handler_user_ids) {
			b++;
			Dto insertDto=Dtos.newDto();
			insertDto.putAll(inDto);
			insertDto.put("grade", 10);// 默认分数
			insertDto.put("state", TASK_STATE_1001);// 默认草稿状态
			insertDto.put("handler_user_id", handler_users_id);
			Integer task_id=create(user_id,username,insertDto);
			// 对象验证
			// ValidatorUtils.validateEntity(taskPO, AddGroup.class);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "创建了" + insertDto.getString("task_name"));
			logsDto.put("state", TASK_STATE_1001);
			logsDto.put("task_id", task_id);
			taskLogsService.create(user_id, logsDto);
			tasks[b]=task_id+"";
			
			//将上传的附件分配给每个任务指派人
			if(AOSUtils.isNotEmpty(inDto.getString("temp_task_id"))) {
				List<TaskFileUploadTempPO> taskFileUploadTempPO = sqlDao.list("com.bl3.pm.task.dao.TaskFileUploadTempDao.taskFileUploadDto", inDto);
				for(TaskFileUploadTempPO taskFileUploadTempPOs : taskFileUploadTempPO) {
					TaskFileUploadPO taskFileUploadPO = new TaskFileUploadPO();
					taskFileUploadPO.setCreate_time(taskFileUploadTempPOs.getCreate_time());
					taskFileUploadPO.setCreate_user_id(taskFileUploadTempPOs.getCreate_user_id());
					taskFileUploadPO.setProj_id(inDto.getInteger("proj_id"));
					taskFileUploadPO.setTask_file_type(taskFileUploadTempPOs.getTask_file_type());
					taskFileUploadPO.setFile_code(taskFileUploadTempPOs.getFile_code());
					taskFileUploadPO.setFile_title(taskFileUploadTempPOs.getFile_title());
					taskFileUploadPO.setFile_size(taskFileUploadTempPOs.getFile_size());
					taskFileUploadPO.setState(taskFileUploadTempPOs.getState());
					taskFileUploadPO.setTask_id(task_id);
					taskFileUploadDao.insert(taskFileUploadPO);
				}
			}
		}
		Dto outDto = Dtos.newOutDto();
		UserModel userModels = httpModel.getUserModel();
		Integer user_ids=httpModel.getUserModel().getId();
		String usernames=httpModel.getUserModel().getName();
		List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(tasks, ",")));
		// 获得选择记录中待发布的任务
		String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1001 + "' " ;
		List<TaskPO> publishList = AOSListUtils.select(list, TaskPO.class, sql, null);
		for (TaskPO taskPO : publishList) {
			taskPO.setState(TASK_STATE_1002);
//			taskPO.setUpdate_time(AOSUtils.getDateTime());
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(userModels.getId());
			taskDao.updateByKey(taskPO);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", usernames + "于" + AOSUtils.date2String(new Date(), "yyyy-MM-dd HH:mm:ss") + "发布了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1002);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_ids, logsDto);
		}
		outDto.setAppMsg(AOSUtils.merge("发布任务成功，本次发布[{0}]个任务。", publishList.size()));
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	
	/**
	 * 接受任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void receive(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		UserModel userModel = httpModel.getUserModel();
		String task_id = inDto.getString("task_id");
		TaskPO taskPO = taskDao.selectByKey(Integer.valueOf(task_id));
		if (!taskPO.getState().equals(TASK_STATE_1002)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]不是待接受的任务。", taskPO.getTask_name()));
		} else if (!taskPO.getHandler_user_id().equals(userModel.getId())) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，请使用指定处理人接受[{0}]。", taskPO.getTask_name()));
		} else {
			taskPO.setState(TASK_STATE_1003);
//			taskPO.setReal_begin_time(AOSUtils.getDateTime());
			taskPO.setReal_begin_time(new Date());
//			taskPO.setUpdate_time(AOSUtils.getDateTime());
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(user_id);
			taskDao.updateByKey(taskPO);
			
			outDto.setAppMsg("接受任务成功。");
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "接受了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1003);
			logsDto.put("task_id", taskPO.getTask_id());
			logsDto.put("percent", taskPO.getPercent());
			taskLogsService.create(user_id, logsDto);
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 计算两个时间的间隔天数 （最小间隔 半天）
	 * @param begin_date
	 * @param end_date
	 * @return 间隔天数
	 */
	public BigDecimal computeWastageDay(Date begin_date,Date end_date){
		int wastage=AOSUtils.getIntervalDays(begin_date, end_date);
		if(begin_date.getHours()<12){
			if(end_date.getHours()<12){
				return new BigDecimal(wastage+0.5);
			}else{
				return new BigDecimal(wastage);
			}
		}else{
			if(end_date.getHours()<12){
				return new BigDecimal(wastage);
			}else{
				return new BigDecimal(wastage+0.5);
			}
		}
	}
	
	public BigDecimal computeWastageDays(Date begin_date,Date end_date){
		String wastage = AOSUtils.getIntervalDay(begin_date, end_date);
//		if("0.0".toString().equals(wastage)){
//			double wastages = 0.5;
//			return new BigDecimal(wastages);
//		}else{
//			return new BigDecimal(wastage);
//		}
		double do_wastage = Double.parseDouble(wastage);
		int wastages = new Double(do_wastage).intValue();
		if(begin_date.getHours()<12){
			if(end_date.getHours()<12){
				return new BigDecimal(wastages);
			}else{
				return new BigDecimal(wastages+0.5);
			}
		}else{
				return new BigDecimal(wastage);
		}
		
	}
	/**
	 * 根据消耗开始时间和消耗时间计算结束时间
	 * @param begin_time 开始时间
	 * @param wastage 消耗天数 
	 * @return endDate 结束时间
	 */
	public Date computeEndDate(Date begin_time,String wastage){
		int int_wastage=0;
		if(wastage.indexOf(".")!=-1){
			int_wastage=Integer.valueOf(wastage.substring(0, wastage.indexOf(".")));
		}else{
			int_wastage=Integer.valueOf(wastage);
		}
		//开始时间到大于小于12点 
		if(begin_time.getHours()<=12){//开始时间在早上 半天 截止时间为12点 ，一天截止时间为17点30
			begin_time.setHours(9);
			begin_time.setMinutes(0);
			begin_time.setSeconds(0);
			if(wastage.indexOf(".")!=-1){//有半天计算 
				Date end_date = AOSUtils.dateAdd(begin_time, Calendar.DATE, int_wastage > 0 ? (int_wastage - 1) : 0);
				end_date.setHours(12);
				end_date.setMinutes(0);
				end_date.setSeconds(0);
				return end_date;
			}else{
				Date end_date=AOSUtils.dateAdd(begin_time, Calendar.DATE, int_wastage-1);
				end_date.setHours(18);
				end_date.setMinutes(0);
				end_date.setSeconds(0);
				return end_date;
			}
		}else {//开始时间在下午 半天 截止时间为17点30 ，一天截止时间为12点
			begin_time.setHours(13);
			begin_time.setMinutes(0);
			begin_time.setSeconds(0);
			if(wastage.indexOf(".")!=-1){//有半天计算
				Date end_date=AOSUtils.dateAdd(begin_time, Calendar.DATE,int_wastage);
				end_date.setHours(18);
				end_date.setMinutes(0);
				end_date.setSeconds(0);
				return end_date;
			}else{
				Date end_date=AOSUtils.dateAdd(begin_time, Calendar.DATE, int_wastage);
				end_date.setHours(12);
				end_date.setMinutes(0);
				end_date.setSeconds(0);
				return end_date;
			}
		}
	}
	/**
	 * 完成任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void finish(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String[] task_ids = inDto.getRows();
		List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(task_ids, ",")));
		// 获得选择所有带待完成的任务
		String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1003 + "' AND handler_user_id="
				+ user_id;
		List<TaskPO> finishList = AOSListUtils.select(list, TaskPO.class, sql, null);
		int   message=0;
		for (TaskPO taskPO : finishList) {
			taskPO.setState(TASK_STATE_1004);
			taskPO.setPercent(100);
//			taskPO.setUpdate_time(AOSUtils.getDateTime());
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(user_id);
			Date real_begin_time=taskPO.getReal_begin_time();
			if(AOSUtils.isEmpty(taskPO.getReal_end_time())){
				Date real_end_time = new Date();//AOSUtils.getDateTime();
				if(real_end_time.getTime() < real_begin_time.getTime()){
					httpModel.setOutMsg("结束时间不能大于开始时间！");
					return;
				}
				taskPO.setReal_end_time(real_end_time);
				BigDecimal real_wastages =taskPO.getReal_wastage();
				String real_wastage = taskPO.getReal_wastage().toString();
				if(real_wastage.equals("0.00")){
					//taskPO.setReal_wastage(computeWastageDay(real_begin_time, real_end_time));
					taskPO.setReal_wastage(computeWastageDays(real_begin_time, real_end_time));
				}else{
					taskPO.setReal_wastage(real_wastages);
				}
			}else{
				Date real_end_time = taskPO.getReal_end_time();
				if(real_end_time.getTime() < real_begin_time.getTime()){
					httpModel.setOutMsg("结束时间不能大于开始时间！");
					return;
				}
				taskPO.setReal_end_time(real_end_time);
				BigDecimal real_wastages =taskPO.getReal_wastage();
				String real_wastage = taskPO.getReal_wastage().toString();
				if(real_wastage.equals("0.00")){
					taskPO.setReal_wastage(computeWastageDays(real_begin_time, real_end_time));
				}else{
					taskPO.setReal_wastage(real_wastages);
				}
			}
			taskDao.updateByKey(taskPO);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.date2String(new Date(), "yyyy-MM-dd HH:mm:ss") + "完成了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1003);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
			
			//消息保存
			Dto putDto=Dtos.newDto();
			int handler_user_id= finishList.get(0).getHandler_user_id();
			int assign_user_id= finishList.get(0).getAssign_user_id();
			putDto.put("proj_id", finishList.get(0).getProj_id());
			putDto.put("team_user_id", handler_user_id);
			int getTaskoKUser = (int) sqlDao.selectOne("WeeklyStorage.getTaskoKUser",putDto);
			String getTaskoKUserAccount;
			outDto.put("getTaskoKUser",getTaskoKUser);
			int 	id ;
			if(getTaskoKUser>0){
				id=getTaskoKUser;
				getTaskoKUserAccount = (String) sqlDao.selectOne("WeeklyStorage.getTaskoKUserAccount",id);
			}else{
				id=assign_user_id;
				getTaskoKUserAccount = (String) sqlDao.selectOne("WeeklyStorage.getTaskoKUserAccount",id);
			}
			outDto.put("getTaskoKUser",getTaskoKUserAccount);
			message=1;
//			if(assign_user_id!= handler_user_id){
//				    	message=1;
//			}
		}
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		String Task_type=list.get(0).getTask_type();
		String Task_code=list.get(0).getTask_code();
		outDto.setAppMsg(AOSUtils.merge("完成任务成功，本次完成[{0}]个任务。", finishList.size()));
		outDto.put("token", token);
		outDto.put("message",message);
		outDto.put("task_type", Task_type);
		outDto.put("task_code", Task_code);
		outDto.put("user_id", user_id);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 关闭任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void close(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		String[] task_ids = inDto.getRows();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(task_ids, ",")));
		// 获得选择所有带待关闭的任务
		String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1004 + "'";
		List<TaskPO> closeList = AOSListUtils.select(list, TaskPO.class, sql, null);
		String demand_id=closeList.get(0).getDemand_id();
		String Task_code=closeList.get(0).getTask_code();
		String message=null;
		for (TaskPO taskPO : closeList) {
			taskPO.setState(TASK_STATE_1005);
//			taskPO.setUpdate_time(AOSUtils.getDateTime());
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(user_id);
			taskDao.updateByKey(taskPO);
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "关闭了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1003);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
			
			//关闭消息发送
			if(AOSUtils.isNotEmpty(demand_id)){
				String  send_id = (String) sqlDao.selectOne("Task.selectDemandId", Dtos.newDto("demand_id", demand_id));
				String  demand_name = (String) sqlDao.selectOne("Task.selectDemandName", Dtos.newDto("demand_id", demand_id));
				outDto.put("demand_id", send_id);
				outDto.put("demand_name", demand_name);
				int handler_user_id= closeList.get(0).getHandler_user_id();
				if(AOSUtils.isNotEmpty(send_id)){
						//消息保存
						Dto putDto=Dtos.newDto();
						putDto.put("proj_id", closeList.get(0).getProj_id());
						putDto.put("team_user_id", handler_user_id);
					//	int getSendMessage = (int) sqlDao.selectOne("WeeklyStorage.getSendMessage",mesSaveDto);
						   //	if(getSendMessage<1){
							//	sqlDao.insert("com.bl3.pm.quality.dao.MessageDao.insert", mesSaveDto);
								message="1";
						//	}
				}
		      }
		}
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		outDto.setAppMsg(AOSUtils.merge("关闭任务成功，本次关闭[{0}]个任务。", closeList.size()));
		outDto.put("message",message);
		outDto.put("token", token);
		outDto.put("user_id", user_id);
		outDto.put("task_code", Task_code);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 批量关闭任务
	 * 
	 * @param httpModel
	 */
	public void batchClose(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String[] selectionIds = inDto.getRows();
		List<TaskPO> taskList = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(selectionIds, ",")));
		for(TaskPO taskPO : taskList) {
			if(!user_id.equals(taskPO.getAssign_user_id())) {
				inDto.setAppMsg(AOSUtils.merge("非任务指派人不能关闭任务！！"));
				httpModel.setOutMsg(AOSJson.toJson(inDto));
				return;
			}
		}
		for (String task_ids : selectionIds) {
			//List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(task_ids, ",")));
			List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", task_ids));
			// 获得选择所有带待关闭的任务
			String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1004 + "'";
			List<TaskPO> closeList = AOSListUtils.select(list, TaskPO.class, sql, null);
			String demand_id=closeList.get(0).getDemand_id();
			String Task_code=closeList.get(0).getTask_code();
			String message=null;
			for (TaskPO taskPO : closeList) {
				taskPO.setState(TASK_STATE_1005);
				taskPO.setUpdate_time(new Date());
				taskPO.setUpdate_user_id(user_id);
				taskDao.updateByKey(taskPO);
				//记录任务日志
				Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "关闭了" + taskPO.getTask_name());
				logsDto.put("state", TASK_STATE_1003);
				logsDto.put("task_id", taskPO.getTask_id());
				taskLogsService.create(user_id, logsDto);
			}
			
			//关闭消息发送
			if(AOSUtils.isNotEmpty(demand_id)){
				String  send_id = (String) sqlDao.selectOne("Task.selectDemandId", Dtos.newDto("demand_id", demand_id));
				String  demand_name = (String) sqlDao.selectOne("Task.selectDemandName", Dtos.newDto("demand_id", demand_id));
				outDto.put("demand_id", send_id);
				outDto.put("demand_name", demand_name);
				int handler_user_id= closeList.get(0).getHandler_user_id();
				if(AOSUtils.isNotEmpty(send_id)){
						//消息保存
						Dto putDto=Dtos.newDto();
						putDto.put("proj_id", closeList.get(0).getProj_id());
						putDto.put("team_user_id", handler_user_id);
						message="1";
				}
		    }
			final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
			String token= JedisUtil.getString(cacheKey);
			outDto.setAppMsg(AOSUtils.merge("批量关闭任务成功。", closeList.size()));
			outDto.put("message",message);
			outDto.put("token", token);
			outDto.put("user_id", user_id);
			outDto.put("task_code", Task_code);
			httpModel.setOutMsg(AOSJson.toJson(outDto));
		}
	}

	/**
	 * 分解任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void resolve(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		UserModel userModel = httpModel.getUserModel();
		String task_id = inDto.getString("task_id");
		List<Dto> taskResolveList = AOSJson.fromJson(inDto.getString("task_resolves"));
		TaskPO taskPO = taskDao.selectByKey(Integer.valueOf(task_id));
		String state = taskPO.getState();// 任务状态
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		Integer handler_user_id = taskPO.getHandler_user_id();// 处理人编码
		Integer assign_user_id = taskPO.getAssign_user_id();// 指派人编码

		if (state.equals(TASK_STATE_1004) || state.equals(TASK_STATE_1005)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]是已关闭或已完成的任务不能分解。", taskPO.getTask_name()));
		} else if (handler_user_id.equals(user_id) || assign_user_id.equals(user_id)) {
			List<Dto> selectTaskDto = sqlDao.list("Task.selectTaskDto", task_id);
			String task_root_id = null;
			for(Dto dtos : selectTaskDto) {
				dtos.put("is_decomposed", "1");
				dtos.put("task_id", task_id);
				dtos.put("update_user_id",user_id);
				dtos.put("update_time", new Date());
				taskDao.updateDecomposed(dtos);
				if(dtos.getString("task_root_id").isEmpty()) {
					task_root_id = task_id;
				} else {
					task_root_id = dtos.getString("task_root_id");
				}
			}
			for (Dto dto : taskResolveList) {
				dto.put("group_id", inDto.get("group_id"));
				dto.put("grade", 5);
//				dto.put("state", state);//默认任务已发布
				dto.put("state", 1001);//默认任务草稿
				dto.put("user_id", user_id);
				dto.put("task_parent_id", task_id);
				dto.put("task_root_id", task_root_id);
				create(user_id,username,dto);
			}
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "分解了" + taskPO.getTask_name());
//			logsDto.put("state", state);
			logsDto.put("state", 1001);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
			// 删除原任务
			//delete(user_id,username, taskPO.getTask_id());
			
			outDto.setAppMsg(AOSUtils.merge("操作成功，[{0}]被分解成{1}个任务", taskPO.getTask_name(), taskResolveList.size()));
		} else {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]没有权限分解任务。请使用指派人或处理人账号分解任务。", taskPO.getTask_name()));

		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 分解任务
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void resolves(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		UserModel userModel = httpModel.getUserModel();
		String task_id = inDto.getString("task_id");
		List<Dto> taskResolveList = AOSJson.fromJson(inDto.getString("task_resolves"));
		TaskPO taskPO = taskDao.selectByKey(Integer.valueOf(task_id));
		String state = taskPO.getState();// 任务状态
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		Integer handler_user_id = taskPO.getHandler_user_id();// 处理人编码
		Integer assign_user_id = taskPO.getAssign_user_id();// 指派人编码

		if (state.equals(TASK_STATE_1004) || state.equals(TASK_STATE_1005)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]是已关闭或已完成的任务不能分解。", taskPO.getTask_name()));
		} else if (handler_user_id.equals(user_id) || assign_user_id.equals(user_id)) {
			List<Dto> selectTaskDto = sqlDao.list("Task.selectTaskDto", task_id);
			String task_root_id = null;
			for(Dto dtos : selectTaskDto) {
				dtos.put("is_decomposed", "1");
				dtos.put("task_id", task_id);
				dtos.put("update_user_id",user_id);
				dtos.put("update_time", new Date());
				taskDao.updateDecomposed(dtos);
				if(dtos.getString("task_root_id").isEmpty()) {
					task_root_id = task_id;
				} else {
					task_root_id = dtos.getString("task_root_id");
				}
			}
			for (Dto dto : taskResolveList) {
				dto.put("group_id", inDto.get("group_id"));
				dto.put("grade", 5);
//				dto.put("state", state);//默认任务已发布
				dto.put("state", 1002);//默认任务已发布
				dto.put("user_id", user_id);
				dto.put("task_parent_id", task_id);
				dto.put("task_root_id", task_root_id);
				create(user_id,username,dto);
			}
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "分解了" + taskPO.getTask_name());
			logsDto.put("state", 1002);
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
			// 删除原任务
			//delete(user_id,username, taskPO.getTask_id());
			
			outDto.setAppMsg(AOSUtils.merge("操作成功，[{0}]被分解成{1}个任务", taskPO.getTask_name(), taskResolveList.size()));
		} else {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]没有权限分解任务。请使用指派人或处理人账号分解任务。", taskPO.getTask_name()));

		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 打回
	 * @param httpModel
	 */
	public void back(HttpModel httpModel){
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		Integer task_id = inDto.getInteger("task_id");
		Integer user_id = httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		TaskPO taskPO = taskDao.selectByKey(task_id);
		Integer state=Integer.valueOf(taskPO.getState());
		taskPO.setState(""+(state-1));
//		taskPO.setUpdate_time(AOSUtils.getDateTime());
		taskPO.setUpdate_time(new Date());
		taskDao.updateByKey(taskPO);
		outDto.setAppMsg("任务撤回成功");
		//记录任务日志
		Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "撤回了" + taskPO.getTask_name());
		logsDto.put("state", state);
		logsDto.put("task_id", taskPO.getTask_id());
		taskLogsService.create(user_id, logsDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 暂停任务
	 */
	public void pause(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String task_id = inDto.getString("task_id");
		UserModel userModel = httpModel.getUserModel();
		TaskPO taskPO = taskDao.selectByKey(Integer.valueOf(task_id));
		if (!taskPO.getState().equals(TASK_STATE_1003)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]不是待接受的任务。", taskPO.getTask_name()));
		} else if (!taskPO.getAssign_user_id().equals(userModel.getId())) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，请使用指定指派人暂停[{0}]。", taskPO.getTask_name()));
		} else {
			taskPO.setState(TASK_STATE_1007);
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(user_id);
			taskDao.updateByKey(taskPO);
			
			outDto.setAppMsg("暂停任务成功。");
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "暂停了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1007);
			logsDto.put("task_id", taskPO.getTask_id());
			logsDto.put("percent", taskPO.getPercent());
			taskLogsService.create(user_id, logsDto);
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 重启任务
	 */
	public void play(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String task_id = inDto.getString("task_id");
		UserModel userModel = httpModel.getUserModel();
		TaskPO taskPO = taskDao.selectByKey(Integer.valueOf(task_id));
		if (!taskPO.getState().equals(TASK_STATE_1007)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，[{0}]不是待重启的任务。", taskPO.getTask_name()));
		} else if (!taskPO.getAssign_user_id().equals(userModel.getId())) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，请使用指定指派人重启[{0}]。", taskPO.getTask_name()));
		} else {
			taskPO.setState(TASK_STATE_1003);
			taskPO.setUpdate_time(new Date());
			taskPO.setUpdate_user_id(user_id);
			taskDao.updateByKey(taskPO);
			
			outDto.setAppMsg("重启任务成功。");
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "重启了" + taskPO.getTask_name());
			logsDto.put("state", TASK_STATE_1007);
			logsDto.put("task_id", taskPO.getTask_id());
			logsDto.put("percent", taskPO.getPercent());
			taskLogsService.create(user_id, logsDto);
		}
	}
	/**
	 * 升级任务
	 * @param httpModel
	 */
	public void up(HttpModel httpModel){
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		UserModel userModel=httpModel.getUserModel();
		Integer task_id = inDto.getInteger("task_id");
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		TaskPO taskPO = taskDao.selectByKey(task_id);
		if(taskPO.getState().equals(TASK_STATE_1005)){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("已关闭的任务不能够升级");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		// 将上级分组加入到任务并删除原始任务
		TaskGroupPO parentGroup=taskGroupService.get(taskPO.getGroup_id());
		if(parentGroup.getParent_id().equals(taskGroupService.DEFAULT_ROOT_ID)){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("任务不能升级到根节点");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		taskPO.setGroup_id(parentGroup.getGroup_id());
		taskDao.deleteByKey(task_id);
		Dto insertDto=taskPO.toDto();
		insertDto.put("group_id", parentGroup.getGroup_id());
		insertDto.put("user_id", user_id);
		//创建新的任务
		create(user_id,username,insertDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
		
	}
	/**
	 * 降级任务
	 * @param httpModel
	 */
	public void down(HttpModel httpModel){
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		Integer task_id = inDto.getInteger("task_id");
		Integer user_id = httpModel.getUserModel().getId();
		String username = httpModel.getUserModel().getName();
		TaskPO taskPO = taskDao.selectByKey(task_id);
		if(taskPO.getState().equals(TASK_STATE_1005)){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("已关闭的任务不能够降级");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		// 删除原任务并将转分组
		taskDao.deleteByKey(task_id);
		Integer group_id = transTaskToGroup(user_id, taskPO);
		Dto insertDto = taskPO.toDto();
		insertDto.put("group_id", group_id);
		insertDto.put("user_id", user_id);
		// 将旧任务加入新分组
		create(user_id,username,insertDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 任务转分组
	 * @param taskPO
	 */
	@Transactional
	public Integer transTaskToGroup(Integer user_id,TaskPO taskPO){
		Dto insertDto = Dtos.newDto();
		AOSUtils.copyProperties(insertDto, taskPO);
		insertDto.put("parent_id", taskPO.getGroup_id());
		insertDto.put("group_name", taskPO.getTask_name());
		insertDto.put("group_from", taskPO.getTask_id());
		insertDto.put("user_id", user_id);
		return taskGroupService.create(insertDto);
	}
	/**
	 * 修改任务内容
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		//移除任务状态修改
		inDto.remove("state");
		TaskPO taskPO = taskDao.selectByKey(inDto.getInteger("task_id"));
		String state=taskPO.getState();
		int Handler_user_id=taskPO.getHandler_user_id();
		int handler_user_id=inDto.getInteger("handler_user_id");
		if("1003".equals(state)&&Handler_user_id!=handler_user_id){
			inDto.put("state", "1002");
		}
		taskPO.copyProperties(inDto);
		//百分比为100%时,任务状态变为已完成
		if(inDto.getInteger("percent")== 100){
			taskPO.setState("1004");
			Date real_begin_time=taskPO.getReal_begin_time();
			if(AOSUtils.isEmpty(taskPO.getReal_end_time())){
				Date real_end_time = new Date();//AOSUtils.getDateTime();
				if(real_end_time.getTime() < real_begin_time.getTime()){
					httpModel.setOutMsg("结束时间不能大于开始时间！");
					return;
				}
				taskPO.setReal_end_time(real_end_time);
				BigDecimal real_wastages =taskPO.getReal_wastage();
				String real_wastage = taskPO.getReal_wastage().toString();
				if(real_wastage.equals("0")){
					taskPO.setReal_wastage(computeWastageDays(real_begin_time, real_end_time));
				}else{
					taskPO.setReal_wastage(real_wastages);
				}
			}else{
				Date real_end_time = taskPO.getReal_end_time();
				taskPO.setReal_end_time(real_end_time);
				BigDecimal real_wastages =taskPO.getReal_wastage();
				String real_wastage = taskPO.getReal_wastage().toString();
				if(real_wastage.equals("0")){
					taskPO.setReal_wastage(computeWastageDays(real_begin_time, real_end_time));
				}else{
					taskPO.setReal_wastage(real_wastages);
				}
			}
		}
		if(AOSUtils.isEmpty(inDto.getInteger("group_name_all_id"))){
			taskPO.setGroup_id(inDto.getInteger("group_id"));
		}else{
			taskPO.setGroup_id(inDto.getInteger("group_name_all_id"));
		}
//		taskPO.setUpdate_time(AOSUtils.getDateTime());
		taskPO.setUpdate_time(new Date());
		taskDao.updateByKey(taskPO);
		//记录任务日志
		Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateStr() + "修改了" + taskPO.getTask_name());
		logsDto.put("state", taskPO.getState());
		logsDto.put("task_id", taskPO.getTask_id());
		logsDto.put("percent", inDto.getBigDecimal("percent"));
		taskLogsService.create(user_id, logsDto);
		httpModel.setOutMsg("修改成功");
	}

	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String[] task_ids = inDto.getRows();
		List<TaskPO> list = sqlDao.list("Task.selectByIds", Dtos.newDto("task_ids", StringUtils.join(task_ids, ",")));
		for(TaskPO taskPO : list) {
			if(!user_id.equals(taskPO.getAssign_user_id())) {
				inDto.setAppMsg(AOSUtils.merge("只能任务指派人删除该任务"));
				httpModel.setOutMsg(AOSJson.toJson(inDto));
				return;
			}
		}
		// 获得当前登录人待发布的任务
		String sql = "SELECT * FROM :AOSList WHERE state ='" + TASK_STATE_1001 + "' AND assign_user_id="
				+ user_id;
		List<TaskPO> delList = AOSListUtils.select(list, TaskPO.class, sql, null);
		for (TaskPO taskPO : delList) {
			delete(user_id,username, taskPO.getTask_id());
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "删除了" + taskPO.getTask_name());
			logsDto.put("state", taskPO.getState());
			logsDto.put("task_id", taskPO.getTask_id());
			taskLogsService.create(user_id, logsDto);
			httpModel.setOutMsg("修改成功");
		}
		inDto.setAppMsg(AOSUtils.merge("删除成功，本次删除[{0}]个任务。", delList.size()));
		httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public TaskPO get(Integer task_id) {
		return taskDao.selectByKey(task_id);
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TaskPO taskPO = taskDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(taskPO));
	}
	/**
	 * 查询指定任务分解后的任务列表
	 */
	public void selectResolveTaskPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		Integer task_id=inDto.getInteger("task_id");
		List<Dto> selectResolveTaskPageList = sqlDao.list("Task.selectResolveTaskPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(selectResolveTaskPageList, inDto.getPageTotal()));
	}
	
	/**
	 * 查询个人任务分页
	 * 
	 * @param httpModel
	 */
	public void selectMyTaskPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// Assert.isNull(inDto.getPageStart(), "(start:查询开始位置)不能为空");
		// Assert.isNull(inDto.getPageLimit(), "(limit:查询条数)不能为空");
		UserModel userModel = httpModel.getUserModel();
		Integer user_id = userModel.getId();

		Dto queryDto = Dtos.newDto();
		queryDto.put("start", inDto.getPageStart());
		queryDto.put("limit", inDto.getPageLimit());
		if(AOSUtils.isEmpty(inDto.get("states"))){
			String states[]= {"1002","1003","1004","1005","1007"};
			queryDto.put("states", StringUtils.join(states, ","));
		}else{
			queryDto.put("states", StringUtils.join(inDto.getString("states").split(","), ","));
		}
		// 过滤查询项目只能查询当前用户所拥有的项目权限（必选）如果不传获得系统角色所有项目权限
		if (AOSUtils.isEmpty(inDto.get("proj_id"))) {
			List<Dto> projects = projCommonsService.getUserPorjects(user_id);
			String[] proj_ids = AOSListUtils.selectPropValues(projects, "proj_id", false);
			queryDto.put("proj_ids", StringUtils.join(proj_ids, ","));
		} else {
			String[] proj_ids = { inDto.getString("proj_id") };
			queryDto.put("proj_ids", StringUtils.join(proj_ids, ","));
		}
		// 只能查询当前用户所属项目任务(如果没有项目，不进行查询操作)
		if(queryDto.getString("proj_ids")!=""){
			queryDto.put("user_id", user_id);// 由我处理的任务及由我发布的任务
			List<Dto> taskDtos = sqlDao.list("Task.selectMyTaskPage", queryDto);
			httpModel.setOutMsg(AOSJson.toGridJson(taskDtos, queryDto.getPageTotal()));
		}

	}

	/**
	 * 分页项目任务分页
	 * 
	 * @param httpModel
	 */
	public void selectManagerTaskPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		Dto queryDto = Dtos.newDto();
		queryDto.setPageLimit(inDto.getPageLimit());
		queryDto.setPageStart(inDto.getPageStart());
		
		String task_states = inDto.getString("task_states");

		if(AOSUtils.isNotEmpty(task_states)){
//          List<String> task_stateList =AOSJson.getList(task_states, String.class);
//          queryDto.put("task_states", task_stateList);
			queryDto.put("task_states", StringUtils.join(inDto.getString("task_states").split(","), ","));
		}else{
			String states[]= {"1001","1002","1003","1004","1005","1007"};
			queryDto.put("task_states", StringUtils.join(states, ",")); 

		}
		queryDto.put("user_id", user_id);
		// 过滤查询项目只能查询当前用户所拥有的项目权限（必选）如果不传获得系统角色所有项目权限
		if (AOSUtils.isEmpty(inDto.get("proj_id"))) {
			List<Dto> projects = projCommonsService.getUserPorjects(user_id);
			String[] proj_ids = AOSListUtils.selectPropValues(projects, "proj_id", false);
			queryDto.put("proj_ids", StringUtils.join(proj_ids, ","));
		} else {
			String[] proj_ids = { inDto.getString("proj_id") };
			queryDto.put("proj_ids", StringUtils.join(proj_ids, ","));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("id"))){
			queryDto.put("handler_user_id", inDto.getString("id"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("handler_user_id"))){
			queryDto.put("handler_user_id", inDto.getString("handler_user_id"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("assign_user_id"))){
			queryDto.put("assign_user_id", inDto.getString("assign_user_id"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("handler_user_name"))){
			queryDto.put("handler_user_name", inDto.getString("handler_user_name"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("assign_user_name"))){
			queryDto.put("assign_user_name", inDto.getString("assign_user_name"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("states"))){
			queryDto.put("states", inDto.getString("states"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("proj_id"))){
			queryDto.put("proj_id", inDto.getString("proj_id"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("query_pa"))){
			queryDto.put("task_name", inDto.getString("query_pa"));
		}
		if(AOSUtils.isNotEmpty(inDto.getString("task_delay_state"))){
			queryDto.put("task_delay_state", inDto.getString("task_delay_state"));
		}
		// 过滤查询分组过滤（可以不选）
		if (AOSUtils.isNotEmpty(inDto.get("group_id"))) {
			// 获得分组及其子分组
			List<TaskGroupPO> childrenGroupList = taskGroupService.getChildrenGroups(inDto.getInteger("group_id"));
			for(TaskGroupPO taskGroupPO : childrenGroupList){
				System.out.print(""+taskGroupPO.getGroup_id()+",");
			}
			System.out.println();
			String[] group_ids = AOSListUtils.selectPropValues(childrenGroupList, "group_id", false);
			queryDto.put("group_ids", StringUtils.join(group_ids, ","));
			List<TaskPO> taskPOs = sqlDao.list("Task.selectManagerTaskPage", queryDto);
			httpModel.setOutMsg(AOSJson.toGridJson(taskPOs, queryDto.getPageTotal()));
			return;
		}
		if(AOSUtils.isNotEmpty(inDto.getString("create_time"))){
			queryDto.put("create_time", inDto.getString("create_time"));
		}
		queryDto.put("plan_begin_time", inDto.getString("plan_begin_time"));
		queryDto.put("plan_end_time", inDto.getString("plan_end_time"));
		List<TaskPO> taskPOs = sqlDao.list("Task.selectManagerTaskPage", queryDto);
		int count=(int) sqlDao.selectOne("Task.selectManagerTaskPageCount", queryDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskPOs, count));
	}
	
	/**
	 * 需求新增任务
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void demandcreatetask(HttpModel httpModel) {
		Gson gson = new Gson();
		Dto inDto = httpModel.getInDto();
		UserModel userModel = httpModel.getUserModel();
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		
		//String detailsStr = (String) inDto.get("details");
		//String json=detailsStr.substring(0,detailsStr.length()).replaceAll("\\\\","");
		//List<Dto> details =AOSJson.fromJson(detailsStr);
//		JSONArray array = JSONArray.fromObject(detailsStr);
//		List<Dto> details = (List<Dto>) JSONArray.toCollection(array, Dto.class);
		List<Dto> details=(List<Dto>) AOSJson.fromJson(inDto.getString("details"));
		if (!details.isEmpty()){
			for (Dto dDto : details){
				List<Integer> handler_user_ids=AOSJson.getList(dDto.getString("handler_user_id"), Integer.class);
				if(!dDto.containsKey("group_id")){
					httpModel.setOutMsg("分组编码不能为空");
					return;
				};
				Integer task_group_id= dDto.getInteger("group_id");
				TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
				if(AOSUtils.isEmpty(taskGroupPO)){
					httpModel.setOutMsg("分组不存在");
					return;
				}
				//
				for (Integer handler_user_id : handler_user_ids) {
					Dto insertDto=Dtos.newDto();
					insertDto.putAll(dDto);
					insertDto.put("grade", 10);// 默认分数
					insertDto.put("state", TASK_STATE_1001);// 默认草稿状态
					insertDto.put("handler_user_id", handler_user_id);
					Integer task_id=create(user_id,username,insertDto);
					// 对象验证
					// ValidatorUtils.validateEntity(taskPO, AddGroup.class);
					//记录任务日志
					Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "创建了" + insertDto.getString("task_name"));
					logsDto.put("state", TASK_STATE_1001);
					logsDto.put("task_id", task_id);
					taskLogsService.create(user_id, logsDto);
					
				}
			}
			
		}
		httpModel.setOutMsg("新增任务成功");
	}
	
	
	/**
	 * 需求发布任务
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void demand_publish_task(HttpModel httpModel) {
		Gson gson = new Gson();
		Dto inDto = httpModel.getInDto();
		UserModel userModel = httpModel.getUserModel();
		String username=userModel.getName();
		Integer user_id=userModel.getId();
		List<Dto> details=(List<Dto>) AOSJson.fromJson(inDto.getString("details"));
		if (!details.isEmpty()){
			for (Dto dDto : details){
				List<Integer> handler_user_ids=AOSJson.getList(dDto.getString("handler_user_id"), Integer.class);
				if(!dDto.containsKey("group_id")){
					httpModel.setOutMsg("分组编码不能为空");
					return;
				};
				Integer task_group_id= dDto.getInteger("group_id");
				TaskGroupPO taskGroupPO=taskGroupService.get(task_group_id);
				if(AOSUtils.isEmpty(taskGroupPO)){
					httpModel.setOutMsg("分组不存在");
					return;
				}
				//
				for (Integer handler_user_id : handler_user_ids) {
					Dto insertDto=Dtos.newDto();
					insertDto.putAll(dDto);
					insertDto.put("grade", 10);// 默认分数
					insertDto.put("state", TASK_STATE_1002);// 默认草稿状态
					insertDto.put("handler_user_id", handler_user_id);
					Integer task_id=create(user_id,username,insertDto);
					// 对象验证
					// ValidatorUtils.validateEntity(taskPO, AddGroup.class);
					//记录任务日志
					Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "创建并发布了" + insertDto.getString("task_name"));
					logsDto.put("state", TASK_STATE_1002);
					logsDto.put("task_id", task_id);
					taskLogsService.create(user_id, logsDto);
					
				}
			}
			
		}
		httpModel.setOutMsg("发布任务成功");
	}
	/**
	 * 需求发布任务
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void impowerIssue(HttpModel httpModel) {
		Dto putDto=Dtos.newDto();
		putDto.put("TEAM_USER_ID", httpModel.getUserModel().getId());
		putDto.put("PROJ_ID",httpModel.getInDto().getString("proj_id"));
		int con =(int) sqlDao.selectOne("WeeklyStorage.impowerIssue", putDto);
		httpModel.setOutMsg(String.valueOf(con));
	}
	/**
	 * 需求发布任务
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getmoduleId(HttpModel httpModel) {
		String str=(String) sqlDao.selectOne("WeeklyStorage.getmoduleId", httpModel.getInDto());
		httpModel.setOutMsg(str);
	}
	
	/**
	 * 获取指派人名称
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getHandlerUserID(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String str=(String) sqlDao.selectOne("WeeklyStorage.getHandlerUserID", inDto);
		httpModel.setOutMsg(str);
	}
	
	/**
	 * 获取任务确认人
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getTaskoKUser(HttpModel httpModel) {
		int str=(int) sqlDao.selectOne("WeeklyStorage.getTaskoKUser", httpModel.getInDto());
		httpModel.setOutMsg(String.valueOf(str));
	}
	
	/**
	 * 获取项目经理
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getProjManager(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeeklyStorage.getProjManager", inDto);
		for(Dto dto : list){
			Integer str = dto.getInteger("team_user_id");
			httpModel.setOutMsg(String.valueOf(str));
		}
	}
	
	/**
	 * 获取项目监管
	 * @param httpModel
	 */
	@Transactional
	public void getProjTprCode(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id=httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Integer count = (Integer) sqlDao.selectOne("WeeklyStorage.getProjTprCode", inDto);
		if (count > 0) {
			int str = user_id;
			httpModel.setOutMsg(String.valueOf(str));
		}
		
	}
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listHandlerComboBox(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("Task.listHandlerComboBox", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 导出
	 * 
	 * @param httpModel
	 * @return
	 */
	public void exportExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String[] task_id = inDto.getString("selection").split(",");
		List<Dto> faPOs =  sqlDao.list("Task.testExampleArrayList", task_id);
		for(int k = 0;k<faPOs.size();k++){
			Dto faPO = faPOs.get(k);
			//判断当前状态
			if(Integer.valueOf(faPO.get("state").toString()) == 1001){
				faPO.put("state", "草稿");
			}else if(Integer.valueOf(faPO.get("state").toString()) == 1002){
				faPO.put("state", "已发布");
			}else if(Integer.valueOf(faPO.get("state").toString()) == 1003){
				faPO.put("state", "已接受");
			}else if(Integer.valueOf(faPO.get("state").toString()) == 1004){	
				faPO.put("state", "已完成");
			}else if(Integer.valueOf(faPO.get("state").toString()) == 1005){
				faPO.put("state", "已关闭");
			}
			//判断延期状态
			if(Integer.valueOf(faPO.get("task_delay_state").toString()) == 01){
				faPO.put("task_delay_state", "正常");
			}else if(Integer.valueOf(faPO.get("task_delay_state").toString()) == 02){
				faPO.put("task_delay_state", "延期");
			}
			//判断任务等级
			if(Integer.valueOf(faPO.get("task_level").toString()) == 1010){
				faPO.put("task_level", "一般");
			}else if(Integer.valueOf(faPO.get("task_level").toString()) == 1020){
				faPO.put("task_level", "急");
			}else if(Integer.valueOf(faPO.get("task_level").toString()) == 1030){
				faPO.put("task_level", "加急");
			}else if(Integer.valueOf(faPO.get("task_level").toString()) == 1040){
				faPO.put("task_level", "特急");
			}
			//判断任务类型
			if(Integer.valueOf(faPO.get("task_type").toString()) == 1010){
				faPO.put("task_type", "需求");
			}else if(Integer.valueOf(faPO.get("task_type").toString()) == 1020){
				faPO.put("task_type", "设计");
			}else if(Integer.valueOf(faPO.get("task_type").toString()) == 1030){
				faPO.put("task_type", "开发");
			}else if(Integer.valueOf(faPO.get("task_type").toString()) == 1040){
				faPO.put("task_type", "测试");
			}else if(Integer.valueOf(faPO.get("task_type").toString()) == 1050){
				faPO.put("task_type", "运维");
			}else if(Integer.valueOf(faPO.get("task_type").toString()) == 1090){
				faPO.put("task_type", "其他");
			}
			faPO.put("task_code", faPO.get("task_code"));//任务编码
			//faPO.put("state", faPO.get("state"));//状态
			faPO.put("task_name", faPO.get("task_name"));//任务名称
			//faPO.put("task_delay_state", faPO.get("task_delay_state"));//延期状态
			faPO.put("assign_user_name", faPO.get("assign_user_name"));//指派人
			faPO.put("handler_user_name", faPO.get("handler_user_name"));//处理人
			faPO.put("plan_begin_time", faPO.get("plan_begin_time"));//计划开始时间
			faPO.put("plan_end_time", faPO.get("plan_end_time"));//计划完成时间
			faPO.put("plan_wastage", faPO.get("plan_wastage"));//计划消耗时间
			faPO.put("percent", faPO.get("percent"));//完成比例
			faPO.put("real_begin_time", faPO.get("real_begin_time"));//实际开始时间
			faPO.put("real_end_time", faPO.get("real_end_time"));//实际完成时间
			faPO.put("update_time", faPO.get("update_time"));//更新时间
			faPO.put("real_wastage", faPO.get("real_wastage"));//实际消耗时间
			//faPO.put("task_type", faPO.get("task_type"));//任务类型
			//faPO.put("task_level", faPO.get("task_level"));//任务等级
			faPO.put("proj_name", faPO.get("proj_name"));//项目
			faPO.put("ad_name", faPO.get("ad_name"));//需求
			faPO.put("dm_name", faPO.get("dm_name"));//模块
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		paramsDto.put("reportTitle", "任务跟踪");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/taskManage.xlsx");
		exporter.setFilename("任务跟踪.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	/**
	 * 判断新增时间段
	 * @param httpModel
	 * @return 
	 */
	public void checkBeginEndTime(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		//List<Integer> task_count =  sqlDao.list("Task.judgePlanTime", inDto);
		//Date plan_begin_time = inDto.getDate("plan_begin_time");
		//Date plan_end_time = inDto.getDate("plan_end_time");
		//List<Integer> handler_user_id =inDto.get("handler_user_id");
		String handler_user_id = inDto.getString("handler_user_id");
		String handler_user_id_=handler_user_id.replace("[","");
		String _handler_user_id_=handler_user_id_.replace("]","");
		String[] handler_user_idList=_handler_user_id_.split(",");
//		List<String> handler_user_idList =AOSJson.getList(handler_user_id, String.class);
		inDto.put("handler_user_id", handler_user_idList);
		
		Dto pDto = Dtos.newDto();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String plan_begin_time = dateString.substring(0, 8) + "01";
		String plan_end_time = dateString.substring(0, 8) + day;
		pDto.put("plan_begin_time",plan_begin_time);
		pDto.put("plan_end_time",plan_end_time);
		
//		pDto.put("plan_begin_time",inDto.getDate("plan_begin_time"));
//		pDto.put("plan_end_time",inDto.getDate("plan_end_time"));
		pDto.put("handler_user_id",handler_user_idList);
//		Integer task_count = taskDao.judgePlanTime(pDto);
//		httpModel.setOutMsg(AOSJson.toJson(task_count));
		Double sum_wastage = taskDao.judgePlanWastage(pDto);
		String plan_wastage = inDto.getString("plan_wastage");
		if(sum_wastage == null){
			BigDecimal sum_wastages = new BigDecimal(0);
			BigDecimal plan_wastages = new BigDecimal(plan_wastage);
			BigDecimal num_wastage = sum_wastages.add(plan_wastages);
			httpModel.setOutMsg(AOSJson.toJson(num_wastage));
		}else{
			BigDecimal sum_wastages = new BigDecimal(Double.toString(sum_wastage));
			BigDecimal plan_wastages = new BigDecimal(plan_wastage);
			BigDecimal num_wastage = sum_wastages.add(plan_wastages);
			httpModel.setOutMsg(AOSJson.toJson(num_wastage));
		}
	}
	
	public void checkSumBeginEndTime(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String handler_user_id = inDto.getString("handler_user_id");
		List<String> handler_user_idList =AOSJson.getList(handler_user_id, String.class);
		inDto.put("handler_user_id", handler_user_idList);
		Dto pDto = Dtos.newDto();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String plan_begin_time = dateString.substring(0, 8) + "01";
		String plan_end_time = dateString.substring(0, 8) + day;
		pDto.put("plan_begin_time",plan_begin_time);
		pDto.put("plan_end_time",plan_end_time);
		pDto.put("handler_user_id",handler_user_idList);
		Double sum_wastage = taskDao.judgePlanWastage(pDto);
		httpModel.setOutMsg(AOSJson.toJson(sum_wastage));
	}
	
	/**
	 * 待办进行修改
	 */
	public void updateGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		if(modifies.isEmpty()){
			httpModel.setOutMsg("请先选择需保存的任务!");
			return;
		}
		for(Dto dto : modifies){
			taskDao.taskUpdateByKey(dto);
		}
		httpModel.setOutMsg("修改成功");
	}
	
	public static void main(String[] args) {
		System.out.println(AOSUtils.getDateTime());

		System.out.println(AOSUtils.getDateTime());
	}
	
	//查询所有父节点
	public void getParentId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String group_name_all = "";
		List<Integer> group_ids = new ArrayList<Integer>();
		int group_id = inDto.getInteger("group_id");
		group_ids.add(group_id);
		List<Integer> groupIdList = findParentId(group_ids);
		groupIdList.add(group_id);
		for(Integer inte : groupIdList){
			String groupName = (String) sqlDao.selectOne("Task.selectGroupName", inte);
			if(AOSUtils.isEmpty(groupName)){
				groupName = "";
			}
			group_name_all = group_name_all + "--" +groupName;
		}
		String group_name = group_name_all.substring(4);
		Dto dto = Dtos.newDto();
		dto.put("group_name_all", group_name);
		httpModel.setOutMsg(AOSJson.toJson(dto));
	}
	
	public List<Integer> findParentId(List<Integer> group_ids) {
		Dto inDto = Dtos.newDto();
		inDto.put("group_ids", group_ids);
		List<Integer> groupId =  sqlDao.list("Task.selectParentId", inDto);
		if(!groupId.contains(0)){
			group_ids.addAll(groupId);
//			return findParentId(group_ids);
			return group_ids;
		}else{
			return groupId;
		}
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void taskHandlerUserPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("Task.taskHandlerUserPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void taskHandlerUsersPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("Task.taskHandlerUsersPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 常用联系人列表
	 * 
	 * @param httpModel
	 */
	public void topContactsPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		List<Dto> list = sqlDao.list("Task.topContactsPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 负责人部门下拉框
	 */
	public void listPrincipalOrg(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("Task.listPrincipalOrg", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
}

