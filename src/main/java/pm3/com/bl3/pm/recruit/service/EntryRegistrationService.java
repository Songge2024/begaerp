package com.bl3.pm.recruit.service;

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


import com.bl3.pm.recruit.dao.EntryRegistrationDao;
import com.bl3.pm.recruit.dao.po.EntryRegistrationPO;

/**
 * <b>bs_entry_registration[bs_entry_registration]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2018-04-20 16:20:30
 */
 @Service
 public class EntryRegistrationService{
 	private static Logger logger = LoggerFactory.getLogger(EntryRegistrationService.class);
 	@Autowired
	private EntryRegistrationDao entryRegistrationDao;
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
		httpModel.setViewPath("pm3/recruit/entryRegistration/entryRegistration_layout.jsp");
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
		EntryRegistrationPO entryRegistrationPO=new EntryRegistrationPO();
	//	entryRegistrationPO.setId(idService.nextValue("seq_bs_entry_registration").intValue());
		entryRegistrationPO.copyProperties(inDto);
		entryRegistrationPO.setCreate_time(AOSUtils.getDate());
		entryRegistrationPO.setCreate_user_id(httpModel.getUserModel().getId());
		entryRegistrationDao.insert(entryRegistrationPO);
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
		EntryRegistrationPO entryRegistrationPO=new EntryRegistrationPO();
		entryRegistrationPO.copyProperties(inDto);
		entryRegistrationPO.setUpdate_time(AOSUtils.getDate());
		entryRegistrationPO.setUpdate_user_id(httpModel.getUserModel().getId());
		entryRegistrationDao.updateByKey(entryRegistrationPO);
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
			entryRegistrationDao.deleteByKey(Integer.valueOf(id));
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
		EntryRegistrationPO entryRegistrationPO=entryRegistrationDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(entryRegistrationPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<EntryRegistrationPO> entryRegistrationPOs = sqlDao.list("com.bl3.pm.recruit.dao.EntryRegistrationDao.queryEnterRegistrationRecord", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(entryRegistrationPOs, inDto.getPageTotal()));
	}
 }