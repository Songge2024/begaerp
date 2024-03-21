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


import com.bl3.pm.basic.dao.ProjWorkloadMonthDao;
import com.bl3.pm.basic.dao.po.ProjWorkloadMonthPO;

/**
 * <b>st_proj_workload_month[st_proj_workload_month]业务逻辑层</b>
 * 
 * @author zocl
 * @date 2018-05-26 21:01:53
 */
 @Service
 public class ProjWorkloadMonthService{
 	private static Logger logger = LoggerFactory.getLogger(ProjWorkloadMonthService.class);
 	@Autowired
	private ProjWorkloadMonthDao projWorkloadMonthDao;
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
		httpModel.setViewPath("projWorkloadMonth/projWorkloadMonth_list.jsp");
	}
/*	*//**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 *//*
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		ProjWorkloadMonthPO projWorkloadMonthPO=new ProjWorkloadMonthPO();
	//	projWorkloadMonthPO.setId(idService.nextValue("seq_st_proj_workload_month").intValue());
		projWorkloadMonthPO.copyProperties(inDto);
		projWorkloadMonthDao.insert(projWorkloadMonthPO);
		httpModel.setOutMsg("新增成功");
	}*/
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		ProjWorkloadMonthPO projWorkloadMonthPO=new ProjWorkloadMonthPO();
		projWorkloadMonthPO.copyProperties(inDto);
		projWorkloadMonthDao.updateByKey(projWorkloadMonthPO);
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
			projWorkloadMonthDao.deleteByKey(Integer.valueOf(id));
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
		ProjWorkloadMonthPO projWorkloadMonthPO=projWorkloadMonthDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projWorkloadMonthPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> projWorkloadMonthPOs = projWorkloadMonthDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projWorkloadMonthPOs, inDto.getPageTotal()));
	}
 }