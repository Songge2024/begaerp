   package com.bl3.pm.process.service;

import java.util.List;

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
 * @author huangtao
 * @date 2017-12-20 10:53:53
 */
 @Service
 public class ProcessService{
 	private static Logger logger = LoggerFactory.getLogger(ProcessService.class);
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
		String proj_id = "";
		String proj_name="";
		if(getDto.get("proj_id")!=null){
		 proj_id = getDto.get("proj_id").toString();
	     proj_name= getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/process/processCut/processfile_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto pDto = Dtos.newDto();
		//inDto.remove("id");
		ProcessPO processPO=new ProcessPO();
		int count = processDao.countProcessId(inDto);
		if(count==0){
			int create_user_id = httpModel.getUserModel().getId();
			int subdir_id = Integer.parseInt((String) inDto.get("process_subdir_id")) ;
			int process_id = idService.nextValue("seq_pr_process").intValue();
			int proj_id = Integer.parseInt((String) inDto.get("proj_id"));
			processPO.setProcess_id(process_id);
			processPO.copyProperties(inDto);
			processPO.setCreate_user_id(create_user_id);
			processPO.setState("1");
			processDao.insert(processPO);
			pDto.put("process_id", process_id);
			pDto.put("subdir_id", subdir_id);
			pDto.put("create_user_id", create_user_id);
			pDto.put("proj_id", proj_id);
			processDao.insertFiletype(pDto);
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
		inDto.put("create_user_id", create_user_id);
		processDao.insertAll(inDto);
		processDao.insertFiletypeAll(inDto);
		processDao.updateProcessFiletype(inDto);
		processDao.updateSeqence(inDto);
		httpModel.setOutMsg("新增成功!");
		
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
		ProcessPO processPO=new ProcessPO();
		processPO.copyProperties(inDto);
		processDao.updateByKey(processPO);
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
			inDto.put("process_id", Integer.valueOf(id));		
			int count =processDao.countProcessFiletype(inDto);
			if(count==0){
					processDao.deleteByKey(Integer.valueOf(id));
					processDao.updateByProcessId(Integer.valueOf(id));
				}else{
					httpModel.setOutMsg("删除失败!该过程信息已上传文件,不能进行删除!");
					return ;
				}
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
		ProcessPO processPO=processDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(processPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessPO> processPOs = processDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 根据项目ID 过程树分页查询
	 * 
	 * @param httpModel
	 */
	public void byProcessPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String tree_param = (String) inDto.get("tree_param");
		int index = tree_param.indexOf("-");
		if(!tree_param.equals("00")){
			if(index == -1){
				inDto.put("", tree_param);
			}
		}
//		select * from pr_process_filetype ppf
//		 where exists (select 1 from pr_process pp 
//		 where ppf.proj_id = pp.proj_id
//		   and ppf.process_id = pp.process_id
//		   and pp.rootdir_id = 1 and ppf.proj_id = 1)
		
		List<ProcessPO> processPOs = processDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processPOs, inDto.getPageTotal()));
	}
	
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void templetPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessPO> processPOs = processDao.listProcessPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void processPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessPO> processPOs = processDao.listFiletypePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 查询项目名称下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxCascadeData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("reModuleDivide.listComboBoxCascadeData", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 查询项目名称下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxTemletData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessDao.listComboBoxTempletData", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	
	/**
	 * 表单数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadFormInfo(HttpModel httpModel) {
		Dto dto =sqlDao.selectDto("com.bl3.pm.process.dao.ProcessDao.listProjInfo", httpModel.getInDto());
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
	
	/**
	 * 表格数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadGridInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessPO> processPOs = processDao.list(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processPOs, processPOs.size()));
	}
	
	/**
	 * 表格数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadFiletypeGridInfo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessFiletypePO> processFiletypePOs = processFiletypeDao.list(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processFiletypePOs, processFiletypePOs.size()));
	}
	
	
/*	*//**
	 * 过程裁剪保存
	 * 
	 * @param httpModel
	 * @return
	 *//*
	public void saveCutProcessGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows("aos_rows");
		List<Dto> filetypeModifies = inDto.getRows("aos_rows_filetype");
		ProcessPO processPO=new ProcessPO();
		int create_user_id = httpModel.getUserModel().getId();
		int proj_id =  Integer.parseInt(inDto.get("proj_id").toString());
		for (Dto dto : modifies) {
			processPO.copyProperties(dto);
			processPO.setProj_id(proj_id);
			processPO.setCreate_user_id(create_user_id);
			processPO.setState("1");
			processDao.insert(processPO);
			processDao.updateSeqence(inDto);
		}
		ProcessFiletypePO processFiletypePO=new ProcessFiletypePO();
		for (Dto dto : filetypeModifies) {
			processFiletypePO.copyProperties(dto);
			processFiletypePO.setProj_id(proj_id);
			processFiletypePO.setCreate_user_id(create_user_id);
			processFiletypePO.setState("1");
			processFiletypeDao.insert(processFiletypePO);
		}
		httpModel.setOutMsg("保存成功");
	}*/
	
	//根目录下拉框
	public void listComboBoxRootDirId(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessDao.listComboBoxRootDirId", null);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	//子目录下拉框
	public void listComboBoxSubDirId(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessDao.listComboBoxSubDirId", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 过程裁剪保存
	 * 
	 * @param httpModel
	 * @return
	 */
	public void saveProcessCut(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int create_user_id = httpModel.getUserModel().getId();
		inDto.put("create_user_id", create_user_id);
		processDao.insertProcessCut(inDto);
		processDao.updateSeqence(inDto);
		processDao.insertProcessFiletype(inDto);
		processDao.updateCutFiletype(inDto);
		httpModel.setOutMsg("选择模板成功");
	}
	/**
	 * updat Sort_no
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateProcessGridSortNo(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		processDao.updateProcessGridSortNo(inDto);
		
	}

	
	//评审文档过滤下拉框
	public void listComboBoxPr_PRocess(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessDao.listComboBoxPr_PRocess", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	//grid变动保存
	public void saveProcessGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		ProcessPO processPO=new ProcessPO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			processPO.copyProperties(dto);
			processPO.setUpdate_user_id(update_user_id);
			processDao.updateByKey(processPO);
		}
		httpModel.setOutMsg("保存成功");
		
	}

	public static void main(String[] args) {
		String tree_param = "0111";
		System.out.println(tree_param.indexOf("-"));
	}
 }