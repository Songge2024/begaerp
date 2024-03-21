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


import com.bl3.pm.basic.dao.ProjTestVersionDao;
import com.bl3.pm.basic.dao.po.ProjTestVersionPO;

/**
 * <b>bs_proj_test_version[bs_proj_test_version]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-07-03 10:08:11
 */
 @Service
 public class ProjTestVersionService{
 	private static Logger logger = LoggerFactory.getLogger(ProjTestVersionService.class);
 	@Autowired
	private ProjTestVersionDao projTestVersionDao;
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
		httpModel.setViewPath("projTestVersion/projTestVersion_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int result = projTestVersionDao.testVersionNumberCount(inDto.getString("test_version_number"),inDto.getInteger("version_id"));
		if(result == 1){
			httpModel.setOutMsg("测试版本号已存在。");
			return;
		}
		ProjTestVersionPO projTestVersionPO=new ProjTestVersionPO();
		Integer create_id = httpModel.getUserModel().getId();
		projTestVersionPO.copyProperties(inDto);
		projTestVersionPO.setCreate_id(create_id);
		projTestVersionPO.setCreate_time(new Date());
		projTestVersionPO.setState("0");
		projTestVersionDao.insert(projTestVersionPO);
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
		int result = projTestVersionDao.testVersionNumberCount1(inDto.getString("test_version_number"),inDto.getInteger("test_version_id"),inDto.getInteger("version_id"));
		if(result == 0){
			ProjTestVersionPO projTestVersionPO=new ProjTestVersionPO();
			Integer update_id = httpModel.getUserModel().getId();
			projTestVersionPO.copyProperties(inDto);
			projTestVersionPO.setUpdate_id(update_id);
			projTestVersionPO.setUpdate_time(new Date());
			projTestVersionDao.updateByKey(projTestVersionPO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("无法修改，测试版本号已存在。");
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
		//校验是否被使用，先提前写好
		List<ProjTestVersionPO> testVersionIds = projTestVersionDao.selectByTestVersinId(inDto.getInteger("test_version_id"));
		if(state.equals("-1")){
			for (String id : selectionIds) {
				if(AOSUtils.isNotEmpty(testVersionIds)){
					httpModel.setOutMsg("当前测试版本号已存在其它项目下，无法删除！");
				}else{
					projTestVersionDao.deleteByKey(Integer.valueOf(id));
					httpModel.setOutMsg("删除成功");
				}
			}
		}
		/*if(state.equals("-1")){
			for(String id : selectionIds){
				projTestVersionDao.deleteByKey(Integer.valueOf(id));
				httpModel.setOutMsg("删除成功");
			}
		}*/
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(projTestVersionDao.selectStateByKey(Integer.valueOf(id)).equals("0")){
					return;
				}else{
					if(AOSUtils.isNotEmpty(testVersionIds)){
						httpModel.setOutMsg("当前测试版本号已存在其它项目下，无法停用！");
						return;
					}else{
						projTestVersionDao.updateStopByKey(Integer.valueOf(id));
						projTestVersionDao.updateCodeStopByKey(Integer.valueOf(id));
					}
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		/*if(state.equals("0")){
			for(String id : selectionIds){
				if(projTestVersionDao.selectStateByKey(Integer.valueOf(id)).equals("0")){
					return;
				}else{
					projTestVersionDao.updateStopByKey(Integer.valueOf(id));
				}
			}
		}*/
		if(state.equals("1")){
			for (String id : selectionIds) {
				if(projTestVersionDao.selectStateByKey(Integer.valueOf(id)).equals("1")){
					return;
				}else{
					projTestVersionDao.updateRunByKey(Integer.valueOf(id));
					projTestVersionDao.updateCodeRunByKey(Integer.valueOf(id));
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
		ProjTestVersionPO projTestVersionPO=projTestVersionDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projTestVersionPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProjTestVersionPO> projTestVersionPOs = projTestVersionDao.likePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projTestVersionPOs, inDto.getPageTotal()));
	}
 }