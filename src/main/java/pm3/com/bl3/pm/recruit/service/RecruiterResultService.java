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


import com.bl3.pm.recruit.dao.RecruiterResultDao;
import com.bl3.pm.recruit.dao.po.RecruiterResultPO;

/**
 * <b>bs_recruiter_result[bs_recruiter_result]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2018-04-17 17:14:23
 */
 @Service
 public class RecruiterResultService{
 	private static Logger logger = LoggerFactory.getLogger(RecruiterResultService.class);
 	@Autowired
	private RecruiterResultDao recruiterResultDao;
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
		httpModel.setViewPath("pm3/recruit/recruitList/recruiterList_layout.jsp");
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
		RecruiterResultPO recruiterResultPO=new RecruiterResultPO();
	//	recruiterResultPO.setId(idService.nextValue("seq_bs_recruiter_result").intValue());
		recruiterResultPO.copyProperties(inDto);
		recruiterResultDao.insert(recruiterResultPO);
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
		RecruiterResultPO recruiterResultPO=new RecruiterResultPO();
		recruiterResultPO.copyProperties(inDto);
		recruiterResultDao.updateByKey(recruiterResultPO);
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
			recruiterResultDao.deleteByKey(Integer.valueOf(id));
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
		RecruiterResultPO recruiterResultPO=recruiterResultDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(recruiterResultPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<RecruiterResultPO> recruiterResultPOs = sqlDao.list("com.bl3.pm.recruit.dao.RecruiterResultDao.queryRecruitList", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(recruiterResultPOs, inDto.getPageTotal()));
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