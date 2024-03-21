package com.bl3.pm.quality.service;

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


import aos.system.common.utils.SystemCons;

import com.bl3.pm.quality.dao.MessageDao;
import com.bl3.pm.quality.dao.po.FilesManagePO;
import com.bl3.pm.quality.dao.po.MessagePO;
import com.bl3.pm.quality.dao.po.ReplyNewsPO;

/**
 * <b>qa_message[qa_message]业务逻辑层</b>
 * 
 * @author z
 * @date 2017-12-31 16:09:28
 */
 @Service
 public class MessageService{
 	private static Logger logger = LoggerFactory.getLogger(MessageService.class);
 	@Autowired
	private MessageDao messageDao;
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
		httpModel.setViewPath("pm3/quality/message/message_layout.jsp");
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
		MessagePO messagePO=new MessagePO();
	//	messagePO.setId(idService.nextValue("seq_qa_message").intValue());
		messagePO.copyProperties(inDto);
		messageDao.insert(messagePO);
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
		MessagePO messagePO=new MessagePO();
		messagePO.copyProperties(inDto);
		messageDao.updateByKey(messagePO);
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
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			MessagePO messagePOs=messageDao.selectByKey(Integer.valueOf(id));
			messageDao.deleteByKey(Integer.valueOf(id));
			ReplyNewsPO replyNewsPOs=new ReplyNewsPO();
			String  Opinion_code   =    messagePOs.getOpinion_code();
			String  User_name   =    messagePOs.getUser_name();
			replyNewsPOs.setText_code(Opinion_code);
			replyNewsPOs.setText_name(User_name);
			sqlDao.delete("WeeklyStorage.updateFlagrelyidByKey",replyNewsPOs);
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
		MessagePO messagePO=messageDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(messagePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int getId=httpModel.getUserModel().getId();
		inDto.put("user_id", getId);
		List<MessagePO> messagePOs =  sqlDao.list("WeeklyStorage.listmessagePage",inDto); 
		httpModel.setOutMsg(AOSJson.toGridJson(messagePOs, inDto.getPageTotal()));
	}
 }