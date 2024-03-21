package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>ta_daily_report[ta_daily_report]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author luojh
 * @date 2017-12-27 15:21:21
 */
public class DailyReportPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 日报编码
	 */
	private Integer id;
	
	/**
	 * 日报名称
	 */
	private String name;
	
	/**
	 * 日报描述
	 */
	private String descc;
	
	/**
	 * remark
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
	 * week_day
	 */
	private String week_day;
	
	/**
	 * 日报状态
	 */
	private String state;
	
	/**
	 * 工作时间
	 */
	private Date daily_time;
	
	/**
	 * desccc
	 */
	private String desccc;
	

	/**
	 * 日报编码
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 日报名称
	 * 
	 * @return name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * 日报描述
	 * 
	 * @return descc
	 */
	public String getDescc() {
		return descc;
	}
	
	/**
	 * remark
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
	 * week_day
	 * 
	 * @return week_day
	 */
	public String getWeek_day() {
		return week_day;
	}
	
	/**
	 * 日报状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 工作时间
	 * 
	 * @return daily_time
	 */
	public Date getDaily_time() {
		return daily_time;
	}
	
	/**
	 * desccc
	 * 
	 * @return desccc
	 */
	public String getDesccc() {
		return desccc;
	}
	

	/**
	 * 日报编码
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 日报名称
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 日报描述
	 * 
	 * @param descc
	 */
	public void setDescc(String descc) {
		this.descc = descc;
	}
	
	/**
	 * remark
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
	 * week_day
	 * 
	 * @param week_day
	 */
	public void setWeek_day(String week_day) {
		this.week_day = week_day;
	}
	
	/**
	 * 日报状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 工作时间
	 * 
	 * @param daily_time
	 */
	public void setDaily_time(Date daily_time) {
		this.daily_time = daily_time;
	}
	
	/**
	 * desccc
	 * 
	 * @param desccc
	 */
	public void setDesccc(String desccc) {
		this.desccc = desccc;
	}
	

}