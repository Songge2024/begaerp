package com.bl3.pm.task.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
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

import com.bl3.pm.task.dao.WorkHoursDao;
import com.bl3.pm.task.dao.po.WorkHourPO;
import com.google.common.collect.Lists;

/**
 * <b>ta_work_hour[ta_work_hour]业务逻辑层</b>
 * 
 * @author zocl
 * @date 2018-05-03 14:27:05
 */
 @Service
 public class WorkHourService{
 	private static Logger logger = LoggerFactory.getLogger(WorkHourService.class);
 	@Autowired
	private WorkHoursDao workHourDao;
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
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String begin_date = dateString.substring(0, 8) + "01";
		String end_date = dateString.substring(0, 8) + day;
		httpModel.setAttribute("begin_date", begin_date);
		httpModel.setAttribute("end_date", end_date);
		httpModel.setViewPath("pm3/basic/workHours/workHour_layout.jsp");
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workHourPOs = sqlDao.list("WeeklyStorage.workHourslikecount", inDto);
	
		String min_date =inDto.getString("begin_date");
		String date_mouey=min_date.substring(0, 4);
		String date_mouey_=min_date.substring(5, 7);
		String date_mouey__=date_mouey+date_mouey_;
		String max_date= inDto.getString("end_date");
		String date="日期:"+min_date+"-"+max_date;
		Iterator<Dto>  it=workHourPOs.iterator();
		List<Dto> list=Lists.newArrayList();
		while (it.hasNext()){
			Dto  type = (Dto) it.next();
			int business_hours=type.getInteger("maneg_user");
			int work_hours=type.getInteger("user_s");
			int hours_count=work_hours+business_hours;
			type.put("hours_count", hours_count);
			type.put("date", date);
			list.add(type);
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto=Dtos.newDto();
	    
		String obj = (String)sqlDao.selectOne("WeeklyStorage.departmentManager", null);
		paramsDto.put("date",date);
		String obj_="部门经理:"+obj;
		paramsDto.put("obj",obj_);
		exporter.setData(paramsDto, list);
		exporter.setTemplatePath("/export/excel/workHours.xlsx");
        if(workHourPOs.size()==1 && AOSUtils.isNotEmpty(min_date)){
        	exporter.setFilename(date_mouey__+"月工时表("+workHourPOs.get(0).getString("project_for_short")+").xlsx");
		}else if(AOSUtils.isNotEmpty(min_date)){
				exporter.setFilename(date_mouey__+"月工时表.xlsx");
		}else{
			exporter.setFilename("工时表.xlsx");
		}
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listTreeUerid(HttpModel httpModel) {
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
		treeNode1.setIcon("go.gif");
		treeNode1.setLeaf(false);
		treeNode1.setExpanded(true);
		treeNode1.setA("0");
		treeNodes.add(treeNode1);
		//历史项目
		TreeNode treeNode2 = new TreeNode();
		treeNode2.setId("A2");
		treeNode2.setText("历史项目");
		treeNode2.setParentId("0000");
		treeNode2.setIcon("history.png");
		treeNode2.setLeaf(false);
		treeNode2.setExpanded(true);
		treeNode2.setA("0");
		treeNodes.add(treeNode2);
		
		inDto.put("userid", httpModel.getUserModel().getId());
		List<Dto> list = sqlDao.list("WeeklyStorage.querymy_project_tree", inDto);
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("PROJ_ID"));
			treeNode.setText(dto.getString("PROJ_NAME"));
			String state = dto.getString("STATE");
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
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		WorkHourPO workHourPO=new WorkHourPO();
		//workHourPO.setId(idService.nextValue("seq_ta_work_hour").intValue());
		workHourPO.copyProperties(inDto);
		workHourDao.insert(workHourPO);
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
		WorkHourPO workHourPO=new WorkHourPO();
		workHourPO.copyProperties(inDto);
		workHourDao.updateByKey(workHourPO);
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
		for (String id : selectionIds) {
			workHourDao.deleteByKey(Integer.valueOf(id));
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
		WorkHourPO workHourPO=workHourDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(workHourPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> workHourPOs = sqlDao.list("WeeklyStorage.workHourslikeOrPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(workHourPOs, inDto.getPageTotal()));
	}
 }