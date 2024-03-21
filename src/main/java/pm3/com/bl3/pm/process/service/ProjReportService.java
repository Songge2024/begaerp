   package com.bl3.pm.process.service;

import java.util.Iterator;
import java.util.List;

import javax.swing.plaf.basic.BasicComboBoxEditor;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;



import com.bl3.pm.process.dao.ProcessDao;
import com.bl3.pm.process.dao.po.ProcessPO;
import com.bl3.pm.process.dao.po.TempletFiletypePO;
import com.bl3.pm.process.dao.po.TempletProcessPO;
import com.bl3.pm.process.dao.ProcessFiletypeDao;
import com.bl3.pm.process.dao.po.ProcessFiletypePO;
import com.google.common.collect.Lists;
/**
 * <b>pr_process[pr_process]业务逻辑层</b>
 * 
 * @author yiping
 * @date 2017-12-20 10:53:53
 */
 @Service
 public class ProjReportService{
 	private static Logger logger = LoggerFactory.getLogger(ProjReportService.class);
 	@Autowired
	private ProcessDao processDao;
	@Autowired
	private ProcessFiletypeDao processFiletypeDao;
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
		
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id  = "";
		String proj_name = "";
		if(getDto.get("proj_id")!=null){
	    proj_id = getDto.get("proj_id").toString();
	    proj_name = getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		
		httpModel.setViewPath("pm3/process/projReport/projectReport_list.jsp");
	}
	
	
	/**
	 * 表单数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadFormInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//缺陷新增数
		Dto dto =sqlDao.selectDto("com.bl3.pm.process.dao.ProcessDao.listProjNum", inDto);
		Dto outDto = dto;
		/*Dto bugfDto =sqlDao.selectDto("com.bl3.pm.process.dao.ProcessDao.bugFinNum", inDto);*/
		
		httpModel.setOutMsg(AOSJson.toJson(dto));
	}
	
	/**
	 * 项目组人员
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadPorjPersonInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//周报详情查询
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessDao.listProjPersonInfo", inDto);
		//Dto dto =sqlDao.selectDto("com.bl3.pm.process.dao.ProcessDao.listProjPersonInfo", inDto);
		Dto outDto =Dtos.newDto();
		String s="";
		
		
		Iterator<Dto> it=list.iterator();
		while(it.hasNext()){
			Dto i = it.next();
			StringBuilder sb=new StringBuilder();
			sb.append(s+i.getString("proj_person")+" ");
			 s=sb.toString();
			}
		
		outDto.put("proj_person", s);
		
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 周报详情查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadWeekDetailInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//周报详情查询
		Dto dto =sqlDao.selectDto("com.bl3.pm.process.dao.ProcessDao.listWeekDetailInfo", inDto);
		httpModel.setOutMsg(AOSJson.toJson(dto));
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
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
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
		List<ProcessPO> rootdirPOs = processDao.rootdirList(inDto);
		// List<Dto> modelDtos = Lists.newArrayList();
		for (ProcessPO rootdirPO : rootdirPOs) {
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
			List<ProcessPO> subdirPOs = processDao.subdirList(inDto);
			for (ProcessPO subdirPO : subdirPOs) {
				TreeNode treeSubNode = new TreeNode();
				treeSubNode.setId(subdirPO.getProcess_id().toString());
				treeSubNode.setText(subdirPO.getProcess_name());
				treeSubNode.setParentId(treeRootNode.getId());
				treeSubNode.setA(subdirPO.getProcess_subdir_id().toString());
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
	
	
 }