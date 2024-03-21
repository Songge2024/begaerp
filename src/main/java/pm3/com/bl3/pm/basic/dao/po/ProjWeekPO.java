package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_week[bs_proj_week]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-19 17:02:26
 */
public class ProjWeekPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 项目周ID
	 */
	private Integer week_id;
	
	/**
	 * 项目周名称
	 */
	private String week_name;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 开始时间
	 */
	private Date begin_date;
	
	/**
	 * 结束时间
	 */
	private Date end_date;
	
	/**
	 * 说明
	 */
	private String comment;
	
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
	 * 状态
	 */
	private String state;
	

	/**
	 * 项目周ID
	 * 
	 * @return week_id
	 */
	public Integer getWeek_id() {
		return week_id;
	}
	
	/**
	 * 项目周名称
	 * 
	 * @return week_name
	 */
	public String getWeek_name() {
		return week_name;
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
	 * 说明
	 * 
	 * @return comment
	 */
	public String getComment() {
		return comment;
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
	 * 状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 项目周ID
	 * 
	 * @param week_id
	 */
	public void setWeek_id(Integer week_id) {
		this.week_id = week_id;
	}
	
	/**
	 * 项目周名称
	 * 
	 * @param week_name
	 */
	public void setWeek_name(String week_name) {
		this.week_name = week_name;
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
	 * 说明
	 * 
	 * @param comment
	 */
	public void setComment(String comment) {
		this.comment = comment;
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
	
	/**
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}