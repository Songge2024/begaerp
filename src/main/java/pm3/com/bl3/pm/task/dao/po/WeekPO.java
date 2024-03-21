package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>ta_week[ta_week]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
public class WeekPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 周报ID
	 */
	private Integer week_id;
	
	/**
	 * 项目名称
	 */
	private String proj_name;
	
	/**
	 * 周报明细编码
	 */
	private String test_code;
	
	/**
	 * 开始时间
	 */
	private Date begin_date;
	
	/**
	 * 结束时间
	 */
	private Date end_date;
	
	/**
	 * 项目编码
	 */
	private String proj_id;
	
	/**
	 * 测试组长
	 */
	private String test_leader;
	
	/**
	 * 记录人
	 */
	private String add_name;
	
	/**
	 * 记录时间
	 */
	private Date create_time;
	/**
	 * 提交时间
	 */
	private Date commit_time;
	
	/**
	 * 意见
	 */
	private String opiniontion;
	/**
	 * 备注
	 */
	private String solve;
	/**
	 * 对外情况
	 */
	private String description;
	/**
	 * 是否有效
	 */
	private String flag;
	
	/**
	 * 周报类型
	 */
	private String type;
	
	/**
	 * 任务数量
	 */
	private String task_plan_num;
	
	/**
	 * 完成数量
	 */
	private String task_finish_num;
	
	/**
	 * 下周计划
	 */
	private String week_plan;
	/**
	 * 打回人
	 */
	private String back_user_id;
	public String getBack_user_id() {
		return back_user_id;
	}

	public void setBack_user_id(String back_user_id) {
		this.back_user_id = back_user_id;
	}

	public Date getBack_time() {
		return back_time;
	}

	public void setBack_time(Date back_time) {
		this.back_time = back_time;
	}

	/**
	 * 打回时间
	 */
	private Date back_time;
	

	/**
	 * 周报ID
	 * 
	 * @return week_id
	 */
	public Integer getWeek_id() {
		return week_id;
	}
	
	/**
	 * 项目名称
	 * 
	 * @return week_name
	 */
	public String getProj_name() {
		return proj_name;
	}
	
	/**
	 * 周报明细编码
	 * 
	 * @return test_code
	 */
	public String getTest_code() {
		return test_code;
	}
	
	/**
	 * 开始时间
	 * 
	 * @return begin_date
	 */
	public Date getBegin_date() {
		return begin_date;
	}
	
	/**
	 * 结束时间
	 * 
	 * @return end_date
	 */
	public Date getEnd_date() {
		return end_date;
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
	 * 测试组长
	 * 
	 * @return test_leader
	 */
	public String getTest_leader() {
		return test_leader;
	}
	
	/**
	 * 记录人
	 * 
	 * @return add_name
	 */
	public String getAdd_name() {
		return add_name;
	}
	
	/**
	 * 记录时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 备注
	 * 
	 * @return remarks
	 */
	public String getSolve() {
		return solve;
	}
	
	/**
	 * 是否有效
	 * 
	 * @return flag
	 */
	public String getFlag() {
		return flag;
	}
	
	/**
	 * 周报类型
	 * 
	 * @return type
	 */
	public String getType() {
		return type;
	}
	
	/**
	 * 任务数量
	 * 
	 * @return task_plan_num
	 */
	public String getTask_plan_num() {
		return task_plan_num;
	}
	
	/**
	 * 完成数量
	 * 
	 * @return task_finish_num
	 */
	public String getTask_finish_num() {
		return task_finish_num;
	}
	

	/**
	 * 周报ID
	 * 
	 * @param week_id
	 */
	public void setWeek_id(Integer week_id) {
		this.week_id = week_id;
	}
	
	/**
	 * 项目名称
	 * 
	 * @param week_name
	 */
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	
	/**
	 * 周报明细编码
	 * 
	 * @param test_code
	 */
	public void setTest_code(String test_code) {
		this.test_code = test_code;
	}
	
	/**
	 * 开始时间
	 * 
	 * @param begin_date
	 */
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	
	/**
	 * 结束时间
	 * 
	 * @param end_date
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
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
	 * 测试组长
	 * 
	 * @param test_leader
	 */
	public void setTest_leader(String test_leader) {
		this.test_leader = test_leader;
	}
	
	/**
	 * 记录人
	 * 
	 * @param add_name
	 */
	public void setAdd_name(String add_name) {
		this.add_name = add_name;
	}
	
	/**
	 * 记录时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 备注
	 * 
	 * @param remarks
	 */
	public void setSolve(String solve) {
		this.solve = solve;
	}
	
	/**
	 * 是否有效
	 * 
	 * @param flag
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	/**
	 * 周报类型
	 * 
	 * @param type
	 */
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 任务数量
	 * 
	 * @param task_plan_num
	 */
	public void setTask_plan_num(String task_plan_num) {
		this.task_plan_num = task_plan_num;
	}
	
	/**
	 * 完成数量
	 * 
	 * @param task_finish_num
	 */
	public void setTask_finish_num(String task_finish_num) {
		this.task_finish_num = task_finish_num;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCommit_time() {
		return commit_time;
	}

	public void setCommit_time(Date commit_time) {
		this.commit_time = commit_time;
	}

	public String getOpiniontion() {
		return opiniontion;
	}

	public void setOpiniontion(String opiniontion) {
		this.opiniontion = opiniontion;
	}

	public String getWeek_plan() {
		return week_plan;
	}

	public void setWeek_plan(String week_plan) {
		this.week_plan = week_plan;
	}
	

}