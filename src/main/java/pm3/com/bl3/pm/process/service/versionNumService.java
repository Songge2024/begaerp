package com.bl3.pm.process.service;

import aos.framework.core.typewrap.Dto;
import aos.framework.web.router.HttpModel;

public class versionNumService {
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel){
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/process/checkItemCatalog/versionNum_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		
	}
}
