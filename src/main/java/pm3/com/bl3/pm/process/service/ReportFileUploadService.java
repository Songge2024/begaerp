package com.bl3.pm.process.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import aos.framework.web.router.HttpModel;

/**
 * <b>pr_report_file_manage[pr_report_file_manage]业务逻辑层</b>
 * 
 * @author heying
 * @date 2018-01-11 11:26:58
 */
 @Service
 public class ReportFileUploadService{
 	private static Logger logger = LoggerFactory.getLogger(ReportFileUploadService.class);
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/process/reportFileUpload/reportFileUpload_list.jsp");
	}
 }