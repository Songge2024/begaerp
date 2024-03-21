package com.bl3.pm.task.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.task.dao.TaskLogsDao;
import com.bl3.pm.task.dao.po.TaskLogsPO;

/**
 * <b>ta_task_logs[ta_task_logs]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2018-01-02 11:34:18
 */
 @Service
 public class TaskLogsService{
 	private static Logger logger = LoggerFactory.getLogger(TaskLogsService.class);
 	@Autowired
	private TaskLogsDao taskLogsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	

	/**
	 * 新增
	 * @return
	 */
	public Integer create(Integer user_id,Dto insertDto){
		TaskLogsPO taskLogsPO=new TaskLogsPO();
		Integer task_logs_id=idService.nextValue("seq_ta_task_logs").intValue();
		taskLogsPO.setLog_id(task_logs_id);
		taskLogsPO.copyProperties(insertDto);
		taskLogsPO.setUpdate_time(AOSUtils.getDateTime());
		taskLogsPO.setUpdate_user_id(user_id);
		Integer maxSerialNo=(Integer) sqlDao.selectOne("Task.selectMaxSerialNo", Dtos.newDto("task_id", insertDto.get("task_id")));
		taskLogsPO.setSerial_no(maxSerialNo);
		taskLogsDao.insert(taskLogsPO);
		return task_logs_id;
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TaskLogsPO> taskLogsPOs = taskLogsDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskLogsPOs, inDto.getPageTotal()));
	}
 }