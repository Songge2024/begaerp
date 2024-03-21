package com.bl3.pm.queryanalysis.service;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.process.dao.po.CheckMainPO;
import com.bl3.pm.quality.dao.BugManageDao;
import com.bl3.pm.quality.dao.TestExampleDao;
import com.bl3.pm.quality.dao.po.BugManagePO;
import com.bl3.pm.quality.dao.po.TestExamplePO;

//import com.google.gson.JsonArray;
//import com.google.gson.JsonObject;


import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * 项目缺陷分析表业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-01-08 15:26:55
 */
 @Service
 public class ProjBugAnalysisService{
 	private static Logger logger = LoggerFactory.getLogger(ProjBugAnalysisService.class);
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private BugManageDao bugManageDao;
 	@Autowired
	private TestExampleDao testExampleDao;
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
		httpModel.setViewPath("pm3/queryanalysis/projBugAnalysis/proBugAnalysistype_grid.jsp");
//		httpModel.setViewPath("pm3/queryanalysis/proj_bugAnalysis.jsp");
	}
	
	/**
	 * 项目缺陷按需求查询
	 * 
	 * @param httpModel
	 */
	public void listDemand(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		String test_version_ids = inDto.getString("test_version_ids");
		if(AOSUtils.isNotEmpty(test_version_ids)){
			List<String> test_version_idsList =AOSJson.getList(test_version_ids, String.class);
			inDto.put("test_version_ids", test_version_idsList);
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist =null;
		if(inDto.get("id").toString().contains("bug_demand")){
	     workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisDemandPage", inDto);
		}
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0 ){
			String msg="该项目没有可以展示的缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		for(Dto s:workChecklist){
				String name=s.getString("name");
				name=name+"("+s.getInteger("value")+")";
				Integer value=s.getInteger("value");
				legen.add(name);
			
		}
		outDto.put("legen", legen);
		httpModel.setOutMsg(AOSJson.toJson(workChecklist));
	}
	
	
	/**
	 * 项目缺陷按项目进度计划查询
	 * 
	 * @param httpModel
	 */
	public void listWeek(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		String test_version_ids = inDto.getString("test_version_ids");
		if(AOSUtils.isNotEmpty(test_version_ids)){
			List<String> test_version_idsList =AOSJson.getList(test_version_ids, String.class);
			inDto.put("test_version_ids", test_version_idsList);
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist =null;
		if(inDto.get("id").toString().contains("bug_week")){
	     workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisWeekPage", inDto);
		}
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0){
			String msg="该项目没有可以展示的缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		for(Dto s:workChecklist){
				String name=s.getString("name");
//				name=name+"("+s.getString("begin_date")+"\t"+"~"+"\t"+s.getString("end_date")+")";
				legen.add(name);
		}
		outDto.put("legen", legen);
		workChecklist.add(outDto);
		httpModel.setOutMsg(AOSJson.toJson(workChecklist));
	}
	/**
	 * 项目缺陷按模块查询
	 * 
	 * @param httpModel
	 */
	public void listModule(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		String test_version_ids = inDto.getString("test_version_ids");
		if(AOSUtils.isNotEmpty(test_version_ids)){
			List<String> test_version_idsList =AOSJson.getList(test_version_ids, String.class);
			inDto.put("test_version_ids", test_version_idsList);
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisModulePage", inDto);
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0){
			String msg="该项目没有可以展示的模块缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		for(Dto s:workChecklist){
			if(AOSUtils.isNotEmpty(s.getString("name"))){
				String name=s.getString("name");
				name=name+"("+s.getInteger("value")+")";
				legen.add(name);
			}
		}
		outDto.put("legen", legen);
		workChecklist.add(outDto);
		httpModel.setOutMsg(AOSJson.toJson(workChecklist));
	}
	/**
	 * 项目缺陷按类型查询
	 * 
	 * @param httpModel
	 */
	public void listType(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		String test_version_ids = inDto.getString("test_version_ids");
		if(AOSUtils.isNotEmpty(test_version_ids)){
			List<String> test_version_idsList =AOSJson.getList(test_version_ids, String.class);
			inDto.put("test_version_ids", test_version_idsList);
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist =null;
		if(inDto.get("id").toString().contains("bug_type")){
	     workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisTypePage", inDto);
		}
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0){
			String msg="该项目没有可以展示的缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		List<String> axis=new ArrayList<String>();
		List series=new ArrayList();
		
		for(Dto s:workChecklist){
			if(AOSUtils.isNotEmpty(s.getString("bug_type"))){
				String bug_type=s.getString("bug_type");
//				bug_type=bug_type+"("+s.getString("s")+")";
				legen.add(bug_type);
//				List<String> series2=new ArrayList<>();
				series.add(s.getString("s"));
//				series.add(series);
			}
			
		}
		axis.add("缺陷类型");
		outDto.put("legen", legen);
		outDto.put("axis",axis);
		outDto.put("series",series);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 项目缺陷按状态查询
	 * 
	 * @param httpModel
	 */
	public void listState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		String test_version_ids = inDto.getString("test_version_ids");
		if(AOSUtils.isNotEmpty(test_version_ids)){
			List<String> test_version_idsList =AOSJson.getList(test_version_ids, String.class);
			inDto.put("test_version_ids", test_version_idsList);
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist =null;
		 if(inDto.get("id").toString().contains("bug_state")){
			workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisStatePage", inDto);
		}
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0){
			String msg="该项目没有可以展示的缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		List<String> axis=new ArrayList<String>();
		List series=new ArrayList();
		for(Dto s:workChecklist){
			if(AOSUtils.isNotEmpty(s.getString("state"))){
				String state_name=s.getString("state_name");
				legen.add(state_name);
				series.add(s.getString("s"));
			}
			
		}
		axis.add("缺陷状态");
		outDto.put("legen", legen);
		outDto.put("axis",axis);
		outDto.put("series",series);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 项目缺陷按人员查询
	 * 
	 * @param httpModel
	 */
	public void listUser(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if(inDto.getString("proj_id").equals("")){
			return;
		}
		inDto.put("start", 0);
		inDto.put("limit", 999999);
		List<Dto> workChecklist =null;
			workChecklist = sqlDao.list("ProjBugAnalysisDao.queryProjBugAnalysisManPage", inDto);
		Dto outDto = Dtos.newDto();
		if(workChecklist.size()==0){
			String msg="该项目没有遗留的人员缺陷数据！";
			httpModel.setOutMsg(AOSJson.toJson(msg));
			return;
		}
		List<String> legen=new ArrayList<String>();
		Dto jobj=Dtos.newDto();
		List<Dto> jarry=new ArrayList<Dto>();
		for(Dto s:workChecklist){
					String name=s.getString("name")+"("+s.getInteger("value")+")";
//					Integer value=s.getInteger("value");
//					if(value>0){
//						outDto.put("name", name);
//						jarry.add(outDto);
//					}
					legen.add(name);
			}
//		workChecklist.addAll(jarry);
		outDto.put("legen", legen);
		workChecklist.add(outDto);
		httpModel.setOutMsg(AOSJson.toJson(workChecklist));
		}
	
	/**
	 * 显示项目缺陷统计表
	 * 
	 * @param httpModel
	 * @throws ParseException 
	 */
	public void initBugCount(HttpModel httpModel) throws ParseException{
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String plan_begin_time = dateString.substring(0, 8) + "01";
		String plan_end_time = dateString.substring(0, 8) + day;
		String year_begin_date = dateString.substring(0, 5) + "01-01";
		String year_end_date = dateString.substring(0, 5) + "12-31";
		if (month == 1) {
			int str = year - 1;
			String recently_begin_date1 = str + "-12-01";
			String recently_end_date1 = str + "-12-31";
			httpModel.setAttribute("recently_begin_date", recently_begin_date1);
			httpModel.setAttribute("recently_end_date", recently_end_date1);
		} else {
			String str1 = String.format("%02d", month - 1);
			String recently_begin_date = year + "-" + (str1) + "-" + "01";
			int recently_day = AOSUtils.getDaysInMonth(year, month - 1);
			String recently_end_date = year + "-" + (str1) + "-" + recently_day;
			httpModel.setAttribute("recently_begin_date", recently_begin_date);
			httpModel.setAttribute("recently_end_date", recently_end_date);
		}
		;
		// 本周
		Calendar cal = Calendar.getInstance();
		cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
		int d = 0;
		if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
			d = -6;
		} else {
			d = 2 - cal.get(Calendar.DAY_OF_WEEK);
		}
		cal.add(Calendar.DAY_OF_WEEK, d);
		// 所在周开始日期
		String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		cal.add(Calendar.DAY_OF_WEEK, 6);
		// 所在周结束日期
		String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setAttribute("today_date", dateString);
		httpModel.setAttribute("year_begin_date", year_begin_date);
		httpModel.setAttribute("year_end_date", year_end_date);
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
		Integer user_id = httpModel.getUserModel().getId();
		int principal_org = (int) sqlDao.selectOne("ProjBugAnalysisDao.principalOrgID", user_id);
		httpModel.setAttribute("principal_org", principal_org);
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
		httpModel.setViewPath("pm3/queryanalysis/projBugAnalysis/bugCount.jsp");
	}
	/**
	 * 查询模块缺陷统计
	 */
	public void bugTypeCountPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String dm_codes = inDto.getString("dm_code");
		if(AOSUtils.isNotEmpty(dm_codes)){
			List<String> dm_codesList =AOSJson.getList(dm_codes, String.class);
			inDto.put("dm_codes", dm_codesList);
		}
		List<BugManagePO> bugManagePOs = bugManageDao.bugTypeCountPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, inDto.getPageTotal()));
	}
	/**
	 * 查询人员缺陷统计
	 */
	public void bugDealCountPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String deal_mans = inDto.getString("deal_mans");
		if(AOSUtils.isNotEmpty(deal_mans)){
			List<String> deal_mansList =AOSJson.getList(deal_mans, String.class);
			inDto.put("deal_mans", deal_mansList);
		}
		List<BugManagePO> bugManagePOs = bugManageDao.bugDealCountPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, inDto.getPageTotal()));
	}
	/**
	 * 查询解决率统计
	 */
	public void bugSolveCountPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		BugManagePO bmp = new BugManagePO();
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(0);
		List<BugManagePO> bugManagePOs = bugManageDao.bugSolveCountPage(inDto);
		int bug_totals = 0;
		int solveds = 0;
		int tobesolves = 0;
		int others = 0;
		for(BugManagePO POs : bugManagePOs){
			bug_totals = bug_totals + POs.getBug_total();
			solveds = solveds + POs.getSolved();
			tobesolves = tobesolves + POs.getTobesolve();
			others = others + POs.getOther();
		}
		String resolution = numberFormat.format((float)(solveds + others)/(bug_totals)*100) + "%";
		bmp.setBug_total(bug_totals);
		bmp.setSolved(solveds);
		bmp.setTobesolve(tobesolves);
		bmp.setOther(others);
		bmp.setResolution(resolution);
		bmp.setDic_descs("统计");
		bugManagePOs.add(bmp);
		httpModel.setOutMsg(AOSJson.toGridJson(bugManagePOs, inDto.getPageTotal()+1));
	}
	/**
	 * 查询用例通过率统计
	 */
	public void testExamplePage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String dm_codes = inDto.getString("dm_code");
		if(AOSUtils.isNotEmpty(dm_codes)){
			List<String> dm_codesList =AOSJson.getList(dm_codes, String.class);
			inDto.put("dm_codes", dm_codesList);
		}
		TestExamplePO testExamplePO = new TestExamplePO();
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(0);
		List<TestExamplePO> testExamples = testExampleDao.testExamplePage(inDto);
		int example_total = 0;  //统计总数
		int example_pass = 0;	//统计通过数
		for(TestExamplePO tePOs : testExamples){
			if(AOSUtils.isNotEmpty(tePOs.getStand_id())){
				List<Integer> test_bug_ids = new ArrayList<Integer>();
				int noBugNum = 0; //不含bug的状态为block和fail的用例ID数量
				inDto.put("stand_id", tePOs.getStand_id());
				//查询当前模块下，状态为block和fail的用例ID
				List<Integer> testIds = sqlDao.list("com.bl3.pm.quality.dao.TestExampleDao.selectStandId", inDto);
				for(Integer ids : testIds){
					//查询用例ID下是否存在bug
					Integer bugCount = (Integer) sqlDao.selectOne("com.bl3.pm.quality.dao.TestExampleDao.selectBugCount", ids);
					if(bugCount > 0){
						test_bug_ids.add(ids);
					}
				}
				noBugNum = testIds.size() - test_bug_ids.size();
				int passBugCount = 0;   //通过的缺陷总数
				int failBugCount = 0;	//未通过的缺陷总数
				for(Integer ids : test_bug_ids){
					//循环查询用例ID下的缺陷状态做统计
					Dto dto = sqlDao.selectDto("com.bl3.pm.quality.dao.TestExampleDao.passOrFail", ids);
					passBugCount = passBugCount + dto.getInteger("pass");
					failBugCount = failBugCount + dto.getInteger("fail");
				}
				tePOs.setAll_example(tePOs.getAll_example()+noBugNum+passBugCount+failBugCount);
				tePOs.setPass_example(tePOs.getPass_example()+passBugCount);
				String pass_rate = numberFormat.format((float)tePOs.getPass_example()/tePOs.getAll_example()*100) + "%";
				tePOs.setPass_rate(pass_rate);
			}
		}
		for(TestExamplePO tePOs : testExamples){
			example_total = example_total + tePOs.getAll_example();
			example_pass = example_pass + tePOs.getPass_example();
		}
		testExamplePO.setStard_name("统计");
		testExamplePO.setAll_example(example_total);
		testExamplePO.setPass_example(example_pass);
		testExamplePO.setPass_rate(numberFormat.format((float)example_pass/example_total*100) + "%");
		testExamples.add(testExamplePO);
		httpModel.setOutMsg(AOSJson.toGridJson(testExamples, inDto.getPageTotal()+1));
	}
	/**
	 * 查询模块缺陷统计汇总
	 */
	public void bugTypeTotal(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String dm_codes = inDto.getString("dm_code");
		if(AOSUtils.isNotEmpty(dm_codes)){
			List<String> dm_codesList =AOSJson.getList(dm_codes, String.class);
			inDto.put("dm_codes", dm_codesList);
		}
		int unsolve_total = 0;          //未解决合计
		int reopen_total = 0;           //重新打开合计
		int postpone_total = 0;			//延期处理合计
		int solve_total = 0;			//已解决合计
		int other_total = 0;			//其他合计
		List<BugManagePO> bugManagePOs = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.bugTypeCountTotal", inDto);
		for(BugManagePO POs : bugManagePOs){
			unsolve_total = unsolve_total + POs.getSubtotal();
			reopen_total = reopen_total + POs.getOpen();
			postpone_total = postpone_total + POs.getPostpone();
			solve_total = solve_total + POs.getResolved() + POs.getClose();
			other_total = other_total + POs.getRefuse() + POs.getReappear();
		}
		Dto pDto = Dtos.newDto();
		pDto.put("unsolve_total", unsolve_total);
		pDto.put("reopen_total", reopen_total);
		pDto.put("postpone_total", postpone_total);
		pDto.put("solve_total", solve_total);
		pDto.put("other_total", other_total);
		httpModel.setOutMsg(AOSJson.toJson(pDto));
	}
	/**
	 * 查询人员缺陷统计汇总
	 */
	public void bugDealTotal(HttpModel httpModel){
//		Dto inDto = httpModel.getInDto();
//		String deal_mans = inDto.getString("deal_mans");
//		if(AOSUtils.isNotEmpty(deal_mans)){
//			List<String> deal_mansList =AOSJson.getList(deal_mans, String.class);
//			inDto.put("deal_mans", deal_mansList);
//		}
//		int unsolve_total = 0;          //未解决合计
//		int reopen_total = 0;           //重新打开合计
//		int postpone_total = 0;			//延期处理合计
//		int solve_total = 0;			//已解决合计
//		int other_total = 0;			//其他合计
//		List<BugManagePO> bugManagePOs = sqlDao.list("com.bl3.pm.quality.dao.BugManageDao.bugDealCountTotal", inDto);
//		for(BugManagePO POs : bugManagePOs){
//			unsolve_total = unsolve_total + POs.getSubtotal();
//			reopen_total = reopen_total + POs.getOpen();
//			postpone_total = postpone_total + POs.getPostpone();
//			solve_total = solve_total + POs.getResolved() + POs.getClose();
//			other_total = other_total + POs.getRefuse() + POs.getReappear();
//		}
//		Dto pDto = Dtos.newDto();
//		pDto.put("unsolve_total", unsolve_total);
//		pDto.put("reopen_total", reopen_total);
//		pDto.put("postpone_total", postpone_total);
//		pDto.put("solve_total", solve_total);
//		pDto.put("other_total", other_total);
//		httpModel.setOutMsg(AOSJson.toJson(pDto));
		Dto inDto = httpModel.getInDto();
		String deal_mans = inDto.getString("deal_mans");
		if(AOSUtils.isNotEmpty(deal_mans)){
			List<String> deal_mansList =AOSJson.getList(deal_mans, String.class);
			inDto.put("deal_mans", deal_mansList);
		}
		Dto outDto = sqlDao.selectDto("ProjBugAnalysisDao.bugDealCountSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 模块子系统下拉框
	 */
	public void selectModel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProjBugAnalysisDao.selectStardCode", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 缺陷类型统计全部导出
	 */
	public void exportTypeExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String dm_codes = inDto.getString("dm_code");
		if(AOSUtils.isNotEmpty(dm_codes)){
			List<String> dm_codesList =Arrays.asList(dm_codes.split(","));
			inDto.put("dm_codes", dm_codesList);
		}
		List<BugManagePO> bugManagePOs = sqlDao.list("ProjBugAnalysisDao.bugTypeCount", inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "缺陷类型统计");
		exporter.setData(pDto, bugManagePOs);
		exporter.setTemplatePath("/export/excel/bugTypeCount.xlsx");
		exporter.setFilename("缺陷类型统计.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	/**
	 * 缺陷处理人统计全部导出
	 */
	public void exportDealExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String deal_mans = inDto.getString("deal_mans");
		if(AOSUtils.isNotEmpty(deal_mans)){
			List<String> deal_mansList =Arrays.asList(deal_mans.split(","));
			inDto.put("deal_mans", deal_mansList);
		}
		List<BugManagePO> bugManagePOs = sqlDao.list("ProjBugAnalysisDao.bugDealCount", inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "缺陷处理人统计");
		List<Dto> bugManageDto = sqlDao.list("ProjBugAnalysisDao.bugDealCountSummary", inDto);
		for(Dto dto : bugManageDto) {
			pDto.put("to_be_solved", dto.get("to_be_solved"));
			pDto.put("resolved", dto.get("resolved"));
			pDto.put("closed",dto.get("closed"));
			pDto.put("total_bug_num", dto.get("total_bug_num"));
		}
		exporter.setData(pDto, bugManagePOs);
		exporter.setTemplatePath("/export/excel/bugDealCount.xlsx");
		exporter.setFilename("缺陷处理人统计.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	/**
	 * 缺陷解决率统计全部导出
	 */
	public void exportSolveExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<BugManagePO> bugManagePOs = sqlDao.list("ProjBugAnalysisDao.bugSolveCount", inDto);
		BugManagePO bmp = new BugManagePO();
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(0);
		int bug_totals = 0;
		int solveds = 0;
		int tobesolves = 0;
		int others = 0;
		for(BugManagePO POs : bugManagePOs){
			bug_totals = bug_totals + POs.getBug_total();
			solveds = solveds + POs.getSolved();
			tobesolves = tobesolves + POs.getTobesolve();
			others = others + POs.getOther();
		}
		String resolution = numberFormat.format((float)(solveds + others)/(bug_totals)*100) + "%";
		bmp.setBug_total(bug_totals);
		bmp.setSolved(solveds);
		bmp.setTobesolve(tobesolves);
		bmp.setOther(others);
		bmp.setResolution(resolution);
		bmp.setDic_descs("统计");
		bugManagePOs.add(bmp);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "缺陷解决率统计");
		exporter.setData(pDto, bugManagePOs);
		exporter.setTemplatePath("/export/excel/bugSolveCount.xlsx");
		exporter.setFilename("缺陷解决率统计.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	/**
	 * 用例通过率全部导出
	 */
	public void exportExampleExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<TestExamplePO> testExamples = sqlDao.list("ProjBugAnalysisDao.testExampleCount", inDto);
		TestExamplePO testExamplePO = new TestExamplePO();
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(0);
		int example_total = 0;  //统计总数
		int example_pass = 0;	//统计通过数
		for(TestExamplePO tePOs : testExamples){
			if(AOSUtils.isNotEmpty(tePOs.getStand_id())){
				List<Integer> test_bug_ids = new ArrayList<Integer>();
				int noBugNum = 0; //不含bug的状态为block和fail的用例ID数量
				inDto.put("stand_id", tePOs.getStand_id());
				//查询当前模块下，状态为block和fail的用例ID
				List<Integer> testIds = sqlDao.list("com.bl3.pm.quality.dao.TestExampleDao.selectStandId", inDto);
				for(Integer ids : testIds){
					//查询用例ID下是否存在bug
					Integer bugCount = (Integer) sqlDao.selectOne("com.bl3.pm.quality.dao.TestExampleDao.selectBugCount", ids);
					if(bugCount > 0){
						test_bug_ids.add(ids);
					}
				}
				noBugNum = testIds.size() - test_bug_ids.size();
				int passBugCount = 0;   //通过的缺陷总数
				int failBugCount = 0;	//未通过的缺陷总数
				for(Integer ids : test_bug_ids){
					//循环查询用例ID下的缺陷状态做统计
					Dto dto = sqlDao.selectDto("com.bl3.pm.quality.dao.TestExampleDao.passOrFail", ids);
					passBugCount = passBugCount + dto.getInteger("pass");
					failBugCount = failBugCount + dto.getInteger("fail");
				}
				tePOs.setAll_example(tePOs.getAll_example()+noBugNum+passBugCount+failBugCount);
				tePOs.setPass_example(tePOs.getPass_example()+passBugCount);
				String pass_rate = numberFormat.format((float)tePOs.getPass_example()/tePOs.getAll_example()*100) + "%";
				tePOs.setPass_rate(pass_rate);
			}
		}
		for(TestExamplePO tePOs : testExamples){
			example_total = example_total + tePOs.getAll_example();
			example_pass = example_pass + tePOs.getPass_example();
		}
		testExamplePO.setStard_name("统计");
		testExamplePO.setAll_example(example_total);
		testExamplePO.setPass_example(example_pass);
		testExamplePO.setPass_rate(numberFormat.format((float)example_pass/example_total*100) + "%");
		testExamples.add(testExamplePO);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "用例通过率统计");
		exporter.setData(pDto, testExamples);
		exporter.setTemplatePath("/export/excel/testExampleCount.xlsx");
		exporter.setFilename("用例通过率统计.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	public void exampleStatisticsPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> exampleStatisticsList = sqlDao.list("ProjBugAnalysisDao.exampleStatisticsPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(exampleStatisticsList));
	}
	
	/**
	 * 分页查询
	 *测试用例
	 * @param httpModel
	 */
	public void examplePage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("ProjBugAnalysisDao.examplePage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
	
	/**
	 * 个人测试用例总数
	 * 
	 * @param httpModel
	 */
	public void queryExampleSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = sqlDao.selectDto("ProjBugAnalysisDao.queryExampleSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	public void bugSubmitPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> exampleStatisticsList = sqlDao.list("ProjBugAnalysisDao.bugSubmitPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(exampleStatisticsList));
	}
	
	/**
	 * 分页查询
	 *所有bug详情
	 * @param httpModel
	 */
	public void bugPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("ProjBugAnalysisDao.bugPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 *项目BUG统计
	 * @param httpModel
	 */
	public void bugProjPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("ProjBugAnalysisDao.bugProjPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
	
	/**
	 * 个人测试用例总数
	 * 
	 * @param httpModel
	 */
	public void queryBugSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = sqlDao.selectDto("ProjBugAnalysisDao.queryBugSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
 }