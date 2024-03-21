package com.bl3.pm.task.service;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bl3.pm.task.dao.DailyReportDao;
import com.bl3.pm.task.dao.po.DailyReportPO;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * <b>ta_daily_report[ta_daily_report]业务逻辑层</b>
 * 
 * @author luojh
 * @date 2017-12-18 11:03:34
 */
@Service
public class DailyReportService {
	private static Logger logger = LoggerFactory
			.getLogger(DailyReportService.class);
	@Autowired
	private DailyReportDao dailyReportDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private DaiReportimplDao daiReportimplDao;

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException
	 */
	public void init(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		httpModel.setViewPath("pm3/task/dailyReport_list.jsp");// 移上来试试
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
		String dateString1 = formatter1.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String begin_date = dateString.substring(0, 8) + "01";
		String end_date = dateString.substring(0, 8) + day;
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
		httpModel.setAttribute("begin_date", begin_date);
		httpModel.setAttribute("end_date", end_date);
		httpModel.setAttribute("today_date", dateString);
		httpModel.setAttribute("a1", "工作日报_"+httpModel.getUserModel().getName()+"("+httpModel.getUserModel().getId()+")_"+dateString1);
		httpModel.setAttribute("year_begin_date", year_begin_date);
		httpModel.setAttribute("year_end_date", year_end_date);
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
		String name_report = "工作日报_" + httpModel.getUserModel().getName() + "("
				+ httpModel.getUserModel().getId() + ")_";
		httpModel.setAttribute("name_report", name_report);
	}

	public void init1(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setViewPath("pm3/task/dailyReport_search1.jsp");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
		String dateString1 = formatter1.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String begin_date = dateString.substring(0, 8) + "01";
		String end_date = dateString.substring(0, 8) + day;
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
		httpModel.setAttribute("begin_date", begin_date);
		httpModel.setAttribute("end_date", end_date);
		httpModel.setAttribute("today_date", dateString);
		httpModel.setAttribute("today_date1", dateString1);
		httpModel.setAttribute("year_begin_date", year_begin_date);
		httpModel.setAttribute("year_end_date", year_end_date);
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
	}
	
