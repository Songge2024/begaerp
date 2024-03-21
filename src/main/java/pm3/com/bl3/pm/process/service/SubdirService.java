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


import com.bl3.pm.process.dao.SubdirDao;
import com.bl3.pm.process.dao.po.FiletypePO;
import com.bl3.pm.process.dao.po.SubdirPO;

/**
 * <b>pr_subdir[pr_subdir]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2017-12-12 14:18:36
 */
 @Service
 public class SubdirService{
 	private static Logger logger = LoggerFactory.getLogger(SubdirService.class);
 	@Autowired
	private SubdirDao subdirDao;
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
		httpModel.setViewPath("subdir/subdir_list.jsp");
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
		SubdirPO subdirPO=new SubdirPO();
		//subdirPO.setSubdir_id(idService.nextValue("seq_pr_subdir").intValue());
		subdirPO.copyProperties(inDto);
		subdirPO.setCreate_user_id(create_user_id);
		subdirPO.setState("0");
		subdirDao.insert(subdirPO);
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
			SubdirPO subdirPO=new SubdirPO();
			subdirPO.copyProperties(inDto);
			subdirDao.updateByKey(subdirPO);
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
				int count1 = subdirDao.selectByKey1(Integer.valueOf(id));
				int count2 = subdirDao.selectByKey2(Integer.valueOf(id));
				if(count1>0 && count2>0){
						httpModel.setOutMsg("有相关联模版,请先删除模板中对应目录");
						return;
				}else{
						subdirDao.deleteByKey13(Integer.valueOf(id));
						subdirDao.deleteByKey12(Integer.valueOf(id));
						httpModel.setOutMsg("删除成功");
					}	
			}	
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(subdirDao.selectByKey3(Integer.valueOf(id)).equals("0")){
					return;
				}else{
				subdirDao.deleteByKey(Integer.valueOf(id));
				subdirDao.deleteByKey1(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for (String id : selectionIds) {
				int rootdir_id = subdirDao.selectByKey4(Integer.valueOf(id));
				if(subdirDao.selectByKey5(Integer.valueOf(rootdir_id)).equals("0")){
					httpModel.setOutMsg("请先启用过程阶段相关文档");
					return;
				}else{
					if(subdirDao.selectByKey3(Integer.valueOf(id)).equals("1")){
						return;
					}else{
					subdirDao.deleteByKey41(Integer.valueOf(id));
					subdirDao.deleteByKey51(Integer.valueOf(id));
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
		SubdirPO subdirPO=subdirDao.selectByKey(inDto.getInteger("rootdir_id"));
		httpModel.setOutMsg(AOSJson.toJson(subdirPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<SubdirPO> subdirPOs = subdirDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(subdirPOs, inDto.getPageTotal()));
	}
	/**
	 * 保存
	 * 
	 * @param httpModel
	 */
	public void saveSubdirGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		SubdirPO subdirPO=new SubdirPO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			subdirPO.copyProperties(dto);
			subdirPO.setUpdate_user_id(update_user_id);
			subdirDao.updateByKey(subdirPO);
		}
		httpModel.setOutMsg("保存成功");
		
	}
 }