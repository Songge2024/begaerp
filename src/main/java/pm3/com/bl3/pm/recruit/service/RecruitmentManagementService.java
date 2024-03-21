package com.bl3.pm.recruit.service;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.recruit.dao.RecruitmentManagementDao;
import com.bl3.pm.recruit.dao.po.RecruitmentManagementPO;

/**
 * <b>bs_recruitment_management[bs_recruitment_management]业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-05-11 09:28:09
 */
 @Service
 public class RecruitmentManagementService{
 	private static Logger logger = LoggerFactory.getLogger(RecruitmentManagementService.class);
 	@Autowired
	private RecruitmentManagementDao recruitmentManagementDao;
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
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		httpModel.setAttribute("userid", httpModel.getUserModel().getId());
		httpModel.setAttribute("time", AOSUtils.getDateStr());
		httpModel.setAttribute("timeout", AOSUtils.getDateStr());
		httpModel.setViewPath("pm3/recruit/codes/recruitmentManagement_layout.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		RecruitmentManagementPO recruitmentManagementPO=new RecruitmentManagementPO();
		recruitmentManagementPO.setRegister_id(idService.nextValue("seq_bs_recruitment_management").intValue());
		recruitmentManagementPO.copyProperties(inDto);
		recruitmentManagementPO.setCreate_time(AOSUtils.getDate());
		recruitmentManagementPO.setCreate_user_id(httpModel.getUserModel().getId());
		recruitmentManagementDao.insert(recruitmentManagementPO);
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
		RecruitmentManagementPO recruitmentManagementPO=new RecruitmentManagementPO();
		recruitmentManagementPO.copyProperties(inDto);
		if(AOSUtils.isNotEmpty(recruitmentManagementPO.getContact_date())){
			recruitmentManagementPO.setState("2");
		}else if(AOSUtils.isNotEmpty(recruitmentManagementPO.getEntry_date())){
			recruitmentManagementPO.setState("4");
		}
		recruitmentManagementPO.setUpdate_time(AOSUtils.getDate());
		recruitmentManagementPO.setUpdate_user_id(httpModel.getUserModel().getId());
		recruitmentManagementDao.updateByKey(recruitmentManagementPO);
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
			recruitmentManagementDao.deleteByKey(Integer.valueOf(id));
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
		RecruitmentManagementPO recruitmentManagementPO=recruitmentManagementDao.selectByKey(inDto.getInteger("register_id"));
		httpModel.setOutMsg(AOSJson.toJson(recruitmentManagementPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto>list=sqlDao.list("com.bl3.pm.recruit.dao.RecruitmentManagementDao.queryRecruitinfo", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] Id = inDto.getString("selection").split(",");
		inDto.put("Id", Id);
		List<Dto> faPOs = sqlDao.list("com.bl3.pm.recruit.dao.RecruiterResultDao.queryRecruitList", inDto);
		ExcelExporter exporter = new ExcelExporter();
		Dto paramsDto = Dtos.newDto();
		paramsDto.put("reportTitle", "招聘一览表");
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		paramsDto.put("sum", faPOs.size());
		paramsDto.put("tab_name", "招聘一览表");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/recruitList.xls");
		//exporter.setFieldsList(fieldsList);
		exporter.setFilename("招聘一览表.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
 }