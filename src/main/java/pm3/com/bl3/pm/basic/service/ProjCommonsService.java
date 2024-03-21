package com.bl3.pm.basic.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import com.bl3.pm.quality.service.FilesManageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.basic.dao.ProjCommonsDao;
import com.bl3.pm.basic.dao.po.ModuleDividePO;
import com.bl3.pm.basic.dao.po.ProjCommonsPO;
import com.bl3.pm.contract.dao.po.ProjContractPO;
import com.bl3.pm.task.dao.WeekReportDao;
import com.bl3.pm.task.service.WeekReportService;
import com.google.common.collect.Lists;

/**
 * <b>bs_proj_commons[bs_proj_commons]业务逻辑层</b>
 * 
 * @author yj
 * @date 2017-12-11 10:44:06
 */
@Service
public class ProjCommonsService {
	private static Logger logger = LoggerFactory.getLogger(ProjCommonsService.class);
	@Autowired
	private ProjCommonsDao projCommonsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private FilesManageService  filesManageService;

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/basic/projCommons/projCommons_layout.jsp");
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//查询最大的porj_id
		int proj_id = (int)sqlDao.selectOne("ProjCommonsDao.queryMaxid", null);
		proj_id= proj_id+1;
		// inDto.remove("id");
		int userid = httpModel.getUserModel().getId();
		ProjCommonsPO projCommonsPO = new ProjCommonsPO();
		// projCommonsPO.setProj_id(idService.nextValue("seq_bs_proj_commons").intValue());
		projCommonsPO.copyProperties(inDto);
		projCommonsPO.setProj_id(proj_id);
		projCommonsPO.setCreate_user_id(userid);
		projCommonsPO.setState("0");
		projCommonsDao.insert(projCommonsPO);
		
