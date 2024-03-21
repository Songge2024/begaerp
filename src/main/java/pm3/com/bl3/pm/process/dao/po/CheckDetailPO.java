package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_check_detail[pr_check_detail]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-22 20:32:10
 */
public class CheckDetailPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 检查明细项ID
	 */
	private Integer check_detail_id;
	
	/**
	 * 检查单ID
	 */
	private Integer check_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 检查明细项名称
	 */
	private String check_detail_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 过程及产品
	 */
	private String process_product;
	
	/**
	 * 问题等级
	 */
	private String problem_level;
	
	/**
	 * 扣分标准
	 */
	private String deduct_point;
	
	/**
	 * 解决时限扣分标准
	 */
	private String solve_deduct_point;
	
	/**
	 * 问题解决时限
	 */
	private String solve_times;
	
	/**
	 * 状态 1 不适用 2 符合 3 不符合
	 */
	private String state;
	
	/**
	 * 是否转问题-1是转，0是不转
	 */
	private String is_problem;
	
	/**
	 * 跟踪情况
	 */
	private String trace_status;
	
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
	
	/**
	 * 不适用项
	 */
	private String none_num;
	
	/**
	 * 符合项
	 */
	private String yes_num;
	
	/**
	 * 不符合项
	 */
	private String no_num;
	

	
	
	public String getNone_num() {
		return none_num;
	}

	public void setNone_num(String none_num) {
		this.none_num = none_num;
	}

	public String getYes_num() {
		return yes_num;
	}

	public void setYes_num(String yes_num) {
		this.yes_num = yes_num;
	}

	public String getNo_num() {
		return no_num;
	}

	public void setNo_num(String no_num) {
		this.no_num = no_num;
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
	 * 检查单ID
	 * 
	 * @return check_id
	 */
	public Integer getCheck_id() {
		return check_id;
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
	 * 检查明细项名称
	 * 
	 * @return check_detail_name
	 */
	public String getCheck_detail_name() {
		return check_detail_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sort_no
	 */
	public Integer getSort_no() {
		return sort_no;
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
	 * 问题等级
	 * 
	 * @return problem_level
	 */
	public String getProblem_level() {
		return problem_level;
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
	 * 问题解决时限
	 * 
	 * @return solve_times
	 */
	public String getSolve_times() {
		return solve_times;
	}
	
	/**
	 * 状态 1 不适用 2 符合 3 不符合
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 是否转问题-1是转，0是不转
	 * 
	 * @return is_problem
	 */
	public String getIs_problem() {
		return is_problem;
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
	 * 检查明细项ID
	 * 
	 * @param check_detail_id
	 */
	public void setCheck_detail_id(Integer check_detail_id) {
		this.check_detail_id = check_detail_id;
	}
	
	/**
	 * 检查单ID
	 * 
	 * @param check_id
	 */
	public void setCheck_id(Integer check_id) {
		this.check_id = check_id;
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
	 * 检查明细项名称
	 * 
	 * @param check_detail_name
	 */
	public void setCheck_detail_name(String check_detail_name) {
		this.check_detail_name = check_detail_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
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
	 * 问题等级
	 * 
	 * @param problem_level
	 */
	public void setProblem_level(String problem_level) {
		this.problem_level = problem_level;
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
	 * 问题解决时限
	 * 
	 * @param solve_times
	 */
	public void setSolve_times(String solve_times) {
		this.solve_times = solve_times;
	}
	
	/**
	 * 状态 1 不适用 2 符合 3 不符合
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 是否转问题-1是转，0是不转
	 * 
	 * @param is_problem
	 */
	public void setIs_problem(String is_problem) {
		this.is_problem = is_problem;
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