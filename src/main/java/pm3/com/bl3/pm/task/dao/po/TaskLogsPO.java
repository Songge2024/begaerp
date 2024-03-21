package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>ta_task_logs[ta_task_logs]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-02 15:38:47
 */
public class TaskLogsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 修改编码
	 */
	private Integer log_id;
	
	/**
	 * 任务ID
	 */
	private Integer task_id;
	
	/**
	 * 序号
	 */
	private Integer serial_no;
	
	/**
	 * 修改描述
	 */
	private String content;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 修改人
	 */
	private Integer update_user_id;
	
	/**
	 * 任务状态
	 */
	private String state;
	/**
	 * 百分比
	 */
	private BigDecimal percent;

	/**
	 * 修改编码
	 * 
	 * @return log_id
	 */
	public Integer getLog_id() {
		return log_id;
	}
	
	/**
	 * 任务ID
	 * 
	 * @return task_id
	 */
	public Integer getTask_id() {
		return task_id;
	}
	
	/**
	 * 序号
	 * 
	 * @return serial_no
	 */
	public Integer getSerial_no() {
		return serial_no;
	}
	
	/**
	 * 修改描述
	 * 
	 * @return content
	 */
	public String getContent() {
		return content;
	}
	
	/**
	 * 修改时间
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 修改人
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
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
	 * 修改编码
	 * 
	 * @param log_id
	 */
	public void setLog_id(Integer log_id) {
		this.log_id = log_id;
	}
	
	/**
	 * 任务ID
	 * 
	 * @param task_id
	 */
	public void setTask_id(Integer task_id) {
		this.task_id = task_id;
	}
	
	/**
	 * 序号
	 * 
	 * @param serial_no
	 */
	public void setSerial_no(Integer serial_no) {
		this.serial_no = serial_no;
	}
	
	/**
	 * 修改描述
	 * 
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 修改时间
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 修改人
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
	}
	
	/**
	 * 任务状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public BigDecimal getPercent() {
		return percent;
	}

	public void setPercent(BigDecimal percent) {
		this.percent = percent;
	}
	

}