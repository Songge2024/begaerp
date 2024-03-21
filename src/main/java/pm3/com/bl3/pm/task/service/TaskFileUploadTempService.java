package com.bl3.pm.task.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.task.dao.TaskFileUploadTempDao;
import com.bl3.pm.task.dao.po.TaskFileUploadPO;
import com.bl3.pm.task.dao.po.TaskFileUploadTempPO;

/**
 * <b>ta_task_file_upload_temp[ta_task_file_upload_temp]业务逻辑层</b>
 * 
 * @author zhaojiaqi
 * @date 2020-07-14 16:28:10
 */
 @Service
 public class TaskFileUploadTempService{
 	private static Logger logger = LoggerFactory.getLogger(TaskFileUploadTempService.class);
 	@Autowired
	private TaskFileUploadTempDao taskFileUploadTempDao;
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
		httpModel.setViewPath("taskFileUploadTemp/taskFileUploadTemp_list.jsp");
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
		TaskFileUploadTempPO taskFileUploadTempPO=new TaskFileUploadTempPO();
		taskFileUploadTempPO.copyProperties(inDto);
		taskFileUploadTempDao.insert(taskFileUploadTempPO);
		httpModel.setOutMsg("新增成功");
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		TaskFileUploadTempPO taskFileUploadTempPO=new TaskFileUploadTempPO();
		taskFileUploadTempPO.copyProperties(inDto);
		taskFileUploadTempDao.updateByKey(taskFileUploadTempPO);
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
		String[] codes = inDto.getString("temp_file_id").split(",");
		for (int a = 0; a < codes.length; a++) {
			if (!codes[a].isEmpty()) {
				TaskFileUploadTempPO dto = new TaskFileUploadTempPO();
				dto = taskFileUploadTempDao.selectByKey(Integer.parseInt(codes[a]));
				if (AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getFile_path())) {
					String path = dto.getFile_path();
					File file = new File(path);
					file.delete();
				}
				taskFileUploadTempDao.deleteByKey(Integer.parseInt(codes[a]));
			}
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TaskFileUploadTempPO taskFileUploadTempPO=taskFileUploadTempDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(taskFileUploadTempPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TaskFileUploadTempPO> taskFileUploadTempPOs = taskFileUploadTempDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskFileUploadTempPOs, inDto.getPageTotal()));
	}
 }