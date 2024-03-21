package com.bl3.pm.contract.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_contract_stage[bs_contract_stage]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
public class ContractStagePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 合同支付阶段ID
	 */
	private Integer ct_stage_id;
	
	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
	/**
	 * 阶段编码
	 */
	private String stage_code;
	
	/**
	 * 阶段名称
	 */
	private String stage_name;
	
	/**
	 * 支付百分比
	 */
	private BigDecimal percentage;
	
	/**
	 * 应收金额
	 */
	private BigDecimal rece_amount;
	
	/**
	 * 实收金额
	 */
	private BigDecimal pay_amount;
	
	/**
	 * 备注
	 */
	private String stage_remark;
	
	/**
	 * 创建人
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
	 * 合同支付阶段ID
	 * 
	 * @return ct_stage_id
	 */
	public Integer getCt_stage_id() {
		return ct_stage_id;
	}
	
	/**
	 * 合同ID
	 * 
	 * @return ct_id
	 */
	public Integer getCt_id() {
		return ct_id;
	}
	
	/**
	 * 阶段编码
	 * 
	 * @return stage_code
	 */
	public String getStage_code() {
		return stage_code;
	}
	
	/**
	 * 阶段名称
	 * 
	 * @return stage_name
	 */
	public String getStage_name() {
		return stage_name;
	}
	
	/**
	 * 支付百分比
	 * 
	 * @return percentage
	 */
	public BigDecimal getPercentage() {
		return percentage;
	}
	
	/**
	 * 应收金额
	 * 
	 * @return rece_amount
	 */
	public BigDecimal getRece_amount() {
		return rece_amount;
	}
	
	/**
	 * 实收金额
	 * 
	 * @return pay_amount
	 */
	public BigDecimal getPay_amount() {
		return pay_amount;
	}
	
	/**
	 * 备注
	 * 
	 * @return stage_remark
	 */
	public String getStage_remark() {
		return stage_remark;
	}
	
	/**
	 * 创建人
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
	 * 合同支付阶段ID
	 * 
	 * @param ct_stage_id
	 */
	public void setCt_stage_id(Integer ct_stage_id) {
		this.ct_stage_id = ct_stage_id;
	}
	
	/**
	 * 合同ID
	 * 
	 * @param ct_id
	 */
	public void setCt_id(Integer ct_id) {
		this.ct_id = ct_id;
	}
	
	/**
	 * 阶段编码
	 * 
	 * @param stage_code
	 */
	public void setStage_code(String stage_code) {
		this.stage_code = stage_code;
	}
	
	/**
	 * 阶段名称
	 * 
	 * @param stage_name
	 */
	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}
	
	/**
	 * 支付百分比
	 * 
	 * @param percentage
	 */
	public void setPercentage(BigDecimal percentage) {
		this.percentage = percentage;
	}
	
	/**
	 * 应收金额
	 * 
	 * @param rece_amount
	 */
	public void setRece_amount(BigDecimal rece_amount) {
		this.rece_amount = rece_amount;
	}
	
	/**
	 * 实收金额
	 * 
	 * @param pay_amount
	 */
	public void setPay_amount(BigDecimal pay_amount) {
		this.pay_amount = pay_amount;
	}
	
	/**
	 * 备注
	 * 
	 * @param stage_remark
	 */
	public void setStage_remark(String stage_remark) {
		this.stage_remark = stage_remark;
	}
	
	/**
	 * 创建人
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