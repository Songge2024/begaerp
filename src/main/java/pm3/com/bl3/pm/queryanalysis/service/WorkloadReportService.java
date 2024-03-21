package com.bl3.pm.queryanalysis.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.basic.dao.ProjWorkloadMonthDao;
import com.bl3.pm.basic.dao.ProjWorkloadUserMonthDao;
import com.bl3.pm.queryanalysis.dao.WorkChecklistDao;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * 工作量统计报表</b>
 * 
 * @author heying
 * @date 2020-02-16
 */
 @Service
 public class WorkloadReportService{
 	private static Logger logger = LoggerFactory.getLogger(WorkloadReportService.class);
 	@Autowired
	private WorkChecklistDao workChecklistDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ProjWorkloadMonthDao projWorkloadMonthDao;
	@Autowired
	private ProjWorkloadUserMonthDao projWorkloadUserMonthDao;
	
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) throws ParseException{
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
		httpModel.setViewPath("pm3/queryanalysis/workloadReportList.jsp");
	}
	
	/**
	 * 项目工作量统计报表
	 * @since 2010-02-17
	 * @author HeYing
	 * @param httpModel
	 */
	public void projectWorkloadReportList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer login_user_id = httpModel.getUserModel().getId();
		inDto.put("login_user_id", login_user_id);
		List<Dto> workChecklist = sqlDao.list("WorkloadReportDao.projectWorkloadReportList", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist));
	}
	
	/**
	 * 根据项目ID查询个人工作量统计报表
	 * @since 2010-03-02
	 * @author HeYing
	 * @param httpModel(proj_id, plan_begin_date, plan_end_date)
	 */
	public void personWorkloadReportByProjIdList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkLoadList = sqlDao.list("WorkloadReportDao.personWorkloadReportByProjIdList", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkLoadList));
	}
	
	//个人工作量统计报表
	public void queryPersonWorkloadReportList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		List<Dto> personWorkloadReportList = sqlDao.list("WorkloadReportDao.personWorkloadReportList", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList));
	}
	
	//查询个人工作量统计报表汇总
	public void queryPersonWorkloadReportSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Dto outDto = sqlDao.selectDto("WorkloadReportDao.personWorkloadReportSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	public void taskYfbPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskYfbPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void taskYjsPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskYjsPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void taskYwcPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskYwcPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void taskYgbPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskYgbPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void taskYztPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskYztPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void taskTotalPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.taskTotalPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugWjjPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugWjjPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugYjjPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugYjjPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugYqclPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugYqclPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugGbPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugGbPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugJjPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugJjPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugCxdkPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugCxdkPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugWffxPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugWffxPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void bugTotalPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.bugTotalPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void meetingYfqPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.meetingYfqPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void meetingYzjPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.meetingYzjPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	public void meetingTotalPage(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		qDto.put("user_id", user_id);
		List<Dto> task_num = sqlDao.list("WorkloadReportDao.meetingTotalPage",qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	/**
	 * 根据查询条件查询月度任务工作量列表
	 * @param httpModel
	 */
	public void queryMonthTaskList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> queryMonthTaskList = sqlDao.list("WorkloadReportDao.queryMonthTaskList",inDto);		
		httpModel.setOutMsg(AOSJson.toGridJson(queryMonthTaskList, queryMonthTaskList.size()));
	}
	
	/**
	 * 根据查询条件查询月度缺陷工作量列表
	 * @param httpModel
	 */
	public void queryMonthBugList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> queryMonthBugList = sqlDao.list("WorkloadReportDao.queryMonthBugList",inDto);		
		httpModel.setOutMsg(AOSJson.toGridJson(queryMonthBugList, queryMonthBugList.size()));
	}
	
	/**
	 * 根据查询条件查询月度会议工作量列表
	 * @param httpModel
	 */
	public void queryMonthMeetingList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> queryMonthMeetingList = sqlDao.list("WorkloadReportDao.queryMonthMeetingList",inDto);		
		httpModel.setOutMsg(AOSJson.toGridJson(queryMonthMeetingList, queryMonthMeetingList.size()));
	}
 }