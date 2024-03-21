package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_problem_trace[pr_problem_trace]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-31 11:40:05
 */
public class ProblemTracePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * QA问题跟踪ID
	 */
	private Integer check_problem_id;
	
	/**
	 * 检查单目录ID
	 */
	private Integer check_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 检查单类型
	 */
	private String check_name;
	
	/**
	 * 检查项编码
	 */
	private String check_code;
	
	/**
	 * 问题来源
	 */
	private String problem_sources;
	
	/**
	 * 过程及产品
	 */
	private String process_product;
	
	/**
	 * 检查明细项ID
	 */
	private Integer check_detail_id;
	
	/**
	 * 检查项内容
	 */
	private String check_detail_name;
	
	/**
	 * 问题等级
	 */
	private String problem_level;
	
	/**
	 * 检查时间
	 */
	private Date check_time;
	
	/**
	 * 问题状态
	 */
	private String problem_state;
	
	/**
	 * 负责人部门
	 */
	private Integer principal_org;
	
	/**
	 * 负责人
	 */
	private Integer principal;
	
	/**
	 * 处理人
	 */
	private String deal_man;
	
	/**
	 * 跟踪情况
	 */
	private String trace_status;
	
	/**
	 * 解决日期
	 */
	private Date solve_time;
	
	/**
	 * 问题解决用时
	 */
	private String solve_day;
	
	/**
	 * 扣分标准
	 */
	private String deduct_point;
	
	/**
	 * 解决时限扣分标准
	 */
	private String solve_deduct_point;
	
	/**
	 * 问题解决时限（天）
	 */
	private String solve_times;
	
	/**
	 * 解决时限扣分
	 */
	private String solve_time_point;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 设计人
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
	
	private String principal_org_name;
	
	private String principal_name;
	
	private String deal_man_name;
	
	private String problem_count;
	
	private String count_point;
	
	private String check_all;
	
	
	
	
	
	public String getProblem_count() {
		return problem_count;
	}

	public void setProblem_count(String problem_count) {
		this.problem_count = problem_count;
	}

	public String getCount_point() {
		return count_point;
	}

	public void setCount_point(String count_point) {
		this.count_point = count_point;
	}

	public String getCheck_all() {
		return check_all;
	}

	public void setCheck_all(String check_all) {
		this.check_all = check_all;
	}

	public String getPrincipal_org_name() {
		return principal_org_name;
	}

	public void setPrincipal_org_name(String principal_org_name) {
		this.principal_org_name = principal_org_name;
	}

	public String getPrincipal_name() {
		return principal_name;
	}

	public void setPrincipal_name(String principal_name) {
		this.principal_name = principal_name;
	}

	public String getDeal_man_name() {
		return deal_man_name;
	}

	public void setDeal_man_name(String deal_man_name) {
		this.deal_man_name = deal_man_name;
	}

	/**
	 * QA问题跟踪ID
	 * 
	 * @return check_problem_id
	 */
	public Integer getCheck_problem_id() {
		return check_problem_id;
	}
	
	/**
	 * 检查单目录ID
	 * 
	 * @return check_id
	 */
	public Integer getCheck_id() {
		return check_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 检查单类型
	 * 
	 * @return check_name
	 */
	public String getCheck_name() {
		return check_name;
	}
	
	/**
	 * 检查项编码
	 * 
	 * @return check_code
	 */
	public String getCheck_code() {
		return check_code;
	}
	
	/**
	 * 问题来源
	 * 
	 * @return problem_sources
	 */
	public String getProblem_sources() {
		return problem_sources;
	}
	
	/**
	 * 过程及产品
	 * 
	 * @return process_product
	 */
	public String getProcess_product() {
		return process_product;
	}
	
	/**
	 * 检查明细项ID
	 * 
	 * @return check_detail_id
	 */
	public Integer getCheck_detail_id() {
		return check_detail_id;
	}
	
	/**
	 * 检查项内容
	 * 
	 * @return check_detail_name
	 */
	public String getCheck_detail_name() {
		return check_detail_name;
	}
	
	/**
	 * 问题等级
	 * 
	 * @return problem_level
	 */
	public String getProblem_level() {
		return problem_level;
	}
	
	/**
	 * 检查时间
	 * 
	 * @return check_time
	 */
	public Date getCheck_time() {
		return check_time;
	}
	
	/**
	 * 问题状态
	 * 
	 * @return problem_state
	 */
	public String getProblem_state() {
		return problem_state;
	}
	
	/**
	 * 负责人部门
	 * 
	 * @return principal_org
	 */
	public Integer getPrincipal_org() {
		return principal_org;
	}
	
	/**
	 * 负责人
	 * 
	 * @return principal
	 */
	public Integer getPrincipal() {
		return principal;
	}
	
	/**
	 * 处理人
	 * 
	 * @return deal_man
	 */
	public String getDeal_man() {
		return deal_man;
	}
	
	/**
	 * 跟踪情况
	 * 
	 * @return trace_status
	 */
	public String getTrace_status() {
		return trace_status;
	}
	
	/**
	 * 解决日期
	 * 
	 * @return solve_time
	 */
	public Date getSolve_time() {
		return solve_time;
	}
	
	/**
	 * 问题解决用时
	 * 
	 * @return solve_day
	 */
	public String getSolve_day() {
		return solve_day;
	}
	
	/**
	 * 扣分标准
	 * 
	 * @return deduct_point
	 */
	public String getDeduct_point() {
		return deduct_point;
	}
	
	/**
	 * 解决时限扣分标准
	 * 
	 * @return solve_deduct_point
	 */
	public String getSolve_deduct_point() {
		return solve_deduct_point;
	}
	
	/**
	 * 问题解决时限（天）
	 * 
	 * @return solve_times
	 */
	public String getSolve_times() {
		return solve_times;
	}
	
	/**
	 * 解决时限扣分
	 * 
	 * @return solve_time_point
	 */
	public String getSolve_time_point() {
		return solve_time_point;
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
	 * 设计人
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
	 * QA问题跟踪ID
	 * 
	 * @param check_problem_id
	 */
	public void setCheck_problem_id(Integer check_problem_id) {
		this.check_problem_id = check_problem_id;
	}
	
	/**
	 * 检查单目录ID
	 * 
	 * @param check_id
	 */
	public void setCheck_id(Integer check_id) {
		this.check_id = check_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 检查单类型
	 * 
	 * @param check_name
	 */
	public void setCheck_name(String check_name) {
		this.check_name = check_name;
	}
	
	/**
	 * 检查项编码
	 * 
	 * @param check_code
	 */
	public void setCheck_code(String check_code) {
		this.check_code = check_code;
	}
	
	/**
	 * 问题来源
	 * 
	 * @param problem_sources
	 */
	public void setProblem_sources(String problem_sources) {
		this.problem_sources = problem_sources;
	}
	
	/**
	 * 过程及产品
	 * 
	 * @param process_product
	 */
	public void setProcess_product(String process_product) {
		this.process_product = process_product;
	}
	
	/**
	 * 检查明细项ID
	 * 
	 * @param check_detail_id
	 */
	public void setCheck_detail_id(Integer check_detail_id) {
		this.check_detail_id = check_detail_id;
	}
	
	/**
	 * 检查项内容
	 * 
	 * @param check_detail_name
	 */
	public void setCheck_detail_name(String check_detail_name) {
		this.check_detail_name = check_detail_name;
	}
	
	/**
	 * 问题等级
	 * 
	 * @param problem_level
	 */
	public void setProblem_level(String problem_level) {
		this.problem_level = problem_level;
	}
	
	/**
	 * 检查时间
	 * 
	 * @param check_time
	 */
	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
	}
	
	/**
	 * 问题状态
	 * 
	 * @param problem_state
	 */
	public void setProblem_state(String problem_state) {
		this.problem_state = problem_state;
	}
	
	/**
	 * 负责人部门
	 * 
	 * @param principal_org
	 */
	public void setPrincipal_org(Integer principal_org) {
		this.principal_org = principal_org;
	}
	
	/**
	 * 负责人
	 * 
	 * @param principal
	 */
	public void setPrincipal(Integer principal) {
		this.principal = principal;
	}
	
	/**
	 * 处理人
	 * 
	 * @param deal_man
	 */
	public void setDeal_man(String deal_man) {
		this.deal_man = deal_man;
	}
	
	/**
	 * 跟踪情况
	 * 
	 * @param trace_status
	 */
	public void setTrace_status(String trace_status) {
		this.trace_status = trace_status;
	}
	
	/**
	 * 解决日期
	 * 
	 * @param solve_time
	 */
	public void setSolve_time(Date solve_time) {
		this.solve_time = solve_time;
	}
	
	/**
	 * 问题解决用时
	 * 
	 * @param solve_day
	 */
	public void setSolve_day(String solve_day) {
		this.solve_day = solve_day;
	}
	
	/**
	 * 扣分标准
	 * 
	 * @param deduct_point
	 */
	public void setDeduct_point(String deduct_point) {
		this.deduct_point = deduct_point;
	}
	
	/**
	 * 解决时限扣分标准
	 * 
	 * @param solve_deduct_point
	 */
	public void setSolve_deduct_point(String solve_deduct_point) {
		this.solve_deduct_point = solve_deduct_point;
	}
	
	/**
	 * 问题解决时限（天）
	 * 
	 * @param solve_times
	 */
	public void setSolve_times(String solve_times) {
		this.solve_times = solve_times;
	}
	
	/**
	 * 解决时限扣分
	 * 
	 * @param solve_time_point
	 */
	public void setSolve_time_point(String solve_time_point) {
		this.solve_time_point = solve_time_point;
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
	 * 设计人
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
	

}