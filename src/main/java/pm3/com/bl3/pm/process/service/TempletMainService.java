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


import com.bl3.pm.process.dao.TempletMainDao;
import com.bl3.pm.process.dao.TempletProcessDao;
import com.bl3.pm.process.dao.TempletFiletypeDao;
import com.bl3.pm.process.dao.po.TempletMainPO;
import com.bl3.pm.process.dao.po.TempletProcessPO;
import com.bl3.pm.process.dao.po.TempletFiletypePO;


/**
 * <b>pr_templet_main[pr_templet_main]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
 @Service
 public class TempletMainService{
 	private static Logger logger = LoggerFactory.getLogger(TempletMainService.class);
 	@Autowired
	private TempletMainDao templetMainDao;
	@Autowired
	private TempletProcessDao templetProcessDao;
	@Autowired
	private TempletFiletypeDao templetFiletypeDao;
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
		httpModel.setViewPath("pm3/process/templet/templet_list.jsp");
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
		TempletMainPO templetMainPO=new TempletMainPO();
		int create_user_id = httpModel.getUserModel().getId();
		templetMainPO.copyProperties(inDto);
		templetMainPO.setTemplet_id(idService.nextValue("seq_pr_templet_main").intValue());
		templetMainPO.setCreate_user_id(create_user_id);
		templetMainPO.setState("1");
		templetMainDao.insert(templetMainPO);
		httpModel.setOutMsg(AOSJson.toJson(templetMainPO.getTemplet_id()));
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
		int update_user_id = httpModel.getUserModel().getId();
		TempletMainPO templetMainPO=new TempletMainPO();
		templetMainPO.copyProperties(inDto);
		templetMainPO.setUpdate_user_id(update_user_id);
		templetMainDao.updateByKey(templetMainPO);
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
			templetMainDao.deleteByKey(Integer.valueOf(id));
			templetMainDao.deleteProcessByKey(Integer.valueOf(id));
			templetMainDao.deleteFiletypeByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 启用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void enable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			templetMainDao.enableByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("启用成功");
	}
	
	/**
	 * 停用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void disable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			templetMainDao.disableByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("停用成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TempletMainPO templetMainPO=templetMainDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(templetMainPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TempletMainPO> templetMainPOs = templetMainDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(templetMainPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 保存过程信息
	 * 
	 * @param httpModel
	 */
	public void saveProcessGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows("aos_rows");
		TempletProcessPO templetProcessPO=new TempletProcessPO();
		int create_user_id = httpModel.getUserModel().getId();
		int templet_id = inDto.getInteger("new_templet_id");
		for (Dto dto : modifies) {
			templetProcessPO.copyProperties(dto);
			templetProcessPO.setCreate_user_id(create_user_id);
			templetProcessPO.setState("1");
			templetProcessPO.setTemplet_id(templet_id);
			templetProcessDao.insert(templetProcessPO);
		}
	}
	
	
	/**
	 * 保存过程信息
	 * 
	 * @param httpModel
	 */
	public void saveFiletypeGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int create_user_id = httpModel.getUserModel().getId();
		inDto.put("create_user_id", create_user_id);
		templetFiletypeDao.insertFiletype(inDto);
		templetFiletypeDao.updateFiletype(inDto);
		

	}
 }