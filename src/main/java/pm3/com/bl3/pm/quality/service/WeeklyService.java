package com.bl3.pm.quality.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.bl3.pm.quality.dao.QaStorageDao;
import com.bl3.pm.quality.dao.WeeklyDao;
import com.bl3.pm.quality.dao.WeeklyDetailDao;
import com.bl3.pm.quality.dao.po.WeeklyPO;
import com.bl3.pm.report.DataToJson;
/**
 * <b>qa_test_weekly[qa_test_weekly]业务逻辑层</b>
 * 
 * @author Z
 * @date 2017-12-11 10:26:55
 */
 @Service
 public class WeeklyService{
 	@Autowired
	private WeeklyDao weeklyDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private QaStorageDao qaStorageDao;
	@Autowired
	private WeeklyDetailDao weeklyDetailDao;
	
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/quality/weekly.jsp");
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
		WeeklyPO WeeklyPO=new WeeklyPO();
		WeeklyPO.copyProperties(inDto);
		weeklyDao.updateByKey(WeeklyPO);
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
		String[] test_code_=inDto.getRows("test_code");
		for (String test_code : test_code_){
			qaStorageDao.deleteTc(test_code);
	    };
		for (String id : selectionIds) {
			weeklyDao.deleteByKey(Integer.valueOf(id));
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
		WeeklyPO WeeklyPO=weeklyDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(WeeklyPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<WeeklyPO> WeeklyPOs = qaStorageDao.likedetailOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(WeeklyPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 删除账户信息
	 * 
	 * @param httpModel
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		weeklyDao.deleteByKey(inDto.getInteger("test_id"));
		httpModel.setOutMsg("账户信息删除成功");
	}
	/**
	 * list转json
	 * @return字符串json
	 */
	public  String JsontoSql(Dto dto){
		//周报主表
		List<Dto> list=sqlDao.list("WeeklyStorage.selectQaWeekly", dto);
		//周报明细
		List<Dto> lists=sqlDao.list("WeeklyStorage.selectQaWeeklyDetail", dto);
		List<Dto> list_i=new ArrayList<Dto>();
		Iterator<Dto> it=lists.iterator();
	    while (it.hasNext()) {
			Dto i = (Dto) it.next();
			StringBuilder sb=new StringBuilder();
			sb.append("缺陷总关闭数:(");
			sb.append(i.getString("bug_close_num")+")");
			sb.append("\n");
			sb.append("缺陷未解决数:(");
			sb.append(i.getString("bug_unfinish_num")+")");
			sb.append("\n");
			sb.append("缺陷已解决总数:(");
			sb.append(i.getString("bug_finish_num")+")");
			sb.append("\n");
			sb.append("本周关闭缺陷数:(");
			sb.append(i.getString("lately_close_num")+")");
			sb.append("\n");
			sb.append("本周新增缺陷数:(");
			sb.append(i.getString("bug_add_num")+")");
			sb.append("\n");
			sb.append("缺陷总数:(");
			sb.append(i.getString("bug_input_num")+")");
			String s=sb.toString();
			i.put("bug_count", s);
			list_i.add(i);
		}
		StringBuilder sb=new StringBuilder();
		String lists_= AOSJson.toJson(list_i);
		String list_= AOSJson.toJson(list);
		Dto putDto=Dtos.newDto();
		putDto.put("bug_count", "bug_count");
		list.add(putDto);
		sb.append("{");
		sb.append("\"Detail\":");
		sb.append(lists_);
		sb.append(",");
		sb.append("\"Master\":");
		sb.append(list_);
		sb.append("}");
		return sb.toString();
	}
	/**
	 * 打印报表数据
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	public void genNodeXmlData(HttpModel httpModel) throws Exception {
		HttpServletResponse response=httpModel.getResponse();
		HttpServletRequest request=httpModel.getRequest();
		Dto pDto=httpModel.getInDto();
		request.setCharacterEncoding("utf-8");
		//获取前端传的参数
		String test_code=httpModel.getInDto().getString("reportDate");
		response.resetBuffer();
		//避免预览时显示乱码
		response.setCharacterEncoding("UTF-8");
	    //周报主表
		List<Dto> list=sqlDao.list("WeeklyStorage.selectQaWeekly",test_code);
		//周报明细
		List<Dto> lists=sqlDao.list("WeeklyStorage.selectQaWeeklyDetail", test_code);
		List<Dto> list_i=new ArrayList<Dto>();
		Iterator<Dto> it=lists.iterator();
		while (it.hasNext()) {
				Dto i = (Dto) it.next();
				StringBuilder sb=new StringBuilder();
				sb.append("缺陷总关闭数:(");
				sb.append(i.getString("bug_close_num")+")");
				sb.append("\n");
				sb.append("缺陷未解决数:(");
				sb.append(i.getString("bug_unfinish_num")+")");
				sb.append("\n");
				sb.append("缺陷已解决总数:(");
				sb.append(i.getString("bug_finish_num")+")");
				sb.append("\n");
				sb.append("本周关闭缺陷数:(");
				sb.append(i.getString("lately_close_num")+")");
				sb.append("\n");
				sb.append("本周新增缺陷数:(");
				sb.append(i.getString("bug_add_num")+")");
				sb.append("\n");
				sb.append("缺陷总数:(");
				sb.append(i.getString("bug_input_num")+")");
				String s=sb.toString();
				i.put("bug_count", s);
				list_i.add(i);
		}
		    //调用数据转换接口
		    DataToJson dataToJson  = new DataToJson();
		    //传入参数，返回数据 ,如果不需要传入list
			String str=dataToJson.reportData(lists, list);
		try {
				PrintWriter pw = response.getWriter();
				pw.print(str.toString());
				pw.close(); // 终止后续不必要内容输出
				
		} catch (Exception e) {
			PrintWriter pw = response.getWriter();
			pw.print(e.toString());
		}
	}
	/**
	 * 调用插件
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	public void listDetailReprot(HttpModel httpModel) throws Exception {
		httpModel.getRequest().setCharacterEncoding("utf-8");
		httpModel.getResponse().resetBuffer();
		//避免预览时显示乱码
		httpModel.getResponse().setCharacterEncoding("UTF-8");
		Dto pDto = httpModel.getInDto();
		String test_code=pDto.getString("test_code");
		String report;
		String data;
		//调用模板
		report = httpModel.getRequest().getContextPath()+"/gridreport/grf/weekly/testweekly.grf";
		//添加数据请求路径
		data = "do.jhtml?router=weeklyService.genNodeXmlData&juid="+httpModel.getUserModel().getJuid()+"&reportDate="+test_code;
		httpModel.setAttribute("report", report);
		httpModel.setAttribute("data", data);
		httpModel.setAttribute("juid", httpModel.getUserModel().getJuid());
		httpModel.setViewPath("pm3/gridreport/data/listReport.jsp");
	}
 }