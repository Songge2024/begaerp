package com.bl3.pm.process.service;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.process.dao.CheckMainDao;
import com.bl3.pm.process.dao.po.CheckMainPO;
import com.bl3.pm.process.dao.po.CheckProjTypePO;
import com.bl3.pm.process.dao.po.ProblemTracePO;
import com.google.common.collect.Lists;

/**
 * <b>pr_check_main[pr_check_main]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-22 20:33:19
 */
 @Service
 public class CheckMainService{
 	private static Logger logger = LoggerFactory.getLogger(CheckMainService.class);
 	@Autowired
	private CheckMainDao checkMainDao;
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
		httpModel.setViewPath("pm3/process/projectChecklist/checkList_list.jsp");
	}
	
	/**
	 * 统计查询初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initCheckList(HttpModel httpModel) {
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
		httpModel.setViewPath("pm3/process/projectChecklist/checkCount_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer create_user_id = httpModel.getUserModel().getId();
		CheckMainPO checkMainPO=new CheckMainPO();
		checkMainPO.copyProperties(inDto);
		checkMainPO.setCreate_user_id(create_user_id);
		checkMainPO.setCreate_time(new Date());
		checkMainPO.setState("0");
		checkMainPO.setCheck_code("PC" + idService.code("checkMain","yyMMdd","9999"));
		checkMainDao.insert(checkMainPO);
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
		CheckMainPO checkMainPO=new CheckMainPO();
		checkMainPO.copyProperties(inDto);
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			CheckMainPO statePo = checkMainDao.selectStateByKey(Integer.valueOf(id));
			if(statePo.getState().equals("0")){
				checkMainDao.updateByKey(checkMainPO);
				httpModel.setOutMsg("保存成功");
			}else if(statePo.getState().equals("1")){
				httpModel.setOutMsg("该检查单已提交，不得保存");
				return;
			}
		}
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
			CheckMainPO statePo = checkMainDao.selectStateByKey(Integer.valueOf(id));
			if(statePo.getState().equals("0")){
				/*CheckMainPO po = checkMainDao.selectNumByKey(Integer.valueOf(id));
				if(po.getNo_num()==0&&po.getNone_num()==0&&po.getYes_num()==0&&(po.getSuggest()==""||po.getSuggest().isEmpty())){*/
					checkMainDao.updateDeStateByKey(Integer.valueOf(id));
					checkMainDao.deleteDetailByKey(Integer.valueOf(id));
				/*}else{
					httpModel.setOutMsg("相关检查项已添加状态或建议与意见,不得删除");
					return;
				}*/
			}else{
				httpModel.setOutMsg("该检查项已提交,不得删除");
				return;
			}
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 表单数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadFormInfo(HttpModel httpModel) {
		Dto dto =sqlDao.selectDto("com.bl3.pm.process.dao.CheckMainDao.listCheckMainInfo", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(dto));
	}
	
	/**
	 * 提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			CheckMainPO po = checkMainDao.selectStateByKey(Integer.valueOf(id));
			if(po.getState().equals("0")){
				checkMainDao.updateStateByKey(Integer.valueOf(id));
				httpModel.setOutMsg("提交成功");
			}else{
				httpModel.setOutMsg("该检查单已提交，不得保存");
				return;
			}
		}
		//final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		//String token= JedisUtil.getString(cacheKey);
		//httpModel.setOutMsg(token.toString());
	}
	
	/**
	 * 撤回
	 */
	public void noSubmit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			CheckMainPO po = checkMainDao.selectStateByKey(Integer.valueOf(id));
			if(po.getState().equals("1")){
				checkMainDao.updateStateNoSubmit(Integer.valueOf(id));
				//checkMainDao.deleteDetailByKey(Integer.valueOf(id));
				checkMainDao.deleteProblemByKey(Integer.valueOf(id));
				httpModel.setOutMsg("撤回成功");
			}else{
				httpModel.setOutMsg("该检查单未提交，不能测回");
				return;
			}
		}
	}
	/**
	 * 检查人下拉框检查项目录选择
	 * 
	 * @param httpModel
	 */
	public void listCheckUserId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto list = (Dto)sqlDao.selectOne("com.bl3.pm.process.dao.CheckMainDao.listCheckUserId", inDto);
		
		List<Dto> list_else = sqlDao.list("com.bl3.pm.process.dao.CheckMainDao.listCheckUserId_else", inDto);
		
		list_else.add(0,list);
		httpModel.setOutMsg(AOSJson.toJson(list_else));
	}
	
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		CheckMainPO checkMainPO=checkMainDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(checkMainPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckMainPO> checkMainPOs = checkMainDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkMainPOs, inDto.getPageTotal()));
	}
	/**
	 * QA检查单查询
	 * 统计查询 
	 * @param httpModel
	 */
	public void countPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckMainPO> checkMainPOs = checkMainDao.CountLikeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkMainPOs, inDto.getPageTotal()));
	}
	/**
	 * 统计查询
	 * 符合数汇总查询
	 * @param httpModel
	 */
	public void countNum(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = sqlDao.selectDto("com.bl3.pm.process.dao.CheckMainDao.countNum", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * QA检查单查询
	 * 问题统计
	 * @param httpModel
	 */
	public void problemCount(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<ProblemTracePO> problemTracePOs = checkMainDao.problemCountPage(inDto);
		//Double sum= problemTracePOs.stream().map(p->Double.valueOf(p.getCheck_all())).reduce(Double::sum).get();
		//System.out.println("sum*************************:"+sum);
		httpModel.setOutMsg(AOSJson.toGridJson(problemTracePOs, inDto.getPageTotal()));
	}
	/**
	 * 问题统计
	 * 扣分小计汇总
	 * @param httpModel
	 */
	public void problemNum(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		double count = 0;
		List<ProblemTracePO> problemTracePOs = (List<ProblemTracePO>) sqlDao.list("com.bl3.pm.process.dao.CheckMainDao.problemNum", inDto);
		for(ProblemTracePO POs : problemTracePOs){
			count = count + Double.valueOf(POs.getCheck_all());
		}
		double counts = (double) Math.round(count * 100) / 100;
		Dto pDto = Dtos.newDto();
		pDto.put("count", counts);
		httpModel.setOutMsg(AOSJson.toJson(pDto));
	}
	
	public void countCata_id(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int count = (int) sqlDao.selectOne("com.bl3.pm.process.dao.CheckMainDao.countCata_id", inDto);
		httpModel.setOutMsg(AOSJson.toJson(count));
	}
	
	/**
	 * 新增窗口下拉框检查项目录选择
	 * 
	 * @param httpModel
	 */
	public void listComboBoxcheckCata(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String type_code = checkMainDao.selectTypeCode(inDto);
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.CheckMainDao.listComboBoxcheckCata", type_code);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 树结构
	 */
	public void getCheckMainListTreeData(HttpModel httpModel){
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		//获取项目的类型
		String type_code = checkMainDao.selectTypeCode(inDto);
		if(AOSUtils.isEmpty(type_code)){
			return;
		}
		inDto.put("type_code", type_code);
		//根节点
		TreeNode rootTreeNode = new TreeNode();
		String parent_id = "0";
		rootTreeNode.setId(parent_id);
		rootTreeNode.setText("QA检查单类型");
		rootTreeNode.setLeaf(false);
		rootTreeNode.setParentId("00");
		rootTreeNode.setExpanded(true);
		// 获取父节点-QA检查项
		List<CheckMainPO> mainPOs = checkMainDao.mainList(inDto);
		for(CheckMainPO mainPO : mainPOs){
			TreeNode parentTreeNode = new TreeNode();
			parentTreeNode.setId("P_"+mainPO.getCheck_cata_id().toString());
			parentTreeNode.setText(mainPO.getCheck_cata_name());
			parentTreeNode.setB(mainPO.getCheck_cata_id().toString());
			parentTreeNode.setLeaf(false);
			parentTreeNode.setParentId(parent_id);
			parentTreeNode.setExpanded(true);
			// 获取子目录节点
			inDto.put("check_cata_id", mainPO.getCheck_cata_id());
			List<CheckMainPO> detailPOs = checkMainDao.detailList(inDto);
			for(CheckMainPO detailPO : detailPOs){
				TreeNode subTreeNode = new TreeNode();
				subTreeNode.setId(detailPO.getCheck_id().toString());
				subTreeNode.setParentId(parentTreeNode.getId());
				subTreeNode.setA(detailPO.getCheck_id().toString());
				subTreeNode.setC(detailPO.getState().toString());
				subTreeNode.setLeaf(true);
				subTreeNode.setExpanded(false);
				String state=checkMainDao.selectStateByCheckCode(detailPO.getCheck_code());
				StringBuilder sb=new StringBuilder();
                if(state.equals("1")){
                	sb.append(detailPO.getCheck_code());
                	sb.append("<font color=\"blue\">(已提交)</font>");
                	subTreeNode.setText(sb.toString());
                }else{
                	sb.append(detailPO.getCheck_code());
                	sb.append("<font color=\"red\">(未提交)</font>");
                	subTreeNode.setText(sb.toString());
                }
                subTreeNode.setC(state);
				parentTreeNode.appendChild(subTreeNode);
			}
			rootTreeNode.appendChild(parentTreeNode);
	}
		treeNodes.add(rootTreeNode);
		String treeJson = AOSJson.toJson(treeNodes);
		httpModel.setOutMsg(treeJson);
		return;
	}
	
	/**
	 * 问题统计树结构
	 */
	public void getCheckMainProblemTreeData(HttpModel httpModel){
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}
		//获取项目的类型
		String type_code = checkMainDao.selectTypeCode(inDto);
		if(AOSUtils.isEmpty(type_code)){
			return;
		}
		inDto.put("type_code", type_code);
		//根节点
		TreeNode rootTreeNode = new TreeNode();
		String parent_id = "0";
		rootTreeNode.setId(parent_id);
		rootTreeNode.setText("QA检查单类型");
		rootTreeNode.setLeaf(false);
		rootTreeNode.setParentId("00");
		rootTreeNode.setExpanded(true);
		// 获取父节点-QA检查项
		List<CheckMainPO> mainPOs = checkMainDao.mainList(inDto);
		for(CheckMainPO mainPO : mainPOs){
			TreeNode parentTreeNode = new TreeNode();
			parentTreeNode.setId("P_"+mainPO.getCheck_cata_id().toString());
			parentTreeNode.setText(mainPO.getCheck_cata_name());
			parentTreeNode.setB(mainPO.getCheck_cata_id().toString());
			parentTreeNode.setLeaf(true);
			parentTreeNode.setParentId(parent_id);
			parentTreeNode.setExpanded(true);
			// 获取子目录节点
			inDto.put("check_cata_id", mainPO.getCheck_cata_id());
			rootTreeNode.appendChild(parentTreeNode);
	}
		treeNodes.add(rootTreeNode);
		String treeJson = AOSJson.toJson(treeNodes);
		httpModel.setOutMsg(treeJson);
		return;
	}
 }