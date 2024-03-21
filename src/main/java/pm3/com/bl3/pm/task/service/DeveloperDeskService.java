package com.bl3.pm.task.service;


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

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSCxt;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.model.UserModel;

import com.bl3.pm.task.dao.DailyReportDao;
import com.bl3.pm.task.dao.po.DailyReportPO;

/**
 * <b>ta_week_report[ta_week_report]业务逻辑层</b>
 * 
 * @author 
 * @date 2017-12-12 11:33:05
 */
 @Service
 public class DeveloperDeskService{
 	private static Logger logger = LoggerFactory.getLogger(DeveloperDeskService.class);
 	@Autowired
	private DailyReportDao dailyReportDao;
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
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		// 本周
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
				Calendar cal = Calendar.getInstance();
				cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
				int d = 0;
				if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
					d = -13;
				} else {
					d = -5 - cal.get(Calendar.DAY_OF_WEEK);
				}
				cal.add(Calendar.DAY_OF_WEEK, d);
				// 所在周开始日期
		String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		cal.add(Calendar.DAY_OF_WEEK, 13);
				// 所在周结束日期
		String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		httpModel.setAttribute("week_begin_date1", week_begin_date);
		httpModel.setAttribute("week_end_date1", week_end_date);
		httpModel.setViewPath("pm3/task/developerDesk_list.jsp");
	}
	public void init1(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		// 本周
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String dateString = formatter.format(AOSUtils.getDateTime());
						Calendar cal = Calendar.getInstance();
						cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
						int d = 0;
						if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
							d = -13;
						} else {
							d = -5 - cal.get(Calendar.DAY_OF_WEEK);
						}
						cal.add(Calendar.DAY_OF_WEEK, d);
						// 所在周开始日期
				String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
				cal.add(Calendar.DAY_OF_WEEK, 13);
						//所在周结束日期  
				String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
				httpModel.setAttribute("week_begin_date1", week_begin_date);
				httpModel.setAttribute("week_end_date1", week_end_date);
		httpModel.setViewPath("pm3/task/testDesk_list.jsp");
	}
	/**
	 * Portal页面初始化
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init2(HttpModel httpModel) {
		UserModel userModel = httpModel.getUserModel();
		httpModel.setAttribute("curSkin", userModel.getSkin());
		httpModel.setAttribute("run_mode", AOSCxt.getParam("run_mode"));
		httpModel.setViewPath("pm3/task/projectManager_list.jsp");
	}
	
	//工作台加载我的日报
	public void page(HttpModel httpModel) {
		Dto dto=httpModel.getInDto();
		List<Dto> getDto=sqlDao.list("DailyReportDao.TestExampleArrayList222",dto);
	   httpModel.setOutMsg(AOSJson.toGridJson(getDto, dto.getPageTotal()));
	}
	//工作台加载我的任务
	public void page2(HttpModel httpModel) {
		Dto dto=httpModel.getInDto();
		int i = httpModel.getUserModel().getId();
		dto.put("handler_user_id", i);	
		List<Dto> getDto=sqlDao.list("DailyReportDao.TestExampleArrayList22",dto);
	   httpModel.setOutMsg(AOSJson.toGridJson(getDto, dto.getPageTotal()));
	}
	//工作台加载我的评审
	
		public void page3(HttpModel httpModel) {
			int user_id = httpModel.getUserModel().getId();
			String user_id_ = ","+user_id+",";
			Dto dto=httpModel.getInDto();
			List<Dto> getDto=sqlDao.list("DailyReportDao.TestExampleArrayList33",dto);
			List<Dto> getDto1 = new ArrayList<Dto>();
			for (int i = 0; i < getDto.size(); i++) {
				Object obj =   getDto.get(i).get("attende_id");
				String attende = obj.toString().replace("[", ",").replace("]", ",").replace(" ", "");
				if(attende.indexOf(user_id_)!=-1){
					getDto1.add(getDto.get(i));
				}
			}
		   httpModel.setOutMsg(AOSJson.toGridJson(getDto1, dto.getPageTotal()));
		}
	//工作台加载我的缺陷（开发人员）
		public void page4(HttpModel httpModel) {
			Dto dto=httpModel.getInDto();
			int i =httpModel.getUserModel().getId();
			dto.put("deal_man", i);
				List<Dto> getDto=sqlDao.list("DailyReportDao.TestExampleArrayList44",dto);
				  httpModel.setOutMsg(AOSJson.toGridJson(getDto, dto.getPageTotal()));
				}
	//工作台加载我的缺陷（测试人员）
				public void page5(HttpModel httpModel) {
					Dto dto=httpModel.getInDto();
					String i =httpModel.getUserModel().getName();
					dto.put("create_man", i);
						List<Dto> getDto=sqlDao.list("DailyReportDao.TestExampleArrayList55",dto);
						  httpModel.setOutMsg(AOSJson.toGridJson(getDto, dto.getPageTotal()));
						}
				
	/**
	 * 提交
	 * 
	 * @param httpModel
	 * @return
	 */
	public void submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		DailyReportPO dailyReportPO=new DailyReportPO();
		dailyReportPO.copyProperties(inDto);
		Date update_time_= AOSUtils.getDateTime();
		dailyReportPO.setUpdate_time(update_time_);
		String state_ ="1002";
		dailyReportPO.setState(state_);
		dailyReportDao.updateByKey(dailyReportPO);
		httpModel.setOutMsg("提交成功");
	}
 }