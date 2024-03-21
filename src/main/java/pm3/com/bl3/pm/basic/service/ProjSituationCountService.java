package com.bl3.pm.basic.service;

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

import com.bl3.pm.basic.dao.ProjSituationCountDao;

/**
 * <b>bs_proj_situation_count[bs_proj_situation_count]业务逻辑层</b>
 * 
 * @author zoucl
 * @date 2018-06-15 11:32:07
 */
 @Service
 public class ProjSituationCountService{
 	private static Logger logger = LoggerFactory.getLogger(ProjSituationCountService.class);
 	@Autowired
	private ProjSituationCountDao projSituationCountDao;
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
		httpModel.setViewPath("pm3/quality/prosituationcount/projSituationCount_layout.jsp");
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void selectPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> projSituationCountPOs = projSituationCountDao.selectPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projSituationCountPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("start", 0);
		inDto.put("limit", 50);
		List<Dto> faPOs = projSituationCountDao.selectPage(inDto);
		ExcelExporter exporter=new ExcelExporter();
		Dto paramsDto=Dtos.newDto();
		paramsDto.put("reportTitle","项目整体情况汇总表");
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		paramsDto.put("tab_name", "项目情况汇总");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/projCaseCount1.xlsx");
		exporter.setFilename("项目整体情况汇总.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
 }