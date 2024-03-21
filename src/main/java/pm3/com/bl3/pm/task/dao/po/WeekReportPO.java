package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>ta_week_report[ta_week_report]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
public class WeekReportPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 周报ID
	 */
	private Integer id;
	
	/**
	 * 周报编码
	 */
	private String test_code;
	
	/**
	 * 任务描述
	 */
	private String remarks;
	
	/**
	 * 责任人id
	 */
	private String owner_id;
	/**
	 * 责任人id
	 */
	private String owner_name;
	
	/**
	 * 计划开始时间
	 */
	private Date begin_date;
	
	/**
	 * 计划结束时间
	 */
	private Date end_date;
	
	/**
	 * 实际完成实际
	 */
	private Date finish_time;
	
	/**
	 * 完成情况
	 */
	private String finish_cond;
	/**
	 * 周报任务类型
	 */
	private String week_class;
	
	/**
	 * 任务偏差分析及解决措施
	 */
	private String descc;
	
	/**
	 * 项目编码
	 */
	private String proj_id;
	
	/**
	 * 周报名称
	 */
	private String week_name;
	
	/**
	 * 周报状态
	 */
	private String state;
	
	/**
	 * 项目周
	 */
	private String task_plan_num;
	
	/**
	 * 更新时间
	 */
	private Date update_time;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 目前情况说明
	 */
	private String solve;

	/**
	 * 对外情况说明
	 */
	private String description;

	/**
	 * 项目名称 proj_name
	 */
	private String proj_name;
	/**
	 * 工作计划类型
	 */
	private String work_plan_type;
	/**
	 * 区分本周和下周数据
	 */
	private String week_flag;

	public String getWork_plan_type() {
		return work_plan_type;
	}

	public void setWork_plan_type(String work_plan_type) {
		this.work_plan_type = work_plan_type;
	}

	public String getWeek_flag() {
		return week_flag;
	}

	public void setWeek_flag(String week_flag) {
		this.week_flag = week_flag;
	}

	/**
	 * 周报ID
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 周报编码
	 * 
	 * @return test_code
	 */
	public String getTest_code() {
		return test_code;
	}
	
	/**
	 * 任务描述
	 * 
	 * @return remark
	 */
	public String getRemarks() {
		return remarks;
	}
	
	/**
	 * 责任人
	 * 
	 * @return owner_id
	 */
	public String getOwner_id() {
		return owner_id;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @return begin_date
	 */
	public Date getBegin_date() {
		return begin_date;
	}
	
	/**
	 * 计划结束时间
	 * 
	 * @return end_date
	 */
	public Date getEnd_date() {
		return end_date;
	}
	
	/**
	 * 实际完成实际
	 * 
	 * @return finish_time
	 */
	public Date getFinish_time() {
		return finish_time;
	}
	
	/**
	 * 完成情况
	 * 
	 * @return finish_cond
	 */
	public String getFinish_cond() {
		return finish_cond;
	}
	
	/**
	 * 任务偏差分析及解决措施
	 * 
	 * @return descc
	 */
	public String getDescc() {
		return descc;
	}
	
	/**
	 * 项目编码
	 * 
	 * @return proj_code
	 */
	public String getProj_id() {
		return proj_id;
	}
	
	/**
	 * 周报名称
	 * 
	 * @return name
	 */
	public String getWeek_name() {
		return week_name;
	}
	
	/**
	 * 周报状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 项目周
	 * 
	 * @return update_user_id
	 */
	public String getTask_plan_num() {
		return task_plan_num;
	}
	
	/**
	 * 更新时间
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 创建时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 创建人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 目前情况说明
	 * 
	 * @return desc
	 */
	public String getSolve() {
		return solve;
	}
	

	/**
	 * 周报ID
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 周报编码
	 * 
	 * @param test_code
	 */
	public void setTest_code(String test_code) {
		this.test_code = test_code;
	}
	
	/**
	 * 任务描述
	 * 
	 * @param remark
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	/**
	 * 责任人
	 * 
	 * @param owner_id
	 */
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @param begin_date
	 */
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	
	/**
	 * 计划结束时间
	 * 
	 * @param end_date
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	/**
	 * 实际完成实际
	 * 
	 * @param finish_time
	 */
	public void setFinish_time(Date finish_time) {
		this.finish_time = finish_time;
	}
	
	/**
	 * 完成情况
	 * 
	 * @param finish_cond
	 */
	public void setFinish_cond(String finish_cond) {
		this.finish_cond = finish_cond;
	}
	
	/**
	 * 任务偏差分析及解决措施
	 * 
	 * @param solve
	 */
	public void setDescc(String descc) {
		this.descc = descc;
	}
	
	/**
	 * 项目编码
	 * 
	 * @param proj_code
	 */
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 周报名称
	 * 
	 * @param name
	 */
	public void setWeek_name(String week_name) {
		this.week_name = week_name;
	}
	
	/**
	 * 周报状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 更新人
	 * 
	 * @param update_user_id
	 */
	public void setTask_plan_num(String task_plan_num) {
		this.task_plan_num = task_plan_num;
	}
	
	/**
	 * 更新时间
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 创建时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 创建人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 目前情况说明
	 * 
	 * @param desc
	 */
	public void setSolve(String solve) {
		this.solve = solve;
	}

	public String getProj_name() {
		return proj_name;
	}

	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOwner_name() {
		return owner_name;
	}

	public void setOwner_name(String owner_name) {
		this.owner_name = owner_name;
	}

	public String getWeek_class() {
		return week_class;
	}

	public void setWeek_class(String week_class) {
		this.week_class = week_class;
	}
	

}