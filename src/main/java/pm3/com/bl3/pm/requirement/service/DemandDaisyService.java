package com.bl3.pm.requirement.service;

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


/**
 * <b>re_demand_action[re_demand_action]业务逻辑层</b>
 * 
 * @author hege
 * @date 2017-12-20 11:08:28
 */
 @Service
 public class DemandDaisyService{
 	private static Logger logger = LoggerFactory.getLogger(DemandDaisyService.class);
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
		httpModel.setViewPath("pm3/requirement/demandDaisy/demandDaisy.jsp");
	}
	/**
	 * 查询需求变更跟踪列表
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listDemandDaisyPage(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("demandDaisy.listDemandDaisyPage", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, qDto.getPageTotal()));
	}
	/**
	 * 查询设计，编码，测试的完成情况
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listMutiModelState(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("demandDaisy.listMutiModelState", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, qDto.getPageTotal()));
	}
 }