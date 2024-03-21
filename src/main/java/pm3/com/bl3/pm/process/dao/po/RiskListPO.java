package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_risk_list[pr_risk_list]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2018-01-10 08:27:14
 */
public class RiskListPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 风险ID
	 */
	private Integer risk_id;
	
	/**
	 * 风险目录ID
	 */
	private Integer risk_cata_id;
	
	/**
	 * 风险目录ID
	 */
	private String risk_cata_id_name;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 风险描述
	 */
	private String risk_cata_name;
	
	/**
	 * 发生概率 百分比
	 */
	private Integer happ_probability;
	
	/**
	 * 影响程度
	 */
	private String influe_degree;
	
	/**
	 * 风险等级
	 */
	private String risk_level;
	
	/**
	 * 风险响应计划
	 */
	private String risk_resp_plan;
	
	/**
	 * 责任人
	 */
	private String risk_owner;
	
	/**
	 * 开放或关闭  1开放 0 关闭
	 */
	private String open_close;
	
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
	 * 风险ID
	 * 
	 * @return risk_id
	 */
	public Integer getRisk_id() {
		return risk_id;
	}
	
	/**
	 * 风险目录ID
	 * 
	 * @return risk_cata_id
	 */
	public Integer getRisk_cata_id() {
		return risk_cata_id;
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
	 * 风险描述
	 * 
	 * @return risk_cata_name
	 */
	public String getRisk_cata_name() {
		return risk_cata_name;
	}
	
	/**
	 * 发生概率 百分比
	 * 
	 * @return happ_probability
	 */
	public Integer getHapp_probability() {
		return happ_probability;
	}
	
	/**
	 * 影响程度
	 * 
	 * @return influe_degree
	 */
	public String getInflue_degree() {
		return influe_degree;
	}
	
	/**
	 * 风险等级
	 * 
	 * @return risk_level
	 */
	public String getRisk_level() {
		return risk_level;
	}
	
	/**
	 * 风险响应计划
	 * 
	 * @return risk_resp_plan
	 */
	public String getRisk_resp_plan() {
		return risk_resp_plan;
	}
	
	/**
	 * 责任人
	 * 
	 * @return risk_owner
	 */
	public String getRisk_owner() {
		return risk_owner;
	}
	
	/**
	 * 开放或关闭  1开放 0 关闭
	 * 
	 * @return open_close
	 */
	public String getOpen_close() {
		return open_close;
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
	 * 风险ID
	 * 
	 * @param risk_id
	 */
	public void setRisk_id(Integer risk_id) {
		this.risk_id = risk_id;
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
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 风险描述
	 * 
	 * @param risk_cata_name
	 */
	public void setRisk_cata_name(String risk_cata_name) {
		this.risk_cata_name = risk_cata_name;
	}
	
	/**
	 * 发生概率 百分比
	 * 
	 * @param happ_probability
	 */
	public void setHapp_probability(Integer happ_probability) {
		this.happ_probability = happ_probability;
	}
	
	/**
	 * 影响程度
	 * 
	 * @param influe_degree
	 */
	public void setInflue_degree(String influe_degree) {
		this.influe_degree = influe_degree;
	}
	
	/**
	 * 风险等级
	 * 
	 * @param risk_level
	 */
	public void setRisk_level(String risk_level) {
		this.risk_level = risk_level;
	}
	
	/**
	 * 风险响应计划
	 * 
	 * @param risk_resp_plan
	 */
	public void setRisk_resp_plan(String risk_resp_plan) {
		this.risk_resp_plan = risk_resp_plan;
	}
	
	/**
	 * 责任人
	 * 
	 * @param risk_owner
	 */
	public void setRisk_owner(String risk_owner) {
		this.risk_owner = risk_owner;
	}
	
	/**
	 * 开放或关闭  1开放 0 关闭
	 * 
	 * @param open_close
	 */
	public void setOpen_close(String open_close) {
		this.open_close = open_close;
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

	public String getRisk_cata_id_name() {
		return risk_cata_id_name;
	}

	public void setRisk_cata_id_name(String risk_cata_id_name) {
		this.risk_cata_id_name = risk_cata_id_name;
	}
	
	
	

}