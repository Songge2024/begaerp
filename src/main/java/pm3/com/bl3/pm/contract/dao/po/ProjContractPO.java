package com.bl3.pm.contract.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_contract[bs_proj_contract]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
public class ProjContractPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 项目合同ID
	 */
	private Integer proj_ct_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
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
	 * 状态
	 */
	private String state;
	

	/**
	 * 项目合同ID
	 * 
	 * @return proj_ct_id
	 */
	public Integer getProj_ct_id() {
		return proj_ct_id;
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
	 * 合同ID
	 * 
	 * @return ct_id
	 */
	public Integer getCt_id() {
		return ct_id;
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
	 * 状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 项目合同ID
	 * 
	 * @param proj_ct_id
	 */
	public void setProj_ct_id(Integer proj_ct_id) {
		this.proj_ct_id = proj_ct_id;
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
	 * 合同ID
	 * 
	 * @param ct_id
	 */
	public void setCt_id(Integer ct_id) {
		this.ct_id = ct_id;
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
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}