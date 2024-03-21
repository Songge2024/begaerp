package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>ta_work_hour[ta_work_hour]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zocl
 * @date 2018-05-03 14:27:05
 */
public class WorkHourPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 工期
	 */
	private Integer work_id;
	
	/**
	 * 人员ID
	 */
	private Integer user_id;
	
	/**
	 * 项目ID
	 */
	private String proj_id;
	
	/**
	 * 周报编码
	 */
	private String test_code;
	
	/**
	 * 基地工时
	 */
	private String work_hours;
	
	/**
	 * 出差工时
	 */
	private String business_hours;
	

	/**
	 * 工期
	 * 
	 * @return work_id
	 */
	public Integer getWork_id() {
		return work_id;
	}
	
	/**
	 * 人员ID
	 * 
	 * @return user_id
	 */
	public Integer getUser_id() {
		return user_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public String getProj_id() {
		return proj_id;
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
	 * 基地工时
	 * 
	 * @return work_hours
	 */
	public String getWork_hours() {
		return work_hours;
	}
	
	/**
	 * 出差工时
	 * 
	 * @return business_hours
	 */
	public String getBusiness_hours() {
		return business_hours;
	}
	

	/**
	 * 工期
	 * 
	 * @param work_id
	 */
	public void setWork_id(Integer work_id) {
		this.work_id = work_id;
	}
	
	/**
	 * 人员ID
	 * 
	 * @param user_id
	 */
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
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
	 * 基地工时
	 * 
	 * @param work_hours
	 */
	public void setWork_hours(String work_hours) {
		this.work_hours = work_hours;
	}
	
	/**
	 * 出差工时
	 * 
	 * @param business_hours
	 */
	public void setBusiness_hours(String business_hours) {
		this.business_hours = business_hours;
	}
	

}