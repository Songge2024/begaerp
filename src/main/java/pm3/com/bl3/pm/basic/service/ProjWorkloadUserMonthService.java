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


import com.bl3.pm.basic.dao.ProjWorkloadUserMonthDao;
import com.bl3.pm.basic.dao.po.ProjWorkloadUserMonthPO;

/**
 * <b>st_proj_workload_user_month[st_proj_workload_user_month]业务逻辑层</b>
 * 
 * @author zocl
 * @date 2018-05-26 22:48:54
 */
 @Service
 public class ProjWorkloadUserMonthService{
 	private static Logger logger = LoggerFactory.getLogger(ProjWorkloadUserMonthService.class);
 	@Autowired
	private ProjWorkloadUserMonthDao projWorkloadUserMonthDao;
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
		httpModel.setViewPath("projWorkloadUserMonth/projWorkloadUserMonth_list.jsp");
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
		ProjWorkloadUserMonthPO projWorkloadUserMonthPO=new ProjWorkloadUserMonthPO();
	//	projWorkloadUserMonthPO.setId(idService.nextValue("seq_st_proj_workload_user_month").intValue());
		projWorkloadUserMonthPO.copyProperties(inDto);
//		projWorkloadUserMonthDao.insert(projWorkloadUserMonthPO);
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
		ProjWorkloadUserMonthPO projWorkloadUserMonthPO=new ProjWorkloadUserMonthPO();
		projWorkloadUserMonthPO.copyProperties(inDto);
		projWorkloadUserMonthDao.updateByKey(projWorkloadUserMonthPO);
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
			projWorkloadUserMonthDao.deleteByKey(Integer.valueOf(id));
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
		ProjWorkloadUserMonthPO projWorkloadUserMonthPO=projWorkloadUserMonthDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projWorkloadUserMonthPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> projWorkloadUserMonthPOs = projWorkloadUserMonthDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projWorkloadUserMonthPOs, inDto.getPageTotal()));
	}
 }