  //新增时获取任务
	public void f_get(HttpModel httpModel) {
		// 获取工作内容
		Dto inDto = httpModel.getInDto();
		int getname = httpModel.getUserModel().getId();
		inDto.put("getname", getname);	
		Integer update_user_id = httpModel.getUserModel().getId();
		inDto.put("update_user_id", update_user_id);	
		Dto descc1_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayList555", inDto); //正在进行的任务
		Dto example_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListexample", inDto); //写的用例
		List<Dto> testexample_ = sqlDao.list("DailyReportDao.TestExampleArrayListtestexample", inDto); //执行的用例
	    Dto bug_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListbug", inDto);  //录入的缺陷
		Dto deal_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListdeal", inDto); //处理的缺陷
		List<Dto> files_ = sqlDao.list("DailyReportDao.TestExampleArrayListfiles", inDto); //线下的评审
		Dto news_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListreplynews", inDto);//线上的评审
		//处理工作内容
		String task_desc = "";
		//拼接到工作内容上	
		if(descc1_.get("task_desc")!=null && descc1_.get("task_desc").toString().length()!=0){
			task_desc =	task_desc+"骉驫," + descc1_.get("task_desc").toString().replace("<br>", "").replace("white-space: normal;", "");
		}
		if(bug_.get("bug_create")!=null && bug_.get("bug_create").toString().length() != 0){
			task_desc = task_desc +"骉驫,"+ "创建了"+bug_.get("sum").toString()+"个缺陷（"+bug_.get("bug_create").toString()+")";	
		};
		if(deal_.get("bug_deal")!=null && deal_.get("bug_deal").toString().length()!= 0 ){
			task_desc = task_desc+"骉驫,"+ "处理了"+deal_.get("sum").toString()+"个缺陷（"+deal_.get("bug_deal").toString()+")";
		};
		if(news_.get("news")!=null && news_.get("news").toString().length()!=0){
			task_desc=task_desc+"骉驫,"+ "参与了以下线上评审：("+news_.get("news").toString()+")";
		}
		if(example_.get("example")!=null && example_.get("example").toString().length() != 0){
			task_desc = task_desc +"骉驫,创建了以下用例：("+ example_.get("example").toString()+")";
		}
		for (int i = 0; i < testexample_.size(); i++) {
			String testexample = testexample_.get(i).get("testexample").toString();
			task_desc = task_desc+"骉驫,执行测试用例：" +testexample;
		}
		for (int i = 0; i < files_.size(); i++) {
			String attend_id = ","+files_.get(i).get("attende_id").toString()+",";
			if(attend_id.indexOf(",1280,")!=-1){
				task_desc = task_desc+	"骉驫,参与会议评审："+files_.get(i).get("theme").toString();
			}
		}
		//判断是否存在的方法
		Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList5555", inDto);
		String  a = have.get("id").toString();
		System.out.println(a+"----------");
		if(a.length()!=0 &&a != null){
			httpModel.setOutMsg("您该日已存在一条日报记录！");
		}else{
		if (!task_desc.equals("")) {
			//String task_desc = "1. " + descc1_.get("task_desc").toString().replace("<br>", "").replace("white-space: normal;", "");
			System.out.println(task_desc+"--------------------");
			for (int i = 1; i < 100; i++) {
				task_desc = task_desc.replace("骉驫骉驫", "骉驫").replaceFirst("骉驫,", ";<br>" + i + ".");
			}
			task_desc = task_desc.replaceFirst(";<br>", "").replace("骉驫", ";<br>").replace("<p>", "").replace("</p>", "").replace("<div>", "").replace("</div>", "");
			System.out.println(task_desc+"----------11111111111111----");
			httpModel.setAttribute("descc_", task_desc);
			httpModel.setOutMsg(task_desc);
			//System.out.println(task_desc + "-----------");
		} else {
			httpModel.setAttribute("descc_", "骉驫");
			httpModel.setOutMsg("骉驫");
			//System.out.println("没有任务----------------");
		};
		// 获取任务结束
		}
	}
  //修改时重新获取任务
	public void f_get1(HttpModel httpModel) {
		// 获取任务
		Dto inDto = httpModel.getInDto();
		int getname = httpModel.getUserModel().getId();
		inDto.put("getname", getname);	
		Dto descc1_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayList555", inDto); //正在进行的任务
		Dto example_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListexample", inDto); //写的用例
		List<Dto> testexample_ = sqlDao.list("DailyReportDao.TestExampleArrayListtestexample", inDto); //执行的用例
	    Dto bug_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListbug", inDto);  //录入的缺陷
		Dto deal_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListdeal", inDto); //处理的缺陷
		List<Dto> files_ = sqlDao.list("DailyReportDao.TestExampleArrayListfiles", inDto); //线下的评审
		Dto news_ = sqlDao.selectDto("DailyReportDao.TestExampleArrayListreplynews", inDto);//线上的评审
		//处理工作内容
		String task_desc = "";
		//拼接到工作内容上	
		if(descc1_.get("task_desc")!=null && descc1_.get("task_desc").toString().length()!=0){
			task_desc =	task_desc +"骉驫,"+ descc1_.get("task_desc").toString().replace("<br>", "").replace("white-space: normal;", "");
		}
		if(bug_.get("bug_create")!=null && bug_.get("bug_create").toString().length() != 0){
			task_desc = task_desc +"骉驫,"+ "创建了"+bug_.get("sum").toString()+"个缺陷（"+bug_.get("bug_create").toString()+")";	
		};
		if(deal_.get("bug_deal")!=null && deal_.get("bug_deal").toString().length()!= 0 ){
			task_desc = task_desc+"骉驫,"+ "处理了"+deal_.get("sum").toString()+"个缺陷（"+deal_.get("bug_deal").toString()+")";
		};
		if(news_.get("news")!=null && news_.get("news").toString().length()!=0){
			task_desc=task_desc+"骉驫,"+ "参与了以下线上评审：("+news_.get("news").toString()+")";
		}
		if(example_.get("example")!=null && example_.get("example").toString().length() != 0){
			task_desc = task_desc +"骉驫,创建了以下用例：("+ example_.get("example").toString()+")";
		}
		for (int i = 0; i < testexample_.size(); i++) {
			String testexample = testexample_.get(i).get("testexample").toString();
			task_desc = task_desc+"骉驫,执行测试用例：" +testexample;
		}
		for (int i = 0; i < files_.size(); i++) {
			String attend_id = ","+files_.get(i).get("attende_id").toString()+",";
			if(attend_id.indexOf(",1280,")!=-1){
				task_desc = task_desc+	"骉驫,参与会议评审："+files_.get(i).get("theme").toString();
			}
		}//判断是否存在的方法
		Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList55555", inDto);
		String  a = have.get("id").toString();
		if(a.length()!=0 &&a != null){
			httpModel.setOutMsg("您该日已存在一条日报记录！");
			//System.out.println(a+"--------------------");
		}else{
			if (!task_desc.equals("")) {
				//String task_desc = "1. " + descc1_.get("task_desc").toString().replace("<br>", "").replace("white-space: normal;", "");
				System.out.println(task_desc+"--------------------");
				for (int i = 2; i < 100; i++) {
					task_desc = task_desc.replace("骉驫骉驫", "骉驫").replaceFirst("骉驫,", ";<br>" + i + ".");
				}
				task_desc = task_desc.replace("骉驫", ";<br>").replace("<p>", "").replace("</p>", "").replace("<div>", "").replace("</div>", "");
				System.out.println(task_desc+"----------11111111111111----");
				httpModel.setAttribute("descc_", task_desc);
				httpModel.setOutMsg(task_desc);
		} else {
			httpModel.setAttribute("descc_", "骉驫");
			httpModel.setOutMsg("骉驫");
			//System.out.println("没有任务----------------");
		};
		// 获取任务结束
		}
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
		Integer update_user_id = httpModel.getUserModel().getId();
		inDto.put("update_user_id", update_user_id);	
		DailyReportPO dailyReportPO = new DailyReportPO();
		// dailyReportPO.setId(idService.nextValue("seq_ta_daily_report").intValue());
		dailyReportPO.copyProperties(inDto);
		Date update_time_ = AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		int update_user_id_ = httpModel.getUserModel().getId();
		dailyReportPO.setUpdate_user_id(update_user_id_);
		String name_ = httpModel.getUserModel().getName();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String dateString = formatter.format(inDto.getDate("daily_time"));
		dailyReportPO.setName("工作日报_" + name_ + "(" + update_user_id_ + ")_"
				+ dateString);
		//String state_ = "1001";
		//dailyReportPO.setState(state_);
		SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
		String update_time_q = sdfInput.format(dailyReportPO.getDaily_time());
		String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
		dailyReportPO.setWeek_day(week_day_);
		// 测试一下备用字段方法 .replace("<br>", "char(10)"))
		String desccc = inDto.getString("descc").replace("<br>", "");
		dailyReportPO.setDesccc(desccc);
		// 这个方法在这里结束
		//判断是否存在的方法
				Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList5555", inDto);
				String  a = have.get("id").toString();
				if(a.length()!=0 &&a != null){
					httpModel.setOutMsg("您该日已存在一条日报记录！");
				}else{
		if (AOSUtils.isEmpty(desccc) || desccc.length() <= 10) {
			httpModel.setOutMsg("日报不能少于10个字！");
		} else {
			dailyReportDao.insert(dailyReportPO);
			httpModel.setOutMsg("新增成功");
		}}
	}

