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


import com.bl3.pm.basic.dao.ProjCodeVersionDao;
import com.bl3.pm.basic.dao.po.ProjCodeVersionPO;

/**
 * <b>bs_proj_code_version[bs_proj_code_version]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-03-08 13:39:11
 */
 @Service
 public class ProjCodeVersionService{
 	private static Logger logger = LoggerFactory.getLogger(ProjCodeVersionService.class);
 	@Autowired
	private ProjCodeVersionDao projCodeVersionDao;
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
		httpModel.setViewPath("projCodeVersion/projCodeVersion_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int result = projCodeVersionDao.codeVersionNumberCount(inDto.getString("code_version_number"),inDto.getInteger("test_version_id"));
		if(result == 1){
			httpModel.setOutMsg("代码版本号已存在!");
			return;
		}
		Integer create_id = httpModel.getUserModel().getId();
		ProjCodeVersionPO projCodeVersionPO=new ProjCodeVersionPO();
		projCodeVersionPO.copyProperties(inDto);
		projCodeVersionPO.setCreate_id(create_id);
		projCodeVersionPO.setCreate_time(new Date());
		projCodeVersionPO.setState("0");
		projCodeVersionDao.insert(projCodeVersionPO);
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
		int result = projCodeVersionDao.codeVersionNumberCount1(inDto.getString("code_version_number"),inDto.getInteger("test_version_id"),inDto.getInteger("code_version_id"));
		if(result == 0){
			ProjCodeVersionPO projCodeVersionPO=new ProjCodeVersionPO();
			Integer update_id = httpModel.getUserModel().getId();
			projCodeVersionPO.copyProperties(inDto);
			projCodeVersionPO.setUpdate_id(update_id);
			projCodeVersionPO.setUpdate_time(new Date());
			projCodeVersionDao.updateByKey(projCodeVersionPO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("无法修改，代码版本号已存在!");
			return;
		}
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
		String state = inDto.getString("state");
		List<ProjCodeVersionPO> codeVersionIds = projCodeVersionDao.selectByCodeVersinId(inDto.getInteger("code_version_id"));
		if(state.equals("-1")){
			for (String id : selectionIds) {
				if(AOSUtils.isNotEmpty(codeVersionIds)){
					httpModel.setOutMsg("当前代码版本号已存在其它项目下，无法删除！");
				}else{
					projCodeVersionDao.deleteByKey(Integer.valueOf(id));
					//projCodeVersionDao.deleteTestByKey(Integer.valueOf(id));
					httpModel.setOutMsg("删除成功");
				}
			}
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(projCodeVersionDao.selectStateByKey(Integer.valueOf(id)).equals("0")){
					return;
				}else{
					if(AOSUtils.isNotEmpty(codeVersionIds)){
						httpModel.setOutMsg("当前代码版本号已存在其它项目下，无法停用！");
						return;
					}else{
						projCodeVersionDao.updateStopByKey(Integer.valueOf(id));
						//projCodeVersionDao.updateTestStopByKey(Integer.valueOf(id));
					}
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for (String id : selectionIds) {
				if(projCodeVersionDao.selectStateByKey(Integer.valueOf(id)).equals("1")){
					return;
				}else{
					projCodeVersionDao.updateRunByKey(Integer.valueOf(id));
					//projCodeVersionDao.updateTestRunByKey(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("启用成功");
		}
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjCodeVersionPO projCodeVersionPO=projCodeVersionDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projCodeVersionPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProjCodeVersionPO> projCodeVersionPOs = projCodeVersionDao.likePage(inDto); //projCodeVersionDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projCodeVersionPOs, inDto.getPageTotal()));
	}
 }