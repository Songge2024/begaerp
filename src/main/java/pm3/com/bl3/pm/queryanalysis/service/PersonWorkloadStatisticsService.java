package com.bl3.pm.queryanalysis.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.queryanalysis.dao.PersonWorkloadStatisticsDao;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;
import aos.system.common.utils.SystemUtils;
import aos.system.dao.AosOrgDao;
import aos.system.dao.po.AosOrgPO;

@Service
public class PersonWorkloadStatisticsService {
	private static Logger logger = LoggerFactory.getLogger(PersonWorkloadStatisticsService.class);
	@Autowired
	private PersonWorkloadStatisticsDao personWorkloadStatisticsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
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
		Integer user_id = httpModel.getUserModel().getId();
        String principal_org_name = (String) sqlDao.selectOne("PersonWorkloadStatisticsDao.principalOrgName", user_id);
        httpModel.setAttribute("principal_org_name", principal_org_name);
        int principal_org_id = (int) sqlDao.selectOne("PersonWorkloadStatisticsDao.principalOrgID", user_id);
        httpModel.setAttribute("principal_org_id", principal_org_id);
		httpModel.setViewPath("pm3/queryanalysis/personWorkloadStatisticsList.jsp");
	}
	
	/**
	 * 全部导出
	 * @param httpModel
	 */
	public void exportALLExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String subordinate_departments_id = inDto.getString("subordinate_departments_id");
		if(AOSUtils.isNotEmpty(subordinate_departments_id)) {
			List<String> subordinate_departments_idList = Arrays.asList(subordinate_departments_id.split(","));
			inDto.put("subordinate_departments_id", subordinate_departments_idList);
		}
		List<Dto> dtos = sqlDao.list("PersonWorkloadStatisticsDao.exportALLExcel", inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "个人工作量汇总统计");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/personWorkloadStatistics.xlsx");
		exporter.setFilename("个人工作量汇总统计.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	/**
	 * 获取部门导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TreeNode> treeNodes = Lists.newArrayList();
		List<Dto> orgSelectBox = sqlDao.list("PersonWorkloadStatisticsDao.orgSelectBox", null);
		for (Dto dto : orgSelectBox) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getInteger("id").toString());
			treeNode.setText(dto.getString("name"));
			treeNode.setParentId(dto.getInteger("parent_id").toString());
			treeNode.setIcon(dto.getString("icon_name"));
			//这个决定是否在节点上初选复选框，true为初始选中
			treeNode.setChecked(false);
			treeNode.setLeaf(StringUtils.equals(dto.getString("is_leaf"), SystemCons.IS.YES) ? true : false );
			treeNode.setExpanded(StringUtils.equals(dto.getString("is_auto_expand"), SystemCons.IS.YES) ? true : false );
			treeNodes.add(treeNode);
		}
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
	
	/**
	 * 负责人部门下拉框
	 */
	public void listPrincipalOrg(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("PersonWorkloadStatisticsDao.listPrincipalOrg", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 个人工作量统计报表
	 * @since 2010-02-17
	 * @author HeYing
	 * @param httpModel
	 */
	public void personWorkloadReportListPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer login_user_id = httpModel.getUserModel().getId();
		inDto.put("login_user_id", login_user_id);
		String subordinate_departments_id = inDto.getString("subordinate_departments_id");
		if(AOSUtils.isNotEmpty(subordinate_departments_id)) {
			List<String> subordinate_departments_idList = Arrays.asList(subordinate_departments_id.split(","));
			inDto.put("subordinate_departments_id", subordinate_departments_idList);
		}
		List<Dto> personWorkloadReportList = sqlDao.list("PersonWorkloadStatisticsDao.personWorkloadReportListPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList));
	}
	
	/**
	 * 工作量总数
	 * 
	 * @param httpModel
	 */
	public void queryPersonWorkloadReportSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String subordinate_departments_id = inDto.getString("subordinate_departments_id");
		if(AOSUtils.isNotEmpty(subordinate_departments_id)) {
			List<String> subordinate_departments_idList = Arrays.asList(subordinate_departments_id.split(","));
			inDto.put("subordinate_departments_id", subordinate_departments_idList);
		}
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Dto outDto = sqlDao.selectDto("PersonWorkloadStatisticsDao.personWorkloadReportSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 任务工作量总数
	 * 
	 * @param httpModel
	 */
	public void queryTaskWorkloadReportSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Dto outDto = sqlDao.selectDto("PersonWorkloadStatisticsDao.taskWorkloadReportSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 缺陷工作量总数
	 * 
	 * @param httpModel
	 */
	public void queryBugWorkloadReportSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Dto outDto = sqlDao.selectDto("PersonWorkloadStatisticsDao.bugWorkloadReportSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 会议工作量总数
	 * 
	 * @param httpModel
	 */
	public void queryManageWorkloadReportSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		inDto.put("user_id", user_id);
		Dto outDto = sqlDao.selectDto("PersonWorkloadStatisticsDao.manageWorkloadReportSummary", inDto);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 分页查询
	 *个人任务
	 * @param httpModel
	 */
	public void taskPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("PersonWorkloadStatisticsDao.taskPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 *个人缺陷
	 * @param httpModel
	 */
	public void bugPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("PersonWorkloadStatisticsDao.bugPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 个人会议
	 */
	public void managePage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> personWorkloadReportList = sqlDao.list("PersonWorkloadStatisticsDao.managePage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(personWorkloadReportList, inDto.getPageTotal()));
	}
}
