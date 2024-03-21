package com.bl3.pm.quality.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.jsoup.Jsoup;
import org.jsoup.examples.HtmlToPlainText;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.HtmlUtils;

import com.bl3.pm.contacts.dao.po.TopContactsPO;
import com.bl3.pm.quality.dao.BugManageDao;
import com.bl3.pm.quality.dao.po.BugManagePO;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.dao.AosCmpDao;

/**
 * <b>qa_bug_manage[qa_bug_manage]业务逻辑层</b>
 * 
 * @author yiping
 * @date 2017-12-08 11:13:48
 */
@Service
public class BugManageService {
	private static Logger logger = LoggerFactory.getLogger(BugManageService.class);
	@Autowired
	private BugManageDao bugManageDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;

	/**
	 * 初始化缺陷管理视图
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
		httpModel.setViewPath("pm3/quality/bugmanage/bugManage.jsp");
	}

	/**
	 * 初始化缺陷管理视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void mybugInit(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/quality/bugmanage/MyBugManage.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// inDto.remove("id");
		BugManagePO bugManagePO = new BugManagePO();
		// bugManagePO.setId(idService.nextValue("seq_qa_bug_manage").intValue());
		inDto.put("bug_code", "BG" + idService.code("bug_code"));
		bugManagePO.copyProperties(inDto);
		bugManageDao.insert(bugManagePO);
		Dto pDto = Dtos.newDto();
		pDto.put("bug_code", inDto.getString("bug_code"));
		//查询bug_id
		BugManagePO bmPO = bugManageDao.selectOne(pDto);	
	    Dto bugNewsDto = Dtos.newDto();
	    bugNewsDto.put("proj_id", bmPO.getProj_id());
	    bugNewsDto.put("bug_id", bmPO.getBug_id());
	    bugNewsDto.put("detail", 1);
	    bugNewsDto.put("news_detail", " ["+bmPO.getFind_name()+"] 在 ["+AOSUtils.getDateStr()+"] 新增");
	    bugNewsDto.put("state", bmPO.getState());
	    bugNewsDto.put("next_deal_man", bmPO.getDeal_man());
	    bugNewsDto.put("submit_name", bmPO.getFind_name());
	    //插入日志
	    sqlDao.insert("BugDealDao.insertByLogId", bugNewsDto);
	    //获取最大的日志记录
	    Integer max_log_id = (Integer)sqlDao.selectOne("BugDealDao.selectMaxLogId", bmPO.getBug_id());
		//更新bug表
		BugManagePO updateBMPO = new BugManagePO();
		updateBMPO.setBug_id(bmPO.getBug_id());
		updateBMPO.setLog_id(max_log_id.toString());
		bugManageDao.updateByKey(updateBMPO);
		
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 复制新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void copyCreate(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// inDto.remove("id");
		BugManagePO bugManagePO = new BugManagePO();
		// bugManagePO.setId(idService.nextValue("seq_qa_bug_manage").intValue());
		inDto.put("bug_code", "BG" + idService.code("bug_code"));
		bugManagePO.copyProperties(inDto);
		bugManageDao.insert(bugManagePO);
		BugManagePO copyBugManagePO = new BugManagePO();
		String relate_bug_code = (String)sqlDao.selectOne("com.bl3.pm.quality.dao.BugManageDao.selectRelateBugCode", inDto.getInteger("from_bug_id"));
		copyBugManagePO.setBug_id(inDto.getString("from_bug_id"));
		//String name = inDto.getString("from_bug_proj");
		String name = inDto.getString("tree_proj_name");
		if(AOSUtils.isEmpty(relate_bug_code)){
			copyBugManagePO.setRelate_bug_code(name+inDto.getString("bug_code"));
			
		}else{
			copyBugManagePO.setRelate_bug_code(relate_bug_code+","+name+inDto.getString("bug_code"));
		}
		bugManageDao.updateByKey(copyBugManagePO);
		Dto pDto = Dtos.newDto();
		pDto.put("bug_code", inDto.getString("bug_code"));
		//查询bug_id
		BugManagePO bmPO = bugManageDao.selectOne(pDto);	
	    Dto bugNewsDto = Dtos.newDto();
	    bugNewsDto.put("proj_id", bmPO.getProj_id());
	    bugNewsDto.put("bug_id", bmPO.getBug_id());
	    bugNewsDto.put("detail", 1);
	    bugNewsDto.put("news_detail", " ["+bmPO.getFind_name()+"] 在 ["+AOSUtils.getDateStr()+"] 新增");
	    bugNewsDto.put("state", bmPO.getState());
	    bugNewsDto.put("next_deal_man", bmPO.getDeal_man());
	    bugNewsDto.put("submit_name", bmPO.getFind_name());
	    //插入日志
	    sqlDao.insert("BugDealDao.insertByLogId", bugNewsDto);
	    //获取最大的日志记录
	    Integer max_log_id = (Integer)sqlDao.selectOne("BugDealDao.selectMaxLogId", bmPO.getBug_id());
		//更新bug表
		BugManagePO updateBMPO = new BugManagePO();
		updateBMPO.setBug_id(bmPO.getBug_id());
		updateBMPO.setLog_id(max_log_id.toString());
		bugManageDao.updateByKey(updateBMPO);
		
		//关联ID
		int from_proj_id = inDto.getInteger("from_proj_id");
		int from_bug_id = inDto.getInteger("from_bug_id");
		Dto bugCopyDto = Dtos.newDto();
		bugCopyDto.put("from_proj_id", from_proj_id);
		bugCopyDto.put("from_bug_id", from_bug_id);
		bugCopyDto.put("to_proj_id", bmPO.getProj_id());
		bugCopyDto.put("to_bug_id", bmPO.getBug_id());
		bugCopyDto.put("create_id", httpModel.getUserModel().getId());
		bugCopyDto.put("create_time", new Date());
		sqlDao.insert("BugCopyDao.insertCopy", bugCopyDto);
		
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 复制新增查询重名
	 */
	public void  selectCopyBug(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer count = (Integer)sqlDao.selectOne("com.bl3.pm.quality.dao.BugManageDao.selectCopyBug", inDto);
		httpModel.setOutMsg(AOSJson.toJson(count));
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
		BugManagePO bugManagePO = new BugManagePO();
		bugManagePO.copyProperties(inDto);
		bugManageDao.updateByKey(bugManagePO);
		//保存修改记录
		int BUGID = inDto.getInteger("bug_id");
		Integer detail = 0;
		//查询同一个bug_id下最大的序列号
		Integer maxdetail = (Integer) sqlDao.selectOne("BugDealDao.selectNewsDetail", BUGID);
		if (maxdetail == null) {
			detail = 1;
		} else
			detail = maxdetail++;
		inDto.put("detail", detail);
		inDto.put("news_detail", "对缺陷做出修改");
		sqlDao.insert("BugDealDao.insertByLogId", inDto);
		httpModel.setOutMsg("修改成功");
	}

