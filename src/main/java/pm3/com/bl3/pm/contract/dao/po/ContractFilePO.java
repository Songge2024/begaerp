package com.bl3.pm.contract.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_contract_file[bs_contract_file]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
public class ContractFilePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 合同文件ID
	 */
	private Integer ct_file_id;
	
	/**
	 * 合同ID
	 */
	private Integer ct_id;
	
	/**
	 * 文件编码
	 */
	private String ct_file_code;
	
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
	 * 上传文件标题
	 */
	private String ct_file_title;
	
	/**
	 * 上传文件路径
	 */
	private String ct_file_path;
	
	/**
	 * 上传文件URL
	 */
	private String ct_file_url;
	
	/**
	 * 上传文件大小
	 */
	private String ct_file_size;
	
	/**
	 * 上传文件备注
	 */
	private String ct_file_remark;
	

	/**
	 * 合同文件ID
	 * 
	 * @return ct_file_id
	 */
	public Integer getCt_file_id() {
		return ct_file_id;
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
	 * 文件编码
	 * 
	 * @return ct_file_code
	 */
	public String getCt_file_code() {
		return ct_file_code;
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
	 * 上传文件标题
	 * 
	 * @return ct_file_title
	 */
	public String getCt_file_title() {
		return ct_file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @return ct_file_path
	 */
	public String getCt_file_path() {
		return ct_file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @return ct_file_url
	 */
	public String getCt_file_url() {
		return ct_file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @return ct_file_size
	 */
	public String getCt_file_size() {
		return ct_file_size;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @return ct_file_remark
	 */
	public String getCt_file_remark() {
		return ct_file_remark;
	}
	

	/**
	 * 合同文件ID
	 * 
	 * @param ct_file_id
	 */
	public void setCt_file_id(Integer ct_file_id) {
		this.ct_file_id = ct_file_id;
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
	 * 文件编码
	 * 
	 * @param ct_file_code
	 */
	public void setCt_file_code(String ct_file_code) {
		this.ct_file_code = ct_file_code;
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
	 * 上传文件标题
	 * 
	 * @param ct_file_title
	 */
	public void setCt_file_title(String ct_file_title) {
		this.ct_file_title = ct_file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @param ct_file_path
	 */
	public void setCt_file_path(String ct_file_path) {
		this.ct_file_path = ct_file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @param ct_file_url
	 */
	public void setCt_file_url(String ct_file_url) {
		this.ct_file_url = ct_file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @param ct_file_size
	 */
	public void setCt_file_size(String ct_file_size) {
		this.ct_file_size = ct_file_size;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @param ct_file_remark
	 */
	public void setCt_file_remark(String ct_file_remark) {
		this.ct_file_remark = ct_file_remark;
	}
	

}