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


import com.bl3.pm.process.dao.FiletypeDao;
import com.bl3.pm.process.dao.po.FiletypePO;
import com.bl3.pm.process.dao.po.TempletFiletypePO;

/**
 * <b>pr_filetype[pr_filetype]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2017-12-12 14:18:36
 */
 @Service
 public class FiletypeService{
 	private static Logger logger = LoggerFactory.getLogger(FiletypeService.class);
 	@Autowired
	private FiletypeDao filetypeDao;
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
		httpModel.setViewPath("filetype/filetype_list.jsp");
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
		String sort_no = inDto.getString("sort_no");
		Integer create_user_id = httpModel.getUserModel().getId();
		FiletypePO filetypePO=new FiletypePO();
		//filetypePO.setFiletype_id(idService.nextValue("seq_pr_filetype").intValue());
		filetypePO.copyProperties(inDto);
		filetypePO.setCreate_user_id(create_user_id);
		filetypePO.setState("0");
		filetypeDao.insert(filetypePO);
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
		String sort_no = inDto.getString("sort_no");
		if(sort_no.matches("[0-9]+")){
			FiletypePO filetypePO=new FiletypePO();
			filetypePO.copyProperties(inDto);
			filetypeDao.updateByKey(filetypePO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("修改失败,请在排序号内输入数字");
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
		if(state.equals("-1")){
			for (String id : selectionIds) {
				int count = filetypeDao.selectByKey1(Integer.valueOf(id));
				if(count>0){
					httpModel.setOutMsg("有相关联模版,请先删除模板中对应目录");
					return;
				}else{
				filetypeDao.deleteByKey1(Integer.valueOf(id));
				httpModel.setOutMsg("删除成功");
				}
			}
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(filetypeDao.selectByKey2(Integer.valueOf(id)).equals("0")){
					return;
				}else{
				filetypeDao.deleteByKey(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for (String id : selectionIds) {
				int subdir_id = filetypeDao.selectByKey3(Integer.valueOf(id));
				if(filetypeDao.selectByKey4(Integer.valueOf(subdir_id)).equals("0")){
					httpModel.setOutMsg("请先启用标准过程相关文档");
					return;
				}else{
					if(filetypeDao.selectByKey2(Integer.valueOf(id)).equals("1")){
						return;
					}else{
					filetypeDao.deleteByKey2(Integer.valueOf(id));
					}
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
		FiletypePO filetypePO=filetypeDao.selectByKey(inDto.getInteger("subdir_id"));
		httpModel.setOutMsg(AOSJson.toJson(filetypePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<FiletypePO> filetypePOs = filetypeDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(filetypePOs, inDto.getPageTotal()));
	}
	/**
	 * 保存
	 * 
	 * @param httpModel
	 */
	public void saveFiletypeGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		FiletypePO filetypePO=new FiletypePO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			filetypePO.copyProperties(dto);
			filetypePO.setUpdate_user_id(update_user_id);
			filetypeDao.updateByKey(filetypePO);
		}
		httpModel.setOutMsg("保存成功");
		
	}
 }