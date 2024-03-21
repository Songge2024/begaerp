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


import com.bl3.pm.process.dao.PreservePointDao;
import com.bl3.pm.process.dao.po.PreservePointPO;

/**
 * <b>pr_preserve_point[pr_preserve_point]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-22 13:44:43
 */
 @Service
 public class PreservePointService{
 	private static Logger logger = LoggerFactory.getLogger(PreservePointService.class);
 	@Autowired
	private PreservePointDao preservePointDao;
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
		httpModel.setViewPath("pm3/process/point/preservePoint_layout.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		PreservePointPO preservePointPO = new PreservePointPO();
		preservePointPO.copyProperties(inDto);
		preservePointDao.insert(preservePointPO);
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
		PreservePointPO preservePointPO=new PreservePointPO();
		preservePointPO.copyProperties(inDto);
		preservePointDao.updateByKey(preservePointPO);
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
			preservePointDao.deleteByKey(Integer.valueOf(id));
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
		PreservePointPO preservePointPO=preservePointDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(preservePointPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<PreservePointPO> preservePointPOs = preservePointDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(preservePointPOs, inDto.getPageTotal()));
	}
 }