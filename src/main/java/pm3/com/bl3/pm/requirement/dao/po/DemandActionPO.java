package com.bl3.pm.requirement.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>re_demand_action[re_demand_action]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2017-12-19 11:08:28
 */
public class DemandActionPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 需求表ID
	 */
	private Integer ad_id;
	
	/**
	 * 需求功能表ID
	 */
	private String ad_code;
	
	/**
	 * 功能模块ID
	 */
	private String dm_code;
	
	/**
	 * 名称
	 */
	private String ad_name;
	
	/**
	 * 需求类型
	 */
	private String ad_type;
	
	/**
	 * 提出时间
	 */
	private Date ad_raise_date;
	
	/**
	 * 计划完成时间
	 */
	private Date ad_plan_finish_date;
	
	/**
	 * 要求完成时间
	 */
	private Date ad_claim_finish_date;
	
	/**
	 * 实际完成时间
	 */
	private Date ad_actual_finish_date;
	
	/**
	 * 需求来源
	 */
	private String ad_source;
	
	/**
	 * 来源说明
	 */
	private String ad_source_remark;
	
	/**
	 * 难易程度
	 */
	private String ad_difficulty;
	
	/**
	 * 优先级
	 */
	private String ad_priority;
	
	/**
	 * 估计工作量
	 */
	private String ad_workload;
	
	/**
	 * 内容
	 */
	private String ad_content;
	
	/**
	 * 备注
	 */
	private String ad_remark;
	
	/**
	 * 变更来源
	 */
	private String ad_chage_source;
	
	/**
	 * 变更提出人
	 */
	private String ad_chage_introducer;
	
	/**
	 * 变更软件版本号
	 */
	private String ad_chage_number;
	
	/**
	 * 变更审核意见
	 */
	private String ad_chage_audit;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 修改人
	 */
	private Integer update_user_id;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 新增人
	 */
	private Integer create_user_id;
	
	/**
	 * 新增时间
	 */
	private Date create_time;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 需求编码
	 */
	private String demand_code;
	
	/**
	 * 第一模块编码	
	 */
	private String dm_first_code;

	
	public String getDm_first_code() {
		return dm_first_code;
	}

	public void setDm_first_code(String dm_first_code) {
		this.dm_first_code = dm_first_code;
	}

	/**
	 * 产品是否满足(0:否,1:是)
	 */
	private String is_product_satisfied;
	
	/**
	 * 要求开始时间
	 */
	private Date ad_claim_start_date;
	
	/**
	 * 开发成员
	 */
	private String development_member;

	public String getIs_product_satisfied() {
		return is_product_satisfied;
	}

	public void setIs_product_satisfied(String is_product_satisfied) {
		this.is_product_satisfied = is_product_satisfied;
	}

	public Date getAd_claim_start_date() {
		return ad_claim_start_date;
	}

	public void setAd_claim_start_date(Date ad_claim_start_date) {
		this.ad_claim_start_date = ad_claim_start_date;
	}

	public String getDevelopment_member() {
		return development_member;
	}

	public void setDevelopment_member(String development_member) {
		this.development_member = development_member;
	}

	/**
	 * 需求表ID
	 * 
	 * @return ad_id
	 */
	public Integer getAd_id() {
		return ad_id;
	}
	
	/**
	 * 需求功能表ID
	 * 
	 * @return ad_code
	 */
	public String getAd_code() {
		return ad_code;
	}
	
	/**
	 * 功能模块ID
	 * 
	 * @return dm_code
	 */
	public String getDm_code() {
		return dm_code;
	}
	
	/**
	 * 名称
	 * 
	 * @return ad_name
	 */
	public String getAd_name() {
		return ad_name;
	}
	
	/**
	 * 需求类型
	 * 
	 * @return ad_type
	 */
	public String getAd_type() {
		return ad_type;
	}
	
	/**
	 * 提出时间
	 * 
	 * @return ad_raise_date
	 */
	public Date getAd_raise_date() {
		return ad_raise_date;
	}
	
	/**
	 * 计划完成时间
	 * 
	 * @return ad_plan_finish_date
	 */
	public Date getAd_plan_finish_date() {
		return ad_plan_finish_date;
	}
	
	/**
	 * 要求完成时间
	 * 
	 * @return ad_claim_finish_date
	 */
	public Date getAd_claim_finish_date() {
		return ad_claim_finish_date;
	}
	
	/**
	 * 实际完成时间
	 * 
	 * @return ad_actual_finish_date
	 */
	public Date getAd_actual_finish_date() {
		return ad_actual_finish_date;
	}
	
	/**
	 * 需求来源
	 * 
	 * @return ad_source
	 */
	public String getAd_source() {
		return ad_source;
	}
	
	/**
	 * 来源说明
	 * 
	 * @return ad_source_remark
	 */
	public String getAd_source_remark() {
		return ad_source_remark;
	}
	
	/**
	 * 难易程度
	 * 
	 * @return ad_difficulty
	 */
	public String getAd_difficulty() {
		return ad_difficulty;
	}
	
	/**
	 * 优先级
	 * 
	 * @return ad_priority
	 */
	public String getAd_priority() {
		return ad_priority;
	}
	
	/**
	 * 估计工作量
	 * 
	 * @return ad_workload
	 */
	public String getAd_workload() {
		return ad_workload;
	}
	
	/**
	 * 内容
	 * 
	 * @return ad_content
	 */
	public String getAd_content() {
		return ad_content;
	}
	
	/**
	 * 备注
	 * 
	 * @return ad_remark
	 */
	public String getAd_remark() {
		return ad_remark;
	}
	
	/**
	 * 变更来源
	 * 
	 * @return ad_chage_source
	 */
	public String getAd_chage_source() {
		return ad_chage_source;
	}
	
	/**
	 * 变更提出人
	 * 
	 * @return ad_chage_introducer
	 */
	public String getAd_chage_introducer() {
		return ad_chage_introducer;
	}
	
	/**
	 * 变更软件版本号
	 * 
	 * @return ad_chage_number
	 */
	public String getAd_chage_number() {
		return ad_chage_number;
	}
	
	/**
	 * 变更审核意见
	 * 
	 * @return ad_chage_audit
	 */
	public String getAd_chage_audit() {
		return ad_chage_audit;
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
	 * 修改人
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
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
	 * 新增人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 新增时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
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
	 * 需求表ID
	 * 
	 * @param ad_id
	 */
	public void setAd_id(Integer ad_id) {
		this.ad_id = ad_id;
	}
	
	/**
	 * 需求功能表ID
	 * 
	 * @param ad_code
	 */
	public void setAd_code(String ad_code) {
		this.ad_code = ad_code;
	}
	
	/**
	 * 功能模块ID
	 * 
	 * @param dm_code
	 */
	public void setDm_code(String dm_code) {
		this.dm_code = dm_code;
	}
	
	/**
	 * 名称
	 * 
	 * @param ad_name
	 */
	public void setAd_name(String ad_name) {
		this.ad_name = ad_name;
	}
	
	/**
	 * 需求类型
	 * 
	 * @param ad_type
	 */
	public void setAd_type(String ad_type) {
		this.ad_type = ad_type;
	}
	
	/**
	 * 提出时间
	 * 
	 * @param ad_raise_date
	 */
	public void setAd_raise_date(Date ad_raise_date) {
		this.ad_raise_date = ad_raise_date;
	}
	
	/**
	 * 计划完成时间
	 * 
	 * @param ad_plan_finish_date
	 */
	public void setAd_plan_finish_date(Date ad_plan_finish_date) {
		this.ad_plan_finish_date = ad_plan_finish_date;
	}
	
	/**
	 * 要求完成时间
	 * 
	 * @param ad_claim_finish_date
	 */
	public void setAd_claim_finish_date(Date ad_claim_finish_date) {
		this.ad_claim_finish_date = ad_claim_finish_date;
	}
	
	/**
	 * 实际完成时间
	 * 
	 * @param ad_actual_finish_date
	 */
	public void setAd_actual_finish_date(Date ad_actual_finish_date) {
		this.ad_actual_finish_date = ad_actual_finish_date;
	}
	
	/**
	 * 需求来源
	 * 
	 * @param ad_source
	 */
	public void setAd_source(String ad_source) {
		this.ad_source = ad_source;
	}
	
	/**
	 * 来源说明
	 * 
	 * @param ad_source_remark
	 */
	public void setAd_source_remark(String ad_source_remark) {
		this.ad_source_remark = ad_source_remark;
	}
	
	/**
	 * 难易程度
	 * 
	 * @param ad_difficulty
	 */
	public void setAd_difficulty(String ad_difficulty) {
		this.ad_difficulty = ad_difficulty;
	}
	
	/**
	 * 优先级
	 * 
	 * @param ad_priority
	 */
	public void setAd_priority(String ad_priority) {
		this.ad_priority = ad_priority;
	}
	
	/**
	 * 估计工作量
	 * 
	 * @param ad_workload
	 */
	public void setAd_workload(String ad_workload) {
		this.ad_workload = ad_workload;
	}
	
	/**
	 * 内容
	 * 
	 * @param ad_content
	 */
	public void setAd_content(String ad_content) {
		this.ad_content = ad_content;
	}
	
	/**
	 * 备注
	 * 
	 * @param ad_remark
	 */
	public void setAd_remark(String ad_remark) {
		this.ad_remark = ad_remark;
	}
	
	/**
	 * 变更来源
	 * 
	 * @param ad_chage_source
	 */
	public void setAd_chage_source(String ad_chage_source) {
		this.ad_chage_source = ad_chage_source;
	}
	
	/**
	 * 变更提出人
	 * 
	 * @param ad_chage_introducer
	 */
	public void setAd_chage_introducer(String ad_chage_introducer) {
		this.ad_chage_introducer = ad_chage_introducer;
	}
	
	/**
	 * 变更软件版本号
	 * 
	 * @param ad_chage_number
	 */
	public void setAd_chage_number(String ad_chage_number) {
		this.ad_chage_number = ad_chage_number;
	}
	
	/**
	 * 变更审核意见
	 * 
	 * @param ad_chage_audit
	 */
	public void setAd_chage_audit(String ad_chage_audit) {
		this.ad_chage_audit = ad_chage_audit;
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
	 * 修改人
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
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
	 * 新增人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 新增时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public String getDemand_code() {
		return demand_code;
	}

	public void setDemand_code(String demand_code) {
		this.demand_code = demand_code;
	}
	

}