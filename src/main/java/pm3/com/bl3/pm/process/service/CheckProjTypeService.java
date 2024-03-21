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


import com.bl3.pm.process.dao.CheckProjTypeDao;
import com.bl3.pm.process.dao.po.CheckProjTypePO;

/**
 * <b>pr_check_proj_type[pr_check_proj_type]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-10 19:46:37
 */
 @Service
 public class CheckProjTypeService{
 	private static Logger logger = LoggerFactory.getLogger(CheckProjTypeService.class);
 	@Autowired
	private CheckProjTypeDao checkProjTypeDao;
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
		httpModel.setViewPath("pm3/process/checkItemCatalog/checkProjType_list.jsp");
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
		CheckProjTypePO checkProjTypePO=new CheckProjTypePO();
		//checkProjTypePO.setId(idService.nextValue("seq_pr_check_proj_type").intValue());
		checkProjTypePO.copyProperties(inDto);
		checkProjTypeDao.insert(checkProjTypePO);
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
		CheckProjTypePO checkProjTypePO=new CheckProjTypePO();
		checkProjTypePO.copyProperties(inDto);
		checkProjTypeDao.updateByKey(checkProjTypePO);
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
			checkProjTypeDao.deleteByKey(String.valueOf(id));
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
		CheckProjTypePO checkProjTypePO=checkProjTypeDao.selectByKey(inDto.getString("id"));
		httpModel.setOutMsg(AOSJson.toJson(checkProjTypePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckProjTypePO> checkProjTypePOs = checkProjTypeDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkProjTypePOs, inDto.getPageTotal()));
	}
 }