	/**
	 * 批量删除
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void deletes(HttpModel httpModel) {
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			bugManageDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("批量删除账户数据成功。");
	}

	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int id = inDto.getInteger("id");
		bugManageDao.deleteByKey(id);
		httpModel.setOutMsg("删除成功");
	}

	/**
	 * 关闭问题
	 * 
	 * @param httpModel
	 * @return
	 */
	public void close(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		sqlDao.update("BugDealDao.closeByBugId", inDto);
		httpModel.setOutMsg("关闭成功");
	}

	/**
	 * 延期处理
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delay(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		sqlDao.update("BugDealDao.delayByBugId", inDto);
		httpModel.setOutMsg("操作成功");
	}
	/**
	 * 提交保存消息并更改主表状态
	 * 
	 * @param httpModel
	 * @return
	 */
	public void saveNews(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int BUGID = inDto.getInteger("bug_id");
		Integer detail = 0;
		//查询同一个bug_id下最大的序列号
		Integer maxdetail = (Integer) sqlDao.selectOne("BugDealDao.selectNewsDetail", BUGID);
		if (maxdetail == null) {
			detail = 1;
		} else
			detail = maxdetail++;
		inDto.put("detail", detail);
		
		BigDecimal plan_wastage = inDto.getBigDecimal("plan_wastage");
		BigDecimal real_wastage = inDto.getBigDecimal("real_wastage");
		if(AOSUtils.isEmpty(plan_wastage)){
			inDto.put("plan_wastage", 0);
		}
		if(AOSUtils.isEmpty(real_wastage)){
			inDto.put("real_wastage", 0);
		}
		
//      将处理信息中的单引号转换为HTML形式
		String trans_news_detail = inDto.getString("trans_news_detail");
		inDto.put("news_detail", trans_news_detail);
		
		sqlDao.insert("BugDealDao.insertByLogId", inDto);
		Integer max_log_id = (Integer)sqlDao.selectOne("BugDealDao.selectMaxLogId", BUGID);
		inDto.put("log_id", max_log_id);
		
		
		//如果是关闭操作
		if (inDto.getString("next_state").equals("1003")) {
			sqlDao.update("BugDealDao.updateCloseState", inDto);
		} else if(inDto.getString("next_state").equals("1001")){
			sqlDao.update("BugDealDao.updateSolveState", inDto);
		}else{
			sqlDao.update("BugDealDao.updateState", inDto);
		}

		httpModel.setOutMsg("提交成功");
	}

	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		BugManagePO bugManagePO = bugManageDao.selectByKey(inDto.getInteger("bug_id"));
		httpModel.setOutMsg(AOSJson.toJson(bugManagePO));
	}

	/**
	 * 获取消息
	 * 
	 * @param httpModel
	 * @return
	 */
	public void newsdata(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> dto = uset_text(inDto);
		inDto.setAppMsg(httpModel.getInDto().getString("juid"));
		// sqlDao.update("BugDealDao.closeByBugId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(dto));
	}

	/**
	 * 获取用户回复内容
	 * 
	 * @param inDto
	 * @return
	 */
	private List<Dto> uset_text(Dto text_code) {
		List<Dto> _userText = bugManageDao.getNewsDate(text_code);
		return _userText;
	}

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException
	 */
	public void newsdataInit(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		String find_time = null;
		String create_time = null;
		String close_time = null;
		String standard_id=null;
		Dto inDto = httpModel.getInDto();
		BugManagePO bugManagePO = bugManageDao.selectByKey(inDto.getInteger("bug_id"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//将发现时间，创建时间，关闭时间放入PO对象
 		if (bugManagePO.getFind_time() != null) {
			find_time = sdf.format(bugManagePO.getFind_time());
		}
		if (bugManagePO.getCreate_time() != null) {
			create_time = sdf.format(bugManagePO.getCreate_time());
		}
		if (bugManagePO.getClose_time() != null) {
			close_time = sdf.format(bugManagePO.getClose_time());
		}
		if (bugManagePO.getStandard_id() == null || bugManagePO.getStandard_id()=="") {
			standard_id = "3.33";
			bugManagePO.setStandard_id(standard_id);
		}
		// java.util.Date find_time=sdf.parse(find);
		bugManagePO.setFind_newtime(find_time);
		bugManagePO.setCreate_newtime(create_time);
		bugManagePO.setClose_newtime(close_time);
		// 主表信息
		httpModel.setAttribute("bug", bugManagePO);
		// 回复消息
		httpModel.setAttribute("userTx", uset_text(inDto));
		// 上级主键
		httpModel.setAttribute("bug_id", inDto.getInteger("bug_id"));
		// 当前登录人
		httpModel.setAttribute("user_name", inDto.getString("user_name"));
		// 查询当前登录人是否有权限修改计划时间
		Dto putDto = Dtos.newDto();
		putDto.put("proj_id", bugManagePO.getProj_id());
		putDto.put("team_user_id", httpModel.getUserModel().getId());
		putDto.put("permission_code", "update_bug_plan_wastage");
		int manager_user_count =(int) sqlDao.selectOne("WeeklyStorage.getRoleTypePermissionPersonCount", putDto);
		httpModel.setAttribute("manager_user_count", manager_user_count);
		
//		httpModel.setViewPath("pm3/quality/bugmanage/bugNews.jsp");
		httpModel.setViewPath("pm3/quality/bugmanage/bug_portal_news.jsp");
	}
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException
	 */
	public void newsManageInit(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		String find_time = null;
		String create_time = null;
		String close_time = null;
		String standard_id=null;
		Dto inDto = httpModel.getInDto();
		BugManagePO bugManagePO = bugManageDao.selectByKey(inDto.getInteger("bug_id"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//将发现时间，创建时间，关闭时间放入PO对象
 		if (bugManagePO.getFind_time() != null) {
			find_time = sdf.format(bugManagePO.getFind_time());
		}
		if (bugManagePO.getCreate_time() != null) {
			create_time = sdf.format(bugManagePO.getCreate_time());
		}
		if (bugManagePO.getClose_time() != null) {
			close_time = sdf.format(bugManagePO.getClose_time());
		}
		if (bugManagePO.getStandard_id() == null || bugManagePO.getStandard_id()=="") {
			standard_id = "3.33";
			bugManagePO.setStandard_id(standard_id);
		}
		// java.util.Date find_time=sdf.parse(find);
		bugManagePO.setFind_newtime(find_time);
		bugManagePO.setCreate_newtime(create_time);
		bugManagePO.setClose_newtime(close_time);
		// 主表信息
		httpModel.setAttribute("bug", bugManagePO);
		// 回复消息
		httpModel.setAttribute("userTx", uset_text(inDto));
		// 上级主键
		httpModel.setAttribute("bug_id", inDto.getInteger("bug_id"));
		// 当前登录人
		httpModel.setAttribute("user_name", inDto.getString("user_name"));
		// 查询当前登录人是否有权限修改计划时间
		Dto putDto = Dtos.newDto();
		putDto.put("proj_id", bugManagePO.getProj_id());
		putDto.put("team_user_id", httpModel.getUserModel().getId());
		putDto.put("permission_code", "update_bug_plan_wastage");
		int manager_user_count =(int) sqlDao.selectOne("WeeklyStorage.getRoleTypePermissionPersonCount", putDto);
		httpModel.setAttribute("manager_user_count", manager_user_count);
		
//		httpModel.setViewPath("pm3/quality/bugmanage/bugNews.jsp");
		httpModel.setViewPath("pm3/quality/bugmanage/bug_manage_news.jsp");
	}

	/**
	 * 分页查询我的缺陷
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String bug_states = inDto.getString("state");
		if(AOSUtils.isNotEmpty(bug_states)){
			List<String> bug_stateList =AOSJson.getList(bug_states, String.class);
			inDto.put("state", bug_stateList);
		}
		List<BugManagePO> bugManagePOs = bugManageDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询缺陷管理
	 * 
	 * @param httpModel
	 */
	public void bugpage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String bug_states = inDto.getString("bug_states");
		String severity = inDto.getString("severitys");
		String bug_addr = inDto.getString("bug_addrs");
		String bug_type = inDto.getString("bug_types");
		String priority = inDto.getString("priority");
		if(AOSUtils.isNotEmpty(bug_states)){
			List<String> bug_stateList =AOSJson.getList(bug_states, String.class);
			inDto.put("bug_states", bug_stateList);
		}
		if(AOSUtils.isNotEmpty(severity)){
			List<String> bug_severityList =AOSJson.getList(severity, String.class);
			inDto.put("severitys", bug_severityList);
		}
		if(AOSUtils.isNotEmpty(bug_addr)){
			List<String> bug_addrList =AOSJson.getList(bug_addr, String.class);
			inDto.put("bug_addrs", bug_addrList);
		}
		if(AOSUtils.isNotEmpty(bug_type)){
			List<String> bug_typeList =AOSJson.getList(bug_type, String.class);
			inDto.put("bug_types", bug_typeList);
		}
		if(AOSUtils.isNotEmpty(priority)){
			List<String> priorityList =AOSJson.getList(priority, String.class);
			inDto.put("priority", priorityList);
		}
		if(AOSUtils.isNotEmpty(inDto.getString("proj_id"))){
			List<BugManagePO> bugManagePOs = bugManageDao.buglikeOrPage(inDto);
		    int count=bugManageDao.buglikeOrCount(inDto);
			httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, count));
		}else{
			List<BugManagePO> bugManagePOs = bugManageDao.bugVaguePage(inDto);
			int count=bugManageDao.bugVagueCount(inDto);
			httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, count));
		}
	}
	
	/**
	 * 复制粘贴
	 * 
	 * @param httpModel
	 */
	public void copyBug(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String copy_bug_id = inDto.getString("copy_bug_id");
		if(AOSUtils.isNotEmpty(copy_bug_id)){
			List<String> copyBugIdList =Arrays.asList(copy_bug_id.split(","));
			//inDto.put("bug_states", copyBugIdList);
			for(String str : copyBugIdList){
				BugManagePO bugManagePO = new BugManagePO();
				bugManagePO = bugManageDao.selectByCopyBugId(Integer.valueOf(str));
				bugManagePO.setBug_code(("BG" + idService.code("bug_code")));
				bugManagePO.setBug_id("");
				bugManagePO.setStand_id(inDto.getString("stand_id"));
				bugManagePO.setFind_time(new Date());
				bugManagePO.setCreate_time(new Date());
				bugManagePO.setCreate_name((httpModel.getUserModel().getId()).toString());
				bugManagePO.setFind_name(httpModel.getUserModel().getName());
				bugManageDao.insert(bugManagePO);
				
				Dto pDto = Dtos.newDto();
				pDto.put("bug_code", bugManagePO.getBug_code());
				//查询bug_id
				BugManagePO bmPO = bugManageDao.selectOne(pDto);	
			    Dto bugNewsDto = Dtos.newDto();
			    bugNewsDto.put("proj_id", bmPO.getProj_id());
			    bugNewsDto.put("bug_id", bmPO.getBug_id());
			    bugNewsDto.put("detail", 1);
			    bugNewsDto.put("news_detail", " ["+bmPO.getFind_name()+"] 在 ["+AOSUtils.getDateStr()+"] 新增");
			    bugNewsDto.put("state", bmPO.getState());
			    bugNewsDto.put("next_deal_man", bmPO.getDeal_man());
			    bugNewsDto.put("submit_name", bmPO.getFind_name());
			    //插入日志
			    sqlDao.insert("BugDealDao.insertByLogId", bugNewsDto);
			    //获取最大的日志记录
			    Integer max_log_id = (Integer)sqlDao.selectOne("BugDealDao.selectMaxLogId", bmPO.getBug_id());
				//更新bug表
				BugManagePO updateBMPO = new BugManagePO();
				updateBMPO.setBug_id(bmPO.getBug_id());
				updateBMPO.setLog_id(max_log_id.toString());
				bugManageDao.updateByKey(updateBMPO);
			}
		}
		httpModel.setOutMsg("复制成功。");
	}
	
	/**
	 * 下拉框查询项目版本号
	 * 
	 * @param httpModel
	 */
	public void listComboBoxVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listComboBoxVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	public void queryName(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.queryDevelopManageByProjId", inDto);
		if(list.size() == 1){
			Dto dto = list.get(0);
			String developManageName = dto.getString("team_user_name");
			String developManageId = dto.getString("team_user_id");

			outDto.put("developManageName", developManageName);
			outDto.put("developManageId", developManageId);
			outDto.setAppCode(AOSCons.SUCCESS);
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 下拉框查询代码版本号
	 * 
	 * @param httpModel
	 */
	public void listComboBoxCodeVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listComboBoxCodeVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 下拉框查询测试版本号
	 */
	public void listComboBoxTestVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listComboBoxTestVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询页面测试版本号下拉框
	 */
	public void listSearchTestVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listSearchTestVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 下拉框查询当前处理人
	 * 
	 * @param httpModel
	 */
	public void listDealmanComboBox(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listComboBoxDealman", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 下拉框查询发现人
	 * 
	 * @param httpModel
	 */
	public void listFindnameComboBox(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listComboBoxFindname", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void bugCopyPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> bugCopyPageList = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.bugCopyPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bugCopyPageList, inDto.getPageTotal()));
	}
	
	/**
	 * bug关联分页查询
	 * 
	 * @param httpModel
	 */
	public void bugRelationPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> bugRelationPageList = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.bugRelationPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bugRelationPageList, inDto.getPageTotal()));
	}
	
	/**
	 * bug关联保存
	 * @param httpModel
	 */
	public void relationSave(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String from_proj_id = inDto.getString("from_proj_id");
		String from_bug_id = inDto.getString("from_bug_id");
		String[] selectionIds = inDto.getRows();
		for(String id : selectionIds) {
			inDto.put("id", id);
			int countBugId = (int) sqlDao.selectOne("BugCopyDao.relationSave", inDto);
			if(countBugId == 0){
				List<Dto> list = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.listBugId", inDto);
				for(Dto dto : list){
					Dto bugCopyDto = Dtos.newDto();
					bugCopyDto.put("from_proj_id", from_proj_id);
					bugCopyDto.put("from_bug_id", from_bug_id);
					bugCopyDto.put("to_proj_id", dto.getString("proj_id"));
					bugCopyDto.put("to_bug_id", dto.getString("bug_id"));
					bugCopyDto.put("create_id", httpModel.getUserModel().getId());
					bugCopyDto.put("create_time", new Date());
					sqlDao.insert("BugCopyDao.insertCopy", bugCopyDto);
					httpModel.setOutMsg("关联成功");
				}
			}
		}
	}
	
	/**
	 * 全部导出
	 */
	public void exportExcel2(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String bug_states = inDto.getString("bug_states");
		String severity = inDto.getString("severitys");
		String bug_type = inDto.getString("bug_types");
		String bug_addr = inDto.getString("bug_addrs");
		String update_begin_time = inDto.getString("update_begin_time");
		String update_end_time = inDto.getString("update_end_time");
		String find_begin_time = inDto.getString("find_begin_time");
		String find_end_time = inDto.getString("find_end_time");
		String find_name = inDto.getString("find_name");
		String deal_man = inDto.getString("deal_man");
		String query_values = inDto.getString("query_values");
		Integer test_version_id = inDto.getInteger("test_version_id");
		String final_deal_man = inDto.getString("final_deal_man");
		if(AOSUtils.isNotEmpty(bug_states)){
			List<String> bug_stateList =Arrays.asList(bug_states.split(","));
			inDto.put("bug_states", bug_stateList);
		}
		if(AOSUtils.isNotEmpty(severity)){
			List<String> bug_severityList =Arrays.asList(severity.split(","));
			inDto.put("severitys", bug_severityList);
		}
		if(AOSUtils.isNotEmpty(bug_addr)){
			List<String> bug_addrList =Arrays.asList(bug_addr.split(","));
			inDto.put("bug_addrs", bug_addrList);
		}
		if(AOSUtils.isNotEmpty(bug_type)){
			List<String> bug_typeList =Arrays.asList(bug_type.split(","));
			inDto.put("bug_types", bug_typeList);
		}
//		List<BugManagePO> bugManagePOs = bugManageDao.bugSearch(inDto);
		//int count=bugManageDao.buglikeOrCount(inDto);
		//httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, count));
		
		//List<Dto> faPOs =  sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.testExampleArrayList", bug_id);
		List<Dto> faPOs =  sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.bugSearch", inDto);
		for(int k=0;k<faPOs.size();k++){
			Dto faPO = faPOs.get(k);
			//判断当前状态
			if(Integer.valueOf(faPO.get("state").toString())==1000){
				faPO.put("state", "未解决");
			}else if(Integer.valueOf(faPO.get("state").toString())==1001){
				faPO.put("state", "已解决");
			}else if(Integer.valueOf(faPO.get("state").toString())==1002){
				faPO.put("state", "延期处理");
			}else if(Integer.valueOf(faPO.get("state").toString())==1003){
				faPO.put("state", "关闭");
			}else if(Integer.valueOf(faPO.get("state").toString())==1004){
				faPO.put("state", "拒绝");
			}else if(Integer.valueOf(faPO.get("state").toString())==1005){
				faPO.put("state", "重新打开");
			}else if(Integer.valueOf(faPO.get("state").toString())==1006){
				faPO.put("state", "无法复现");
			}else if(Integer.valueOf(faPO.get("state").toString())==1007){
				faPO.put("state", "已删除");
			}
			//判断严重程度
			if(Integer.valueOf(faPO.get("severity").toString())==1000){
				faPO.put("severity", "轻微");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1001){
				faPO.put("severity", "一般");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1002){
				faPO.put("severity", "严重");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1003){
				faPO.put("severity", "致命");
			}
			//判断优先级
			if(Integer.valueOf(faPO.get("priority").toString())==1000){
				faPO.put("priority", "不急");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1001){
				faPO.put("priority", "普通");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1002){
				faPO.put("priority", "急");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1003){
				faPO.put("priority", "特急");
			}
			//判断缺陷类型
			if(Integer.valueOf(faPO.get("bug_type").toString())==1000){
				faPO.put("bug_type", "缺陷");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1001){
				faPO.put("bug_type", "非缺陷");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1002){
				faPO.put("bug_type", "改进建议");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1003){
				faPO.put("bug_type", "代码走直问题");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1004){
				faPO.put("bug_type", "文档评审问题");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1005){
				faPO.put("bug_type", "功能缺失");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1006){
				faPO.put("bug_type", "需求变更");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1007){
				faPO.put("bug_type", "文档更新");
			}
			//判断缺陷位置
			if(Integer.valueOf(faPO.get("bug_addr").toString())==1000){
				faPO.put("bug_addr", "界面");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1001){
				faPO.put("bug_addr", "文档");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1002){
				faPO.put("bug_addr", "编码");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1003){
				faPO.put("bug_addr", "设计");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1004){
				faPO.put("bug_addr", "操作不当");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1005){
				faPO.put("bug_addr", "接口");
			}
			//判断出现频率
			if(Integer.valueOf(faPO.get("rate").toString())==1000){
				faPO.put("rate", "每次都可重现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1001){
				faPO.put("rate", "经常出现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1002){
				faPO.put("rate", "偶尔出现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1003){
				faPO.put("rate", "很难重现");
			}
			//判断来源方
			if(Integer.valueOf(faPO.get("source").toString())==1000){
				faPO.put("source", "内部测试");
			}else if(Integer.valueOf(faPO.get("source").toString())==1001){
				faPO.put("source", "第三方测试");
			}else if(Integer.valueOf(faPO.get("source").toString())==1002){
				faPO.put("source", "客户反馈");
			}else if(Integer.valueOf(faPO.get("source").toString())==1003){
				faPO.put("source", "其他");
			}
			Document doc = Jsoup.parse(faPO.getString("bug_detail"));
			HtmlToPlainText htmlToPlainText =new HtmlToPlainText();
			String plainText = htmlToPlainText.getPlainText(doc);
			faPO.put("bug_detail", plainText);
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "缺陷管理");
		exporter.setData(pDto, faPOs);
		exporter.setTemplatePath("/export/excel/bugManage.xlsx");
		exporter.setFilename("缺陷管理.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String[] bug_id = inDto.getString("selection").split(",");
		List<Dto> faPOs =  sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.testExampleArrayList", bug_id);
		for(int k=0;k<faPOs.size();k++){
			Dto faPO = faPOs.get(k);
			//判断当前状态
			if(Integer.valueOf(faPO.get("state").toString())==1000){
				faPO.put("state", "未解决");
			}else if(Integer.valueOf(faPO.get("state").toString())==1001){
				faPO.put("state", "已解决");
			}else if(Integer.valueOf(faPO.get("state").toString())==1002){
				faPO.put("state", "延期处理");
			}else if(Integer.valueOf(faPO.get("state").toString())==1003){
				faPO.put("state", "关闭");
			}else if(Integer.valueOf(faPO.get("state").toString())==1004){
				faPO.put("state", "拒绝");
			}else if(Integer.valueOf(faPO.get("state").toString())==1005){
				faPO.put("state", "重新打开");
			}else if(Integer.valueOf(faPO.get("state").toString())==1006){
				faPO.put("state", "无法复现");
			}else if(Integer.valueOf(faPO.get("state").toString())==1007){
				faPO.put("state", "已删除");
			}
			//判断严重程度
			if(Integer.valueOf(faPO.get("severity").toString())==1000){
				faPO.put("severity", "轻微");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1001){
				faPO.put("severity", "一般");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1002){
				faPO.put("severity", "严重");
			}else if(Integer.valueOf(faPO.get("severity").toString())==1003){
				faPO.put("severity", "致命");
			}
			//判断优先级
			if(Integer.valueOf(faPO.get("priority").toString())==1000){
				faPO.put("priority", "不急");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1001){
				faPO.put("priority", "普通");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1002){
				faPO.put("priority", "急");
			}else if(Integer.valueOf(faPO.get("priority").toString())==1003){
				faPO.put("priority", "特急");
			}
			//判断缺陷类型
			if(Integer.valueOf(faPO.get("bug_type").toString())==1000){
				faPO.put("bug_type", "缺陷");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1001){
				faPO.put("bug_type", "非缺陷");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1002){
				faPO.put("bug_type", "改进建议");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1003){
				faPO.put("bug_type", "代码走直问题");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1004){
				faPO.put("bug_type", "文档评审问题");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1005){
				faPO.put("bug_type", "功能缺失");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1006){
				faPO.put("bug_type", "需求变更");
			}else if(Integer.valueOf(faPO.get("bug_type").toString())==1007){
				faPO.put("bug_type", "文档更新");
			}
			//判断缺陷位置
			if(Integer.valueOf(faPO.get("bug_addr").toString())==1000){
				faPO.put("bug_addr", "界面");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1001){
				faPO.put("bug_addr", "文档");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1002){
				faPO.put("bug_addr", "编码");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1003){
				faPO.put("bug_addr", "设计");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1004){
				faPO.put("bug_addr", "操作不当");
			}else if(Integer.valueOf(faPO.get("bug_addr").toString())==1005){
				faPO.put("bug_addr", "接口");
			}
			//判断出现频率
			if(Integer.valueOf(faPO.get("rate").toString())==1000){
				faPO.put("rate", "每次都可重现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1001){
				faPO.put("rate", "经常出现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1002){
				faPO.put("rate", "偶尔出现");
			}else if(Integer.valueOf(faPO.get("rate").toString())==1003){
				faPO.put("rate", "很难重现");
			}
			//判断来源方
			if(Integer.valueOf(faPO.get("source").toString())==1000){
				faPO.put("source", "内部测试");
			}else if(Integer.valueOf(faPO.get("source").toString())==1001){
				faPO.put("source", "第三方测试");
			}else if(Integer.valueOf(faPO.get("source").toString())==1002){
				faPO.put("source", "客户反馈");
			}else if(Integer.valueOf(faPO.get("source").toString())==1003){
				faPO.put("source", "其他");
			}
			Document doc = Jsoup.parse(faPO.getString("bug_detail"));
			HtmlToPlainText htmlToPlainText =new HtmlToPlainText();
			String plainText = htmlToPlainText.getPlainText(doc);
			faPO.put("bug_detail", plainText);
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		paramsDto.put("reportTitle", "缺陷管理");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/bugManage.xlsx");
		exporter.setFilename("缺陷管理.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	public static void main(String[] args) {
		List<Map> list = new ArrayList<Map>();
		for(int i=1; i<11; i++){
			Map map = new HashMap();
			map.put("id", i);
			map.put("name", "name"+i);
			map.put("count", i);
			list.add(map);
		}
		System.out.println("list="+list);
		
		int day = 120;
		String result = "";
		
		for(Map testMap : list){
			int testCount = (int) testMap.get("count");
			String testName = (String) testMap.get("name");
			if(day > testCount){
				day = day - testCount;
			}
			else if(day == testCount){
				result = testName+"等于";
				break;
			}
			else if(day < testCount){
				result = testName+"小于";
				break;
			}
		}
		
		System.out.println("result="+result);
				
	}
}