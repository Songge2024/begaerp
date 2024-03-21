package com.bl3.pm.basic.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.basic.dao.ProjClientContactsDao;
import com.bl3.pm.basic.dao.po.ProjClientContactsPO;

/**
 * <b>bs_proj_client_contacts[bs_proj_client_contacts]业务逻辑层</b>
 * 
 * @author yj
 * @date 2017-12-13 14:59:53
 */
 @Service
 public class ProjClientContactsService{
 	private static Logger logger = LoggerFactory.getLogger(ProjClientContactsService.class);
 	@Autowired
	private ProjClientContactsDao projClientContactsDao;
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
		httpModel.setViewPath("projClientContacts/projClientContacts_list.jsp");
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
		ProjClientContactsPO projClientContactsPO=new ProjClientContactsPO();
//		projClientContactsPO.setCont_id(idService.nextValue("seq_bs_proj_client_contacts").intValue());
		projClientContactsPO.copyProperties(inDto);
		projClientContactsDao.insert(projClientContactsPO);
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
		ProjClientContactsPO projClientContactsPO=new ProjClientContactsPO();
		projClientContactsPO.copyProperties(inDto);
		projClientContactsDao.updateByKey(projClientContactsPO);
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
			projClientContactsDao.deleteByKey(Integer.valueOf(id));
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
		ProjClientContactsPO projClientContactsPO=projClientContactsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projClientContactsPO));
	}

	/**
	 * 分页查询项目基础信息
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjClientContactsDao.queryProjContactDataPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
	}
 }