	// create_submit
	/**
	 * 新增并提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create_submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_user_id = httpModel.getUserModel().getId();
		inDto.put("update_user_id", update_user_id);	
		// inDto.remove("id");
		DailyReportPO dailyReportPO = new DailyReportPO();
		// dailyReportPO.setId(idService.nextValue("seq_ta_daily_report").intValue());
		dailyReportPO.copyProperties(inDto);
		Date update_time_ = AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		int update_user_id_ = httpModel.getUserModel().getId();
		dailyReportPO.setUpdate_user_id(update_user_id_);
		String name_ = httpModel.getUserModel().getName();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String dateString = formatter.format(inDto.getDate("daily_time"));
		dailyReportPO.setName("工作日报_" + name_ + "(" + update_user_id_ + ")_"
				+ dateString);
		String state_ = "1002";
		dailyReportPO.setState(state_);
		SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
		String update_time_q = sdfInput.format(dailyReportPO.getDaily_time());
		String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
		dailyReportPO.setWeek_day(week_day_);
		// 测试一下备用字段方法
		String desccc = inDto.getString("descc").replace("<br>", "");
		dailyReportPO.setDesccc(desccc);
		// 这个方法在这里结束
		//判断是否存在的方法
		Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList5555", inDto);
		String  a = have.get("id").toString();
		if(a.length()!=0 &&a != null){
			httpModel.setOutMsg("您该日已存在一条日报记录！");
		}else{
		if (AOSUtils.isEmpty(desccc) || desccc.length() <= 10) {
			httpModel.setOutMsg("日报内容不能少于10个字！");
		} else {
			dailyReportDao.insert(dailyReportPO);
			httpModel.setOutMsg("新增并提交成功！");
		}}
	}
	
	/**
	 * 修改并提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update_submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// inDto.remove("id");
		DailyReportPO dailyReportPO = new DailyReportPO();
		dailyReportPO.copyProperties(inDto);
		Date update_time_ = AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
		String update_time_q = sdfInput.format(dailyReportPO.getDaily_time());
		String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
		dailyReportPO.setWeek_day(week_day_);
		String name_ = httpModel.getUserModel().getName();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String dateString = formatter.format(inDto.getDate("daily_time"));
		int update_user_id_ = httpModel.getUserModel().getId();
		dailyReportPO.setUpdate_user_id(update_user_id_);
		String state_ = "1002";
		dailyReportPO.setState(state_);
		dailyReportPO.setName("工作日报_" + name_ + "(" + update_user_id_ + ")_"
				+ dateString);
		// 测试一下备用字段方法
		String desccc = inDto.getString("descc").replace("<br>", " ");
		dailyReportPO.setDesccc(desccc);
		// 这个方法在这里结束
		//判断是否存在的方法
				Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList55555", inDto);
				String  a = have.get("id").toString();
				if(a.length()!=0 &&a != null){
					httpModel.setOutMsg("您该日已存在一条日报记录！");
				//	System.out.println(a+"--------------------");
				}else{
		if (AOSUtils.isEmpty(desccc) || desccc.length() <= 10) {
			httpModel.setOutMsg("日报内容不能少于10个字！");
		} else {
			dailyReportDao.updateByKey(dailyReportPO);
			httpModel.setOutMsg("修改并提交成功");
		}}
	}

	/**
	 * 单条导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel1(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<DailyReportPO> faPOs = dailyReportDao.list(inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		//paramsDto.put("reportTitle", "单条日报导出");
		//paramsDto.put("dcr", httpModel.getUserModel().getName());
		//paramsDto.put("dcsj", AOSUtils.getDateStr());
		//paramsDto.put("sum", "1");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/dailyReport.xlsx");
		exporter.setFilename("工作日志-"+httpModel.getUserModel().getName()+AOSUtils.getDateStr()+".xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}

	/**
	 * 新的查询项目组人员日报
	 * 
	 * @param httpModel
	 */
	public void fn_select_all(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("pm_user_id", httpModel.getUserModel().getId());
		List<Dto> obList =(List<Dto>) sqlDao.list("DailyReportDao.SelectType", inDto);
		String role_id = "";
		for(Dto ob : obList){
			role_id  = ob.getString("role_id");
			if(role_id.equals("4985")){
				break;
			}
			if(role_id.equals("4991")){
				break;
			}
		}
		
		List<DailyReportPO> dailyReportPOs;
		if(role_id.equals("4985") ){
			dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPage123_qa", inDto);
		}else if(role_id.equals("4991")){
			dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPage123_ui", inDto);
		}else{
		 dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPage123", inDto);
		}
		
		String[] Id = new String[dailyReportPOs.size()+1];		
		for (int i = 0; i < dailyReportPOs.size(); i++) {
    	   Dto inDto1 = (Dto) dailyReportPOs.get(i);
    	   Id[i]=inDto1.get("id1").toString();
    	  System.out.println(inDto1.get("id1").toString()+"--------------------"+Id[i]); 
		}	
		List<Dto> faPOs = sqlDao.list("DailyReportDao.TestExampleArrayList", Id);
		for (int i = 0; i < faPOs.size(); i++) {
			Dto faPO = faPOs.get(i);
			faPO.put("daily_time",faPO.get("daily_time").toString().replace("00:00:00.0", ""));
			faPO.put("descc", faPO.get("descc").toString().replace("&nbsp;", "").replace("<br>", "<br>"+"&nbsp;&nbsp;&nbsp;&nbsp;").replace("<div>", "").replace("</div>", "").replace("<p>", "").replace("</p>", ""));
			String name_ = faPO.get("name").toString();
			int i3 = name_.indexOf("(");
			String name__ = name_.substring(5, i3);
			faPO.put("update_user_id", name__);
			// faPO.put("remark", faPO.get("remark").toString().replace("<br>",
			// " ")); //先确认是否需要可以换行
		}
		httpModel.setAttribute("aaa", httpModel.getInDto().getString("aaa"));
		httpModel.setAttribute("faPOss", faPOs);
	    httpModel.setViewPath("pm3/task/dailyReport_searchall.jsp");
	}
	
	
	/**
	 * 查询项目组人员日报
	 * 
	 * @param httpModel
	 */
	
