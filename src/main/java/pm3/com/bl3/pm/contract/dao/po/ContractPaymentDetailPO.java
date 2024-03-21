package com.bl3.pm.contract.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_contract_payment_detail[bs_contract_payment_detail]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
public class ContractPaymentDetailPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 支付明细ID
	 */
	private Integer ct_detail_id;
	
	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
	/**
	 * 支付ID
	 */
	private Integer ct_pay_id;
	
	
	
	private String ct_pay_name;
	
	/**
	 * 合同支付阶段ID
	 */
	private Integer ct_stage_id;
	
	
	private String ct_stage_name;
	
	/**
	 * 阶段名称ID
	 */
	private Integer stage_id;
	
	/**
	 * 拆分到阶段的支付金额
	 */
	private BigDecimal pay_money;
	
	/**
	 * 备注
	 */
	private String pay_remark;
	
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
	 * 支付明细ID
	 * 
	 * @return ct_detail_id
	 */
	public Integer getCt_detail_id() {
		return ct_detail_id;
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
	 * 支付ID
	 * 
	 * @return ct_pay_id
	 */
	public Integer getCt_pay_id() {
		return ct_pay_id;
	}
	
	/**
	 * 合同支付阶段ID
	 * 
	 * @return ct_stage_id
	 */
	public Integer getCt_stage_id() {
		return ct_stage_id;
	}
	
	/**
	 * 阶段名称ID
	 * 
	 * @return stage_id
	 */
	public Integer getStage_id() {
		return stage_id;
	}
	
	/**
	 * 拆分到阶段的支付金额
	 * 
	 * @return pay_money
	 */
	public BigDecimal getPay_money() {
		return pay_money;
	}
	
	/**
	 * 备注
	 * 
	 * @return pay_remark
	 */
	public String getPay_remark() {
		return pay_remark;
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
	 * 支付明细ID
	 * 
	 * @param ct_detail_id
	 */
	public void setCt_detail_id(Integer ct_detail_id) {
		this.ct_detail_id = ct_detail_id;
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
	 * 支付ID
	 * 
	 * @param ct_pay_id
	 */
	public void setCt_pay_id(Integer ct_pay_id) {
		this.ct_pay_id = ct_pay_id;
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
	 * 阶段名称ID
	 * 
	 * @param stage_id
	 */
	public void setStage_id(Integer stage_id) {
		this.stage_id = stage_id;
	}
	
	/**
	 * 拆分到阶段的支付金额
	 * 
	 * @param pay_money
	 */
	public void setPay_money(BigDecimal pay_money) {
		this.pay_money = pay_money;
	}
	
	/**
	 * 备注
	 * 
	 * @param pay_remark
	 */
	public void setPay_remark(String pay_remark) {
		this.pay_remark = pay_remark;
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

	public String getCt_pay_name() {
		return ct_pay_name;
	}

	public void setCt_pay_name(String ct_pay_name) {
		this.ct_pay_name = ct_pay_name;
	}

	public String getCt_stage_name() {
		return ct_stage_name;
	}

	public void setCt_stage_name(String ct_stage_name) {
		this.ct_stage_name = ct_stage_name;
	}
	

}