package com.bl3.pm.recruit.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_recruiter_information[bs_recruiter_information]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2018-04-18 11:34:16
 */
public class RecruiterInformationPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Integer register_id;
	
	/**
	 * 登记日期
	 */
	private Date register_date;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 性别
	 */
	private String sex;
	
	/**
	 * 联系方式
	 */
	private String link_phone;
	
	/**
	 * 来源
	 */
	private String source;
	
	/**
	 * 登记备注
	 */
	private String register_remark;
	
	/**
	 * 登记人
	 */
	private Integer register_user_id;
	
	/**
	 * 联系日期
	 */
	private Date contact_date;
	
	/**
	 * 联系人
	 */
	private Integer contact_user_id;
	
	/**
	 * 联系结果
	 */
	private String contact_result;
	
	/**
	 * 联系情况
	 */
	private String contact_information;
	
	/**
	 * 约定面试日期
	 */
	private Date interview_date;
	
	/**
	 * 通知入职时间
	 */
	private Date notify_entry_time;
	

	/**
	 * id
	 * 
	 * @return id
	 */
	public Integer getRegister_Id() {
		return register_id;
	}
	
	/**
	 * 登记日期
	 * 
	 * @return register_date
	 */
	public Date getRegister_date() {
		return register_date;
	}
	
	/**
	 * 姓名
	 * 
	 * @return name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * 性别
	 * 
	 * @return sex
	 */
	public String getSex() {
		return sex;
	}
	
	/**
	 * 联系方式
	 * 
	 * @return link_phone
	 */
	public String getLink_phone() {
		return link_phone;
	}
	
	/**
	 * 来源
	 * 
	 * @return source
	 */
	public String getSource() {
		return source;
	}
	
	/**
	 * 登记备注
	 * 
	 * @return register_remark
	 */
	public String getRegister_remark() {
		return register_remark;
	}
	
	/**
	 * 登记人
	 * 
	 * @return register_user_id
	 */
	public Integer getRegister_user_id() {
		return register_user_id;
	}
	
	/**
	 * 联系日期
	 * 
	 * @return contact_date
	 */
	public Date getContact_date() {
		return contact_date;
	}
	
	/**
	 * 联系人
	 * 
	 * @return contact_user_id
	 */
	public Integer getContact_user_id() {
		return contact_user_id;
	}
	
	/**
	 * 联系结果
	 * 
	 * @return contact_result
	 */
	public String getContact_result() {
		return contact_result;
	}
	
	/**
	 * 联系情况
	 * 
	 * @return contact_information
	 */
	public String getContact_information() {
		return contact_information;
	}
	
	/**
	 * 约定面试日期
	 * 
	 * @return 
interview_date
	 */
	public Date getinterview_date() {
		return 
interview_date;
	}
	
	/**
	 * 通知入职时间
	 * 
	 * @return notify_entry_time
	 */
	public Date getNotify_entry_time() {
		return notify_entry_time;
	}
	

	/**
	 * id
	 * 
	 * @param id
	 */
	public void setRegister_Id(Integer register_Id) {
		this.register_id = register_Id;
	}
	
	/**
	 * 登记日期
	 * 
	 * @param register_date
	 */
	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	
	/**
	 * 姓名
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 性别
	 * 
	 * @param sex
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	/**
	 * 联系方式
	 * 
	 * @param link_phone
	 */
	public void setLink_phone(String link_phone) {
		this.link_phone = link_phone;
	}
	
	/**
	 * 来源
	 * 
	 * @param source
	 */
	public void setSource(String source) {
		this.source = source;
	}
	
	/**
	 * 登记备注
	 * 
	 * @param register_remark
	 */
	public void setRegister_remark(String register_remark) {
		this.register_remark = register_remark;
	}
	
	/**
	 * 登记人
	 * 
	 * @param register_user_id
	 */
	public void setRegister_user_id(Integer register_user_id) {
		this.register_user_id = register_user_id;
	}
	
	/**
	 * 联系日期
	 * 
	 * @param contact_date
	 */
	public void setContact_date(Date contact_date) {
		this.contact_date = contact_date;
	}
	
	/**
	 * 联系人
	 * 
	 * @param contact_user_id
	 */
	public void setContact_user_id(Integer contact_user_id) {
		this.contact_user_id = contact_user_id;
	}
	
	/**
	 * 联系结果
	 * 
	 * @param contact_result
	 */
	public void setContact_result(String contact_result) {
		this.contact_result = contact_result;
	}
	
	/**
	 * 联系情况
	 * 
	 * @param contact_information
	 */
	public void setContact_information(String contact_information) {
		this.contact_information = contact_information;
	}
	
	/**
	 * 约定面试日期
	 * 
	 * @param 
interview_date
	 */
	public void setinterview_date(Date interview_date) {
		this.interview_date = interview_date;
	}
	
	/**
	 * 通知入职时间
	 * 
	 * @param notify_entry_time
	 */
	public void setNotify_entry_time(Date notify_entry_time) {
		this.notify_entry_time = notify_entry_time;
	}
	

}