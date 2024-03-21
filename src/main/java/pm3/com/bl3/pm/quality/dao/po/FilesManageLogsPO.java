package com.bl3.pm.quality.dao.po;

import java.util.Date;

import aos.framework.core.typewrap.PO;

public class FilesManageLogsPO extends PO {

	private static final long serialVersionUID = 1L;
	
	/**
	 * 修改编码
	 */
	private Integer log_id;
	
	/**
	 * 会议编码ID
	 */
	private Integer manage_id;
	
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

	public Integer getLog_id() {
		return log_id;
	}

	public void setLog_id(Integer log_id) {
		this.log_id = log_id;
	}

	public Integer getManage_id() {
		return manage_id;
	}

	public void setManage_id(Integer manage_id) {
		this.manage_id = manage_id;
	}

	public Integer getSerial_no() {
		return serial_no;
	}

	public void setSerial_no(Integer serial_no) {
		this.serial_no = serial_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public Integer getUpdate_user_id() {
		return update_user_id;
	}

	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
	}
	
	
}