		//项目链接合同
		String ctid = inDto.getString("for_ct_id");
		if(!ctid.equals("")) {
			String[] sourceStrArray = ctid.split(",");
			for (int i = 0; i < sourceStrArray.length; i++) {
				int Ct_id = Integer.valueOf(sourceStrArray[i]);
				ProjContractPO ppo = new  ProjContractPO();
				ppo.setCt_id(Ct_id);
				ppo.setCreate_date(AOSUtils.getDateTime());
				ppo.setCreate_user_id( httpModel.getUserModel().getId());
				ppo.setState("1");
				ppo.setProj_id(proj_id);
				sqlDao.insert("com.bl3.pm.contract.dao.ProjContractDao.insert", ppo);
			}
		}
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
		// inDto.remove("id");
		int userid = httpModel.getUserModel().getId();
		ProjCommonsPO projCommonsPO = new ProjCommonsPO();
		projCommonsPO.copyProperties(inDto);
		projCommonsPO.setUpdate_user_id(userid);
		projCommonsDao.updateByKey(projCommonsPO);
		int proj_id = projCommonsPO.getProj_id();
		//清空链接的合同
		sqlDao.delete("ContractDao.delectSaveContract", projCommonsPO);
		// 重新项目链接合同
		String ctid = inDto.getString("for_ct_id");
		if(!ctid.equals("")) {
			String[] sourceStrArray = ctid.split(",");
			for (int i = 0; i < sourceStrArray.length; i++) {
				int Ct_id = Integer.valueOf(sourceStrArray[i]);
				ProjContractPO ppo = new ProjContractPO();
				ppo.setCt_id(Ct_id);
				ppo.setCreate_date(AOSUtils.getDateTime());
				ppo.setCreate_user_id(httpModel.getUserModel().getId());
				ppo.setState("1");
				ppo.setProj_id(proj_id);
				sqlDao.insert("com.bl3.pm.contract.dao.ProjContractDao.insert", ppo);
			}
		}
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 单元格编辑表格提交的数据，一次有可能会提交多条记录
	 * @param httpModel
	 */
	public void saveCellEditGrid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
			sqlDao.insert("com.bl3.pm.basic.dao.ProjTeamsDao.updateByKey", inDto);
		httpModel.setOutMsg("保存成功");
	}
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int userid = httpModel.getUserModel().getId();
		String user_name = httpModel.getUserModel().getName();
		httpModel.setAttribute("user_name", user_name);
		String[] selectionIds = inDto.getRows();
		String state = inDto.getString("state");
		for (String id : selectionIds) {
			ProjCommonsPO projCommonsPO = new ProjCommonsPO();
			projCommonsPO.setUpdate_user_id(userid);
			projCommonsPO.setState(state);
			if(state.equals("2")){
				projCommonsPO.setAccept_date(AOSUtils.getDateTime());
			}
			projCommonsPO.setProj_id(Integer.valueOf(id));
			projCommonsDao.updateByKey(projCommonsPO);
			// projCommonsDao.deleteByKey(Integer.valueOf(id));
		}
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		 httpModel.setOutMsg(token.toString());
		//httpModel.setOutMsg("操作成功");
	}
	
	public void exportALLExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> dtos = sqlDao.list("com.bl3.pm.basic.dao.ProjCommonsDao.exportALLExcel", inDto);
		for(int k=0;k<dtos.size();k++){
			Dto dto = dtos.get(k);
			if(AOSUtils.isNotEmpty(dto.get("state")) && dto.get("state") != ""){
				if(Integer.valueOf(dto.get("state").toString()) == 0){
					dto.put("state", "未启用");
				}else if(Integer.valueOf(dto.get("state").toString()) == 1){
					dto.put("state", "已启用");
				}else{
					dto.put("state", "");
				}
			}
		}
		
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "项目基础信息管理");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/projCommon.xlsx");
		exporter.setFilename("项目基础信息管理.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
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
		ProjCommonsPO projCommonsPO = projCommonsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projCommonsPO));
	}

	/**
	 * 分页查询项目基础信息
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjCommonsDao.queryProjBaseDataPage", inDto);
		//httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, inDto.getPageTotal()));
	}

	/**
	 * 查询自定义下拉组件数据 公共下拉框获取数据 cb_id下拉框id cd_name下拉框显示名称 cb_table表名
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxData", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxUerid(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if (inDto.getString("type").equals("all")) {
			inDto.put("team_user_id", "");
		} else {
			String userid = httpModel.getUserModel().getId().toString();
			inDto.put("team_user_id", userid);
		}
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listTreeUerid(HttpModel httpModel) {/*
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if (inDto.getString("type").equals("all")) {
			inDto.put("team_user_id", "");
		} else {
			String userid = httpModel.getUserModel().getId().toString();
			inDto.put("team_user_id", userid);
		}
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("value"));
			treeNode.setText(dto.getString("display"));
			treeNode.setParentId("0");
			treeNode.setIcon("042802.png");
			treeNode.setLeaf(false);
			treeNode.setExpanded(true);
			treeNodes.add(treeNode);
			treeNode.setA("true");
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	*/
		

		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		//我的项目
		TreeNode treeNode0 = new TreeNode();
		treeNode0.setId("0000");
		treeNode0.setText("我的项目");
		treeNode0.setParentId("0");
		treeNode0.setIcon("home.png");
		treeNode0.setLeaf(false);
		treeNode0.setExpanded(true);
		treeNode0.setA("0");
		treeNodes.add(treeNode0);
		//进行中的项目
		TreeNode treeNode1 = new TreeNode();
		treeNode1.setId("A1");
		treeNode1.setText("进行中的项目");
		treeNode1.setParentId("0000");
		treeNode1.setIcon("go.gif");
		treeNode1.setLeaf(false);
		treeNode1.setExpanded(true);
		treeNode1.setA("0");
		treeNodes.add(treeNode1);
		//历史项目
		TreeNode treeNode2 = new TreeNode();
		treeNode2.setId("A2");
		treeNode2.setText("历史项目");
		treeNode2.setParentId("0000");
		treeNode2.setIcon("history.png");
		treeNode2.setLeaf(false);
		treeNode2.setExpanded(true);
		treeNode2.setA("0");
		treeNodes.add(treeNode2);
		
		inDto.put("userid", httpModel.getUserModel().getId());
		List<Dto> list = sqlDao.list("ProjCommonsDao.querymy_project_tree", inDto);
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("PROJ_ID"));
			treeNode.setText(dto.getString("PROJ_NAME"));
			String state = dto.getString("STATE");
			String parentId = state.equals("1")? "A1" : "A2";
			if(parentId.equals("A1")){
				treeNode.setIcon("042802.png");
			}else{
				treeNode.setIcon("bullet_black.png");
			}
			treeNode.setParentId(parentId);
			treeNode.setLeaf(false);
			treeNode.setA("1");
			treeNode.setExpanded(true);
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	
	}

	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxProjId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxProjId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询自定义下拉组件数据包括离职人员
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listAllComboBoxProjId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjCommonsDao.listAllComboBoxProjId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询自定义下拉组件数据(工作台图表项目成员下拉框)
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxProjUserId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxProjUserId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 查询周报下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxWeekReport(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.basic.dao.ProjCommonsDao.listComboBoxWeekReport", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询自定义下拉组件数据 公共下拉框获取数据 cb_id下拉框id cd_name下拉框显示名称 cb_table表名
	 * 
	 * @param httpModel
	 * @return
	 */
	public List<Dto> listGridRendererData(String tabname) {
		Dto inDto = Dtos.newDto();
		inDto.put("tabname", tabname);
		List<Dto> list = sqlDao.list("com.bl3.pm.basic.dao.ProjCommonsDao.listGridRendererData", inDto);
		return list;
	}

	/**
	 * 查询项目角色剩余分配人员
	 * 
	 * @param httpModel
	 */
	public void queryUnProjRoleTypes(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjCommonsDao.queryUnProjRoleTypes", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
	}

	/**
	 * 查询项目经理待办事宜
	 * 
	 * @param httpModel
	 */
	public void queryTodo(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List Todo = sqlDao.list("ProjCommonsDao.queryTodo", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(Todo, inDto.getPageTotal()));
	}

	/**
	 * 查询项目待处理缺陷
	 * 
	 * @param httpModel
	 */
	public void queryBug(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List Bug = sqlDao.list("ProjCommonsDao.queryBug", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(Bug, inDto.getPageTotal()));
	}

	/**
	 * 查询项目日报
	 * 
	 * @param httpModel
	 */
	public void queryDaily(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List Daily = sqlDao.list("ProjCommonsDao.queryDaily", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(Daily, inDto.getPageTotal()));
	}

	/**
	 * 查询项目周报
	 * 
	 * @param httpModel
	 */
	public void queryWeekly(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List Weekly = sqlDao.list("ProjCommonsDao.queryWeekly", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(Weekly, inDto.getPageTotal()));
	}

	/**
	 * 查询进行中的项目
	 * 
	 * @param httpModel
	 */
	public void queryProjectProgress(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List ProjectProgress = sqlDao.list("ProjCommonsDao.queryProjectProgress", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(ProjectProgress, inDto.getPageTotal()));
	}

	/**
	 * 查询登陆人的项目角色
	 * 
	 * @param httpModel
	 */
	public void queryProrole(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String userid = httpModel.getUserModel().getId().toString();
		inDto.put("userid", userid);
		List <Dto>ProjectProgress = sqlDao.list("ProjCommonsDao.queryProrole", inDto);
		httpModel.setOutMsg(AOSJson.toJson(ProjectProgress));
	}

	/**
	 * 人员项目角色树
	 * 
	 * @param httpModel
	 */

	public List<Dto> getUserPorjects(Integer userid) {
		return sqlDao.list("ProjCommonsDao.queryProjectRoleTree", Dtos.newDto("userid", userid));
	}

	public void getProjectRoleTree(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjCommonsDao.listTree", inDto);
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("type_code"));
			treeNode.setText(dto.getString("type_name"));
			treeNode.setParentId("0");
			treeNode.setIcon("folder1.png");
			treeNode.setLeaf(false);
			treeNode.setExpanded(false);
			treeNode.setA("1");
			treeNodes.add(treeNode);
		}
		Integer userid = httpModel.getUserModel().getId();
		inDto.put("userid", userid);
		List<Dto> list2 = getUserPorjects(userid);
		for (Dto dto : list2) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("proj_id"));
			treeNode.setText(dto.getString("proj_name") + "(" + dto.getString("trp_name") + ")");
			treeNode.setParentId(dto.getString("type_code"));
			treeNode.setIcon("icon75.png");
			treeNode.setB(dto.getString("trp_name"));
			treeNode.setLeaf(true);
			treeNode.setA("0");
			treeNode.setExpanded(false);
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	//获取我的项目树 （历史，正在进行中的）
	public void my_project_tree(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		//我的项目
		TreeNode treeNode0 = new TreeNode();
		treeNode0.setId("0000");
		treeNode0.setText("我的项目");
		treeNode0.setParentId("0");
		treeNode0.setIcon("home.png");
		treeNode0.setLeaf(false);
		treeNode0.setExpanded(true);
		treeNode0.setA("0");
		treeNodes.add(treeNode0);
		//进行中的项目
		TreeNode treeNode1 = new TreeNode();
		treeNode1.setId("A1");
		treeNode1.setText("进行中的项目");
		treeNode1.setParentId("0000");
		treeNode1.setIcon("042804.png");
		treeNode1.setLeaf(false);
		treeNode1.setExpanded(true);
		treeNode1.setA("1");
		treeNodes.add(treeNode1);
		//历史项目
		TreeNode treeNode2 = new TreeNode();
		treeNode2.setId("A2");
		treeNode2.setText("历史项目");
		treeNode2.setParentId("0000");
		treeNode2.setIcon("042803.png");
		treeNode2.setLeaf(false);
		treeNode2.setExpanded(true);
		treeNode2.setA("2");
		treeNodes.add(treeNode2);
		inDto.put("userid", httpModel.getUserModel().getId());
		List<Dto> list = sqlDao.list("ProjCommonsDao.querymy_project_tree", inDto);
		//查询当前用户的默认项目
		Dto defaultProjIdDto = Dtos.newDto();
		defaultProjIdDto.put("person_id", httpModel.getUserModel().getId());
		Dto have = sqlDao.selectDto("DailyReportDao.SelectDefaultProject", defaultProjIdDto);
		String default_proj_id = null;
		if(AOSUtils.isNotEmpty(have.getString("proj_id"))){
			default_proj_id = have.getString("proj_id");
		}
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("PROJ_ID"));
			//当为该用户默认项目-变颜色
			if(default_proj_id != null && default_proj_id.equals(dto.getString("PROJ_ID"))){
				treeNode.setText("<span style='font-weight:bold;'>"+dto.getString("PROJ_NAME")+"</span><span style='color:red;font-weight:bold;'>(当前项目)</span>");
			}else{
				treeNode.setText(dto.getString("PROJ_NAME"));
			}
			String state = dto.getString("STATE");
			String parentId = state.equals("1")? "A1" : "A2";
			if(parentId.equals("A1")){
				treeNode.setIcon("042802.png");
			}else{
				treeNode.setIcon("bullet_black.png");
			}
			treeNode.setParentId(parentId);
			treeNode.setLeaf(false);
			treeNode.setA("3");
			treeNode.setExpanded(true);
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	
	/**
	 * 查询我的待办任务
	 * 
	 * @param httpModel
	 */
	public void queryToDoTask(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String userid = httpModel.getUserModel().getId().toString();
		inDto.put("userid", userid);
		/**start 2019-07-03注释代码，和测试组沟通，测试组只需要关注自己的缺陷和任务，不需要查看自己指派的，所以注释了 **/
		/*List<Dto>testUserList = sqlDao.list("ProjCommonsDao.queryTestUserid", inDto);
		for(int a=0;a<testUserList.size();a++){
			Dto tDto=testUserList.get(a);
			if(tDto.getString("id").equals(userid)){
				List list = sqlDao.list("ProjCommonsDao.query_to_do_test", inDto);
				httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
				return;
			}
		}*/
		/**end 2019-07-03注释代码，和测试组沟通，测试组只需要关注自己的缺陷和任务，不需要查看自己指派的，所以注释了 **/
		List list = sqlDao.list("ProjCommonsDao.query_to_do_task", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}

	/**
	 * 查询单个项目详情
	 * 
	 * @param httpModel
	 */
	public void queryOneProjectInformation(HttpModel httpModel) {
		Dto dto = httpModel.getInDto();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		// 本周
				Calendar cal = Calendar.getInstance();
				try {
					cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int d = 0;
				if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
					d = -6;
				} else {
					d = 2 - cal.get(Calendar.DAY_OF_WEEK);
				}
				cal.add(Calendar.DAY_OF_WEEK, d);
				// 所在周开始日期
				Date da=cal.getTime();
				cal.add(Calendar.DAY_OF_WEEK, 6);
		//定义第几周
		int getWeekly=0;
		//获取启动时间
		String proj_id=dto.getString("proj_id");
		Date dts = (Date) sqlDao.selectOne("com.bl3.pm.task.dao.WeStorageDao.getProjdt",proj_id);
		//取系统时间
		Date dt=AOSUtils.getDate();
		if(AOSUtils.isEmpty(dts)){
			
		}else{
			//系统时间减去项目启动时间
		int s=AOSUtils.getIntervalDays(dts, dt);
		
		//系统时间减去本周开始时间
		int s_=AOSUtils.getIntervalDays(da,dt);
		int difftDay=s-s_;
		if(difftDay>0) {
			getWeekly=difftDay/7+1;
		if(difftDay%7!=0)
			getWeekly=getWeekly+1;
		}
		else
			getWeekly=1;
		String n ;
		n = "第"+getWeekly+"周";
		dto.put("week_date"  ,n);
		}
		List<Dto> list = sqlDao.list("ProjCommonsDao.queryOneProjectInformation", dto);
		list.add(dto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询默认项目详情
	 * 
	 * @param httpModel
     * @ DailyReportDao
	 */
	public void queryOneProjectInformation_default(HttpModel httpModel) {
		Dto dto = httpModel.getInDto();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		// 本周
				Calendar cal = Calendar.getInstance();
				try {
					cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int d = 0;
				if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
					d = -6;
				} else {
					d = 2 - cal.get(Calendar.DAY_OF_WEEK);
				}
				cal.add(Calendar.DAY_OF_WEEK, d);
				// 所在周开始日期
				Date da=cal.getTime();
				cal.add(Calendar.DAY_OF_WEEK, 6);
		//定义第几周
		int getWeekly=0;
		
	//	Dto proj_id_ = new Dtos(); 
		int person_id = httpModel.getUserModel().getId();
		Dto outDto=Dtos.newDto();
		outDto.put("person_id", person_id);
		List<Dto>pList = sqlDao.list("DailyReportDao.SelectDefaultProject", outDto);
		String proj_id="";
		if(pList.size()!=0){
			 proj_id=pList.get(0).getString("proj_id");
		}
		
		if(AOSUtils.isNotEmpty(proj_id)){
			Date dts = (Date) sqlDao.selectOne("com.bl3.pm.task.dao.WeStorageDao.getProjdt",proj_id);
			//取系统时间
			Date dt=AOSUtils.getDate();
			if(AOSUtils.isEmpty(dts)){
				
			}else{
				//系统时间减去项目启动时间
			int s=AOSUtils.getIntervalDays(dts, dt);
			
			//系统时间减去本周开始时间
			int s_=AOSUtils.getIntervalDays(da,dt);
			int difftDay=s-s_;
			if(difftDay>0) {
				getWeekly=difftDay/7+1;
			if(difftDay%7!=0)
				getWeekly=getWeekly+1;
			}
			else
				getWeekly=1;
			String n ;
			n = "第"+getWeekly+"周";
			dto.put("week_date"  ,n);
			}
			dto.put("proj_id", proj_id);
			List<Dto> list = sqlDao.list("ProjCommonsDao.queryOneProjectInformation", dto);
			list.add(dto);
			httpModel.setOutMsg(AOSJson.toJson(list));
			httpModel.setAttribute("proj_flag", "有默认项目");
			//System.out.println("有默认项目");
		}else{
			httpModel.setAttribute("proj_flag", "无默认项目");
		//	System.out.println("无默认项目");
		}
		httpModel.setAttribute("proj_id_", proj_id);
		
		
	}
	
}