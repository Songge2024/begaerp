package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>st_proj_workload_user_month[st_proj_workload_user_month]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zocl
 * @date 2018-05-26 22:48:54
 */
public class ProjWorkloadUserMonthPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 项目工作量人员月度统计ID
	 */
	private Integer st_work_user_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * user_id
	 */
	private Integer user_id;
	
	/**
	 * 年月（默认格式YYYYMM）
	 */
	private Integer month;
	
	/**
	 * 需求数量
	 */
	private Integer demand_num;
	
	/**
	 * 总需求数量
	 */
	private Integer demand_total_num;
	
	/**
	 * 任务数量
	 */
	private Integer task_num;
	
	/**
	 * 总任务数量
	 */
	private Integer task_total_num;
	
	/**
	 * 缺陷数量
	 */
	private Integer defect_num;
	
	/**
	 * 总缺陷数量
	 */
	private Integer defect_total_num;
	
	/**
	 * 项目的计划工作量
	 */
	private String plan_workload;
	
	/**
	 * 实际工作量
	 */
	private String real_workload;
	
	/**
	 * 总计划工作量
	 */
	private String total_plan_workload;
	
	/**
	 * 总实际工作量
	 */
	private String total_real_workload;
	
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
	 * 项目工作量人员月度统计ID
	 * 
	 * @return st_work_user_id
	 */
	public Integer getSt_work_user_id() {
		return st_work_user_id;
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
	 * user_id
	 * 
	 * @return user_id
	 */
	public Integer getUser_id() {
		return user_id;
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
	 * 需求数量
	 * 
	 * @return demand_num
	 */
	public Integer getDemand_num() {
		return demand_num;
	}
	
	/**
	 * 总需求数量
	 * 
	 * @return demand_total_num
	 */
	public Integer getDemand_total_num() {
		return demand_total_num;
	}
	
	/**
	 * 任务数量
	 * 
	 * @return task_num
	 */
	public Integer getTask_num() {
		return task_num;
	}
	
	/**
	 * 总任务数量
	 * 
	 * @return task_total_num
	 */
	public Integer getTask_total_num() {
		return task_total_num;
	}
	
	/**
	 * 缺陷数量
	 * 
	 * @return defect_num
	 */
	public Integer getDefect_num() {
		return defect_num;
	}
	
	/**
	 * 总缺陷数量
	 * 
	 * @return defect_total_num
	 */
	public Integer getDefect_total_num() {
		return defect_total_num;
	}
	
	/**
	 * 项目的计划工作量
	 * 
	 * @return plan_workload
	 */
	public String getPlan_workload() {
		return plan_workload;
	}
	
	/**
	 * 实际工作量
	 * 
	 * @return real_workload
	 */
	public String getReal_workload() {
		return real_workload;
	}
	
	/**
	 * 总计划工作量
	 * 
	 * @return total_plan_workload
	 */
	public String getTotal_plan_workload() {
		return total_plan_workload;
	}
	
	/**
	 * 总实际工作量
	 * 
	 * @return total_real_workload
	 */
	public String getTotal_real_workload() {
		return total_real_workload;
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
	 * 项目工作量人员月度统计ID
	 * 
	 * @param st_work_user_id
	 */
	public void setSt_work_user_id(Integer st_work_user_id) {
		this.st_work_user_id = st_work_user_id;
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
	 * user_id
	 * 
	 * @param user_id
	 */
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
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
	 * 需求数量
	 * 
	 * @param demand_num
	 */
	public void setDemand_num(Integer demand_num) {
		this.demand_num = demand_num;
	}
	
	/**
	 * 总需求数量
	 * 
	 * @param demand_total_num
	 */
	public void setDemand_total_num(Integer demand_total_num) {
		this.demand_total_num = demand_total_num;
	}
	
	/**
	 * 任务数量
	 * 
	 * @param task_num
	 */
	public void setTask_num(Integer task_num) {
		this.task_num = task_num;
	}
	
	/**
	 * 总任务数量
	 * 
	 * @param task_total_num
	 */
	public void setTask_total_num(Integer task_total_num) {
		this.task_total_num = task_total_num;
	}
	
	/**
	 * 缺陷数量
	 * 
	 * @param defect_num
	 */
	public void setDefect_num(Integer defect_num) {
		this.defect_num = defect_num;
	}
	
	/**
	 * 总缺陷数量
	 * 
	 * @param defect_total_num
	 */
	public void setDefect_total_num(Integer defect_total_num) {
		this.defect_total_num = defect_total_num;
	}
	
	/**
	 * 项目的计划工作量
	 * 
	 * @param plan_workload
	 */
	public void setPlan_workload(String plan_workload) {
		this.plan_workload = plan_workload;
	}
	
	/**
	 * 实际工作量
	 * 
	 * @param real_workload
	 */
	public void setReal_workload(String real_workload) {
		this.real_workload = real_workload;
	}
	
	/**
	 * 总计划工作量
	 * 
	 * @param total_plan_workload
	 */
	public void setTotal_plan_workload(String total_plan_workload) {
		this.total_plan_workload = total_plan_workload;
	}
	
	/**
	 * 总实际工作量
	 * 
	 * @param total_real_workload
	 */
	public void setTotal_real_workload(String total_real_workload) {
		this.total_real_workload = total_real_workload;
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