package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_proj_commons[bs_proj_commons]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yj
 * @date 2017-12-11 10:44:06
 */
public class ProjCommonsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 类型CODE
	 */
	private String type_code;
	
	/**
	 * 项目编码
	 */
	private String proj_code;
	
	/**
	 * 项目名称
	 */
	private String proj_name;
	
	/**
	 * 项目简称
	 */
	private String project_for_short;
	
	/**
	 * 项目经理
	 */
	private Integer pm_user_id;
	
	/**
	 * 程序经理
	 */
	private Integer pm2_user_id;
	
	/**
	 * 客户名称
	 */
	private String client_name;
	
	/**
	 * 客户地址
	 */
	private String client_address;
	
	/**
	 * 客户项目责任人姓名
	 */
	private String client_out_name;
	
	/**
	 * 客户项目责任人电话
	 */
	private String client_out_phone;
	
	/**
	 * 项目启动时间
	 */
	private Date begin_date;
	/**
	 * 计划完成时间
	 */
	private Date plan_completion_time;
	
	/**
	 * 项目计划周期
	 */
	private Integer period;
	
	/**
	 * 开发任务确认人
	 */
	private Integer develop_task_user;
	/**
	 * 计划完成工作总量
	 */
	private Integer plan_workload;

	public Integer getPlan_workload() {
		return plan_workload;
	}

	public void setPlan_workload(Integer plan_workload) {
		this.plan_workload = plan_workload;
	}

	/**
	 * 项目验收时间
	 */
	private Date accept_date;
	
	public Date getAccept_date() {
		return accept_date;
	}

	public void setAccept_date(Date accept_date) {
		this.accept_date = accept_date;
	}
	
	private String trp_name;
	
	private String team_user_name;

	private String develop_task_user_name;
	
	private String check_user_name;

	/**
	 * 合同号
	 */
	private String ct_code;
	
	public String getTrp_name() {
		return trp_name;
	}

	public void setTrp_name(String trp_name) {
		this.trp_name = trp_name;
	}

	public String getTeam_user_name() {
		return team_user_name;
	}

	public void setTeam_user_name(String team_user_name) {
		this.team_user_name = team_user_name;
	}

	public String getDevelop_task_user_name() {
		return develop_task_user_name;
	}

	public void setDevelop_task_user_name(String develop_task_user_name) {
		this.develop_task_user_name = develop_task_user_name;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	/**
	 * 合同金额
	 */
	private BigDecimal ct_money;
	
	/**
	 * 付款条件说明
	 */
	private String pt_desc;
	
	/**
	 * 回款说明
	 */
	private String rt_desc;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 创建时间
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
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 类型CODE
	 * 
	 * @return type_code
	 */
	public String getType_code() {
		return type_code;
	}
	
	/**
	 * 项目编码
	 * 
	 * @return proj_code
	 */
	public String getProj_code() {
		return proj_code;
	}
	
	/**
	 * 开发任务确认人
	 */
	public Integer getDevelop_task_user() {
		return develop_task_user;
	}
	/**
	 * 开发任务确认人
	 */
	public void setDevelop_task_user(Integer develop_task_user) {
		this.develop_task_user = develop_task_user;
	}
	
	/**
	 * 项目名称
	 * 
	 * @return proj_name
	 */
	public String getProj_name() {
		return proj_name;
	}
	
	/**
	 * 项目简称
	 * 
	 * @return project_for_short
	 */
	public String getProject_for_short() {
		return project_for_short;
	}
	
	/**
	 * 项目经理
	 * 
	 * @return pm_user_id
	 */
	public Integer getPm_user_id() {
		return pm_user_id;
	}
	
	/**
	 * 程序经理
	 * 
	 * @return pm2_user_id
	 */
	public Integer getPm2_user_id() {
		return pm2_user_id;
	}
	
	/**
	 * 客户名称
	 * 
	 * @return client_name
	 */
	public String getClient_name() {
		return client_name;
	}
	
	/**
	 * 客户地址
	 * 
	 * @return client_address
	 */
	public String getClient_address() {
		return client_address;
	}
	
	/**
	 * 客户项目责任人姓名
	 * 
	 * @return client_out_name
	 */
	public String getClient_out_name() {
		return client_out_name;
	}
	
	/**
	 * 客户项目责任人电话
	 * 
	 * @return client_out_phone
	 */
	public String getClient_out_phone() {
		return client_out_phone;
	}
	
	/**
	 * 项目启动时间
	 * 
	 * @return begin_date
	 */
	public Date getBegin_date() {
		return begin_date;
	}
	
	/**
	 * 项目计划周期
	 * 
	 * @return period
	 */
	public Integer getPeriod() {
		return period;
	}
	
	/**
	 * 合同号
	 * 
	 * @return ct_code
	 */
	public String getCt_code() {
		return ct_code;
	}
	
	/**
	 * 合同金额
	 * 
	 * @return ct_money
	 */
	public BigDecimal getCt_money() {
		return ct_money;
	}
	
	/**
	 * 付款条件说明
	 * 
	 * @return pt_desc
	 */
	public String getPt_desc() {
		return pt_desc;
	}
	
	/**
	 * 回款说明
	 * 
	 * @return rt_desc
	 */
	public String getRt_desc() {
		return rt_desc;
	}
	
	/**
	 * 状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
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
	 * 创建时间
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
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 类型CODE
	 * 
	 * @param type_code
	 */
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	
	/**
	 * 项目编码
	 * 
	 * @param proj_code
	 */
	public void setProj_code(String proj_code) {
		this.proj_code = proj_code;
	}
	
	/**
	 * 项目名称
	 * 
	 * @param proj_name
	 */
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	
	/**
	 * 项目简称
	 * 
	 * @param project_for_short
	 */
	public void setProject_for_short(String project_for_short) {
		this.project_for_short = project_for_short;
	}
	
	/**
	 * 项目经理
	 * 
	 * @param pm_user_id
	 */
	public void setPm_user_id(Integer pm_user_id) {
		this.pm_user_id = pm_user_id;
	}
	
	/**
	 * 程序经理
	 * 
	 * @param pm2_user_id
	 */
	public void setPm2_user_id(Integer pm2_user_id) {
		this.pm2_user_id = pm2_user_id;
	}
	
	/**
	 * 客户名称
	 * 
	 * @param client_name
	 */
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	
	/**
	 * 客户地址
	 * 
	 * @param client_address
	 */
	public void setClient_address(String client_address) {
		this.client_address = client_address;
	}
	
	/**
	 * 客户项目责任人姓名
	 * 
	 * @param client_out_name
	 */
	public void setClient_out_name(String client_out_name) {
		this.client_out_name = client_out_name;
	}
	
	/**
	 * 客户项目责任人电话
	 * 
	 * @param client_out_phone
	 */
	public void setClient_out_phone(String client_out_phone) {
		this.client_out_phone = client_out_phone;
	}
	
	/**
	 * 项目启动时间
	 * 
	 * @param begin_date
	 */
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	
	/**
	 * 项目计划周期
	 * 
	 * @param period
	 */
	public void setPeriod(Integer period) {
		this.period = period;
	}
	
	/**
	 * 合同号
	 * 
	 * @param ct_code
	 */
	public void setCt_code(String ct_code) {
		this.ct_code = ct_code;
	}
	
	/**
	 * 合同金额
	 * 
	 * @param ct_money
	 */
	public void setCt_money(BigDecimal ct_money) {
		this.ct_money = ct_money;
	}
	
	/**
	 * 付款条件说明
	 * 
	 * @param pt_desc
	 */
	public void setPt_desc(String pt_desc) {
		this.pt_desc = pt_desc;
	}
	
	/**
	 * 回款说明
	 * 
	 * @param rt_desc
	 */
	public void setRt_desc(String rt_desc) {
		this.rt_desc = rt_desc;
	}
	
	/**
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
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
	 * 创建时间
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

	public Date getPlan_completion_time() {
		return plan_completion_time;
	}

	public void setPlan_completion_time(Date plan_completion_time) {
		this.plan_completion_time = plan_completion_time;
	}
	

}