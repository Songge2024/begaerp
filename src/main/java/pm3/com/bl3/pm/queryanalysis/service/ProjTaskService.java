package com.bl3.pm.queryanalysis.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * 业务逻辑层</b>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
 @Service
 public class ProjTaskService{
 	private static Logger logger = LoggerFactory.getLogger(ProjTaskService.class);
 	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException 
	 */
	public void init(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/queryanalysis/proj_task.jsp");
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
	}
	/**
	 * 分页查询任务
	 * 
	 * @param httpModel
	 */
	public void projTask(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> tasks = sqlDao.list("WorkChecklistDao.projTask", inDto);
		for (int i = 0; i < tasks.size(); i++) {
		if (tasks.get(i).get("display").toString() != null
				&& tasks.get(i).get("display").toString().length() != 0) {
			String display = "1. " + tasks.get(i).get("display").toString();
			for (int j = 2; j < display.length(); j++) {
				display = display.replaceFirst(",", ";<br>" + j + ".");
				tasks.get(i).put("display", display);
			}
		}
	 } 
		httpModel.setOutMsg(AOSJson.toGridJson(tasks));
	}
	public void projTasks(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> tasks = sqlDao.list("WorkChecklistDao.projTasks", inDto);
//		for (int i = 0; i < tasks.size(); i++) {
//			if (tasks.get(i).get("task_name").toString() != null
//					&& tasks.get(i).get("task_name").toString().length() != 0) {
//				String task_name = "1. " + tasks.get(i).get("task_name").toString();
//				for (int j = 2; j < task_name.length(); j++) {
//					task_name = task_name.replaceFirst(",", ";<br>" + j + ".");
//					tasks.get(i).put("task_name", task_name);
//				}
//			}
//		} 
		httpModel.setOutMsg(AOSJson.toGridJson(tasks));
	}
	
	
	
	
	/**
	 * 分页查询
	 * demandPage
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.proj", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist));
	}
	
	/**
	 * 分页查询
	 *项目需求
	 * @param httpModel
	 */
	public void demandPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.demandPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 *项目任务
	 * @param httpModel
	 */
	public void taskPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.taskPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist, inDto.getPageTotal()));
	}
	/**
	 * 分页查询
	 *项目缺陷
	 * @param httpModel
	 */
	public void bugPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.bugPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist, inDto.getPageTotal()));
	}
	/**
	 * 双击跳转明细
	 */
	public void actionTabDb(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		Dto intDto=Dtos.newDto();
		intDto.put("id", dto.getString("id"));  
		httpModel.setOutMsg(AOSJson.toJson(intDto));
	}
	
	/**
	 * 查询任务详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void task_num(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> task_num = sqlDao.list("WorkChecklistDao.task_num", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_num, task_num.size()));
	}
	
	/**
	 * 查询缺陷详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void bug_num(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> bug_num = sqlDao.list("WorkChecklistDao.bug_num", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bug_num, bug_num.size()));
	}
	/**
	 * 查询需求详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void demand_num(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> demand_num = sqlDao.list("WorkChecklistDao.demand_num", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(demand_num, demand_num.size()));
	}
	
 }