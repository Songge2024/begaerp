package com.bl3.pm.basic.service;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.bl3.pm.basic.dao.ProjRoleTypesDao;
import com.bl3.pm.basic.dao.po.ProjRoleTypesPO;
import com.bl3.pm.basic.dao.po.ProjTypesPO;

/**
 * <b>bs_proj_role_types[bs_proj_role_types]业务逻辑层</b>
 * 
 * @author hege
 * @date 2017-12-18 11:40:02
 */
 @Service
 public class ProjRoleTypesService{
 	private static Logger logger = LoggerFactory.getLogger(ProjRoleTypesService.class);
 	@Autowired
	private ProjRoleTypesDao projRoleTypesDao;
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
		httpModel.setViewPath("pm3/basic/projroletypes/projRoleTypes.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjRoleTypesPO projRoleTypesPO=new ProjRoleTypesPO();
		projRoleTypesPO.copyProperties(inDto);
		projRoleTypesPO.setTrp_code(idService.nextValue("seq_proj_role_type").toString());
		projRoleTypesPO.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time=AOSUtils.getDateTime();
		projRoleTypesPO.setCreate_time(create_time);
		projRoleTypesDao.insert(projRoleTypesPO);
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
		ProjRoleTypesPO projTypesPO=new ProjRoleTypesPO();
		projTypesPO.copyProperties(inDto);
		projTypesPO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time=AOSUtils.getDateTime();
		projTypesPO.setUpdate_time(update_time);
		projRoleTypesDao.updateByKey(projTypesPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 修改状态
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			ProjRoleTypesPO upPO = projRoleTypesDao.selectByKey(String.valueOf(id)); 
			upPO.copyProperties(inDto);
			if (AOSUtils.isEmpty(upPO)) {
				continue;
			}
			upPO.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time=AOSUtils.getDateTime();
			upPO.setUpdate_time(update_time);
			upPO.setState(inDto.getString("state"));
			projRoleTypesDao.updateByKey(upPO);
		}
		httpModel.setOutMsg("启用成功");
	}
	/**
	 * 删除项目角色分类信息
	 * 
	 * @param httpModel
	 */
	public void delProjRoleInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			projRoleTypesDao.deleteByKey(String.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
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
			projRoleTypesDao.deleteByKey(String.valueOf(id));
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
		ProjRoleTypesPO projRoleTypesPO=projRoleTypesDao.selectByKey(inDto.getString("id"));
		httpModel.setOutMsg(AOSJson.toJson(projRoleTypesPO));
	}
	/**
	 * 查询系统角色下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxRoleData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.basic.dao.ProjRoleTypesDao.listComboBoxRoleData", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjRoleTypesDao.listModulesPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, inDto.getPageTotal()));
	}
	
	/**
	 * 有效角色人员查询
	 * 
	 * @param httpModel
	 */
	public void queryPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjRoleTypesDao.listRolePage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, inDto.getPageTotal()));
	}
 }