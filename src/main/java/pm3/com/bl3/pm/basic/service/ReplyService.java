package com.bl3.pm.basic.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.basic.dao.ReplyDao;
import com.bl3.pm.basic.dao.po.ReplyPO;

/**
 * <b>bs_reply[bs_reply]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2018-01-24 15:46:53
 */
 @Service
 public class ReplyService{
 	private static Logger logger = LoggerFactory.getLogger(ReplyService.class);
 	@Autowired
	private ReplyDao replyDao;
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
		httpModel.setViewPath("reply/reply_list.jsp");
	}
	/**
	 * 
	 * @param insertDto
	 * @return
	 */
	@Transactional
	public Integer create(Dto insertDto){
		ReplyPO replyPO=new ReplyPO();
		Integer id=idService.nextValue("seq_bs_reply").intValue();
		replyPO.copyProperties(insertDto);
		replyPO.setId(id);
		replyDao.insert(replyPO);
		return id;
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
		ReplyPO replyPO=new ReplyPO();
		replyPO.setId(idService.nextValue("seq_bs_reply").intValue());
		replyPO.copyProperties(inDto);
		replyDao.insert(replyPO);
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
		ReplyPO replyPO=new ReplyPO();
		replyPO.copyProperties(inDto);
		replyDao.updateByKey(replyPO);
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
			replyDao.deleteByKey(Integer.valueOf(id));
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
		ReplyPO replyPO=replyDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(replyPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ReplyPO> replyPOs = replyDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(replyPOs, inDto.getPageTotal()));
	}
 }