	public void fn_select_all1(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<DailyReportPO> dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPage1234", inDto);
		String[] Id = new String[dailyReportPOs.size()+1];		
		for (int i = 0; i < dailyReportPOs.size(); i++) {
    	   Dto inDto1 = (Dto) dailyReportPOs.get(i);
    	   Id[i]=inDto1.get("id1").toString();
    	  System.out.println(inDto1.get("id1").toString()+"--------------------"+Id[i]); 
		}			
		List<Dto> faPOs = sqlDao.list("DailyReportDao.TestExampleArrayList", Id);
		for (int i = 0; i < faPOs.size(); i++) {
			Dto faPO = faPOs.get(i);
			faPO.put("daily_time",faPO.get("daily_time").toString().replace("00:00:00.0", ""));
			faPO.put("descc", faPO.get("descc").toString().replace("&nbsp;", "").replace("<br>", "<br>"+"&nbsp;&nbsp;&nbsp;&nbsp;").replace("<div>", "").replace("</div>", "").replace("<p>", "").replace("</p>", ""));
			faPO.put("state", faPO.get("state").toString().replace("1002", "提交").replace("1001", "草稿"));
			String name_ = faPO.get("name").toString();
			int i3 = name_.indexOf("(");
			String name__ = name_.substring(5, i3);
			faPO.put("update_user_id", name__);
			// faPO.put("remark", faPO.get("remark").toString().replace("<br>",
			// " ")); //先确认是否需要可以换行
		}
		httpModel.setAttribute("aaa", httpModel.getInDto().getString("aaa"));
		httpModel.setAttribute("faPOss", faPOs);
		httpModel.setViewPath("pm3/task/dailyReport_search.jsp");
		
	}

	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		/*Dto inDto = httpModel.getInDto();
		List<DailyReportPO> faPOs = dailyReportDao.list(inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		//paramsDto.put("reportTitle", "单条日报导出");
		//paramsDto.put("dcr", httpModel.getUserModel().getName());
		//paramsDto.put("dcsj", AOSUtils.getDateStr());
		//paramsDto.put("sum", "1");
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/dailyReport.xlsx");
		exporter.setFilename("工作日志-"+httpModel.getUserModel().getName()+AOSUtils.getDateStr()+".xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}*/
		
