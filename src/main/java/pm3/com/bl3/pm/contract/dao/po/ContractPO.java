package com.bl3.pm.contract.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_contract[bs_contract]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-24 17:34:23
 */
public class ContractPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
	/**
	 * 合同编码
	 */
	private String ct_code;
	
	/**
	 * 合同名称
	 */
	private String ct_name;
	
	/**
	 * 合同类型
	 */
	private String ct_type;
	/**
	 * 合同性质
	 */
	private String ct_properties;
	/**
	 * 销售代表
	 */
	private String sales_leader;
	
	/**
	 * 甲方名称
	 */
	private String partya_name;
	
	/**
	 * 乙方名称
	 */
	private String partyb_name;
	
	/**
	 * 丙方名称
	 */
	private String partyc_name;
	
	/**
	 * 合同总金额
	 */
	private BigDecimal ct_total_amount;
	
	/**
	 * 合同签订时间
	 */
	private Date ct_sign_date;
	
	/**
	 * 合同生效日期
	 */
	private Date ct_begin_date;
	
	/**
	 * 合同终止日期
	 */
	private Date ct_end_date;
	
	/**
	 * 合同备注
	 */
	private String ct_remark;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 创建日期
	 */
	private Date create_date;
	
	/**
	 * 修改人
	 */
	private Integer update_user_id;
	
	/**
	 * 修改日期
	 */
	private Date update_date;
	
	/**
	 * 合同状态
	 */
	private String state;
	
	/**
	 * 作废原因
	 */
	private String reason;
	

	/**
	 * 合同ID
	 * 
	 * @return ct_id
	 */
	public Integer getCt_id() {
		return ct_id;
	}
	
	/**
	 * 合同编码
	 * 
	 * @return ct_code
	 */
	public String getCt_code() {
		return ct_code;
	}
	
	/**
	 * 合同名称
	 * 
	 * @return ct_name
	 */
	public String getCt_name() {
		return ct_name;
	}
	
	/**
	 * 合同类型
	 * 
	 * @return ct_type
	 */
	public String getCt_type() {
		return ct_type;
	}
	
	/**
	 * 甲方名称
	 * 
	 * @return partya_name
	 */
	public String getPartya_name() {
		return partya_name;
	}
	
	/**
	 * 乙方名称
	 * 
	 * @return partyb_name
	 */
	public String getPartyb_name() {
		return partyb_name;
	}
	
	/**
	 * 丙方名称
	 * 
	 * @return partyc_name
	 */
	public String getPartyc_name() {
		return partyc_name;
	}
	
	/**
	 * 合同总金额
	 * 
	 * @return ct_total_amount
	 */
	public BigDecimal getCt_total_amount() {
		return ct_total_amount;
	}
	
	/**
	 * 合同签订时间
	 * 
	 * @return ct_sign_date
	 */
	public Date getCt_sign_date() {
		return ct_sign_date;
	}
	
	/**
	 * 合同生效日期
	 * 
	 * @return ct_begin_date
	 */
	public Date getCt_begin_date() {
		return ct_begin_date;
	}
	
	/**
	 * 合同终止日期
	 * 
	 * @return ct_end_date
	 */
	public Date getCt_end_date() {
		return ct_end_date;
	}
	
	/**
	 * 合同备注
	 * 
	 * @return ct_remark
	 */
	public String getCt_remark() {
		return ct_remark;
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
	 * 创建日期
	 * 
	 * @return create_date
	 */
	public Date getCreate_date() {
		return create_date;
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
	 * 修改日期
	 * 
	 * @return update_date
	 */
	public Date getUpdate_date() {
		return update_date;
	}
	
	/**
	 * 合同状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 作废原因
	 * 
	 * @return reason
	 */
	public String getReason() {
		return reason;
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
	 * 合同编码
	 * 
	 * @param ct_code
	 */
	public void setCt_code(String ct_code) {
		this.ct_code = ct_code;
	}
	
	/**
	 * 合同名称
	 * 
	 * @param ct_name
	 */
	public void setCt_name(String ct_name) {
		this.ct_name = ct_name;
	}
	
	/**
	 * 合同类型
	 * 
	 * @param ct_type
	 */
	public void setCt_type(String ct_type) {
		this.ct_type = ct_type;
	}
	
	/**
	 * 甲方名称
	 * 
	 * @param partya_name
	 */
	public void setPartya_name(String partya_name) {
		this.partya_name = partya_name;
	}
	
	/**
	 * 乙方名称
	 * 
	 * @param partyb_name
	 */
	public void setPartyb_name(String partyb_name) {
		this.partyb_name = partyb_name;
	}
	
	/**
	 * 丙方名称
	 * 
	 * @param partyc_name
	 */
	public void setPartyc_name(String partyc_name) {
		this.partyc_name = partyc_name;
	}
	
	/**
	 * 合同总金额
	 * 
	 * @param ct_total_amount
	 */
	public void setCt_total_amount(BigDecimal ct_total_amount) {
		this.ct_total_amount = ct_total_amount;
	}
	
	/**
	 * 合同签订时间
	 * 
	 * @param ct_sign_date
	 */
	public void setCt_sign_date(Date ct_sign_date) {
		this.ct_sign_date = ct_sign_date;
	}
	
	/**
	 * 合同生效日期
	 * 
	 * @param ct_begin_date
	 */
	public void setCt_begin_date(Date ct_begin_date) {
		this.ct_begin_date = ct_begin_date;
	}
	
	/**
	 * 合同终止日期
	 * 
	 * @param ct_end_date
	 */
	public void setCt_end_date(Date ct_end_date) {
		this.ct_end_date = ct_end_date;
	}
	
	/**
	 * 合同备注
	 * 
	 * @param ct_remark
	 */
	public void setCt_remark(String ct_remark) {
		this.ct_remark = ct_remark;
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
	 * 创建日期
	 * 
	 * @param create_date
	 */
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
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
	 * 修改日期
	 * 
	 * @param update_date
	 */
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	
	/**
	 * 合同状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 作废原因
	 * 
	 * @param reason
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getCt_properties() {
		return ct_properties;
	}

	public void setCt_properties(String ct_properties) {
		this.ct_properties = ct_properties;
	}

	public String getSales_leader() {
		return sales_leader;
	}

	public void setSales_leader(String sales_leader) {
		this.sales_leader = sales_leader;
	}
	

}