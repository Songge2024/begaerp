package com.bl3.pm.task.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.bl3.pm.task.dao.DailyReportDao;
import com.bl3.pm.task.dao.po.DailyReportPO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bl3.pm.task.dao.DailyProductionDao;
import com.bl3.pm.task.dao.po.DailyProductionPO;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * <b>ta_daily_production[ta_daily_production]业务逻辑层</b>
 * 
 * @author ZhaoJiaqi
 * @date 2020-03-20 15:32:23
 */
 @Service
 public class DailyProductionService{
 	private static Logger logger = LoggerFactory.getLogger(DailyProductionService.class);
 	@Autowired
	private DailyProductionDao dailyProductionDao;
	@Autowired
	private DailyReportDao dailyReportDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 新增保存
	 * 
	 * @param httpModel
	 */
	public void saveAdd(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer id = httpModel.getUserModel().getId();
		DailyProductionPO dailyProductionPO = new DailyProductionPO();
		dailyProductionPO.copyProperties(inDto);
		dailyProductionPO.setDaily_date(inDto.getDate("daily_date"));
		dailyProductionPO.setProj_id(inDto.getInteger("proj_id"));
		dailyProductionPO.setCreate_id(id);
		dailyProductionPO.setCreate_time(new Date());
		dailyProductionPO.setDaily_desc(inDto.getString("daily_desc"));
		dailyProductionPO.setDaily_status("");
		dailyProductionPO.setDaily_type(inDto.getString("daily_type"));
		dailyProductionDao.insert(dailyProductionPO);
		httpModel.setOutMsg("新增成功。");
	}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_id = httpModel.getUserModel().getId();
		inDto.put("update_id", update_id);
		List<Dto> allReport =  sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.allReport",inDto);
		List<Dto> productionReportList = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.queryProductionDesc", inDto);
		List<Dto> dailyReportList = sqlDao.list("DailyReportDao.selectDailyReportByDate", inDto);
		DailyReportPO dailyReportPO = new DailyReportPO();
		String desc = "";
		boolean flag = false;
		if (dailyReportList.size() > 0) {
			dailyReportPO.copyProperties(dailyReportList.get(0));
			flag = true;
		} else {
			dailyReportPO.setWeek_day(AOSUtils.getWeekDayByDate(inDto.getString("daily_date")));
			dailyReportPO.setUpdate_user_id(update_id);
			dailyReportPO.setDaily_time(inDto.getDate("daily_date"));
			dailyReportPO.setState("1002");
			dailyReportPO.setUpdate_time(AOSUtils.getDateTime());
			dailyReportPO.setName("工作日报_" + httpModel.getUserModel().getName() + "(" + update_id + ")_" + new SimpleDateFormat("yyyyMMdd").format(inDto.getDate("daily_date")));
		}
		for(Dto dto : allReport){
			DailyProductionPO dailyProductionPO = new DailyProductionPO();
			dailyProductionPO.setUpdate_id(update_id);
			dailyProductionPO.setUpdate_time(new Date());
			dailyProductionPO.setDaily_id(dto.getInteger("daily_id"));
			dailyProductionPO.setDaily_status("1");
			dailyProductionPO.setWorking_percent(dto.getBigDecimal("working_percent"));
			dailyProductionDao.updateIdByKey(dailyProductionPO);
		}
		for(Dto dto : productionReportList){
			desc += dto.getString("descc");
		}
		dailyReportPO.setDescc(desc);
		dailyReportPO.setDesccc(desc);
		if (flag) dailyReportDao.updateByKey(dailyReportPO);
		else dailyReportDao.insert(dailyReportPO);
		httpModel.setOutMsg("提交成功");
	}
	
	/**
	 * 草稿新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void draft_create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_id = httpModel.getUserModel().getId();
		inDto.put("update_id", update_id);
		List<Dto> allReport =  sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.allReport", inDto);
		for(Dto dto : allReport){
			DailyProductionPO dailyProductionPO = new DailyProductionPO();
			dailyProductionPO.setUpdate_id(update_id);
			dailyProductionPO.setUpdate_time(new Date());
			dailyProductionPO.setDaily_status("0");
			dailyProductionPO.setWorking_percent(dto.getBigDecimal("working_percent"));
			dailyProductionPO.setDaily_id(dto.getInteger("daily_id"));
			dailyProductionDao.updateIdByKey(dailyProductionPO);
		}
		httpModel.setOutMsg("新增草稿成功！");
	}
	
	/**
	 * 修改草稿
	 * 
	 * @param httpModel
	 * @return
	 */
	public void draft_update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_id = httpModel.getUserModel().getId();
		inDto.put("update_id", update_id);
			List<Dto> allReport =  sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.allReport",inDto);
			for(Dto dto : allReport){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.setUpdate_id(update_id);
				dailyProductionPO.setUpdate_time(new Date());
				dailyProductionPO.setDaily_id(dto.getInteger("daily_id"));
				dailyProductionPO.setDaily_status("0");
				dailyProductionPO.setWorking_percent(dto.getBigDecimal("working_percent"));
				dailyProductionDao.updateIdByKey(dailyProductionPO);
			}
		httpModel.setOutMsg("修改草稿成功！");
	}
	
	/**
	 * 修改提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update_submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_id = httpModel.getUserModel().getId();
		inDto.put("update_id", update_id);
		List<Dto> allReport =  sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.allReport",inDto);
		List<Dto> productionReportList = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.queryProductionDesc", inDto);
		List<Dto> dailyReportList = sqlDao.list("DailyReportDao.selectDailyReportByDate", inDto);
		DailyReportPO dailyReportPO = new DailyReportPO();
		String desc = "";
		boolean flag = false;
		if (dailyReportList.size() > 0) {
			dailyReportPO.copyProperties(dailyReportList.get(0));
			flag = true;
		} else {
			dailyReportPO.setWeek_day(AOSUtils.getWeekDayByDate(inDto.getString("daily_date")));
			dailyReportPO.setUpdate_user_id(update_id);
			dailyReportPO.setDaily_time(inDto.getDate("daily_date"));
			dailyReportPO.setState("1002");
			dailyReportPO.setUpdate_time(AOSUtils.getDateTime());
			dailyReportPO.setName("工作日报_" + httpModel.getUserModel().getName() + "(" + update_id + ")_" + new SimpleDateFormat("yyyyMMdd").format(inDto.getDate("daily_date")));
		}
		for(Dto dto : allReport){
			DailyProductionPO dailyProductionPO = new DailyProductionPO();
			dailyProductionPO.setUpdate_id(update_id);
			dailyProductionPO.setUpdate_time(new Date());
			dailyProductionPO.setDaily_id(dto.getInteger("daily_id"));
			dailyProductionPO.setDaily_status("1");
			dailyProductionPO.setWorking_percent(dto.getBigDecimal("working_percent"));
			dailyProductionDao.updateIdByKey(dailyProductionPO);
		}
		for(Dto dto : productionReportList){
			desc += dto.getString("descc");
		}
		dailyReportPO.setDescc(desc);
		dailyReportPO.setDesccc(desc);
		if (flag) dailyReportDao.updateByKey(dailyReportPO);
		else dailyReportDao.insert(dailyReportPO);
		httpModel.setOutMsg("提交成功");
	}
	
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			dailyProductionDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 根据时间删除
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void delDate(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		dailyProductionDao.deleteDateByKey(inDto.getDate("daily_date"));
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 查询自定义下拉组件数据
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
		List<Dto> list = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.listComboBoxUerid", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 自动生成
	 * 
	 * @param httpModel
	 */
	public void f_get(HttpModel httpModel) {
		// 获取工作内容
		Dto inDto = httpModel.getInDto();
		Date daily_date = inDto.getDate("daily_date");
		int getname = httpModel.getUserModel().getId();
		inDto.put("getname", getname);	
		Integer update_id = httpModel.getUserModel().getId();
		inDto.put("update_id", update_id);	
		Integer user_id = httpModel.getUserModel().getId();
		int count = (int) sqlDao.selectOne("com.bl3.pm.task.dao.DailyProductionDao.countSum", inDto);
		if(count == 0){
			//进行的任务
			List<Dto> conductCount = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.conductCount", inDto);
			for(Dto dto : conductCount){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("task_desc"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			//处理的缺陷
			List<Dto> handleBug = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.handleBug", inDto);
			for(Dto dto : handleBug){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("bug_name"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			//参加的会议
			List<Dto> attendMeeting = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.attendMeeting", inDto);
			for(Dto dto : attendMeeting){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("theme"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			httpModel.setOutMsg("同步成功");
		}else{
			httpModel.setOutMsg("您该日已存在日报记录！");
		}
	}
		
		/**
		 * 重新获取
		 * 
		 * @param httpModel
		 */
		public void f_get1(HttpModel httpModel) {
			// 获取工作内容
			Dto inDto = httpModel.getInDto();
			Date daily_date = inDto.getDate("daily_date");
			int getname = httpModel.getUserModel().getId();
			inDto.put("getname", getname);	
			Integer update_id = httpModel.getUserModel().getId();
			inDto.put("update_id", update_id);	
			Integer user_id = httpModel.getUserModel().getId();
			//进行的任务
			List<Dto> conductCount = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.conductCount", inDto);
			for(Dto dto : conductCount){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setUpdate_id(user_id);
				dailyProductionPO.setUpdate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("task_desc"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			//处理的缺陷
			List<Dto> handleBug = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.handleBug", inDto);
			for(Dto dto : handleBug){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setUpdate_id(user_id);
				dailyProductionPO.setUpdate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("bug_name"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			//参加的会议
			List<Dto> attendMeeting = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.attendMeeting", inDto);
			for(Dto dto : attendMeeting){
				DailyProductionPO dailyProductionPO = new DailyProductionPO();
				dailyProductionPO.copyProperties(dto);
				SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
				String update_time_q = sdfInput.format(daily_date);
				String week_day_ = AOSUtils.getWeekDayByDate(update_time_q);
				dailyProductionPO.setWeek_day(week_day_);
				dailyProductionPO.setCreate_id(user_id);
				dailyProductionPO.setCreate_time(new Date());
				dailyProductionPO.setUpdate_id(user_id);
				dailyProductionPO.setUpdate_time(new Date());
				dailyProductionPO.setDaily_date(daily_date);
				dailyProductionPO.setDaily_type(dto.getString("type"));
				dailyProductionPO.setDaily_desc(dto.getString("theme"));
				dailyProductionPO.setDaily_status(" ");
				dailyProductionDao.insert(dailyProductionPO);
			}
			httpModel.setOutMsg("同步成功");
		}
		
		/**
		 * 	统一保存
		 * 
		 * @param httpModel
		 * @return
		 */
		public void updateGrid(HttpModel httpModel) {
			Dto inDto = httpModel.getInDto();
			Integer update_user_id = httpModel.getUserModel().getId();
			List<Dto> modifies = inDto.getRows();
			if(modifies.isEmpty()){
				httpModel.setOutMsg("请先选择需保存的检查项!");
				return;
			}
			for (Dto dto : modifies) {
				dto.put("update_id", update_user_id);
				dailyProductionDao.reportUpdateByKey(dto);
			}
			httpModel.setOutMsg("保存成功");
		}
		
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		DailyProductionPO dailyProductionPO=dailyProductionDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(dailyProductionPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id=httpModel.getUserModel().getId();
		inDto.put("create_id", user_id);
		List<DailyProductionPO> dailyProductionPOs = dailyProductionDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(dailyProductionPOs, inDto.getPageTotal()));
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
		List<Dto> list = sqlDao.list("com.bl3.pm.task.dao.DailyProductionDao.select_my_daily", inDto);
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
						String descc = dto.getString("daily_desc");
						dto.remove(dto.getString("daily_desc"));
						dto.remove(minDateStr);
						dto.put("m_time",minDateStr);
						dto.put("daily_date",minDateStr.substring(0,10));
						dto.put("daily_desc",descc);
						sumList.add(dto);
						a = 1;
						break;
					}
				}
				if (a == 0) {
					Dto mdto = Dtos.newDto();
					mdto.put("m_time", minDateStr);
					mdto.put("daily_date", minDateStr.substring(0,10));
					mdto.put("week_day", week);
					mdto.put("daily_status", "null");
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