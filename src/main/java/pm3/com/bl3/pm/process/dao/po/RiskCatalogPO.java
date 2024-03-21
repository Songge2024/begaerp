package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_risk_catalog[pr_risk_catalog]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2018-01-09 09:39:52
 */
public class RiskCatalogPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 风险目录ID
	 */
	private Integer risk_cata_id;
	
	/**
	 * 风险目录名称
	 */
	private String risk_cata_name;
	
	/**
	 * 说明
	 */
	private String comment;
	
	/**
	 * risk_state
	 */
	private String risk_state;
	
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
	 * 风险目录ID
	 * 
	 * @return risk_cata_id
	 */
	public Integer getRisk_cata_id() {
		return risk_cata_id;
	}
	
	/**
	 * 风险目录名称
	 * 
	 * @return risk_cata_name
	 */
	public String getRisk_cata_name() {
		return risk_cata_name;
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
	 * risk_state
	 * 
	 * @return risk_state
	 */
	public String getRisk_state() {
		return risk_state;
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
	 * 风险目录ID
	 * 
	 * @param risk_cata_id
	 */
	public void setRisk_cata_id(Integer risk_cata_id) {
		this.risk_cata_id = risk_cata_id;
	}
	
	/**
	 * 风险目录名称
	 * 
	 * @param risk_cata_name
	 */
	public void setRisk_cata_name(String risk_cata_name) {
		this.risk_cata_name = risk_cata_name;
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
	 * risk_state
	 * 
	 * @param risk_state
	 */
	public void setRisk_state(String risk_state) {
		this.risk_state = risk_state;
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