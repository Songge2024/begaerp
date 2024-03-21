package com.bl3.pm.process.service;

import java.util.Date;
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


import com.bl3.pm.process.dao.CheckCatalogDao;
import com.bl3.pm.process.dao.po.CheckCatalogPO;

/**
 * <b>pr_check_catalog[pr_check_catalog]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-10 13:57:28
 */
 @Service
 public class CheckCatalogService{
 	private static Logger logger = LoggerFactory.getLogger(CheckCatalogService.class);
 	@Autowired
	private CheckCatalogDao checkCatalogDao;
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
		httpModel.setViewPath("checkCatalog/checkCatalog_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer id = httpModel.getUserModel().getId();
		int result = checkCatalogDao.catalogCount(inDto.getString("type_code"),inDto.getString("check_cata_name"));
		if(result == 1){
			httpModel.setOutMsg("存在重名检查项。");
			return;
		}
		CheckCatalogPO checkCatalogPO=new CheckCatalogPO();
		checkCatalogPO.copyProperties(inDto);
		checkCatalogPO.setCreate_user_id(id);
		checkCatalogPO.setCreate_time(new Date());
		checkCatalogPO.setState("0");
		checkCatalogDao.insert(checkCatalogPO);
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
		int result = checkCatalogDao.catalogOtCount(inDto.getString("type_code"),inDto.getString("check_cata_name"),inDto.getString("check_cata_id"));
		if(result == 0){
			Integer id = httpModel.getUserModel().getId();
			CheckCatalogPO checkCatalogPO=new CheckCatalogPO();
			checkCatalogPO.copyProperties(inDto);
			checkCatalogPO.setUpdate_user_id(id);
			checkCatalogPO.setUpdate_time(new Date());
			checkCatalogDao.updateByKey(checkCatalogPO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("无法修改，存在重名的检查项。");
			return;
		}
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
		String state = inDto.getString("state");
		if(state.equals("-1")){
			for (String id : selectionIds) {
				checkCatalogDao.deleteByKey(Integer.valueOf(id));
				checkCatalogDao.deleteItemByKey(Integer.valueOf(id));
			}
			httpModel.setOutMsg("删除成功");
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				checkCatalogDao.cataStopByKey(Integer.valueOf(id));
				checkCatalogDao.itemStopByKey(Integer.valueOf(id));
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for(String id : selectionIds){
				checkCatalogDao.cataRunByKey(Integer.valueOf(id));
				checkCatalogDao.itemRunByKey(Integer.valueOf(id));
			}
			httpModel.setOutMsg("启用成功");
		}
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		CheckCatalogPO checkCatalogPO=checkCatalogDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(checkCatalogPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckCatalogPO> checkCatalogPOs = checkCatalogDao.likePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkCatalogPOs, inDto.getPageTotal()));
	}
 }