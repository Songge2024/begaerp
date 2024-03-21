package com.bl3.pm.quality.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.system.dao.DemoAccountDao;
import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.quality.dao.QaStorageDao;
import com.bl3.pm.quality.dao.WeeklyDao;
import com.bl3.pm.quality.dao.WeeklyDetailDao;
import com.bl3.pm.quality.dao.po.WeeklyDetailPO;
import com.bl3.pm.quality.dao.po.WeeklyPO;
/**
 * <b>qa_test_weekly[qa_test_weekly]业务逻辑层</b>
 * 
 * @author Z
 * @date 2017-12-11 10:26:55
 */
 @Service
 public class WeeklyDetailService{
 	@Autowired
	private WeeklyDetailDao weeklyDetailDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private QaStorageDao qaStorageDao;
	@Autowired
	private WeeklyDao weeklyDao;
	@Autowired
	private DemoAccountDao demoAccountDao;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/quality/weeklyDetail.jsp");
	}
	
	/**
	 * 导出明细 Excel_DIY
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void exportWeeklyExcel_d(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String  test_code=inDto.getString("test_code");
		if (AOSUtils.isEmpty(test_code)){
			return;
		}
		Dto paramsDto=Dtos.newDto();
		List<Dto> allLists = new ArrayList<Dto>();
		String begin_date_="";
		String end_date_="";
			List<Dto> list = sqlDao.list("WeeklyStorage.getWeeklyTextCodedaile", Dtos.newDto("test_code", test_code));
			int money=Integer.valueOf(AOSUtils.getDateStr("MM"));
			Iterator<Dto> it=list.iterator();
			while(it.hasNext()){
				Dto i=it.next();
				StringBuilder sb=new StringBuilder();
				sb.append("=\"");
				sb.append("缺陷总关闭数:(");
				sb.append(i.getString("bug_close_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷未解决数:(");
				sb.append(i.getString("bug_unfinish_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷已解决总数:(");
				sb.append(i.getString("bug_finish_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("本周关闭缺陷数:(");
				sb.append(i.getString("lately_close_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("本周新增缺陷数:(");
				sb.append(i.getString("bug_add_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷总数:(");
				sb.append(i.getString("bug_input_num")+")\"");
				String s=sb.toString();
				String proj_name=i.getString("proj_name");
				String job_content=i.getString("job_content");
				String accept_cond=i.getString("accept_cond");
				String finish_cond=i.getString("finish_cond");
				String remark=i.getString("remark");
		        i.put("proj_name", proj_name);
		        i.put("bug_count", s);
		        i.put("job_content", job_content);
		        i.put("accept_cond", accept_cond);;
		        i.put("finish_cond", finish_cond);
		        i.put("remark", remark);
		        allLists.add(i);
		        begin_date_= AOSUtils.date2String(i.getDate("begin_date"),"yyyy年MM月dd日 ");
		        end_date_= AOSUtils.date2String(i.getDate("end_date"),"yyyy年MM月dd日 ");
			}
			paramsDto.put("reportTitle", "项目测试周报");
			paramsDto.put("datalast", begin_date_+"-"+end_date_);
			paramsDto.put("editWeeklydate", AOSUtils.getDateStr("yyyy/MM/dd"));
			paramsDto.put("editWeeklyname", httpModel.getUserModel().getName());
			paramsDto.put("reportTitle", "项目测试周报");
			paramsDto.put("tab_name", "测试周报");
			ExcelExporter exporter=new ExcelExporter();
			exporter.setData(paramsDto, allLists);
			exporter.setTemplatePath("/export/excel/testWeekly.xls");
			exporter. setFilename("项目测试周报.xls");
			try {
				exporter.export(httpModel.getRequest(), httpModel.getResponse());
			} catch (IOException e) {
				throw new AOSException("导出失败："+e.getMessage());
			}
	}

	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void exportWeeklyExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String  weeklyId=inDto.getString("weeklyId");
		String[] weeklyId_ =weeklyId.split(",");
		if (AOSUtils.isEmpty(weeklyId)){
			return;
		}
		List paramsDtos= new ArrayList(); 
		int getDay=1;
		List<List> allLists = new ArrayList();
		String begin_date_="";
		String end_date_="";
		int n=0;   
		for(String weekly_id : weeklyId_ ){
			Dto paramsDto=Dtos.newDto();
			List<Dto> allList = new ArrayList<Dto>();
			List<Dto> list = sqlDao.list("WeeklyStorage.getWeeklyTestCode", Dtos.newDto("weekly_id", weekly_id));
			int money=Integer.valueOf(AOSUtils.getDateStr("MM"));
			Iterator<Dto> it=list.iterator();
			while(it.hasNext()){
				Dto i=it.next();
				StringBuilder sb=new StringBuilder();
				sb.append("=\"");
				sb.append("缺陷总关闭数:(");
				sb.append(i.getString("bug_close_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷未解决数:(");
				sb.append(i.getString("bug_unfinish_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷已解决总数:(");
				sb.append(i.getString("bug_finish_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("本周关闭缺陷数:(");
				sb.append(i.getString("lately_close_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("本周新增缺陷数:(");
				sb.append(i.getString("bug_add_num")+")");
				sb.append("\"&CHAR(10)&\"");
				sb.append("缺陷总数:(");
				sb.append(i.getString("bug_input_num")+")\"");
				String s=sb.toString();
				
				//取年份和月份减去当前日。获取到一个总天数，用总天数除以7获取到一个周，如果不能整除则进位。
				int getDateDay=AOSUtils.getDaysInMonth(Integer.valueOf(AOSUtils.getDateStr("yyyy")),money);
				int getDateDay_=getDateDay-Integer.valueOf(AOSUtils.getDateStr("dd"));
				float _getDateDay__=Math.round(getDateDay_/7);
				String str=String.valueOf(_getDateDay__);
				String str_=str.substring(0, 1);
				String str__=str.substring(2,3);
				if(Integer.valueOf(str__)>0){
					getDay=Integer.valueOf(str_)+1;
				}else if(Integer.valueOf(str__)==0){
					getDay=Integer.valueOf(str_);
				}
				String proj_name=i.getString("proj_name");
				String job_content=i.getString("job_content");
				String accept_cond=i.getString("accept_cond");
				String finish_cond=i.getString("finish_cond");
				String remark=i.getString("remark");
		        i.put("proj_name", proj_name);
		        i.put("bug_count", s);
		        i.put("job_content", job_content);
		        i.put("accept_cond", accept_cond);;
		        i.put("finish_cond", finish_cond);
		        i.put("remark", remark);
		        allList.add(i);
		        allLists.add(allList);
		        begin_date_= AOSUtils.date2String(i.getDate("begin_date"),"yyyy年MM月dd日 ");
		        end_date_= AOSUtils.date2String(i.getDate("end_date"),"yyyy年MM月dd日 ");
			}
			paramsDto.put("reportTitle", "项目测试周报");
			paramsDto.put("datalast", begin_date_+"-"+end_date_);
			
			paramsDto.put("editWeeklydate", AOSUtils.getDateStr("yyyy/MM/dd"));
			paramsDto.put("editWeeklyname", httpModel.getUserModel().getName());
			paramsDto.put("reportTitle", "项目测试周报");
			n++;
			paramsDto.put("tab_name", "第"+n+"周");
			paramsDtos.add(paramsDto);
		}   
			ExcelExporter exporter=new ExcelExporter();
			exporter.setData(paramsDtos, allLists);
			exporter.setTemplatePath("/export/excel/testWeekly.xls");
			exporter. setFilename("项目测试周报.xls");
			try {
				exporter.export_tab(httpModel.getRequest(), httpModel.getResponse());
			} catch (IOException e) {
				throw new AOSException("导出失败："+e.getMessage());
			}
	}
	/**
	 * 新增数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void createData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//查询数据DTO
		Dto setDto=Dtos.newDto();
		//传入后台的DTO
		//Dto errStrDto=Dtos.newDto();
		//获取前端数据查询传入参数
		String test_code_=inDto.getString("test_code");
		String beginDate_=AOSUtils.date2String(inDto.getDate("begin_date"),"yyyy-MM-dd") ;
		String endDate_=AOSUtils.date2String(inDto.getDate("end_date"),"yyyy-MM-dd");
		Dto pDto=Dtos.newDto();
		//查询评审主题
		pDto.put("end_date", endDate_);
		pDto.put("begin_date",beginDate_ );
		List<Dto> listFiles=sqlDao.list("WeeklyStorage.getFilesId", pDto);
		StringBuilder sb=new StringBuilder();
		Iterator<Dto> getF=listFiles.iterator();
		int num=1;
		while (getF.hasNext()) {
			sb.append(num+".");
			Dto dto = (Dto) getF.next();
			sb.append(dto.getString("theme"));
		};
		//项目编码
		setDto.put("beginDate_",beginDate_);
		setDto.put("endDate_",endDate_);
		String _name =httpModel.getUserModel().getName(); 
		
		//遍历取值
		List<Dto> bugCount_=qaStorageDao.bugConut(setDto);
		Iterator<Dto> iterator = bugCount_.iterator();
		while(iterator.hasNext())
		 {
		 Dto i = (Dto) iterator.next();
		 i.put("test_code", test_code_);
		String testexample= i.getString("testexample");
		String example= i.getString("example");
		String jobsubStr="";
		if(AOSUtils.isNotEmpty(testexample) && AOSUtils.isNotEmpty(example)){
			 jobsubStr=testexample+"<br>"+example;
		  }else
		  {
			  jobsubStr=testexample;
		  }
		 i.put("add_time", AOSUtils.getDateTime());
		 i.put("jobsubStr", jobsubStr);
		 i.put("add_name", _name);
		 i.put("detail", 1);
		 i.put("getFilesTheme", sb);
         //序列号缺省
		}
	httpModel.setOutMsg(AOSJson.toGridJson(bugCount_));
	}
	/**
	 * 保存数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void saveData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String test_code_=inDto.getString("test_code");
		String _name =httpModel.getUserModel().getName();
		Date credate_=AOSUtils.getDateTime();
		List<Dto> list=inDto.getRows();
		for(Dto dto : list){
			//类型转换
			isEmptyData(dto,"input_cond");
			isEmptyData(dto,"bug_input_num");
			isEmptyData(dto,"bug_unfinish_num");
			isEmptyData(dto,"bug_finish_num");
			isEmptyData(dto,"bug_close_num");
			isEmptyData(dto,"bug_add_num");
			isEmptyData(dto,"lately_close_num");
			dto.put("test_code", test_code_);
			dto.put("add_time",credate_ );
			dto.put("add_name", _name);
			dto.put("update_time", credate_);
			dto.put("update_name", _name);
			qaStorageDao.insertWd(dto);
		}
		//周报主表
		String 	begin_date_=inDto.getString("begin_date");
	    String end_date_=inDto.getString("end_date");
		String remarks_w_=inDto.getString("remarks_w");
		
		
		if( qaStorageDao.weeklyCount(test_code_)>0){
			Dto rDto=Dtos.newDto();
			rDto.put("remarks", remarks_w_);
			rDto.put("test_code", test_code_);
			sqlDao.update("WeeklyStorage.upWeekRemarks", rDto);
			return;
		};
		WeeklyPO weeklyPO=new WeeklyPO();
		//查询测试组长
		String groupL=(String)sqlDao.selectOne("WeeklyStorage.testGrouplaSel", null);
		weeklyPO.setTest_leader(groupL);
		weeklyPO.setAdd_name(_name);
		weeklyPO.setBegin_date(AOSUtils.stringToDate(begin_date_));
		//从新建的DAO.XML文件中取一条数据
		weeklyPO.setTest_code(test_code_);
		weeklyPO.setCreate_time(AOSUtils.getDateTime());
		weeklyPO.setEnd_date(AOSUtils.stringToDate(end_date_));
		//ADMIN=2
		weeklyPO.setFlag(SystemCons.GRANT_TYPE.BIZ);
		weeklyPO.setRemarks(remarks_w_);
		weeklyDao.insert(weeklyPO);
		httpModel.setOutMsg("保存成功");
	}
	
	/**
	 * 封装一个判断方法，判断数据是否空的方法
	 */
	public  void isEmptyData( Dto dtos,String getValues_){
		if( AOSUtils.isEmpty(dtos.getInteger(getValues_))){ 
			    dtos.put(getValues_, 0);
			}else
			 {  int input_cond= dtos.getInteger(getValues_);
			    dtos.put(getValues_, input_cond);
			}
	}
	/**
	 * 提交状态
	 */
	public void state_commit(HttpModel httpModel){
		Dto inDto=httpModel.getInDto();
		String[] id= inDto.getRows();
		for(String id_ : id){
		WeeklyPO weeklyPO= new WeeklyPO();
		weeklyPO.setWeekly_id(Integer.valueOf(id_));
		weeklyPO.setFlag(SystemCons.GRANT_TYPE.ADMIN);
		weeklyDao.updateByKey(weeklyPO);
		}
		httpModel.setOutMsg("提交成功.");
	}
	/**
	 * 作废
	 */
	public  void delWeekly(HttpModel httpModel){
	  Dto dto=httpModel.getInDto();
	  String test_code_=dto.getString("test_code");
	  qaStorageDao.weeklyDel(test_code_);
	  qaStorageDao.weeklyDeDel(test_code_);
	  httpModel.setOutMsg("数据已作废.");
	}
	/**
	 * 跳转明细
	 */
	public void actionTab(HttpModel httpModel){
		Dto inDto=Dtos.newDto();
		String getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		inDto.put("test_code"  ,new FilesManageService().dateToStamp("qw"));
		inDto.put("getendDate", getendDate);
		httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	
	/**
	 * 双击跳转明细
	 */
	public void actionTabDb(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		Dto intDto=Dtos.newDto();
		intDto.put("test_code", dto.getString("test_code"));
		intDto.put("end_date", AOSUtils.date2String(dto.getDate("end_date"), "yyyy-MM-dd"));
		intDto.put("remarks", dto.getString("remarks"));
		intDto.put("flag", dto.getString("flag"));  
		httpModel.setOutMsg(AOSJson.toJson(intDto));
	}
	/**
	 * 查询项目数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getProjt(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> accountPOs = qaStorageDao.getProjtPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(accountPOs, inDto.getPageTotal()));
	}
	/**
		* 新增
		* 
		* @param httpModel
		* @return
	*/
	public void main_Weekly(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
			String _name =httpModel.getUserModel().getName();
			WeeklyPO weeklyPO=new WeeklyPO();
			//获取一个datetime 格式的时间
			weeklyPO.setCreate_time(AOSUtils.getDateTime());
			//设置一个自定义的字符串
			weeklyPO.setTest_leader("xxxx");
			weeklyPO.setAdd_name(_name);
			//取一个5天前时间
			String getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
			//字符串格式的日期转date   ....stringToDate
			weeklyPO.setEnd_date(AOSUtils.stringToDate(AOSUtils.getDateStr("yyyy-MM-dd")));
			weeklyPO.setBegin_date(AOSUtils.stringToDate(getDate));
			//从新建的DAO.XML文件中取一条数据

			String _test_code_ =inDto.getString("text_code");
			weeklyPO.setTest_code(_test_code_);
			weeklyPO.copyProperties(inDto);
			weeklyDao.insert(weeklyPO);
		}
	/**
	 * 获取明细时间
	 */
	public void getwkdDate(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		String end_date_=dto.getString("end_date");
		Dto dto_=Dtos.newDto();
		String getDate;
		String getendDate = null;
		if(end_date_.isEmpty()){
			//取一个5天前时间
			 getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
			 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		}else{
			Date getD =AOSUtils.stringToDate(end_date_);
			getDate=AOSUtils.date2String(AOSUtils.dateAdd(getD,Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
		}
		 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		dto_.put("getendDate", getendDate);
		dto_.put("getDate", getDate);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	
	
	
	/**
	 * 获取 主表改变后的时间
	 */
	public void changeweekDate(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		String end_date_=dto.getString("end_date");
		Dto dto_=Dtos.newDto();
		String getDate;
		String getendDate = null;
		if(end_date_.isEmpty()){
			//取一个5天前时间
			 getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-30),"yyyy-MM-dd");
			 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		}else{
			Date getD =AOSUtils.stringToDate(end_date_);
			getDate=AOSUtils.date2String(AOSUtils.dateAdd(getD,Calendar.DAY_OF_MONTH,-30),"yyyy-MM-dd");
		}
		dto_.put("getDate", getDate);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	/**
	 * 获取 主表改变后的时间
	 */
	public void changeweekDates(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		String end_date_=dto.getString("end_date");
		Dto dto_=Dtos.newDto();
		String getDate;
		String getendDate = null;
		if(end_date_.isEmpty()){
			//取一个5天前时间
			 getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-30),"yyyy-MM-dd");
			 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		}else{
			Date getD =AOSUtils.stringToDate(end_date_);
			getDate=AOSUtils.date2String(AOSUtils.dateAdd(getD,Calendar.DAY_OF_MONTH,-7),"yyyy-MM-dd");
		}
		dto_.put("getDate", getDate);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	/**
	 * 获取改编变后的时间
	 */
	public void changeDate(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		String end_date_=dto.getString("end_date");
		Dto dto_=Dtos.newDto();
		String getDate;
		String getendDate = null;
		if(end_date_.isEmpty()){
			//取一个5天前时间
			 getDate=AOSUtils.date2String(AOSUtils.dateAdd(AOSUtils.getDate(),Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
			 getendDate=AOSUtils.getDateTimeStr("yyyy-MM-dd");
		}else{
			Date getD =AOSUtils.stringToDate(end_date_);
			getDate=AOSUtils.date2String(AOSUtils.dateAdd(getD,Calendar.DAY_OF_MONTH,-5),"yyyy-MM-dd");
		}
		dto_.put("getDate", getDate);
		httpModel.setOutMsg(AOSJson.toJson(dto_));
	}
	
	
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Date update_time_=AOSUtils.getDateTime();
		String name_=httpModel.getUserModel().getName();
		inDto.put("update_time", update_time_);
		inDto.put("update_name", name_);
		WeeklyDetailPO WeeklyDetailPO=new WeeklyDetailPO();
		WeeklyDetailPO.copyProperties(inDto);
		weeklyDetailDao.updateByKey(WeeklyDetailPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void alldelete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			if (AOSUtils.isNotEmpty(id)){
			weeklyDetailDao.deleteByKey(Integer.valueOf(id));
			  }else
			{return;}
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
		WeeklyDetailPO WeeklyDetailPO=weeklyDetailDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(WeeklyDetailPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<WeeklyDetailPO> WeeklyDetailPOs = qaStorageDao.likeweekOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(WeeklyDetailPOs, inDto.getPageTotal()));
	}
	/**
	 * 删除账户信息
	 * 
	 * @param httpModel
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		weeklyDetailDao.deleteByKey(inDto.getInteger("test_id"));
		httpModel.setOutMsg("账户信息删除成功");
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void getPoj(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto>  getProjN= qaStorageDao.getProjN();
		httpModel.setOutMsg(AOSJson.toGridJson(getProjN, inDto.getPageTotal()));
	}
 }