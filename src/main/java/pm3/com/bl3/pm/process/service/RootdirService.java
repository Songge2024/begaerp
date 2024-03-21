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


import com.bl3.pm.process.dao.RootdirDao;
import com.bl3.pm.process.dao.po.RootdirPO;

/**
 * <b>pr_rootdir[pr_rootdir]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2017-12-12 14:18:36
 */
 @Service
 public class RootdirService{
 	private static Logger logger = LoggerFactory.getLogger(RootdirService.class);
 	@Autowired
	private RootdirDao rootdirDao;
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
		httpModel.setViewPath("pm3/process/process_list.jsp");
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
		RootdirPO rootdirPO=new RootdirPO();
		rootdirPO.setRootdir_id(idService.nextValue("seq_pr_rootdir").intValue());
		rootdirPO.copyProperties(inDto);
		rootdirPO.setCreate_user_id(create_user_id);
		rootdirPO.setState("0");
		rootdirDao.insert(rootdirPO);
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
			RootdirPO rootdirPO=new RootdirPO();
			rootdirPO.copyProperties(inDto);
			rootdirDao.updateByKey(rootdirPO);
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
				int count = rootdirDao.selectByKey1(Integer.valueOf(id));
				if(count>0){
					httpModel.setOutMsg("有相关联模版,请先删除模板中对应目录");
					return;
				}else{
					rootdirDao.deleteByKey13(Integer.valueOf(id));
					rootdirDao.deleteByKey14(Integer.valueOf(id));
					rootdirDao.deleteByKey15(Integer.valueOf(id));
					httpModel.setOutMsg("删除成功");
				}
			}
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(rootdirDao.selectByKey2(Integer.valueOf(id)).equals("0")){
					return;
				}else{
				rootdirDao.deleteByKey1(Integer.valueOf(id));
				rootdirDao.deleteByKey2(Integer.valueOf(id));
				rootdirDao.deleteByKey(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for (String id : selectionIds) {
				if(rootdirDao.selectByKey2(Integer.valueOf(id)).equals("1")){
					return;
				}else{
				rootdirDao.deleteByKey61(Integer.valueOf(id));
				rootdirDao.deleteByKey71(Integer.valueOf(id));
				rootdirDao.deleteByKey81(Integer.valueOf(id));
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
		RootdirPO rootdirPO=rootdirDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(rootdirPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<RootdirPO> rootdirPOs = rootdirDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(rootdirPOs, inDto.getPageTotal()));
	}
 }