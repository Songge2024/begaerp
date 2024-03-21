package com.bl3.pm.markdown.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


/**
 * 
 * @author hege
 * @date 2018-3-5 11:17:18
 */
@Service
public class markDownEchartService {
	private static Logger logger = LoggerFactory.getLogger(markDownEchartService.class);
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
		httpModel.setViewPath("showcase/misc/markDownEchartDemo.jsp");
	}

}