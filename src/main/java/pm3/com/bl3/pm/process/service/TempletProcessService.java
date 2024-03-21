package com.bl3.pm.process.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.process.dao.TempletFiletypeDao;
import com.bl3.pm.process.dao.TempletProcessDao;
import com.bl3.pm.process.dao.po.TempletProcessPO;
import com.google.common.collect.Lists;

/**
 * <b>pr_templet_process[pr_templet_process]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
 @Service
 public class TempletProcessService{
 	private static Logger logger = LoggerFactory.getLogger(TempletProcessService.class);
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
		httpModel.setViewPath("templetProcess/templetProcess_list.jsp");
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
		TempletProcessPO templetProcessPO=new TempletProcessPO();
		int create_user_id = httpModel.getUserModel().getId();
//		templetProcessPO.setTemp_proc_id(idService.nextValue("seq_pr_templet_process").intValue());
		int count =templetProcessDao.countRootDirId(inDto);
		if(count==0){
		templetProcessPO.copyProperties(inDto);
		templetProcessPO.setCreate_user_id(create_user_id);
		templetProcessPO.setState("1");
		templetProcessDao.insert(templetProcessPO);
		templetProcessDao.insertFiletype(inDto);
		templetFiletypeDao.updateFiletype(inDto);
		httpModel.setOutMsg("新增成功");
		}else{
			httpModel.setOutMsg("保存失败,存在相同的过程信息,请核对!");
		}
	}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void createAll(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int create_user_id = httpModel.getUserModel().getId();
//		int temp_proc_id = idService.nextValue("seq_pr_templet_process").intValue();
		inDto.put("create_user_id", create_user_id);
		templetProcessDao.insertAll(inDto);
		templetProcessDao.insertFiletypeAll(inDto);
		templetFiletypeDao.updateFiletype(inDto);
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
		int update_user_id = httpModel.getUserModel().getId();
		TempletProcessPO templetProcessPO=new TempletProcessPO();
		templetProcessPO.copyProperties(inDto);
		templetProcessPO.setUpdate_user_id(update_user_id);
		templetProcessDao.updateByKey(templetProcessPO);
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
			templetProcessDao.deleteByKey(Integer.valueOf(id));
			templetProcessDao.updateFiletypeByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 获取过程阶段
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getProcessListTreeData(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		//String parent_id = (String) inDto.get("parent_id");
		if(AOSUtils.isEmpty(inDto.get("templet_id"))) {
			return;
		}

		//父节点
		TreeNode parentNode = new TreeNode();
		String parent_id = "0";
		parentNode.setId(parent_id);
		parentNode.setText("全部");
		parentNode.setLeaf(false);
		parentNode.setParentId("00");
		parentNode.setExpanded(true);

		// 获取根目录节点
		List<TempletProcessPO> rootdirPOs = templetProcessDao.rootdirList(inDto);
		// List<Dto> modelDtos = Lists.newArrayList();
		for (TempletProcessPO rootdirPO : rootdirPOs) {
			TreeNode treeRootNode = new TreeNode();
			treeRootNode.setId(rootdirPO.getRootdir_id().toString());
			treeRootNode.setText(rootdirPO.getRootdir_name());
			treeRootNode.setB(rootdirPO.getRootdir_id().toString());
			treeRootNode.setChecked(false);
			treeRootNode.setLeaf(false);
			treeRootNode.setParentId(parent_id);
			treeRootNode.setExpanded(true);

			// 获取子目录节点
			inDto.put("rootdir_id", rootdirPO.getRootdir_id());
			List<TempletProcessPO> subdirPOs = templetProcessDao.subdirList(inDto);
			for (TempletProcessPO subdirPO : subdirPOs) {
				TreeNode treeSubNode = new TreeNode();
				treeSubNode.setId(subdirPO.getTemp_proc_id().toString());
				treeSubNode.setText(subdirPO.getTemp_proc_name()+"("+subdirPO.getFlow_state_name()+")");
				treeSubNode.setParentId(treeRootNode.getId());
				treeSubNode.setA(subdirPO.getSubdir_id().toString());
				treeSubNode.setChecked(false);
				treeSubNode.setLeaf(true);
				treeSubNode.setExpanded(false);
				treeRootNode.appendChild(treeSubNode);
			}

			parentNode.appendChild(treeRootNode);
		}
		//}
		treeNodes.add(parentNode);
		String treeJson = AOSJson.toJson(treeNodes);
		httpModel.setOutMsg(treeJson);
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TempletProcessPO templetProcessPO=templetProcessDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(templetProcessPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TempletProcessPO> templetProcessPOs = templetProcessDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(templetProcessPOs, inDto.getPageTotal()));
	}
	
	public void saveProcessGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		TempletProcessPO templetProcessPO=new TempletProcessPO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			templetProcessPO.copyProperties(dto);
			templetProcessPO.setUpdate_user_id(update_user_id);
			templetProcessDao.updateByKey(templetProcessPO);
		}
		httpModel.setOutMsg("保存成功");
		
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 * @return dto
	 */
	public void listTemplet(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TempletProcessPO templetProcessPO = templetProcessDao.listTemplet(inDto);
		Dto outDto = templetProcessPO.toDto();
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	public void listComboBoxRootDirId(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.TempletProcessDao.listComboBoxRootDirId", null);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
/*	public void listComboBoxRootDirName(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("TempletProcess.listComboBoxData", null);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}*/
	public void listComboBoxSubDirId(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.TempletProcessDao.listComboBoxSubDirId", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
/*	public void listComboBoxSubDirName(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("TempletProcess.listComboBoxData", null);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}*/
	
 }