package com.bl3.pm.basic.service;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bl3.pm.basic.dao.ProjCommonsDao;
import com.bl3.pm.basic.dao.ProjTypesDao;
import com.bl3.pm.basic.dao.po.ProjCommonsPO;
import com.bl3.pm.basic.dao.po.ProjTypesPO;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * <b>bs_proj_types[bs_proj_types]业务逻辑层</b>
 * 
 * @author hege
 * @date 2017-12-11 11:40:02
 */
 @Service
 public class ProjTypesService{
 	private static Logger logger = LoggerFactory.getLogger(ProjTypesService.class);
 	@Autowired
	private ProjTypesDao projTypesDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ProjCommonsDao projCommonsDao;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/basic/codes/projTypes.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		final String type_code = "seq_proj_type";
		ProjTypesPO projTypesPO=new ProjTypesPO();
		projTypesPO.copyProperties(inDto);
		projTypesPO.setType_code(idService.nextValue(type_code).toString());
		projTypesPO.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time=AOSUtils.getDateTime();
		projTypesPO.setCreate_time(create_time);
		projTypesDao.insert(projTypesPO);
		httpModel.setOutMsg("新增成功");
		
	}
	/**
	 * 修改项目类型状态
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void updateProjTypeState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			ProjTypesPO upPO = projTypesDao.selectByKey(String.valueOf(id)); 
			upPO.copyProperties(inDto);
			if (AOSUtils.isEmpty(upPO)) {
				continue;
			}
			upPO.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time=AOSUtils.getDateTime();
			upPO.setUpdate_time(update_time);
			upPO.setState(inDto.getString("state"));
			projTypesDao.updateByKey(upPO);
		}
		httpModel.setOutMsg("启用成功");
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
		ProjTypesPO projTypesPO=new ProjTypesPO();
		projTypesPO.copyProperties(inDto);
		projTypesPO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time=AOSUtils.getDateTime();
		projTypesPO.setUpdate_time(update_time);
		projTypesDao.updateByKey(projTypesPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 删除项目类型信息
	 * 
	 * @param httpModel
	 */
	public void delProjInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjTypesPO projTypesPO=new ProjTypesPO();
		projTypesPO.copyProperties(inDto);
		projTypesPO.setState("-1");
		projTypesDao.updateByKey(projTypesPO);
		httpModel.setOutMsg("项目类型删除成功");
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
			projTypesDao.deleteByKey(String.valueOf(id));
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
		ProjTypesPO projTypesPO=projTypesDao.selectByKey(inDto.getString("id"));
		httpModel.setOutMsg(AOSJson.toJson(projTypesPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjTypesDao.listModulesPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, inDto.getPageTotal()));
	}
	
	/**
	 * 获取树组件数据(一次性全部加载树节点)
	 * 项目树
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		List<ProjTypesPO> ProjTypesPOs = projTypesDao.listTree(inDto);
		for (ProjTypesPO ProjTypesPO : ProjTypesPOs) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId("A" + ProjTypesPO.getType_code().toString());
			treeNode.setText(ProjTypesPO.getType_name());
			treeNode.setParentId("0");
			treeNode.setIcon("folder1.png");
			treeNode.setLeaf(false);
			treeNode.setExpanded(true);
			treeNode.setA("0");
			treeNodes.add(treeNode);
		}
		String userid = httpModel.getUserModel().getId().toString();
		inDto.put("userid", userid);
		Dto roleDto = sqlDao.selectDto("ProjCommonsDao.queryRole", inDto);
		System.out.println(roleDto.getInteger("id").equals(-1));
		System.out.println(roleDto.getInteger("id").equals(-1));
		if(roleDto.getInteger("id").equals(-1)||roleDto.getInteger("id").equals(1580)||roleDto.getInteger("id").equals(1635)) {
			inDto.put("userid", "");
		}else {
			inDto.put("userid", userid);
		}
		List<ProjCommonsPO> ProjCommonsPOs = projCommonsDao.listTree(inDto);
		for (ProjCommonsPO ProjCommonsPO : ProjCommonsPOs) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(ProjCommonsPO.getProj_id().toString());
			treeNode.setText(ProjCommonsPO.getProj_name());
			treeNode.setParentId("A"+ProjCommonsPO.getType_code());
			treeNode.setIcon("icon75.png");
			//这个决定是否在节点上初选复选框，true为初始选中
			//treeNode.setChecked(true);
			treeNode.setLeaf(false);
			treeNode.setA("1");
			treeNode.setExpanded(false);
			//附加属性
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	/**
	 * 获取树组件数据(一次性全部加载树节点)
	 * 模块树
	 * @param httpModel
	 * @return
	 */
	public void getModuleDivideTreeData(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		String userid = httpModel.getUserModel().getId().toString();
		inDto.put("team_user_id", userid);
		List<Dto> mlist = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		if(!(mlist.size()==0)){
			List<Dto> list = sqlDao.list("ProjTypesDao.listModuleDivideTree", inDto);
			for (Dto dto : list) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(dto.getString("id"));
				treeNode.setText(dto.getString("TEXT"));
				treeNode.setParentId("0");
				treeNode.setIcon("folder1.png");
				treeNode.setLeaf(false);
				treeNode.setExpanded(true); // 只展开第二级
				treeNode.setA("true");
				treeNodes.add(treeNode);
			}

			List<Dto> list2 = sqlDao.list("ProjTypesDao.listModuleDivideTree2", inDto);
			for (Dto dto : list2) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(dto.getString("id"));
				treeNode.setText(dto.getString("TEXT"));
				treeNode.setParentId(dto.getString("parentid"));
				treeNode.setIcon("icon75.png");
				treeNode.setLeaf(false);
				treeNode.setExpanded(false);
				treeNodes.add(treeNode);
				treeNode.setA("false");
			}
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	/**
	 * 获取树组件数据(一次性全部加载树节点)
	 * 模块树
	 * @param httpModel
	 * @return
	 */
	public void getModuleDivideTree(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		String userid = httpModel.getUserModel().getId().toString();
		inDto.put("team_user_id", userid);
		List<Dto> mlist = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		if(!(mlist.size()==0)){
			List<Dto> list = sqlDao.list("ProjTypesDao.listModuleDivideTree", inDto);
			for (Dto dto : list) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(dto.getString("id"));
				treeNode.setText(dto.getString("TEXT"));
				treeNode.setParentId("0");
				treeNode.setIcon("folder1.png");
				treeNode.setLeaf(false);
				treeNode.setExpanded(true); // 只展开第二级
				treeNode.setA("true");
				treeNodes.add(treeNode);
			}

			List<Dto> list2 = sqlDao.list("ProjTypesDao.listModuleDivideTree2", inDto);
			for (Dto dto : list2) {
				TreeNode treeNode = new TreeNode();
				Dto taskDto = Dtos.newDto();
				String stand_id = dto.getString("id");
				taskDto.put("stand_id", stand_id);
				taskDto.put("proj_id", inDto.get("proj_id"));
				Integer task_percent = (Integer)sqlDao.selectOne("ProjTypesDao.getAVGGroupId", taskDto);
				if(AOSUtils.isNotEmpty(task_percent)){
					treeNode.setText(dto.getString("TEXT")+"<span style='color:green;font-weight:bold;'>("+task_percent+"%)</span>");
				}else{
					treeNode.setText(dto.getString("TEXT"));
				}
				treeNode.setId(dto.getString("id"));
				treeNode.setParentId(dto.getString("parentid"));
				treeNode.setIcon("icon75.png");
				treeNode.setLeaf(false);
				treeNode.setExpanded(false);
				treeNodes.add(treeNode);
				treeNode.setA("false");
			}
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
 }