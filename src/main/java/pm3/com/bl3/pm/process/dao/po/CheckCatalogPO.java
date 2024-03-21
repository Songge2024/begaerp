package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_check_catalog[pr_check_catalog]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-10 13:57:28
 */
public class CheckCatalogPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 检查单目录ID
	 */
	private Integer check_cata_id;
	
	/**
	 * 项目类型ID
	 */
	private String type_code;
	
	/**
	 * 检查单名称
	 */
	private String check_cata_name;
	
	/**
	 * 说明
	 */
	private String remark;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
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
	 * 状态(1为启用，0为不启用）
	 */
	private String state;
	
	private String state_name;
	
	

	public String getState_name() {
		return state_name;
	}

	public void setState_name(String state_name) {
		this.state_name = state_name;
	}

	/**
	 * 检查单目录ID
	 * 
	 * @return check_cata_id
	 */
	public Integer getCheck_cata_id() {
		return check_cata_id;
	}
	
	/**
	 * 项目类型ID
	 * 
	 * @return type_code
	 */
	public String getType_code() {
		return type_code;
	}
	
	/**
	 * 检查单名称
	 * 
	 * @return check_cata_name
	 */
	public String getCheck_cata_name() {
		return check_cata_name;
	}
	
	/**
	 * 说明
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sort_no
	 */
	public Integer getSort_no() {
		return sort_no;
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
	 * 状态(1为启用，0为不启用）
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 检查单目录ID
	 * 
	 * @param check_cata_id
	 */
	public void setCheck_cata_id(Integer check_cata_id) {
		this.check_cata_id = check_cata_id;
	}
	
	/**
	 * 项目类型ID
	 * 
	 * @param type_code
	 */
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	
	/**
	 * 检查单名称
	 * 
	 * @param check_cata_name
	 */
	public void setCheck_cata_name(String check_cata_name) {
		this.check_cata_name = check_cata_name;
	}
	
	/**
	 * 说明
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
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
	 * 状态(1为启用，0为不启用）
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}