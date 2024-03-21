package com.bl3.pm.task.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.quality.dao.QaStorageDao;
import com.bl3.pm.quality.service.FilesManageService;
import com.bl3.pm.task.dao.WeStorageDao;
import com.bl3.pm.task.dao.WeekDao;
import com.bl3.pm.task.dao.WeekReportDao;
import com.bl3.pm.task.dao.WorkHourDao;
import com.bl3.pm.task.dao.po.WeekPO;
import com.bl3.pm.task.dao.po.WeekReportPO;
import com.bl3.pm.task.dao.po.WorkHour;
import com.google.common.collect.Lists;
import com.sun.xml.internal.ws.api.streaming.XMLStreamReaderFactory.Default;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.exception.AOSException;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

/**
 * <b>ta_week_report[ta_week_report]业务逻辑层</b>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
 @Service
 public class WeekReportService{
 	private static Logger logger = LoggerFactory.getLogger(WeekReportService.class);
 	@Autowired
	private WeekReportDao weekReportDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private WeStorageDao weStorageDao;
	@Autowired
	private QaStorageDao qaStorageDao;
	@Autowired
	private WeekDao weekDao;
	@Autowired
	private WorkHourDao workHourDao;
	@Autowired
	private FilesManageService  filesManageService;
	
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException 
	 */
	public void init(HttpModel httpModel) throws ParseException {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("name", httpModel.getUserModel().getName());
		httpModel.setAttribute("id", httpModel.getUserModel().getId());
		httpModel.setAttribute("user_name", httpModel.getUserModel().getName());
		httpModel.setViewPath("pm3/task/weekReport_layout.jsp");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
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
		httpModel.setAttribute("year_begin_date", year_begin_date);
		httpModel.setAttribute("year_end_date", year_end_date);
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
	}
	/**
	 * 新增本周任务完成情况
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
	    String 	begin_date_=inDto.getString("begin_date");
	    String end_date_=inDto.getString("end_date");
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String proj_name=inDto.getString("proj_name");
		String task_plan_num=inDto.getString("task_plan_num");
		String _name =httpModel.getUserModel().getName();
		//新增周报明细
		List<Dto> list=inDto.getRows();
		for (int i = 0; i < list.size(); i++) {
			String remarks = list.get(i).get("remarks").toString();
			String remarks_=remarks.replace("<font face=\"tahoma, arial, verdana, sans-serif\">","")
					.replace("<span style=\"font-family: sans-serif; font-size: 16px;\">", "")
					.replace("</font>","")
            		.replace("</span>", "");
			String owner_id = list.get(i).get("owner_id").toString();
			String owner_id_=owner_id.replace("[","");
            String _owner_id_=owner_id_.replace("]","");
            String[] str=_owner_id_.split(",");
	        List<String> s=new  ArrayList<String>();
	        for (int j=0 ; j<str.length;j++) {
	        	String id= str[j];
	            String id_=id.replaceAll(" ", "");
	        	System.out.print(str[j]);
	        	String owner_name = (String) sqlDao.selectOne("com.bl3.pm.task.dao.WeStorageDao.proj_people", id_);
	        	s.add(owner_name);
	      	}
	        String s_=s.toString();
	        String _s_=s_.replace("[","");
	        String _s__=_s_.replace("]","");
			list.get(i).put("owner_id", _owner_id_);
			list.get(i).put("remarks", remarks_);
			list.get(i).put("owner_name", _s__);
		}
		for(Dto dto : list){
			weStorageDao.insert(dto);
		}
		if( weStorageDao.weeklyCount(test_code_)>0){
			return;
		};
		WeekPO weekPO=new WeekPO();
		//设置一个自定义的字符串
		weekPO.setTest_leader("xxxx");
		weekPO.setAdd_name(_name);
		weekPO.setBegin_date(AOSUtils.stringToDate(begin_date_));
		//从新建的DAO.XML文件中取一条数据
		weekPO.setTest_code(test_code_);
		weekPO.setProj_id(proj_id);
		weekPO.setProj_name(proj_name);
		weekPO.setTask_plan_num(task_plan_num);
		weekPO.setCreate_time(AOSUtils.getDateTime());
		weekPO.setEnd_date(AOSUtils.stringToDate(end_date_));
		weekPO.setSolve(solve);
		weekPO.setDescription(description);
		weekDao.insert(weekPO);
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 新增下周工作计划
	 * 
	 * @param httpModel
	 * @return
	 */
	public void week_plan_create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
	    String 	begin_date_=inDto.getString("begin_date");
	    String end_date_=inDto.getString("end_date");
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String proj_name=inDto.getString("proj_name");
		String task_plan_num=inDto.getString("task_plan_num");
		String _name =httpModel.getUserModel().getName();
		//新增下周工作计划
		List<Dto> list=inDto.getRows();
		for (int i = 0; i < list.size(); i++) {
			String begin_date = list.get(i).get("begin_date").toString();
			String end_date = list.get(i).get("end_date").toString();
			String remarks = list.get(i).get("remarks").toString();
			String remarks_=remarks.replace("<font face=\"tahoma, arial, verdana, sans-serif\">","")
					.replace("<span style=\"font-family: sans-serif; font-size: 16px;\">", "");
            String _remarks_=remarks_.replace("</font>","")
            		.replace("</span>", "");
			String owner_id = list.get(i).get("owner_id").toString();
			String owner_id_=owner_id.replace("[","");
			String _owner_id_=owner_id_.replace("]","");
			String[] str=_owner_id_.split(",");
			List<String> s=new  ArrayList<String>();
			for (int j=0 ; j<str.length;j++) {
				String id= str[j];
				String id_=id.replaceAll(" ", "");
				System.out.print(str[j]);
				String owner_name = (String) sqlDao.selectOne("com.bl3.pm.task.dao.WeStorageDao.proj_people", id_);
				s.add(owner_name);
			}
			String s_=s.toString();
			String _s_=s_.replace("[","");
			String _s__=_s_.replace("]","");
			list.get(i).put("owner_id", _owner_id_);
			list.get(i).put("remarks", _remarks_);
			list.get(i).put("begin_date",begin_date);
			list.get(i).put("end_date",end_date);
			list.get(i).put("owner_name", _s__);
		}
		for(Dto dto : list){
			weStorageDao.insert_week_plan(dto);
		}
		if( weStorageDao.weeklyCount(test_code_)>0){
			return;
		};
		WeekPO weekPO=new WeekPO();
		//设置一个自定义的字符串
		weekPO.setTest_leader("xxxx");
		weekPO.setAdd_name(_name);
		weekPO.setBegin_date(AOSUtils.stringToDate(begin_date_));
		//从新建的DAO.XML文件中取一条数据
		weekPO.setTest_code(test_code_);
		weekPO.setProj_id(proj_id);
		weekPO.setProj_name(proj_name);
		weekPO.setTask_plan_num(task_plan_num);
		weekPO.setCreate_time(AOSUtils.getDateTime());
		weekPO.setEnd_date(AOSUtils.stringToDate(end_date_));
		weekPO.setSolve(solve);
		weekPO.setDescription(description);
		weekDao.insert(weekPO);
		httpModel.setOutMsg("新增成功");
	}
	
	// 获取本周日期
	public Dto getWeekDate() throws ParseException{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
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
//		String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
//				.getTime());
//		cal.add(Calendar.DAY_OF_WEEK, -7);
		// 所在周结束日期
		String    week_end_date= new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		cal.add(Calendar.DAY_OF_WEEK, -8);
		String  week_begin_date= new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		
		Dto inDto=Dtos.newDto();
		inDto.put("begin_date", week_begin_date);
		inDto.put("end_date", week_end_date);
		return inDto;
	}
	
	//获取我的项目树 （历史，正在进行中的）
	public void my_project_tree(HttpModel httpModel) {
			List<TreeNode> treeNodes = Lists.newArrayList();
			Dto inDto = httpModel.getInDto();
			//我的项目
			TreeNode treeNode0 = new TreeNode();
			treeNode0.setId("0000");
			treeNode0.setText("我的项目");
			treeNode0.setParentId("0");
			treeNode0.setIcon("home.png");
			treeNode0.setLeaf(false);
			treeNode0.setExpanded(true);
			treeNode0.setA("0");
			treeNodes.add(treeNode0);
			//进行中的项目
			TreeNode treeNode1 = new TreeNode();
			treeNode1.setId("A1");
			treeNode1.setText("进行中的项目");
			treeNode1.setParentId("0000");
			treeNode1.setIcon("042804.png");
			treeNode1.setLeaf(false);
			treeNode1.setExpanded(true);
			treeNode1.setA("0");
			treeNodes.add(treeNode1);
			//历史项目
			TreeNode treeNode2 = new TreeNode();
			treeNode2.setId("A2");
			treeNode2.setText("历史项目");
			treeNode2.setParentId("0000");
			treeNode2.setIcon("042803.png");
			treeNode2.setLeaf(false);
			treeNode2.setExpanded(true);
			treeNode2.setA("0");
			treeNodes.add(treeNode2);
			
			inDto.put("userid", httpModel.getUserModel().getId());
			List<Dto> list = sqlDao.list("WeeklyStorage.querymy_project_tree", inDto);
			for (Dto dto : list) {
				//获取本周项目周报是否编写
				Dto putDto = null;
				try {
					putDto=getWeekDate();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				putDto.put("proj_id",dto.getString("PROJ_ID"));
				TreeNode treeNode = new TreeNode();
				treeNode.setId(dto.getString("PROJ_ID"));
				StringBuilder sb=new StringBuilder();
				String state = dto.getString("STATE");
				if(state.equals("1")){
					int num=(int) sqlDao.selectOne("WeeklyStorage.getWeekDate",putDto);
					 if(num>0){
		                	sb.append(dto.getString("PROJ_NAME"));
		                	sb.append("<font color=\"blue\">(已提交)</font>");
		                	treeNode.setText(sb.toString());
		                }
		                   else{
		                sb.append(dto.getString("PROJ_NAME"));
		              	sb.append("<font color=\"red\">(未提交)</font>");
		              	treeNode.setText(sb.toString());
		                }
				}else{
					sb.append(dto.getString("PROJ_NAME"));
					treeNode.setText(sb.toString());
				}
				
				
				String parentId = state.equals("1")? "A1" : "A2";
				if(parentId.equals("A1")){
					treeNode.setIcon("042802.png");
				}else{
					treeNode.setIcon("bullet_black.png");
				}
				treeNode.setParentId(parentId);
				treeNode.setLeaf(false);
				treeNode.setA("1");
				treeNode.setExpanded(true);
				treeNodes.add(treeNode);
			}
			String jsonString = TreeBuilder.build(treeNodes);
			httpModel.setOutMsg(jsonString);
		}
		
	
	/**
	 * 保存数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void saveData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
	    String 	begin_date_=inDto.getString("begin_date");
	    String end_date_=inDto.getString("end_date");
		String solve1=inDto.getString("solve");
		String description1=inDto.getString("description");
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String proj_name=inDto.getString("proj_name");
		String task_plan_num=inDto.getString("task_plan_num");
		String week_plan=inDto.getString("week_plan");
		String _name =httpModel.getUserModel().getName();
		
		//添加周报明细
		List<Dto> list=inDto.getRows();
		for (int i = 0; i < list.size(); i++) {
			String owner_id = list.get(i).get("owner_id").toString();
			String owner_id_=owner_id.replace("[","");
            String _owner_id_=owner_id_.replace("]","");
			list.get(i).put("owner_id",_owner_id_);
			
		}
		for(Dto dto : list){
			weStorageDao.insert(dto);
		}
		//周报主表
		if( weStorageDao.weeklyCount(test_code_)>0){
			WeekPO weekPO=new WeekPO();
			weekPO.copyProperties(inDto);
			weekDao.updateByKey(weekPO);
			httpModel.setOutMsg("保存成功");
			 return;
		};
		WeekPO weekPO=new WeekPO();
		//设置一个自定义的字符串
		weekPO.setTest_leader("xxxx");
		weekPO.setAdd_name(_name);
		weekPO.setBegin_date(AOSUtils.stringToDate(begin_date_));
		//从新建的DAO.XML文件中取一条数据
		weekPO.setTest_code(test_code_);
		weekPO.setProj_id(proj_id);
		weekPO.setProj_name(proj_name);
		weekPO.setTask_plan_num(task_plan_num);
		weekPO.setCreate_time(AOSUtils.getDateTime());
		weekPO.setEnd_date(AOSUtils.stringToDate(end_date_));
		//ADMIN=2
//		weekPO.setFlag(SystemCons.GRANT_TYPE.BIZ);
		weekPO.setSolve(solve1);
		weekPO.setDescription(description1);
		weekPO.setWeek_plan(week_plan);
		weekDao.insert(weekPO);
		httpModel.setOutMsg("保存成功");
		
	}
	
	public void saveHour(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String test_code=inDto.getString("test_code");
		Date begin_date=inDto.getDate("begin_date");
		Date end_date=inDto.getDate("end_date");
		List<Dto> list=inDto.getRows();
		for (int i = 0; i < list.size(); i++) {
			String work_hours = list.get(i).getString("work_hours");
			String business_hours = list.get(i).getString("business_hours");
			int sj = AOSUtils.getIntervalDays(begin_date,end_date)+1;
			float hours=0;
			if(AOSUtils.isEmpty(work_hours)&&AOSUtils.isEmpty(business_hours)) {
				 hours =0;
			}
			if(AOSUtils.isEmpty(work_hours)&&AOSUtils.isNotEmpty(business_hours)) {
				hours =Float.valueOf(business_hours);
			}
			if(AOSUtils.isEmpty(business_hours)&&AOSUtils.isNotEmpty(work_hours)) {
				hours =Float.valueOf(work_hours);
			}
			
			if(AOSUtils.isNotEmpty(business_hours)&&AOSUtils.isNotEmpty(work_hours)) {
				hours =Float.valueOf(business_hours)+Float.valueOf(work_hours);
			}
			if(hours>sj) {
				 httpModel.setOutMsg("录入的工期不能大于结束时间和开始时间之差,请重输!");
				 return;
			}
		}
		for (int i = 0; i < list.size(); i++) {
			Dto putDto =Dtos.newDto();
			String user_id = list.get(i).getString("user_id");
			String work_hours = list.get(i).getString("work_hours");
			String business_hours = list.get(i).getString("business_hours");
			String proj_id = list.get(i).getString("proj_id");
			putDto.put("test_code",test_code);
			putDto.put("user_id", user_id);
			putDto.put("work_hours", work_hours);
			putDto.put("business_hours", business_hours);
			putDto.put("proj_id", proj_id);
			list.get(i).put("test_code",test_code);
			if( weStorageDao.weekhsCount(putDto)>0)
				sqlDao.update("com.bl3.pm.task.dao.WeStorageDao.upWeekhs", putDto);
			else
				workHourDao.insert(putDto);
			
		}
		 httpModel.setOutMsg("保存成功！");
	}
	
	
	public void getDate(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Date begin_date=inDto.getDate("begin_date");
		Date end_date=inDto.getDate("end_date");
		int sj = AOSUtils.getIntervalDays(begin_date,end_date)+1;
		 httpModel.setOutMsg(String.valueOf(sj));
	}
	
	/**
	 * 生成数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void createData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//查询数据DTO
		Dto setDto=Dtos.newDto();
		//传入后台的DTO
		Dto errStrDto=Dtos.newDto();
		//获取前端数据查询传入参数
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String begin_date=inDto.getString("begin_date");
		String end_date=inDto.getString("end_date");
		String proj_name=inDto.getString("proj_name");
		String week_name=inDto.getString("week_name");
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
		String _name =httpModel.getUserModel().getName();
		setDto.put("proj_id", proj_id);
		setDto.put("begin_date", begin_date);
		setDto.put("end_date", end_date);
		//遍历取值
		List<Dto> week_=weStorageDao.week_name(setDto);
		for (int i = 0; i < week_.size(); i++) {
			if (week_.get(i).get("remarks").toString() != null
					&& week_.get(i).get("remarks").toString().length() != 0) {
				String remarks = "1."+ week_.get(i).get("remarks").toString()
			//		.replaceAll("</?[^>]+>", "") //剔出<html>的标签
					.replaceAll("</?[^/?(br)|][^><]*>","")
					.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
					.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
				for (int j = 2; j < remarks.length(); j++) {
					remarks = remarks.replaceFirst(",", ";<br>" + j + ".")
			//				.replaceAll("</?[^>]+>", "") //剔出<html>的标签
							.replaceAll("</?[^/?(br)|][^><]*>","")
							.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
							.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
					week_.get(i).put("remarks", remarks);
				}
			}
		 } 
		Iterator<Dto> iterator = week_.iterator();
		while(iterator.hasNext())
		 {
		 Dto i = (Dto) iterator.next();
		 i.put("test_code", test_code_);
		 i.put("proj_id", proj_id);
		 i.put("proj_name", proj_name);
		 i.put("week_name", week_name);
		 i.put("add_name",_name);
		 i.put("solve", solve);
		 i.put("description", description);
		 i.put("detail", 1);
         //序列号缺省
		}
		httpModel.setOutMsg("生成数据成功！");
	httpModel.setOutMsg(AOSJson.toGridJson(week_));
	}
	
	
	public void createData0(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//查询数据DTO
		Dto setDto=Dtos.newDto();
		//传入后台的DTO
		Dto errStrDto=Dtos.newDto();
		//获取前端数据查询传入参数
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String begin_date=inDto.getString("begin_date");
		String end_date=inDto.getString("end_date");
		String proj_name=inDto.getString("proj_name");
		String week_name=inDto.getString("week_name");
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
		String _name =httpModel.getUserModel().getName();
		setDto.put("proj_id", proj_id);
		setDto.put("begin_date", begin_date);
		setDto.put("end_date", end_date);
		//遍历取值
		List<Dto> week_=weStorageDao.week_T(setDto);
		for (int i = 0; i < week_.size(); i++) {
			if (week_.get(i).get("remarks").toString() != null
					&& week_.get(i).get("remarks").toString().length() != 0) {
				String remarks = "1."+  week_.get(i).get("remarks").toString()
						//		.replaceAll("</?[^>]+>", "") //剔出<html>的标签
						.replaceAll("</?[^/?(br)|][^><]*>","")
						.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
						.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
				for (int j = 2; j < remarks.length(); j++) {
					remarks = remarks.replaceFirst(",", ";<br>" + j + ".")
							//				.replaceAll("</?[^>]+>", "") //剔出<html>的标签
							.replaceAll("</?[^/?(br)|][^><]*>","")
							.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
							.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
					week_.get(i).put("remarks", remarks);
				}
			}
		} 
		Iterator<Dto> iterator = week_.iterator();
		while(iterator.hasNext())
		{
			Dto i = (Dto) iterator.next();
			i.put("test_code", test_code_);
			i.put("proj_id", proj_id);
			i.put("proj_name", proj_name);
			i.put("week_name", week_name);
			i.put("add_name",_name);
			i.put("solve", solve);
			i.put("description", description);
			i.put("detail", 1);
			//序列号缺省
		}
		httpModel.setOutMsg("生成数据成功！");
		httpModel.setOutMsg(AOSJson.toGridJson(week_));
	}
	
	
	public void createData1(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//查询数据DTO
		Dto setDto=Dtos.newDto();
		//传入后台的DTO
		Dto errStrDto=Dtos.newDto();
		//获取前端数据查询传入参数
		String test_code_=inDto.getString("test_code");
		String proj_id=inDto.getString("proj_id");
		String begin_date=inDto.getString("begin_date");
		String end_date=inDto.getString("end_date");
		String proj_name=inDto.getString("proj_name");
		String week_name=inDto.getString("week_name");
		String solve=inDto.getString("solve");
		String description=inDto.getString("description");
		String _name =httpModel.getUserModel().getName();
		setDto.put("proj_id", proj_id);
		setDto.put("begin_date", begin_date);
		setDto.put("end_date", end_date);
		//遍历取值
		List<Dto> week_=weStorageDao.week_N(setDto);
		for (int i = 0; i < week_.size(); i++) {
			if (week_.get(i).get("remarks").toString() != null
					&& week_.get(i).get("remarks").toString().length() != 0) {
				String remarks = "1."+  week_.get(i).get("remarks").toString()
						//		.replaceAll("</?[^>]+>", "") //剔出<html>的标签
						.replaceAll("</?[^/?(br)|][^><]*>","")
						.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
						.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
				for (int j = 2; j < remarks.length(); j++) {
					remarks = remarks.replaceFirst(",", ";<br>" + j + ".")
							//				.replaceAll("</?[^>]+>", "") //剔出<html>的标签
							.replaceAll("</?[^/?(br)|][^><]*>","")
							.replaceAll("<img src=\"http://172.21.1.110:8080/bl3pm/static/weblib/ued","")
							.replaceAll("<p style=\"font-family: tahoma;<br>2. arial;<br>3. verdana;<br>4. sans-serif; font-size: 12px;","");//保留br标签和p标签  
					week_.get(i).put("remarks", remarks);
				}
			}
		} 
		Iterator<Dto> iterator = week_.iterator();
		while(iterator.hasNext())
		{
			Dto i = (Dto) iterator.next();
			i.put("test_code", test_code_);
			i.put("proj_id", proj_id);
			i.put("proj_name", proj_name);
			i.put("week_name", week_name);
			i.put("add_name",_name);
			i.put("solve", solve);
			i.put("description", description);
			i.put("detail", 1);
			//序列号缺省
		}
		httpModel.setOutMsg("生成数据成功！");
		httpModel.setOutMsg(AOSJson.toGridJson(week_));
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
		WeekReportPO weekReportPO=new WeekReportPO();
		WeekPO weekPO=new WeekPO();
		weekReportPO.copyProperties(inDto);
		weekPO.copyProperties(inDto);
		String remarks = inDto.getString("remarks").toString();
		String remarks_=remarks.replace("<font face=\"tahoma, arial, verdana, sans-serif\">","")
				.replace("<span style=\"font-family: sans-serif; font-size: 16px;\">", "")
				.replace("</font>","")
        		.replace("</span>", "");
		String owner_id=inDto.getString("owner_id");
		 String owner_id_=owner_id.replace("[","");
	      String _owner_id_=owner_id_.replace("]","");
	      String[] str=_owner_id_.split(",");
	        List<String> s=new  ArrayList<String>();
	        for (int i=0 ; i<str.length;i++) {
	        	String id=str[i];
	            String id_= id.replaceAll(" ", "");
	        	String list = qaStorageDao.returnUserName(Integer.parseInt(id_));
	        	s.add(list);
	      	}
	        String s_=s.toString();
	        String _s_=s_.replace("[","");
	        String _s__=_s_.replace("]","");
	        weekReportPO.setOwner_name(_s__);
		
	     weekReportPO.setOwner_id(_owner_id_);
	     weekReportPO.setRemarks(remarks_);
		weekReportDao.updateByKey(weekReportPO);
		weekDao.updateByKey(weekPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update_plan(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		WeekReportPO weekReportPO=new WeekReportPO();
		weekReportPO.copyProperties(inDto);
		String owner_id=inDto.getString("owner_id");
		String owner_id_=owner_id.replace("[","");
		String _owner_id_=owner_id_.replace("]","");
		String[] str=_owner_id_.split(",");
		List<String> s=new  ArrayList<String>();
		for (int i=0 ; i<str.length;i++) {
			String id=str[i];
			String id_= id.replaceAll(" ", "");
			String list = qaStorageDao.returnUserName(Integer.parseInt(id_));
			s.add(list);
		}
		String s_=s.toString();
		String _s_=s_.replace("[","");
		String _s__=_s_.replace("]","");
		weekReportPO.setOwner_name(_s__);
		weekReportPO.setOwner_id(_owner_id_);
		weekReportDao.updatePlan(weekReportPO);
		httpModel.setOutMsg("修改成功");
	}
	
	/**
	 * 作废
	 */
	public  void delWeekly(HttpModel httpModel){
	  Dto dto=httpModel.getInDto();
	  String test_code_=dto.getString("test_code");
	  weStorageDao.weeklyDel(test_code_);
	  weStorageDao.weeklyDeDel(test_code_);
	  weStorageDao.weeklyDelH(test_code_);
	  httpModel.setOutMsg("数据已作废");
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] test_code = inDto.getString("selection").split(",");
		List<Dto> faPOs = sqlDao.list("WeekReportDao.TestExampleArrayList",test_code);
		for (int i = 0; i < faPOs.size(); i++) {
			faPOs.get(i).put("begin_date", faPOs.get(i).get("begin_date").toString());
			faPOs.get(i).put("end_date", faPOs.get(i).get("end_date").toString());
			faPOs.get(i).put("remarks", faPOs.get(i).get("remarks").toString().replace("<br>", " ").replace("&nbsp;", ""));
			faPOs.get(i).put("solve", faPOs.get(i).get("solve").toString().replace("<br>", " ").replace("&nbsp;", ""));
			faPOs.get(i).put("descripton", faPOs.get(i).get("description").toString().replace("<br>", " ").replace("&nbsp;", ""));
			faPOs.get(i).put("rowno", i+1);
		}
		ExcelExporter exporter=new ExcelExporter();
		Dto paramsDto=Dtos.newDto();
			paramsDto.put("dcr", httpModel.getUserModel().getName());
			paramsDto.put("dcsj", AOSUtils.getDateStr());
			paramsDto.put("solve", faPOs.get(0).get("solve"));
			paramsDto.put("proj_name", faPOs.get(0).get("proj_name"));
			paramsDto.put("description", faPOs.get(0).get("description"));
			paramsDto.put("task_plan_num", faPOs.get(0).get("task_plan_num"));
			paramsDto.put("b_time", faPOs.get(0).get("b_time"));
			paramsDto.put("e_time", faPOs.get(0).get("e_time"));
			exporter.setData(paramsDto, faPOs);
			exporter.setTemplatePath("/export/excel/weekReport.xls");
			exporter.setFilename("周工作计划及任务完成情况.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}

			
	}
	
	public void exportExcel1(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] week_id = inDto.getString("week_id").split(",");
		String[] test_code = inDto.getString("test_code").split(",");
		List paramsList = new ArrayList();//导出的头数据集
		List faPOList = new ArrayList();//导出的身体数据集
		String proj_name = "";
		for(int i=0;i<test_code.length;i++){
			List tbPOList = new ArrayList();//第一个表格和第二个表格的数据
			boolean flag = true;
			for(int j=0;j<i;j++){//用i当前编码去判断是否和i之前的编码J相等
				if(test_code[i].equals(test_code[j])){//相等返回false
					flag = false;
				}
			}
			if(flag){
				Dto dto = Dtos.newDto();
				dto.put("week_id", week_id[i]);
				dto.put("test_code", test_code);
				List<Dto> faPOs = (List<Dto>) sqlDao.list("WeekReportDao.TestExampleArrayList", dto);
				Dto paramsDto=Dtos.newDto();
				paramsDto.put("rowTitle1","项目周报");
				paramsDto.put("data_row","8");//数据从多少行开始写入 从0开始  *必填
				paramsDto.put("dcr", httpModel.getUserModel().getName());
				paramsDto.put("dcsj", AOSUtils.getDateStr());
				int amount = faPOs.size();
				for (int k = 0; k < amount; k++) {
					 Dto faPO = faPOs.get(k);	
					 faPO.put("begin_date", faPO.get("b_time").toString());
					 faPO.put("end_date", faPO.get("e_time").toString());
					 faPO.put("remarks", faPO.get("remarks").toString().replace("<br>", " ").replace("&nbsp;", "")
							 .replace("<div>", " ").replace("</div>","").replace("</div>","").replace("<font face=\"tahoma, arial, verdana, sans-serif\">","")
							 .replace("</font>","").replace("<div style=\"color: rgb(0, 0, 0); font-family: tahoma, arial, verdana, sans-serif; font-size: 12px;\">","")
							 .replace("<span style=\"white-space:pre\">","") .replace("</span>","")
							 );
					 faPO.put("solve", faPO.get("solve").toString().replace("<br>", " ").replace("&nbsp;", ""));
					 faPO.put("descripton", faPO.get("description").toString().replace("<br>", " ").replace("&nbsp;", ""));
					 faPO.put("rowno", k+1);
				}
				paramsDto.put("dcr", httpModel.getUserModel().getName());
				paramsDto.put("dcsj", AOSUtils.getDateStr());
				paramsDto.put("solve", faPOs.get(0).get("solve"));
				paramsDto.put("proj_name", faPOs.get(0).get("proj_name"));
//					paramsDto.put("week_class", faPOs.get(0).get("week_class"));
				paramsDto.put("description", faPOs.get(0).get("description"));
				paramsDto.put("task_plan_num", faPOs.get(0).get("task_plan_num"));
				paramsDto.put("b_time", faPOs.get(0).get("b_time"));
				paramsDto.put("e_time", faPOs.get(0).get("e_time"));
				String task_plan_num =faPOs.get(0).getString("task_plan_num")+"("+i+")";
				paramsDto.put("tab_name",task_plan_num);//设置当前tab页的名称：模块名称
				paramsList.add(paramsDto);
				proj_name = faPOs.get(0).getString("proj_name");//提取项目名
				tbPOList.add(faPOs);
			
				Dto pDto = Dtos.newDto();
				pDto.put("week_id", week_id[i]);
				pDto.put("test_code", test_code);
			    List<Dto> faPOss = (List<Dto>) sqlDao.list("WeekReportDao.TestExampleArrayListx", pDto);
				int amounts = faPOss.size();
				for (int k = 0; k < amounts; k++) {
					Dto faPOx = faPOss.get(k);	
					faPOx.put("remarks", faPOx.get("remarks").toString().replace("<br>", " ").replace("&nbsp;", "")
							.replace("<div>", " ").replace("</div>","").replace("</div>","").replace("<font face=\"tahoma, arial, verdana, sans-serif\">","")
							.replace("</font>","").replace("<div style=\"color: rgb(0, 0, 0); font-family: tahoma, arial, verdana, sans-serif; font-size: 12px;\">","")
							.replace("<span style=\"white-space:pre\">","") .replace("</span>","")
							);
					faPOx.put("owner_name", faPOx.get("owner_name").toString());
					faPOx.put("week_class", faPOx.get("week_class").toString());
					faPOx.put("week_name", faPOx.get("week_name").toString());
					faPOx.put("rowno", k+1);
				}
				tbPOList.add(faPOss);
			}
			faPOList.add(tbPOList);
		}
		ExcelExporter exporter=new ExcelExporter();
		exporter.setData(paramsList, faPOList);
		exporter.setTemplatePath("/export/excel/weekReport.xls");
		exporter.setFilename(proj_name+"项目周报.xls");
		try {
			exporter.export_tabe(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
	}
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
			weekReportDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 删除下周工作计划
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete_plan(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			weekReportDao.deletePlan(Integer.valueOf(id));
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
		WeekReportPO weekReportPO=weekReportDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(weekReportPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<WeekReportPO> weekReportPOs = weekReportDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(weekReportPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void pageProj(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> pageProj = sqlDao.list("WeekReportDao.pageProj", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(pageProj, inDto.getPageTotal()));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void work_plan(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> work_plan = sqlDao.list("WeekReportDao.work_plan", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(work_plan, inDto.getPageTotal()));
	}
	
	/**
	 * 周报汇总(详情)
	 * 
	 * @param httpModel
	 */
	public void work_plan_count(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> work_plan = sqlDao.list("WeekReportDao.work_plan_count", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(work_plan, inDto.getPageTotal()));
	}
	
	/**
	 * 根据项目编码查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getCode(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		WeekReportPO weekReportPO=weekReportDao.getProjt(inDto);
		httpModel.setOutMsg(AOSJson.toJson(weekReportPO));
	}
	
	/**
	 * 编码新增
    */		
	private String str(String  str){
		String strs=filesManageService.dateToStamp(str);
			return strs;
	}
	
	/**
	 *项目周
    */		
	private String str_n(int  i,int _len){
			String str_n =i+"";
			while(str_n.length()<_len){
				str_n = "0"+str_n;
			  }
			return str_n;
	}
	
	
	/**
	 * 跳转明细
	 * @throws ParseException 
	 */
	public void actionTab(HttpModel httpModel) throws ParseException{
		Dto dto=httpModel.getInDto();
		Dto inDto=Dtos.newDto();
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
				Date da=cal.getTime();
				String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
						.getTime());
				cal.add(Calendar.DAY_OF_WEEK, 6);
				// 所在周结束日期
				String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
						.getTime());
		String _test_code_s = str("Ta");
		//定义第几周
		int getWeekly=0;
		//获取启动时间
		String proj_id=dto.getString("proj_id");
		Date dts = (Date) sqlDao.selectOne("com.bl3.pm.task.dao.WeStorageDao.getProjdt",proj_id);
		//取系统时间
		Date dt=AOSUtils.getDate();
		//系统时间减去项目启动时间
		int s=AOSUtils.getIntervalDays(dts, dt);
		
		//系统时间减去本周开始时间
		int s_=AOSUtils.getIntervalDays(da,dt);
		int difftDay=s-s_;
		if(difftDay>0) {
			getWeekly=difftDay/7+1;
		if(difftDay%7!=0)
			getWeekly=getWeekly+1;
		}
		else
			getWeekly=1;
		String n ;
		n = "第"+getWeekly+"周";
		inDto.put("test_code"  ,_test_code_s);
		inDto.put("week_end_date", week_end_date);
		inDto.put("week_begin_date", week_begin_date);
		inDto.put("task_plan_num"  ,n);
		httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	/**
	 * 星期转天
	 * @return int 天
	 */
	public int returnDay(String str) {
	switch(str){
		case "星期一":
		    return 1;
		case "星期二":
		    return 2;
		case "星期三":
		    return 3;
		case "星期四":
		    return 4;
		case "星期五":
		    return 5;
		case "星期六":
		    return 6;
		 default:
			 return 7;
		}
	}
	
	/**
	 * 双击跳转明细
	 */
	public void actionTabDb(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		Dto intDto=Dtos.newDto();
		intDto.put("test_code", dto.getString("test_code"));
		intDto.put("end_date", AOSUtils.date2String(dto.getDate("end_date"), "yyyy-MM-dd"));
		intDto.put("solve", dto.getString("solve"));
		intDto.put("description", dto.getString("description"));
		intDto.put("flag", dto.getString("flag"));  
		intDto.put("proj_id", dto.getString("proj_id"));  
		intDto.put("task_plan_num", dto.getString("task_plan_num"));  
		intDto.put("proj_name", dto.getString("proj_name"));  
		intDto.put("week_plan", dto.getString("week_plan"));  
		httpModel.setOutMsg(AOSJson.toJson(intDto));
	}
	
	/**
	 * 获取改编变后的时间
	 * @throws ParseException 
	 */
	public void changeDate(HttpModel httpModel) throws ParseException{
		Dto dto=httpModel.getInDto();
		//String end_date_=dto.getString("end_date");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		Dto dto_=Dtos.newDto();
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
//		String getDate;
//		String getendDate = null;
//		if(end_date_.isEmpty()){
//			//取一个5天前时间
//			 getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
//			 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
//		}else{
//			Date getD =AOSUtils.stringToDate(end_date_);
//			getDate=AOSUtils.date2String(AOSUtils.dateAdd(getD,Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
//		}
		dto_.put("getDate", week_begin_date);
		dto_.put("getend_date", week_end_date);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	
	public void changeCode(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		String proj_code=dto.getString("proj_code");
		Dto dto_=Dtos.newDto();
		dto_.put("proj_code", proj_code);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	
	
	/**
	 * 提交状态
	 */
	public void state_commit(HttpModel httpModel){
		Dto inDto=httpModel.getInDto();
		WeekPO weekPO= new WeekPO();
		weekPO.setCommit_time(AOSUtils.getDateTime());
		weekPO.setFlag(SystemCons.GRANT_TYPE.BIZ);
		weekPO.copyProperties(inDto);
		weekDao.updateByKey(weekPO);
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		 httpModel.setOutMsg(token.toString());
	}
	/**
	 * 修改提交状态
	 */
	public void state_update(HttpModel httpModel){
		Dto inDto=httpModel.getInDto();
		inDto.put("back_user_id", httpModel.getUserModel().getId());
		inDto.put("back_time", AOSUtils.getDateTime());
		sqlDao.update("com.bl3.pm.task.dao.WeStorageDao.state_update", inDto);
		final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		 httpModel.setOutMsg(token.toString());
	}
	/*
	 * 查询项目对应成员
	 * */
	public void listComboBoxProjId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> name = sqlDao.list("WeekReportDao.listComboBoxProjId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(name).toString());
	}
	/*
	 * 查询项目对应成员工期
	 * */
	public void work_hours(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> name = sqlDao.list("WeekReportDao.work_hours", inDto);
		httpModel.setOutMsg(AOSJson.toJson(name).toString());
	}
	
	public void listComboBoxProjName(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> name = sqlDao.list("WeekReportDao.listComboBoxProjName", inDto);
		httpModel.setOutMsg(AOSJson.toJson(name).toString());
	}
	/*
	 * 周报明细
	 * */
	public void listWeek(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> weekReport = sqlDao.list("WeekReportDao.listWeek", inDto);
		httpModel.setOutMsg(AOSJson.toJson(weekReport));
	}
	
	/*
	 * 周报明细
	 * */
	public void pageweek(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> weekReport = sqlDao.list("WeekReportDao.pageweek", inDto);
		httpModel.setOutMsg(AOSJson.toJson(weekReport));
	}
	
//	复制按钮
	public void copy(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		WeekReportPO weekReportPO=new WeekReportPO();
		weekReportPO.copyProperties(inDto);
		weekReportDao.copy(weekReportPO);
		httpModel.setOutMsg("复制成功");
	}
	
 }