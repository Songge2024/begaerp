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
public class WorkHour extends PO {

	private static final long serialVersionUID = 1L;
	//人员id
	private Integer user_id;
	
	//项目id
	private String proj_id;
	
	//周报编码
	private String test_code;
	
	//基地工时
		private String work_hours;
		
	//出差工时
	private String business_hours;
		
	
	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getProj_id() {
		return proj_id;
	}

	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}

	public String getTest_code() {
		return test_code;
	}

	public void setTest_code(String test_code) {
		this.test_code = test_code;
	}

	public String getWork_hours() {
		return work_hours;
	}

	public void setWork_hours(String work_hours) {
		this.work_hours = work_hours;
	}

	public String getBusiness_hours() {
		return business_hours;
	}

	public void setBusiness_hours(String business_hours) {
		this.business_hours = business_hours;
	}

	
}