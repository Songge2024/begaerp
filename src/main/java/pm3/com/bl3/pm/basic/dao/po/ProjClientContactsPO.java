package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>bs_proj_client_contacts[bs_proj_client_contacts]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yj
 * @date 2017-12-13 14:59:53
 */
public class ProjClientContactsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 联系人ID
	 */
	private Integer cont_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 联系人姓名
	 */
	private String cont_name;
	
	/**
	 * 联系人电话
	 */
	private String cont_phone;
	
	/**
	 * 联系人邮箱
	 */
	private String cont_email;
	
	/**
	 * 沟通说明
	 */
	private String cont_remark;
	
	/**
	 * 沟通频次
	 */
	private String cont_frequency;
	
	/**
	 * 联系人说明
	 */
	private String cont_desc;
	

	/**
	 * 联系人ID
	 * 
	 * @return cont_id
	 */
	public Integer getCont_id() {
		return cont_id;
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
	 * 联系人姓名
	 * 
	 * @return cont_name
	 */
	public String getCont_name() {
		return cont_name;
	}
	
	/**
	 * 联系人电话
	 * 
	 * @return cont_phone
	 */
	public String getCont_phone() {
		return cont_phone;
	}
	
	/**
	 * 联系人邮箱
	 * 
	 * @return cont_email
	 */
	public String getCont_email() {
		return cont_email;
	}
	
	/**
	 * 沟通说明
	 * 
	 * @return cont_remark
	 */
	public String getCont_remark() {
		return cont_remark;
	}
	
	/**
	 * 沟通频次
	 * 
	 * @return cont_frequency
	 */
	public String getCont_frequency() {
		return cont_frequency;
	}
	
	/**
	 * 联系人说明
	 * 
	 * @return cont_desc
	 */
	public String getCont_desc() {
		return cont_desc;
	}
	

	/**
	 * 联系人ID
	 * 
	 * @param cont_id
	 */
	public void setCont_id(Integer cont_id) {
		this.cont_id = cont_id;
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
	 * 联系人姓名
	 * 
	 * @param cont_name
	 */
	public void setCont_name(String cont_name) {
		this.cont_name = cont_name;
	}
	
	/**
	 * 联系人电话
	 * 
	 * @param cont_phone
	 */
	public void setCont_phone(String cont_phone) {
		this.cont_phone = cont_phone;
	}
	
	/**
	 * 联系人邮箱
	 * 
	 * @param cont_email
	 */
	public void setCont_email(String cont_email) {
		this.cont_email = cont_email;
	}
	
	/**
	 * 沟通说明
	 * 
	 * @param cont_remark
	 */
	public void setCont_remark(String cont_remark) {
		this.cont_remark = cont_remark;
	}
	
	/**
	 * 沟通频次
	 * 
	 * @param cont_frequency
	 */
	public void setCont_frequency(String cont_frequency) {
		this.cont_frequency = cont_frequency;
	}
	
	/**
	 * 联系人说明
	 * 
	 * @param cont_desc
	 */
	public void setCont_desc(String cont_desc) {
		this.cont_desc = cont_desc;
	}
	

}