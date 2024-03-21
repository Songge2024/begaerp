package com.bl3.pm.task.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
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
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.task.dao.WeStorageDao;
import com.bl3.pm.task.dao.WeekDao;
import com.bl3.pm.task.dao.po.TaskPO;
import com.bl3.pm.task.dao.po.WeekPO;
import com.bl3.pm.task.dao.po.WeekReportPO;
import com.google.common.collect.Lists;
import com.google.gson.reflect.TypeToken;

/**
 * <b>ta_week[ta_week]业务逻辑层</b>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
 @Service
 public class WeekService{
 	private static Logger logger = LoggerFactory.getLogger(WeekService.class);
 	private static final  int DATA_STATE_THIS_WEEK=1;
 	private static final  int DATA_STATE_NEXT_WEEK=2;
 	@Autowired
	private WeekDao weekDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private WeStorageDao weStorageDao;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel)  throws ParseException{
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		httpModel.setAttribute("user_name", httpModel.getUserModel().getName());
		httpModel.setAttribute("account", httpModel.getUserModel().getAccount());
		httpModel.setViewPath("pm3/task/week_layout.jsp");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
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
		cal.add(Calendar.DAY_OF_WEEK, 1);
		// 所在周开始日期
		String x_week_begin_date  = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		cal.add(Calendar.DAY_OF_WEEK, 6);
		// 所在周结束日期
		String x_week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
		httpModel.setAttribute("x_week_begin_date", x_week_begin_date);
		httpModel.setAttribute("x_week_end_date", x_week_end_date);
		
	}
	public void init1(HttpModel httpModel)  throws ParseException{
		Dto inDto = httpModel.getInDto();
		String[] str=inDto.getString("test_code").split(",");
		StringBuilder sb= new StringBuilder();
		List<WeekReportPO> weekReportPO = sqlDao.list("WeekReportDao.listWeek",Dtos.newDto("test_code",str));
		List<Dto> oneList = new ArrayList();
		List<Dto> hList = new ArrayList();
		Dto pDto=Dtos.newDto();
		List<Dto> nextWeek= new ArrayList();
		 List<Dto> userHouers=null;
       for (int i = 0; i < weekReportPO.size(); i++) {
    	   Dto week =  (Dto) weekReportPO.get(i);
    	   String test_code = week.getString("test_code");
    	   Dto dtos= Dtos.newDto();
    	   dtos.put("test_code",test_code);
    	   dtos.put("week_flag",DATA_STATE_THIS_WEEK);
    	   List<Dto> faPOs_this = sqlDao.list("WeekReportDao.week_lists",dtos);
    	   Dto dtos_= Dtos.newDto();
    	   dtos_.put("test_code",test_code);
    	   dtos_.put("week_flag",DATA_STATE_NEXT_WEEK);
    	   List<Dto> faPOs_next = sqlDao.list("WeekReportDao.week_lists",dtos_);
    	   userHouers = sqlDao.list("WeekReportDao.userHouers", Dtos.newDto("test_code",test_code));
    	   
    	   
    	   
    	   
//    	   concat('<strong>',au.name,'</strong>'),
//			  if(twh.work_hours is null,'',concat(' ','基地:',twh.work_hours)),
//	      if( twh.`business_hours`  is null,'',concat(' ','出差:',twh.business_hours))
			 
    	//本周工作計劃
		for (int j = 0; j < faPOs_this.size();j++) {
			Dto faPO = faPOs_this.get(j);
			faPO.put("rowno", j+1);
	        oneList.add(faPO);
		}	
		
		//下周工作計劃
		for (int j = 0; j < faPOs_next.size();j++) {
			Dto faPO = faPOs_next.get(j);
			faPO.put("rowno", j+1);
			nextWeek.add(faPO);
		}	
		//工時
		
		for (int j = 0; j < userHouers.size();j++) {
			Dto faPO = userHouers.get(j);
			String name =faPO.getString("name");
			String work_hours =faPO.getString("work_hours");
			String business_hours =faPO.getString("business_hours");
			faPO.put("rowno", j+1);
			sb.append("<strong>"+name+"</strong>:");
			if(!work_hours.isEmpty()&&work_hours!="" ){
				if(Integer.valueOf(work_hours)>0){
					sb.append("基地工时:"+work_hours+";");
					}
			}
			if(!business_hours.isEmpty()&&business_hours!="" ){
				if(Integer.valueOf(business_hours)>0){
					sb.append("出差工时:"+business_hours+";");
				}
			}
		 }	
		pDto.put("test_code",test_code);
       }  
       pDto.put("sb",sb);
       hList.add(pDto);
       httpModel.setAttribute("faPOss", oneList);
       httpModel.setAttribute("faPO", weekReportPO);
       httpModel.setAttribute("userHouers", hList);
       httpModel.setAttribute("nextWeek", nextWeek);
       httpModel.setViewPath("pm3/task/week_list.jsp");
}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void cache_token(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String cardListJson = JedisUtil.getString(cacheKey);
		if (AOSUtils.isEmpty(cardListJson)) {
			String token=inDto.getString("token");
			JedisUtil.setString(cacheKey,token , 0); 
		}
		httpModel.setOutMsg(cardListJson);
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		WeekPO weekPO=new WeekPO();
		weekPO.setWeek_id(idService.nextValue("seq_ta_week").intValue());
		weekPO.copyProperties(inDto);
		weekDao.insert(weekPO);
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
		//inDto.remove("id");
		WeekPO weekPO=new WeekPO();
		weekPO.copyProperties(inDto);
		weekDao.updateByKey(weekPO);
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
		String[] test_code_=inDto.getRows("test_code");
		for (String test_code : test_code_){
			weStorageDao.deleteTc(test_code);
	    };
	    for (String test_code : test_code_){
	    	weStorageDao.deleteTh(test_code);
	    };
		for (String id : selectionIds) {
			weekDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		WeekPO weekPO=weekDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(weekPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<WeekPO> weekPOs = weekDao.list(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(weekPOs));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page1(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("user_id", httpModel.getUserModel().getId());
		List<Dto> list = sqlDao.list("WeeklyStorage.listWeekPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list));
	}
	public void listWeek(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeekReportDao.listProj_week",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list));
	}
	public void listProj(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeekReportDao.listComboBoxProj",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list));
	}
	/**
	 * 周报汇总
	 * 
	 * @param httpModel
	 */
	public void pages(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<WeekPO> weekPOs = weekDao.lists(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(weekPOs));
		
	}
	
 }