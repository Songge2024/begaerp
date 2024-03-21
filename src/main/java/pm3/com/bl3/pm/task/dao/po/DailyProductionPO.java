package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>ta_daily_production[ta_daily_production]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author ZhaoJiaqi
 * @date 2020-03-20 15:32:23
 */
public class DailyProductionPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 日报id
	 */
	private Integer daily_id;
	
	/**
	 * 日报日期（yyyy-mm-dd格式）
	 */
	private Date daily_date;
	
	/**
	 * 日报描述
	 */
	private String daily_desc;
	
	/**
	 * 1 自定义 2 任务 3 缺陷 4 测试用例 5 会议
	 */
	private String daily_type;
	
	/**
	 * 项目id
	 */
	private Integer proj_id;
	
	/**
	 * 工作百分比
	 */
	private BigDecimal working_percent;
	
	/**
	 * 工作量（人天）
	 */
	private BigDecimal working_workload;
	
	/**
	 * 0 草稿 1 提交 2已同步
	 */
	private String daily_status;
	
	/**
	 * 同步ID
	 */
	private String sync_id;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * create_id
	 */
	private Integer create_id;
	
	/**
	 * create_time
	 */
	private Date create_time;
	
	/**
	 * update_id
	 */
	private Integer update_id;
	
	/**
	 * update_time
	 */
	private Date update_time;
	
	/**
	 * 0 未删除 1 已删除
	 */
	private String is_del;
	
	/**
	 * 日报名称
	 */
	private String daily_name;
	
	private String week_day;
	
	private String proj_name;

	public String getProj_name() {
		return proj_name;
	}

	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}

	public String getWeek_day() {
		return week_day;
	}

	public void setWeek_day(String week_day) {
		this.week_day = week_day;
	}

	/**
	 * 日报id
	 * 
	 * @return daily_id
	 */
	public Integer getDaily_id() {
		return daily_id;
	}
	
	/**
	 * 日报日期（yyyy-mm-dd格式）
	 * 
	 * @return daily_date
	 */
	public Date getDaily_date() {
		return daily_date;
	}
	
	/**
	 * 日报描述
	 * 
	 * @return daily_desc
	 */
	public String getDaily_desc() {
		return daily_desc;
	}
	
	/**
	 * 1 自定义 2 任务 3 缺陷 4 测试用例 5 会议
	 * 
	 * @return daily_type
	 */
	public String getDaily_type() {
		return daily_type;
	}
	
	/**
	 * 项目id
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 工作百分比
	 * 
	 * @return working_percent
	 */
	public BigDecimal getWorking_percent() {
		return working_percent;
	}
	
	/**
	 * 工作量（人天）
	 * 
	 * @return working_workload
	 */
	public BigDecimal getWorking_workload() {
		return working_workload;
	}
	
	/**
	 * 0 草稿 1 提交 2已同步
	 * 
	 * @return daily_status
	 */
	public String getDaily_status() {
		return daily_status;
	}
	
	/**
	 * 同步ID
	 * 
	 * @return sync_id
	 */
	public String getSync_id() {
		return sync_id;
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
	 * create_id
	 * 
	 * @return create_id
	 */
	public Integer getCreate_id() {
		return create_id;
	}
	
	/**
	 * create_time
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * update_id
	 * 
	 * @return update_id
	 */
	public Integer getUpdate_id() {
		return update_id;
	}
	
	/**
	 * update_time
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 0 未删除 1 已删除
	 * 
	 * @return is_del
	 */
	public String getIs_del() {
		return is_del;
	}
	
	/**
	 * 日报名称
	 * 
	 * @return daily_name
	 */
	public String getDaily_name() {
		return daily_name;
	}
	

	/**
	 * 日报id
	 * 
	 * @param daily_id
	 */
	public void setDaily_id(Integer daily_id) {
		this.daily_id = daily_id;
	}
	
	/**
	 * 日报日期（yyyy-mm-dd格式）
	 * 
	 * @param daily_date
	 */
	public void setDaily_date(Date daily_date) {
		this.daily_date = daily_date;
	}
	
	/**
	 * 日报描述
	 * 
	 * @param daily_desc
	 */
	public void setDaily_desc(String daily_desc) {
		this.daily_desc = daily_desc;
	}
	
	/**
	 * 1 自定义 2 任务 3 缺陷 4 测试用例 5 会议
	 * 
	 * @param daily_type
	 */
	public void setDaily_type(String daily_type) {
		this.daily_type = daily_type;
	}
	
	/**
	 * 项目id
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 工作百分比
	 * 
	 * @param working_percent
	 */
	public void setWorking_percent(BigDecimal working_percent) {
		this.working_percent = working_percent;
	}
	
	/**
	 * 工作量（人天）
	 * 
	 * @param working_workload
	 */
	public void setWorking_workload(BigDecimal working_workload) {
		this.working_workload = working_workload;
	}
	
	/**
	 * 0 草稿 1 提交 2已同步
	 * 
	 * @param daily_status
	 */
	public void setDaily_status(String daily_status) {
		this.daily_status = daily_status;
	}
	
	/**
	 * 同步ID
	 * 
	 * @param sync_id
	 */
	public void setSync_id(String sync_id) {
		this.sync_id = sync_id;
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
	 * create_id
	 * 
	 * @param create_id
	 */
	public void setCreate_id(Integer create_id) {
		this.create_id = create_id;
	}
	
	/**
	 * create_time
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * update_id
	 * 
	 * @param update_id
	 */
	public void setUpdate_id(Integer update_id) {
		this.update_id = update_id;
	}
	
	/**
	 * update_time
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 0 未删除 1 已删除
	 * 
	 * @param is_del
	 */
	public void setIs_del(String is_del) {
		this.is_del = is_del;
	}
	
	/**
	 * 日报名称
	 * 
	 * @param daily_name
	 */
	public void setDaily_name(String daily_name) {
		this.daily_name = daily_name;
	}
	

}