package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>pr_preserve_point[pr_preserve_point]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-22 13:44:43
 */
public class PreservePointPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 扣分标准ID
	 */
	private Integer id;
	
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
	 * 扣分标准ID
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
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
	 * 扣分标准ID
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
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
	

}