package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>ta_task[ta_task]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-22 11:10:33
 */
public class TaskPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 任务编码
	 */
	private Integer task_id;
	
	/**
	 * 编码
	 */
	private String task_code;
	
	/**
	 * 任务名称
	 */
	private String task_name;
	
	/**
	 * 项目编码
	 */
	private String proj_id;
	
	/**
	 * 模块编码
	 */
	private String module_id;
	
	/**
	 * 需求编码
	 */
	private String demand_id;
	
	/**
	 * 分组编码
	 */
	private Integer group_id;
	
	/**
	 * 任务分数
	 */
	private Integer grade;
	
	/**
	 * 实际得分
	 */
	private Integer real_grade;
	
	/**
	 * 计划开始时间
	 */
	private Date plan_begin_time;
	
	/**
	 * 计划完成时间
	 */
	private Date plan_end_time;
	
	/**
	 * 计划消耗天数
	 */
	private BigDecimal plan_wastage;
	
	/**
	 * 实际开始时间
	 */
	private Date real_begin_time;
	
	/**
	 * 实际完成时间
	 */
	private Date real_end_time;
	
	/**
	 * 实际消耗天数
	 */
	private BigDecimal real_wastage;
	
	/**
	 * 处理人编码
	 */
	private Integer handler_user_id;
	
	/**
	 * 指派人编码
	 */
	private Integer assign_user_id;
	
	/**
	 * 关闭人编码
	 */
	private Integer close_user_id;
	
	public Integer getClose_user_id() {
		return close_user_id;
	}

	public void setClose_user_id(Integer close_user_id) {
		this.close_user_id = close_user_id;
	}

	/**
	 * 任务类型
	 */
	private String task_type;
	
	/**
	 * 任务等级
	 */
	private String task_level;
	
	/**
	 * 完成百分比
	 */
	private Integer percent;
	
	/**
	 * 任务分组类型
	 */
	private String group_type;
	
	/**
	 * 抄送人编码
	 */
	private String cc_user_ids;
	
	/**
	 * 耗时
	 */
	private Integer consume_time;
	
	/**
	 * 任务描述
	 */
	private String task_desc;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 更新人
	 */
	private Integer update_user_id;
	
	/**
	 * 更新时间
	 */
	private Date update_time;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 创建人编码
	 */
	private Integer create_user_id;
	
	/**
	 * 任务状态
	 */
	private String state;
	
	/**
	 * 任务延期状态
	 */
	private String task_delay_state;
	
	/**
	 * 任务是否分解('0'为否，'1'为是)
	 */
	private String is_decomposed;
	
	/**
	 * 额外完成任务时间
	 */
	private String task_extra_time;
	
	/**
	 * 分解任务上级ID
	 */
	private String task_parent_id;
	
	/**
	 *  任务是否分解('0'为否，'1'为是)
	 * @return
	 */
	public String getIs_decomposed() {
		return is_decomposed;
	}

	/**
	 * 任务是否分解('0'为否，'1'为是)
	 * @param is_decomposed
	 */
	public void setIs_decomposed(String is_decomposed) {
		this.is_decomposed = is_decomposed;
	}

	/**
	 * 额外完成任务时间 
	 * @return
	 */
	public String getTask_extra_time() {
		return task_extra_time;
	}

	/**
	 *  额外完成任务时间 
	 * @param task_extra_time
	 */
	public void setTask_extra_time(String task_extra_time) {
		this.task_extra_time = task_extra_time;
	}

	/**
	 * 分解任务上级ID
	 * @return
	 */
	public String getTask_parent_id() {
		return task_parent_id;
	}

	/**
	 * 分解任务上级ID
	 * @param task_parent_id
	 */
	public void setTask_parent_id(String task_parent_id) {
		this.task_parent_id = task_parent_id;
	}

	/**
	 *  分解任务根ID
	 * @return
	 */
	public String getTask_root_id() {
		return task_root_id;
	}

	/**
	 * 分解任务根ID
	 * @param task_root_id
	 */
	public void setTask_root_id(String task_root_id) {
		this.task_root_id = task_root_id;
	}

	/**
	 * 分解任务根ID
	 */
	private String task_root_id;
	
	public String getTask_delay_state() {
		return task_delay_state;
	}

	public void setTask_delay_state(String task_delay_state) {
		this.task_delay_state = task_delay_state;
	}

	/**
	 * 任务编码
	 * 
	 * @return task_id
	 */
	public Integer getTask_id() {
		return task_id;
	}
	
	/**
	 * 编码
	 * 
	 * @return task_code
	 */
	public String getTask_code() {
		return task_code;
	}
	
	/**
	 * 任务名称
	 * 
	 * @return task_name
	 */
	public String getTask_name() {
		return task_name;
	}
	
	/**
	 * 项目编码
	 * 
	 * @return proj_id
	 */
	public String getProj_id() {
		return proj_id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @return module_id
	 */
	public String getModule_id() {
		return module_id;
	}
	
	/**
	 * 需求编码
	 * 
	 * @return demand_id
	 */
	public String getDemand_id() {
		return demand_id;
	}
	
	/**
	 * 分组编码
	 * 
	 * @return group_id
	 */
	public Integer getGroup_id() {
		return group_id;
	}
	
	/**
	 * 任务分数
	 * 
	 * @return grade
	 */
	public Integer getGrade() {
		return grade;
	}
	
	/**
	 * 实际得分
	 * 
	 * @return real_grade
	 */
	public Integer getReal_grade() {
		return real_grade;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @return plan_begin_time
	 */
	public Date getPlan_begin_time() {
		return plan_begin_time;
	}
	
	/**
	 * 计划完成时间
	 * 
	 * @return plan_end_time
	 */
	public Date getPlan_end_time() {
		return plan_end_time;
	}
	
	/**
	 * 计划消耗天数
	 * 
	 * @return plan_wastage
	 */
	public BigDecimal getPlan_wastage() {
		return plan_wastage;
	}
	
	/**
	 * 实际开始时间
	 * 
	 * @return real_begin_time
	 */
	public Date getReal_begin_time() {
		return real_begin_time;
	}
	
	/**
	 * 实际完成时间
	 * 
	 * @return real_end_time
	 */
	public Date getReal_end_time() {
		return real_end_time;
	}
	
	/**
	 * 实际消耗天数
	 * 
	 * @return real_wastage
	 */
	public BigDecimal getReal_wastage() {
		return real_wastage;
	}
	
	/**
	 * 处理人编码
	 * 
	 * @return handler_user_id
	 */
	public Integer getHandler_user_id() {
		return handler_user_id;
	}
	
	/**
	 * 指派人编码
	 * 
	 * @return assign_user_id
	 */
	public Integer getAssign_user_id() {
		return assign_user_id;
	}
	
	/**
	 * 任务类型
	 * 
	 * @return task_type
	 */
	public String getTask_type() {
		return task_type;
	}
	
	/**
	 * 任务等级
	 * 
	 * @return task_level
	 */
	public String getTask_level() {
		return task_level;
	}
	
	/**
	 * 完成百分比
	 * 
	 * @return percent
	 */
	public Integer getPercent() {
		return percent;
	}
	
	/**
	 * 任务分组类型
	 * 
	 * @return group_type
	 */
	public String getGroup_type() {
		return group_type;
	}
	
	/**
	 * 抄送人编码
	 * 
	 * @return cc_user_ids
	 */
	public String getCc_user_ids() {
		return cc_user_ids;
	}
	
	/**
	 * 耗时
	 * 
	 * @return consume_time
	 */
	public Integer getConsume_time() {
		return consume_time;
	}
	
	/**
	 * 任务描述
	 * 
	 * @return task_desc
	 */
	public String getTask_desc() {
		return task_desc;
	}
	
	/**
	 * 备注
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
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
	 * 创建时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 创建人编码
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 任务状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 任务编码
	 * 
	 * @param task_id
	 */
	public void setTask_id(Integer task_id) {
		this.task_id = task_id;
	}
	
	/**
	 * 编码
	 * 
	 * @param task_code
	 */
	public void setTask_code(String task_code) {
		this.task_code = task_code;
	}
	
	/**
	 * 任务名称
	 * 
	 * @param task_name
	 */
	public void setTask_name(String task_name) {
		this.task_name = task_name;
	}
	
	/**
	 * 项目编码
	 * 
	 * @param proj_id
	 */
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @param module_id
	 */
	public void setModule_id(String module_id) {
		this.module_id = module_id;
	}
	
	/**
	 * 需求编码
	 * 
	 * @param demand_id
	 */
	public void setDemand_id(String demand_id) {
		this.demand_id = demand_id;
	}
	
	/**
	 * 分组编码
	 * 
	 * @param group_id
	 */
	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
	
	/**
	 * 任务分数
	 * 
	 * @param grade
	 */
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	
	/**
	 * 实际得分
	 * 
	 * @param real_grade
	 */
	public void setReal_grade(Integer real_grade) {
		this.real_grade = real_grade;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @param plan_begin_time
	 */
	public void setPlan_begin_time(Date plan_begin_time) {
		this.plan_begin_time = plan_begin_time;
	}
	
	/**
	 * 计划完成时间
	 * 
	 * @param plan_end_time
	 */
	public void setPlan_end_time(Date plan_end_time) {
		this.plan_end_time = plan_end_time;
	}
	
	/**
	 * 计划消耗天数
	 * 
	 * @param plan_wastage
	 */
	public void setPlan_wastage(BigDecimal plan_wastage) {
		this.plan_wastage = plan_wastage;
	}
	
	/**
	 * 实际开始时间
	 * 
	 * @param real_begin_time
	 */
	public void setReal_begin_time(Date real_begin_time) {
		this.real_begin_time = real_begin_time;
	}
	
	/**
	 * 实际完成时间
	 * 
	 * @param real_end_time
	 */
	public void setReal_end_time(Date real_end_time) {
		this.real_end_time = real_end_time;
	}
	
	/**
	 * 实际消耗天数
	 * 
	 * @param real_wastage
	 */
	public void setReal_wastage(BigDecimal real_wastage) {
		this.real_wastage = real_wastage;
	}
	
	/**
	 * 处理人编码
	 * 
	 * @param handler_user_id
	 */
	public void setHandler_user_id(Integer handler_user_id) {
		this.handler_user_id = handler_user_id;
	}
	
	/**
	 * 指派人编码
	 * 
	 * @param assign_user_id
	 */
	public void setAssign_user_id(Integer assign_user_id) {
		this.assign_user_id = assign_user_id;
	}
	
	/**
	 * 任务类型
	 * 
	 * @param task_type
	 */
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	
	/**
	 * 任务等级
	 * 
	 * @param task_level
	 */
	public void setTask_level(String task_level) {
		this.task_level = task_level;
	}
	
	/**
	 * 完成百分比
	 * 
	 * @param percent
	 */
	public void setPercent(Integer percent) {
		this.percent = percent;
	}
	
	/**
	 * 任务分组类型
	 * 
	 * @param group_type
	 */
	public void setGroup_type(String group_type) {
		this.group_type = group_type;
	}
	
	/**
	 * 抄送人编码
	 * 
	 * @param cc_user_ids
	 */
	public void setCc_user_ids(String cc_user_ids) {
		this.cc_user_ids = cc_user_ids;
	}
	
	/**
	 * 耗时
	 * 
	 * @param consume_time
	 */
	public void setConsume_time(Integer consume_time) {
		this.consume_time = consume_time;
	}
	
	/**
	 * 任务描述
	 * 
	 * @param task_desc
	 */
	public void setTask_desc(String task_desc) {
		this.task_desc = task_desc;
	}
	
	/**
	 * 备注
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
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
	 * 创建时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 创建人编码
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 任务状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}