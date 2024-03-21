package com.bl3.pm.quality.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.quality.dao.FilesManageLogsDao;
import com.bl3.pm.quality.dao.po.FilesManageLogsPO;
import com.bl3.pm.task.dao.po.TaskLogsPO;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

@Service
public class FilesManageLogsService {
	private static Logger logger = LoggerFactory.getLogger(FilesManageLogsService.class);
	@Autowired
	private FilesManageLogsDao filesManageLogsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 新增
	 * @return
	 */
	public Integer create(Integer user_id,Dto insertDto){
		FilesManageLogsPO filesManageLogsPO=new FilesManageLogsPO();
		Integer files_logs_id=idService.nextValue("seq_qa_files_manage_logs").intValue();
		filesManageLogsPO.setLog_id(files_logs_id);
		filesManageLogsPO.copyProperties(insertDto);
		filesManageLogsPO.setUpdate_time(AOSUtils.getDateTime());
		filesManageLogsPO.setUpdate_user_id(user_id);
		Integer maxSerialNo=(Integer) sqlDao.selectOne("com.bl3.pm.quality.dao.FilesManageDao.selectMaxSerialNo", Dtos.newDto("manage_id", insertDto.get("manage_id")));
		filesManageLogsPO.setSerial_no(maxSerialNo);
		filesManageLogsDao.insert(filesManageLogsPO);
		return files_logs_id;
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<FilesManageLogsPO> filesManageLogsPOs = filesManageLogsDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(filesManageLogsPOs, inDto.getPageTotal()));
	}
}