		Dto inDto = httpModel.getInDto();
		String[] Id = inDto.getString("selection").split(",");
		List<Dto> faPOs = sqlDao.list("DailyReportDao.TestExampleArrayList", Id);
		for (int i = 0; i < faPOs.size(); i++) {
			Dto faPO = faPOs.get(i);
			faPO.put("daily_time",faPO.get("daily_time").toString().replace("00:00:00.0", ""));
			faPO.put("descc", faPO.get("descc").toString().replace("<br>", " ").replace("&nbsp;", ""));
			String name_ = faPO.get("name").toString();
			int i3 = name_.indexOf("(");
			String name__ = name_.substring(5, i3);
			faPO.put("update_user_id", name__);
			faPO.put("work_hours", 8); //工时
			
			// faPO.put("remark", faPO.get("remark").toString().replace("<br>",
			// " ")); //先确认是否需要可以换行
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		/*paramsDto.put("reportTitle", "个人日报");
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		paramsDto.put("sum", faPOs.size());
		paramsDto.put("tab_name", "日报");*/
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/dailyReport.xlsx");
		//exporter.setFieldsList(fieldsList);
		/*exporter.setFilename("个人日报.xls");*/
		exporter.setFilename("工作日志-"+httpModel.getUserModel().getName()+AOSUtils.getDateStr()+".xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
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
		DailyReportPO dailyReportPO = new DailyReportPO();
		dailyReportPO.copyProperties(inDto);
		Date update_time_ = AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
		String update_time_q = sdfInput.format(dailyReportPO.getDaily_time());
		String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
		dailyReportPO.setWeek_day(week_day_);
		String name_ = httpModel.getUserModel().getName();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String dateString = formatter.format(inDto.getDate("daily_time"));
		int update_user_id_ = httpModel.getUserModel().getId();
		dailyReportPO.setUpdate_user_id(update_user_id_);
		dailyReportPO.setName("工作日报_" + name_ + "(" + update_user_id_ + ")_"
				+ dateString);
		// 测试一下备用字段方法
		String desccc = inDto.getString("descc").replace("<br>", " ");
		dailyReportPO.setDesccc(desccc);
		// 这个方法在这里结束
		//判断是否存在的方法
				Dto have =sqlDao.selectDto("DailyReportDao.TestExampleArrayList55555", inDto);
				String  a = have.get("id").toString();
				if(a.length()!=0 &&a != null){
					httpModel.setOutMsg("您该日已存在一条日报记录！");
				//	System.out.println(a+"--------------------");
				}else{
		if (AOSUtils.isEmpty(desccc) || desccc.length() <= 10) {
			httpModel.setOutMsg("日报内容不能少于10个字！");
		} else {
			dailyReportDao.updateByKey(dailyReportPO);
			httpModel.setOutMsg("修改成功");
		}}

	}

	/**
	 * 提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// inDto.remove("id");
		DailyReportPO dailyReportPO = new DailyReportPO();
		dailyReportPO.copyProperties(inDto);
		Date update_time_ = AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		String state_ = "1002";
		dailyReportPO.setState(state_);
		dailyReportDao.updateByKey(dailyReportPO);
		httpModel.setOutMsg("提交成功");
	}

	/**
	 * 删除日报
	 * 
	 * @param httpModel
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		dailyReportDao.deleteByKey(inDto.getInteger("id"));
		httpModel.setOutMsg("成功删除1条日报！");
	}

	/**
	 * 批量删除日报
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void deletes(HttpModel httpModel) {
		String[] selectionIds = httpModel.getInDto().getRows();
		int i = 0;
		for (String id : selectionIds) {
			dailyReportDao.deleteByKey(Integer.valueOf(id));
			i++;
		}
		httpModel.setOutMsg("成功删除" + i + "条日报！");
	}

	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		DailyReportPO dailyReportPO = dailyReportDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(dailyReportPO));
	}

	/**
	 * 根据项目组查询
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException
	 */
	public void initpanel(HttpModel httpModel) throws ParseException {
		//httpModel.setAttribute("xxx", "这里是个什么鬼啊啊");
		//httpModel.setAttribute("aaa", httpModel.getInDto().getString("aaa"));
		httpModel.setViewPath("pm3/task/dailyReport_search.jsp");
	}

	/**
	 * 分页查询所有日报
	 * 
	 * @param httpModel
	 */
	
	
	public void page3(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		inDto.put("pm_user_id", httpModel.getUserModel().getId());
		List<Dto> obList =(List<Dto>) sqlDao.list("DailyReportDao.SelectType", inDto);
		String role_id = "";
		for(Dto ob : obList){
			role_id  = ob.getString("role_id");
			if(role_id.equals("4985")){
				break;
			}
			if(role_id.equals("4991")){
				break;
			}
		}
		
		List<DailyReportPO> dailyReportPOs;
		if(role_id.equals("4985")   ){
		 dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListsearchPage_qa", inDto);
		}else if(role_id.equals("4991")){
			dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListsearchPage_ui", inDto);
		}else{
		 dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListsearchPage", inDto);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(dailyReportPOs,inDto.getPageTotal()));
	}
	
	public void page_sum(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		inDto.put("pm_user_id", httpModel.getUserModel().getId());
		List<Dto> obList =(List<Dto>) sqlDao.list("DailyReportDao.SelectType", inDto);
		String role_id = "";
		for(Dto ob : obList){
			role_id  = ob.getString("role_id");
			if(role_id.equals("4985")){
				break;
			}
			if(role_id.equals("4991")){
				break;
			}
		}
		
		List<DailyReportPO> dailyReportPOs;
		if(role_id.equals("4985") ){
			dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPagesum_qa", inDto);
		}else if(role_id.equals("4991")){
			dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPagesum_ui", inDto);
		}else{
		  dailyReportPOs = sqlDao.list("DailyReportDao.TestExampleArrayListPagesum", inDto);
		};
		httpModel.setOutMsg(AOSJson.toGridJson(dailyReportPOs));
	}
	
	/**
	 * 日报查询查询项目经理所有的项目
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxUerid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if (inDto.getString("type").equals("all")) {
			inDto.put("team_user_id", "");
		} else {
			String userid = httpModel.getUserModel().getId().toString();
			inDto.put("team_user_id", userid);
		}
		List<Dto> list = sqlDao.list("DailyReportDao.listComboBoxUerid", inDto);
		
		for (int i = 0; i < list.size(); i++) {
		String display = "<nobr>"+list.get(i).get("display").toString()+"</nobr>";
		list.get(i).put("display", display);
		}
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 分页查询我的日报
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<DailyReportPO> dailyReportPOs;
		if (inDto.get("proj_id_") == "" || inDto.get("proj_id_") == null) {
			DailyReportPO dailyReportPO = (DailyReportPO) sqlDao.selectOne(
					"DailyReportDao.TestExampleArrayList11Page", inDto);
			dailyReportPOs = sqlDao.list(
					"DailyReportDao.TestExampleArrayList1Page", inDto);
			if (dailyReportPO != null) {
				dailyReportPOs.add(0, dailyReportPO);
			}
		} else {
			dailyReportPOs = sqlDao.list(
					"DailyReportDao.TestExampleArrayListPage", inDto);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(dailyReportPOs,inDto.getPageTotal()+1));
		
	}

	/**
	 * 查询所有日报
	 * 
	 * @param httpModel
	 */
	public void select_all(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<DailyReportPO> dailyReportPOs = sqlDao.list(
				"DailyReportDao.TestExampleArrayList2Page", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(dailyReportPOs,
				inDto.getPageTotal()));
	}
    //设置我的默认项目
	public void set_my_default_project(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		String person_name =httpModel.getUserModel().getName();
		inDto.put("person_name", person_name);
		//判断是否存在
		Dto have = sqlDao.selectDto("DailyReportDao.SelectDefaultProject", inDto);
		if(AOSUtils.isEmpty(have.getString("proj_id"))){
		sqlDao.insert("DailyReportDao.SetDefaultProject", inDto);
		httpModel.setOutMsg("设置当前项目成功！");
		}else{
		sqlDao.update("DailyReportDao.UpdateDefaultProject", inDto);
		httpModel.setOutMsg("修改当前项目成功！");
		}
	}
	//删除我的默认项目
	public void delete_my_default_project(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		sqlDao.delete("DailyReportDao.DeleteDefaultProject", inDto);
		httpModel.setOutMsg("删除当前项目成功！");
		
	}
	/**
	 * 查询我的日报
	 * 
	 * @param httpModel
	 */
	public void select_my_daily(HttpModel httpModel) {
		Date date=new Date();
		 String str = new java.text.SimpleDateFormat("yyyy年MM月dd日").format(new java.util.Date());
	        String days = str.substring(str.indexOf("月")+1,str.indexOf("日")); //取日
	        int day = Integer.parseInt(days);
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd  EEEE");
		String maxDateStr=format.format(date);
		String minDateStr = "";
		String week = "";    
		SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd  EEEE");
		SimpleDateFormat sweek  = new SimpleDateFormat("EEEE");
		Dto inDto = httpModel.getInDto();
		inDto.put("user_id", httpModel.getUserModel().getId());
		List<Dto> list = sqlDao.list("DailyReportDao.select_my_daily", inDto);
		List<Dto> sumList = new ArrayList<Dto>();
	    Calendar calc =Calendar.getInstance();    
	    
	      try {      
			for (int i = 0; i < day; i++) {
				int a = 0;
				calc.setTime(sdf.parse(maxDateStr));
				calc.add(calc.DATE, -i);
				Date minDate = calc.getTime();
				minDateStr = sdf.format(minDate);
				week = sweek.format(minDate);
				if(AOSUtils.isEmpty(inDto.getInteger("week"))){
					
				}else{
				if((week.equals("星期六")||(week.equals("Saturday"))||week.equals("星期日")||week.equals("Sunday"))&&inDto.getInteger("week")==6){
					continue;
				}
				}
				for (Dto dto : list) {
					if (dto.getString("m_time").equals(minDateStr.substring(0,10))) {
						String descc = dto.getString("descc");
						dto.remove(dto.getString("descc"));
						dto.remove(minDateStr);
						dto.put("m_time",minDateStr);
						dto.put("time",minDateStr.substring(0,10));
						dto.put("descc",descc);
						sumList.add(dto);
						a = 1;
						break;
					}
				}
				if (a == 0) {
					Dto mdto = Dtos.newDto();
					mdto.put("m_time", minDateStr);
					mdto.put("time", minDateStr.substring(0,10));
					mdto.put("week_day", week);
					mdto.put("state", "null");
					sumList.add(mdto);
				}
				
			}
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		
		httpModel.setOutMsg(AOSJson.toGridJson(sumList,
				inDto.getPageTotal()));
	}

}