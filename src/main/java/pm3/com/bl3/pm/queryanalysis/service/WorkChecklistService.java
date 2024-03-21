package com.bl3.pm.queryanalysis.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.bl3.pm.basic.dao.ProjWorkloadMonthDao;
import com.bl3.pm.basic.dao.ProjWorkloadUserMonthDao;
import com.bl3.pm.basic.dao.po.ProjWorkloadMonthPO;
import com.bl3.pm.queryanalysis.dao.WorkChecklistDao;

/**
 * 业务逻辑层</b>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
 @Service
 public class WorkChecklistService{
 	private static Logger logger = LoggerFactory.getLogger(WorkChecklistService.class);
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
		httpModel.setViewPath("pm3/queryanalysis/work_checklist.jsp");
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
	 * 分页查询项目
	 * 
	 * @param httpModel
	 */
	public void proj(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.ChecklistList", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist, inDto.getPageTotal()));
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
	 * 分页查询
	 * 项目会议
	 */
	public void managePage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.managePage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workChecklist, inDto.getPageTotal()));
	}
	/**
	 * 双击跳转明细
	 */
	public void actionTabDb(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		Dto intDto=Dtos.newDto();
		intDto.put("proj_id", dto.getString("proj_id"));  
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
	 * 查询任务总数详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void task_nums(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> task_nums = sqlDao.list("WorkChecklistDao.task_nums", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(task_nums, task_nums.size()));
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
	 * 查询总缺陷详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void bug_nums(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> bug_nums = sqlDao.list("WorkChecklistDao.bug_nums", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bug_nums, bug_nums.size()));
	}
	/**
	 * 查询会议详细数据
	 */
	public void manage_num(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		List<Dto> manage_num = sqlDao.list("WorkChecklistDao.manage_num", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(manage_num, manage_num.size()));
	}
	/**
	 * 查询会议总数数据
	 */
	public void manage_nums(HttpModel httpModel){
		Dto qDto = httpModel.getInDto();
		List<Dto> manage_nums = sqlDao.list("WorkChecklistDao.manage_nums", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(manage_nums, manage_nums.size()));
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
	/**
	 * 查询个人总需求详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void demand_nums(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> demand_nums = sqlDao.list("WorkChecklistDao.demand_nums", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(demand_nums, demand_nums.size()));
	}
	/**
	 * 生成数据
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getworkCherckistData(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		Dto inDto=Dtos.newDto();
		Date plan_begin_time=qDto.getDate("plan_begin_time");
		Date plan_end_time=qDto.getDate("plan_end_time");
		String month=AOSUtils.date2String(plan_begin_time, "YYYYMM");
		String year=month.substring(0, 4);
		String month_=month.substring(4, 6);
		int addDate=AOSUtils.getDaysInMonth(Integer.valueOf(year),Integer.valueOf(month_));
		int addDate_= AOSUtils.getIntervalDays(plan_begin_time,plan_end_time)+1;
		if(addDate!=addDate_){
			httpModel.setOutMsg("日期格式选择有误!");
			return;
		}
		String proj_id=qDto.getString("proj_id");
		String re=proj_id.replace("[","");
		String re_=re.replace("]","");
		int len=0;
		String[] proj_id_=re_.split(",");
		for (String proj:proj_id_){
			String proj_=proj.trim();
			if(AOSUtils.isEmpty(proj_)){
				continue;
			}
			inDto.put("proj_id", proj_);
			inDto.put("start", 0);
			inDto.put("limit", 1);
			inDto.put("month", month);
			List<Dto> num=projWorkloadMonthDao.listtaide(inDto);
			if(num.size()>0){
				continue;
			}else{
				len++;
			}
			qDto.put("proj_id",proj_);
			List<Dto> workCheck = sqlDao.list("WorkChecklistDao.proj", qDto);
			int user_id=httpModel.getUserModel().getId();
		
			//判断是否已经存在
			Date getData=AOSUtils.getDateTime();
			Iterator<Dto>  it= workCheck.iterator();
		
			while (it.hasNext()) {
				Dto workCheckIT = (Dto) it.next();
				//插入年月
				workCheckIT.put("month", month);
				int demand_num=workCheckIT.getInteger("demand_num");
				int task_num=workCheckIT.getInteger("task_num");
				int bug_num=workCheckIT.getInteger("bug_num");
				String jhgzl=workCheckIT.getString("jhgzl");
				String sjgzl=workCheckIT.getString("sjgzl");
				workCheckIT.put("proj_demand_num",demand_num);
				workCheckIT.put("proj_task_num",task_num);
				workCheckIT.put("proj_defect_num",bug_num);
				workCheckIT.put("proj_plan_workload",jhgzl);
				workCheckIT.put("proj_real_workload",sjgzl);
				workCheckIT.put("create_user_id",user_id);
				workCheckIT.put("create_time",getData);
				workCheckIT.put("update_user_id",user_id);
				workCheckIT.put("update_time",getData);
				projWorkloadMonthDao.insert(workCheckIT);
			}
			List<Dto> workChecklist = sqlDao.list("WorkChecklistDao.ChecklistList", qDto);
			Iterator<Dto>  its= workChecklist.iterator();
			while (its.hasNext()) {
				Dto workCheckITs = (Dto) its.next();
				//插入年月
				workCheckITs.put("month", month);
				String demand_nums=workCheckITs.getString("demand_nums");
				if(AOSUtils.isEmpty(demand_nums)){
					demand_nums=null;
				}
				String task_nums=workCheckITs.getString("task_nums");
				if(AOSUtils.isEmpty(task_nums)){
					task_nums=null;
				}
				String bug_num=workCheckITs.getString("bug_num");
				if(AOSUtils.isEmpty(bug_num)){
					bug_num=null;
				}
				String bug_nums=workCheckITs.getString("bug_nums");
				if(AOSUtils.isEmpty(bug_nums)){
					bug_nums=null;
				}
				String id=workCheckITs.getString("id");
				String jhgzl=workCheckITs.getString("jhgzl");
				String sjgzl=workCheckITs.getString("sjgzl");
				String jhgzls=workCheckITs.getString("jhgzls");
				String sjgzls=workCheckITs.getString("sjgzls");
				workCheckITs.put("demand_total_num",demand_nums);
				workCheckITs.put("task_total_num",task_nums);
				workCheckITs.put("defect_num",bug_num);
				workCheckITs.put("defect_total_num",bug_nums);
				workCheckITs.put("task_total_num",task_nums);
				workCheckITs.put("plan_workload",jhgzl);
				workCheckITs.put("real_workload",sjgzl);
				workCheckITs.put("total_plan_workload",jhgzls);
				workCheckITs.put("total_real_workload",sjgzls);
				workCheckITs.put("create_user_id",user_id);
				workCheckITs.put("create_time",getData);
				workCheckITs.put("update_user_id",user_id);
				workCheckITs.put("update_time",getData);
				workCheckITs.put("user_id",id);
				projWorkloadUserMonthDao.insert(workCheckITs);
			}
		}
		httpModel.setOutMsg((AOSUtils.merge("数据生成成功，本次生成[{0}]条数据。", len)));
	}
	
	/**
	 * 撤销数据
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void delworkCherckistData(HttpModel httpModel) {
		String[] st_work_id = httpModel.getInDto().getRows();
		Dto qDto=Dtos.newDto();
		Dto inDto=Dtos.newDto();
		int len=0;
		for (String st_work_ids : st_work_id) {
			String st_work_ids_=st_work_ids.trim();
			if(AOSUtils.isEmpty(st_work_ids_)){
				continue;
			}
			ProjWorkloadMonthPO projWorkloadMonthPO=  projWorkloadMonthDao.selectByKey(Integer.valueOf(st_work_ids_));
			if(AOSUtils.isEmpty(projWorkloadMonthPO)){
				continue;
			}
			String month = String.valueOf(projWorkloadMonthPO.getMonth());
			inDto.put("start", 0);
			inDto.put("limit", 1);
			inDto.put("month", month);
			inDto.put("proj_id", projWorkloadMonthPO.getProj_id());
			List<Dto> num=projWorkloadMonthDao.list(inDto);
			if(num.size()>0){
				continue;
			}else{
				len++;
			}
			qDto.put("create_user_id",projWorkloadMonthPO.getCreate_user_id());
			qDto.put("month",projWorkloadMonthPO.getMonth());
			qDto.put("proj_id",projWorkloadMonthPO.getProj_id());
			sqlDao.delete("WorkChecklistDao.delList", qDto);
			projWorkloadMonthDao.deleteByKey(Integer.valueOf(st_work_ids_));
		}
		 //判断是否已经存在
		httpModel.setOutMsg((AOSUtils.merge("数据撤销成功，本次撤销[{0}]条数据。", len)));
	}
 }