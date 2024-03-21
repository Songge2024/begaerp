package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_proj_contract[bs_proj_contract]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author gaoyong
 * @date 2017-12-21 16:29:14
 */
public class BsProjContractPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 合同名称
	 */
	private String cont_name;
	
	/**
	 * 合同类型
	 */
	private String cont_type;
	
	/**
	 * 付款条件
	 */
	private String pt_desc;
	
	/**
	 * 总金额
	 */
	private BigDecimal total_money;
	
	/**
	 * 签订时间
	 */
	private Date sign_time;
	
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
	 * 合同描述
	 */
	private String cont_desc;
	

	/**
	 * 合同ID
	 * 
	 * @return ct_id
	 */
	public Integer getCt_id() {
		return ct_id;
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
	 * 合同名称
	 * 
	 * @return cont_name
	 */
	public String getCont_name() {
		return cont_name;
	}
	
	/**
	 * 合同类型
	 * 
	 * @return cont_type
	 */
	public String getCont_type() {
		return cont_type;
	}
	
	/**
	 * 付款条件
	 * 
	 * @return pt_desc
	 */
	public String getPt_desc() {
		return pt_desc;
	}
	
	/**
	 * 总金额
	 * 
	 * @return total_money
	 */
	public BigDecimal getTotal_money() {
		return total_money;
	}
	
	/**
	 * 签订时间
	 * 
	 * @return sign_time
	 */
	public Date getSign_time() {
		return sign_time;
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
	 * 合同描述
	 * 
	 * @return cont_desc
	 */
	public String getCont_desc() {
		return cont_desc;
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
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 合同名称
	 * 
	 * @param cont_name
	 */
	public void setCont_name(String cont_name) {
		this.cont_name = cont_name;
	}
	
	/**
	 * 合同类型
	 * 
	 * @param cont_type
	 */
	public void setCont_type(String cont_type) {
		this.cont_type = cont_type;
	}
	
	/**
	 * 付款条件
	 * 
	 * @param pt_desc
	 */
	public void setPt_desc(String pt_desc) {
		this.pt_desc = pt_desc;
	}
	
	/**
	 * 总金额
	 * 
	 * @param total_money
	 */
	public void setTotal_money(BigDecimal total_money) {
		this.total_money = total_money;
	}
	
	/**
	 * 签订时间
	 * 
	 * @param sign_time
	 */
	public void setSign_time(Date sign_time) {
		this.sign_time = sign_time;
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
	
	/**
	 * 合同描述
	 * 
	 * @param cont_desc
	 */
	public void setCont_desc(String cont_desc) {
		this.cont_desc = cont_desc;
	}
	

}