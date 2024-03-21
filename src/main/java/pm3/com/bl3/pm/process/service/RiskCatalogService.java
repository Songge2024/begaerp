package com.bl3.pm.process.service;

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


import com.bl3.pm.process.dao.RiskCatalogDao;
import com.bl3.pm.process.dao.po.RiskCatalogPO;

/**
 * <b>pr_risk_catalog[pr_risk_catalog]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2018-01-09 09:18:47
 */
 @Service
 public class RiskCatalogService{
 	private static Logger logger = LoggerFactory.getLogger(RiskCatalogService.class);
 	@Autowired
	private RiskCatalogDao riskCatalogDao;
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
		httpModel.setViewPath("pm3/process/riskCatalog/riskCatalog_layout.jsp");
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
		RiskCatalogPO riskCatalogPO=new RiskCatalogPO();
		int create_user_id = httpModel.getUserModel().getId();
	//	riskCatalogPO.setRisk_cata_id(idService.nextValue("seq_pr_risk_catalog").intValue());
		riskCatalogPO.copyProperties(inDto);
		riskCatalogPO.setCreate_user_id(create_user_id);
		riskCatalogPO.setState("0");
		riskCatalogDao.insert(riskCatalogPO);
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
		int update_user_id = httpModel.getUserModel().getId();
		RiskCatalogPO riskCatalogPO=new RiskCatalogPO();
		riskCatalogPO.copyProperties(inDto);
		riskCatalogPO.setUpdate_user_id(update_user_id);
		riskCatalogDao.updateByKey(riskCatalogPO);
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
		int update_user_id = httpModel.getUserModel().getId();
		for (String id : selectionIds) {
			inDto.put("risk_cata_id", id);
			inDto.put("update_user_id", update_user_id);
			riskCatalogDao.updateState(inDto);
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
		RiskCatalogPO riskCatalogPO=riskCatalogDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(riskCatalogPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<RiskCatalogPO> riskCatalogPOs = riskCatalogDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(riskCatalogPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 启用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void enable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			riskCatalogDao.enableByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("启用成功");
	}
	
	/**
	 * 停用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void disable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			riskCatalogDao.disableByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("停用成功");
	}
	
 }