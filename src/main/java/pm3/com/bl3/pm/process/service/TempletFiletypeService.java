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


import com.bl3.pm.process.dao.TempletFiletypeDao;
import com.bl3.pm.process.dao.po.TempletFiletypePO;


/**
 * <b>pr_templet_filetype[pr_templet_filetype]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2017-12-14 09:48:51
 */
 @Service
 public class TempletFiletypeService{
 	private static Logger logger = LoggerFactory.getLogger(TempletFiletypeService.class);
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
		httpModel.setViewPath("templetFiletype/templetFiletype_list.jsp");
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
		int create_user_id = httpModel.getUserModel().getId();
		int count = templetFiletypeDao.countFiletypeId(inDto);
		if(count==0){
		TempletFiletypePO templetFiletypePO=new TempletFiletypePO();
//		templetFiletypePO.setTemp_filetype_id(idService.nextValue("seq_pr_templet_filetype").intValue());
		templetFiletypePO.copyProperties(inDto);
		templetFiletypePO.setCreate_user_id(create_user_id);
		templetFiletypePO.setState("1");
		templetFiletypeDao.insert(templetFiletypePO);
		httpModel.setOutMsg("新增成功");
		}else{
			httpModel.setOutMsg("保存失败,存在相同的文件信息,请核对!");
		}
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
		TempletFiletypePO templetFiletypePO=new TempletFiletypePO();
		templetFiletypePO.copyProperties(inDto);
		templetFiletypePO.setUpdate_user_id(update_user_id);
		templetFiletypeDao.updateByKey(templetFiletypePO);
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
			templetFiletypeDao.deleteByKey(Integer.valueOf(id));
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
		TempletFiletypePO templetFiletypePO=templetFiletypeDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(templetFiletypePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TempletFiletypePO> templetFiletypePOs = templetFiletypeDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(templetFiletypePOs, inDto.getPageTotal()));
	}
	
	public void saveFiletypeGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		TempletFiletypePO templetFiletypePO=new TempletFiletypePO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			templetFiletypePO.copyProperties(dto);
			templetFiletypePO.setUpdate_user_id(update_user_id);
			templetFiletypeDao.updateByKey(templetFiletypePO);
		}
		httpModel.setOutMsg("保存成功");
		
	}
	
	
	public void listComboBoxFiletypeId(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.TempletFiletypeDao.listComboBoxFiletypeId", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
 }