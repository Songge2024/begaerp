package com.bl3.pm.contacts.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>qa_top_contacts[qa_top_contacts]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zhaojiaqi
 * @date 2020-03-30 15:54:55
 */
public class TopContactsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 常用id
	 */
	private Integer top_id;
	
	/**
	 * 常用联系人
	 */
	private String top_name;
	
	/**
	 * 用户ID
	 */
	private Integer user_id;
	
	/**
	 * 创建人id
	 */
	private Integer create_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 常用联系人所属部门
	 */
	private String top_org_name;
	

	/**
	 * 常用联系人所属部门id
	 */
	private String top_org_name_id;
	
	/**
	 * 常用联系人角色
	 */
	private String top_role_name;
	
	/**
	 * 常用联系人性别
	 */
	private String top_sex;
	

	/**
	 * 常用id
	 * 
	 * @return top_id
	 */
	public Integer getTop_id() {
		return top_id;
	}
	
	/**
	 * 常用联系人
	 * 
	 * @return top_name
	 */
	public String getTop_name() {
		return top_name;
	}
	
	/**
	 * 用户ID
	 * 
	 * @return user_id
	 */
	public Integer getUser_id() {
		return user_id;
	}
	
	/**
	 * 创建人id
	 * 
	 * @return create_id
	 */
	public Integer getCreate_id() {
		return create_id;
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
	 * 常用联系人所属部门
	 * 
	 * @return top_org_name
	 */
	public String getTop_org_name() {
		return top_org_name;
	}
	
	/**
	 * 常用联系人角色
	 * 
	 * @return top_role_name
	 */
	public String getTop_role_name() {
		return top_role_name;
	}
	
	/**
	 * 常用联系人性别
	 * 
	 * @return top_sex
	 */
	public String getTop_sex() {
		return top_sex;
	}
	

	/**
	 * 常用id
	 * 
	 * @param top_id
	 */
	public void setTop_id(Integer top_id) {
		this.top_id = top_id;
	}
	
	/**
	 * 常用联系人
	 * 
	 * @param top_name
	 */
	public void setTop_name(String top_name) {
		this.top_name = top_name;
	}
	
	/**
	 * 用户ID
	 * 
	 * @param user_id
	 */
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	
	/**
	 * 创建人id
	 * 
	 * @param create_id
	 */
	public void setCreate_id(Integer create_id) {
		this.create_id = create_id;
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
	 * 常用联系人所属部门
	 * 
	 * @param top_org_name
	 */
	public void setTop_org_name(String top_org_name) {
		this.top_org_name = top_org_name;
	}
	
	/**
	 * 常用联系人角色
	 * 
	 * @param top_role_name
	 */
	public void setTop_role_name(String top_role_name) {
		this.top_role_name = top_role_name;
	}
	
	/**
	 * 常用联系人性别
	 * 
	 * @param top_sex
	 */
	public void setTop_sex(String top_sex) {
		this.top_sex = top_sex;
	}
	

	public String getTop_org_name_id() {
		return top_org_name_id;
	}
	
	public void setTop_org_name_id(String top_org_name_id) {
		this.top_org_name_id = top_org_name_id;
	}
}