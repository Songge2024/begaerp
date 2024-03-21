package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_role_types[bs_proj_role_types]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2017-12-25 16:20:40
 */
public class ProjRoleTypesPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * TRP_CODE
	 */
	private String trp_code;
	
	/**
	 * TRP_NAME
	 */
	private String trp_name;
	
	/**
	 * TRP_REMARK
	 */
	private String trp_remark;
	
	/**
	 * STATE
	 */
	private String state;
	
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
	 * 系统角色ID
	 */
	private Integer aos_role_id;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	/**
	 * 统计数
	 * @return
	 */
	private Integer count_role;

	public Integer getCount_role() {
		return count_role;
	}

	public void setCount_role(Integer count_role) {
		this.count_role = count_role;
	}

	public Integer getSort_no() {
		return sort_no;
	}

	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
	}

	/**
	 * TRP_CODE
	 * 
	 * @return trp_code
	 */
	public String getTrp_code() {
		return trp_code;
	}
	
	/**
	 * TRP_NAME
	 * 
	 * @return trp_name
	 */
	public String getTrp_name() {
		return trp_name;
	}
	
	/**
	 * TRP_REMARK
	 * 
	 * @return trp_remark
	 */
	public String getTrp_remark() {
		return trp_remark;
	}
	
	/**
	 * STATE
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
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
	 * 系统角色ID
	 * 
	 * @return aos_role_id
	 */
	public Integer getAos_role_id() {
		return aos_role_id;
	}
	

	/**
	 * TRP_CODE
	 * 
	 * @param trp_code
	 */
	public void setTrp_code(String trp_code) {
		this.trp_code = trp_code;
	}
	
	/**
	 * TRP_NAME
	 * 
	 * @param trp_name
	 */
	public void setTrp_name(String trp_name) {
		this.trp_name = trp_name;
	}
	
	/**
	 * TRP_REMARK
	 * 
	 * @param trp_remark
	 */
	public void setTrp_remark(String trp_remark) {
		this.trp_remark = trp_remark;
	}
	
	/**
	 * STATE
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
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
	 * 系统角色ID
	 * 
	 * @param aos_role_id
	 */
	public void setAos_role_id(Integer aos_role_id) {
		this.aos_role_id = aos_role_id;
	}
	

}