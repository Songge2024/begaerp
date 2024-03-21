package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>pr_contract_pay_info[pr_contract_pay_info]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author gaoyong
 * @date 2017-12-21 14:27:43
 */
public class ContractPayInfoPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 应收金额
	 */
	private BigDecimal rece_amount;
	
	public BigDecimal getRece_amount() {
		return rece_amount;
	}

	public void setRece_amount(BigDecimal rece_amount) {
		this.rece_amount = rece_amount;
	}

	public BigDecimal getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(BigDecimal pay_amount) {
		this.pay_amount = pay_amount;
	}

	public BigDecimal getPercentage() {
		return percentage;
	}

	public void setPercentage(BigDecimal percentage) {
		this.percentage = percentage;
	}

	public String getStage_name() {
		return stage_name;
	}

	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}

	public String getStage_code() {
		return stage_code;
	}

	public void setStage_code(String stage_code) {
		this.stage_code = stage_code;
	}


	/**
	 * 实收金额
	 */
	private BigDecimal pay_amount;
	/**
	 * 支付百分比
	 */
	private BigDecimal percentage;
	/**
	 * 阶段名称
	 */
	private String stage_name;
	/**
	 * 阶段编码
	 */
	private String stage_code;
	/**
	 * 支付ID
	 */
	private Integer pay_id;

	/**
	 * 支付ID
	 */
	private Integer ct_id;
	
	/**
	 * 合同ID
	 */
	private Integer cont_id;
	
	

	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 *  阶段名称ID
	 */
	private Integer stage_id;
	
	/**
	 * 支付名称
	 */
	private String pay_name;
	
	/**
	 * 支付金额
	 */
	private BigDecimal pay_money;
	
	/**
	 * 支付条件
	 */
	private String pay_condition;
	
	/**
	 * 支付时间
	 */
	private Date pay_time;
	
	/**
	 * 支付人
	 */
	private String pay_object;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 创建人
	 */
	private Integer total_pay_money;
	

	/**
	 * 合同名称
	 */
	private String cont_name;
	
	/**
	 * 合同类型
	 */
	private String cont_type;
	
	/**
	 * 合同开始时间
	 */
	private Date cp_bengin_date;
	
	/**
	 * 合同结束时间
	 */
	private Date cp_end_date;
	
	/**
	 * 合同状态：执行中、执行完成
	 */
	private String cp_type;
	
	/**
	 * 总金额
	 */
	private BigDecimal total_money;
	
	/**
	 * 签订时间
	 */
	private Date sign_time;
	
	/**
	 * 合同描述
	 */
	private String cont_desc;
	
	/**
	 * 付款条件
	 */
	private String pt_desc;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	

	public Integer getCt_id() {
		return ct_id;
	}

	public void setCt_id(Integer ct_id) {
		this.ct_id = ct_id;
	}
	

	/**
	 * 创建人名称
	 */
	private String create_user_name;
	public String getCreate_user_name() {
		return create_user_name;
	}

	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}

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
	 * 支付ID
	 * 
	 * @return pay_id
	 */
	public Integer getPay_id() {
		return pay_id;
	}
	
	/**
	 * 合同ID
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
	 *  阶段名称ID
	 * 
	 * @return stage_id
	 */
	public Integer getStage_id() {
		return stage_id;
	}
	
	/**
	 * 支付名称
	 * 
	 * @return pay_name
	 */
	public String getPay_name() {
		return pay_name;
	}
	
	/**
	 * 支付金额
	 * 
	 * @return pay_money
	 */
	public BigDecimal getPay_money() {
		return pay_money;
	}
	
	/**
	 * 支付条件
	 * 
	 * @return pay_condition
	 */
	public String getPay_condition() {
		return pay_condition;
	}
	
	/**
	 * 支付时间
	 * 
	 * @return pay_time
	 */
	public Date getPay_time() {
		return pay_time;
	}
	
	/**
	 * 支付人
	 * 
	 * @return pay_object
	 */
	public String getPay_object() {
		return pay_object;
	}
	
	/**
	 * 备注
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
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
	 * 支付ID
	 * 
	 * @param pay_id
	 */
	public void setPay_id(Integer pay_id) {
		this.pay_id = pay_id;
	}
	
	/**
	 * 合同ID
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
	 *  阶段名称ID
	 * 
	 * @param stage_id
	 */
	public void setStage_id(Integer stage_id) {
		this.stage_id = stage_id;
	}
	
	/**
	 * 支付名称
	 * 
	 * @param pay_name
	 */
	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}
	
	/**
	 * 支付金额
	 * 
	 * @param pay_money
	 */
	public void setPay_money(BigDecimal pay_money) {
		this.pay_money = pay_money;
	}
	
	/**
	 * 支付条件
	 * 
	 * @param pay_condition
	 */
	public void setPay_condition(String pay_condition) {
		this.pay_condition = pay_condition;
	}
	
	/**
	 * 支付时间
	 * 
	 * @param pay_time
	 */
	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}
	
	/**
	 * 支付人
	 * 
	 * @param pay_object
	 */
	public void setPay_object(String pay_object) {
		this.pay_object = pay_object;
	}
	
	/**
	 * 备注
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
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

	public Integer getTotal_pay_money() {
		return total_pay_money;
	}

	public void setTotal_pay_money(Integer total_pay_money) {
		this.total_pay_money = total_pay_money;
	}

	public String getCont_name() {
		return cont_name;
	}

	public void setCont_name(String cont_name) {
		this.cont_name = cont_name;
	}

	public String getCont_type() {
		return cont_type;
	}

	public void setCont_type(String cont_type) {
		this.cont_type = cont_type;
	}

	public Date getCp_bengin_date() {
		return cp_bengin_date;
	}

	public void setCp_bengin_date(Date cp_bengin_date) {
		this.cp_bengin_date = cp_bengin_date;
	}

	public Date getCp_end_date() {
		return cp_end_date;
	}

	public void setCp_end_date(Date cp_end_date) {
		this.cp_end_date = cp_end_date;
	}

	public String getCp_type() {
		return cp_type;
	}

	public void setCp_type(String cp_type) {
		this.cp_type = cp_type;
	}

	public BigDecimal getTotal_money() {
		return total_money;
	}

	public void setTotal_money(BigDecimal total_money) {
		this.total_money = total_money;
	}

	public Date getSign_time() {
		return sign_time;
	}

	public void setSign_time(Date sign_time) {
		this.sign_time = sign_time;
	}

	public String getCont_desc() {
		return cont_desc;
	}

	public void setCont_desc(String cont_desc) {
		this.cont_desc = cont_desc;
	}

	public String getPt_desc() {
		return pt_desc;
	}

	public void setPt_desc(String pt_desc) {
		this.pt_desc = pt_desc;
	}
	

}