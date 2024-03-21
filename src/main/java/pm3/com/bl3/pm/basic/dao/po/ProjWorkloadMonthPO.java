package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>st_proj_workload_month[st_proj_workload_month]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zocl
 * @date 2018-05-26 21:01:53
 */
public class ProjWorkloadMonthPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 项目工作量月度统计ID
	 */
	private Integer st_work_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 年月（默认格式YYYYMM）
	 */
	private Integer month;
	
	/**
	 * 项目的总需求数量
	 */
	private Integer proj_demand_num;
	
	/**
	 * proj_task_num
	 */
	private Integer proj_task_num;
	
	/**
	 * 项目的缺陷数量
	 */
	private Integer proj_defect_num;
	
	/**
	 * 项目的工作量
	 */
	private String proj_plan_workload;
	
	/**
	 * proj_real_workload
	 */
	private String proj_real_workload;
	
	/**
	 * 生成人
	 */
	private Integer create_user_id;
	
	/**
	 * 生成时间
	 */
	private Date create_time;
	
	/**
	 * 更新人
	 */
	private Integer update_user_id;
	
	/**
	 * 更新时间
	 */
	private Date update_time;
	
	/**
	 * 状态，默认1有效，0无效
	 */
	private String state;
	

	/**
	 * 项目工作量月度统计ID
	 * 
	 * @return st_work_id
	 */
	public Integer getSt_work_id() {
		return st_work_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 年月（默认格式YYYYMM）
	 * 
	 * @return month
	 */
	public Integer getMonth() {
		return month;
	}
	
	/**
	 * 项目的总需求数量
	 * 
	 * @return proj_demand_num
	 */
	public Integer getProj_demand_num() {
		return proj_demand_num;
	}
	
	/**
	 * proj_task_num
	 * 
	 * @return proj_task_num
	 */
	public Integer getProj_task_num() {
		return proj_task_num;
	}
	
	/**
	 * 项目的缺陷数量
	 * 
	 * @return proj_defect_num
	 */
	public Integer getProj_defect_num() {
		return proj_defect_num;
	}
	
	/**
	 * 项目的工作量
	 * 
	 * @return proj_plan_workload
	 */
	public String getProj_plan_workload() {
		return proj_plan_workload;
	}
	
	/**
	 * proj_real_workload
	 * 
	 * @return proj_real_workload
	 */
	public String getProj_real_workload() {
		return proj_real_workload;
	}
	
	/**
	 * 生成人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 生成时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 更新人
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
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
	 * 状态，默认1有效，0无效
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 项目工作量月度统计ID
	 * 
	 * @param st_work_id
	 */
	public void setSt_work_id(Integer st_work_id) {
		this.st_work_id = st_work_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 年月（默认格式YYYYMM）
	 * 
	 * @param month
	 */
	public void setMonth(Integer month) {
		this.month = month;
	}
	
	/**
	 * 项目的总需求数量
	 * 
	 * @param proj_demand_num
	 */
	public void setProj_demand_num(Integer proj_demand_num) {
		this.proj_demand_num = proj_demand_num;
	}
	
	/**
	 * proj_task_num
	 * 
	 * @param proj_task_num
	 */
	public void setProj_task_num(Integer proj_task_num) {
		this.proj_task_num = proj_task_num;
	}
	
	/**
	 * 项目的缺陷数量
	 * 
	 * @param proj_defect_num
	 */
	public void setProj_defect_num(Integer proj_defect_num) {
		this.proj_defect_num = proj_defect_num;
	}
	
	/**
	 * 项目的工作量
	 * 
	 * @param proj_plan_workload
	 */
	public void setProj_plan_workload(String proj_plan_workload) {
		this.proj_plan_workload = proj_plan_workload;
	}
	
	/**
	 * proj_real_workload
	 * 
	 * @param proj_real_workload
	 */
	public void setProj_real_workload(String proj_real_workload) {
		this.proj_real_workload = proj_real_workload;
	}
	
	/**
	 * 生成人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 生成时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 更新人
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
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
	 * 状态，默认1有效，0无效
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}