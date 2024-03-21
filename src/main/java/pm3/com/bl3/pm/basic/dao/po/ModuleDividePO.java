package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>re_module_divide[re_module_divide]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2017-12-11 11:17:18
 */
public class ModuleDividePO extends PO {

	private static final long serialVersionUID = 1L;
	/**
	 * 自定义code
	 */
	private Integer dm_id;
	
	/**
	 * 功能模块ID
	 */
	private String dm_code;
	/**
	 * 测试用例ID
	 */
	private String test_code;
	
	/**
	 * 名称
	 */
	private String dm_name;
	
	/**
	 * 父节点
	 */
	private String dm_parent_code;
	
	/**
	 * 是否子节点
	 */
	private String dm_is_leaf;
	
	/**
	 * 排序号
	 */
	private Integer dm_sort_no;
	
	/**
	 * 描述
	 */
	private String dm_remark;
	
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
	 * 开发负责人
	 */
	private String coding_user_name;
	/**
	 * 測試負責人
	 */
	private String test_user_name;
	
	/**
	 * 备注
	 */
	private String remarks;
	
	private String coding_complete;
	
	private String test_complete;
	
	private String proj_name;
	
	private String module_percent;
	
	public String getModule_percent() {
		return module_percent;
	}
	public void setModule_percent(String module_percent) {
		this.module_percent = module_percent;
	}
	public String getProj_name() {
		return proj_name;
	}
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	public String getCoding_complete() {
		return coding_complete;
	}
	public void setCoding_complete(String coding_complete) {
		this.coding_complete = coding_complete;
	}
	public String getTest_complete() {
		return test_complete;
	}
	public void setTest_complete(String test_complete) {
		this.test_complete = test_complete;
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
	 * 自定义code
	 * 
	 * @return dm_code
	 */
	public Integer getDm_id() {
		return dm_id;
	}
	/**
	 * 名称
	 * 
	 * @return dm_name
	 */
	public String getDm_name() {
		return dm_name;
	}
	
	/**
	 * 父节点
	 * 
	 * @return dm_parent_code
	 */
	public String getDm_parent_code() {
		return dm_parent_code;
	}
	
	/**
	 * 是否子节点
	 * 
	 * @return dm_is_leaf
	 */
	public String getDm_is_leaf() {
		return dm_is_leaf;
	}
	
	/**
	 * 排序号
	 * 
	 * @return dm_sort_no
	 */
	public Integer getDm_sort_no() {
		return dm_sort_no;
	}
	
	/**
	 * 描述
	 * 
	 * @return dm_remark
	 */
	public String getDm_remark() {
		return dm_remark;
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
	 * 开发负责人
	 * 
	 * @return coding_user_name
	 */
	public String getCoding_user_name() {
		return coding_user_name;
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
	 * 測試負責人
	 * 
	 * @return test_user_name
	 */
	public String getTest_user_name() {
		return test_user_name;
	}
	
	/**
	 * 备注
	 * 
	 * @return remarks
	 */
	public String getRemarks() {
		return remarks;
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
	 * 自定义code
	 * 
	 * @return dm_code
	 */
	public void setDm_id(Integer dm_id) {
		this.dm_id = dm_id;
	}
	/**
	 * 名称
	 * 
	 * @param dm_name
	 */
	public void setDm_name(String dm_name) {
		this.dm_name = dm_name;
	}
	
	/**
	 * 父节点
	 * 
	 * @param dm_parent_code
	 */
	public void setDm_parent_code(String dm_parent_code) {
		this.dm_parent_code = dm_parent_code;
	}
	
	/**
	 * 是否子节点
	 * 
	 * @param dm_is_leaf
	 */
	public void setDm_is_leaf(String dm_is_leaf) {
		this.dm_is_leaf = dm_is_leaf;
	}
	
	/**
	 * 排序号
	 * 
	 * @param dm_sort_no
	 */
	public void setDm_sort_no(Integer dm_sort_no) {
		this.dm_sort_no = dm_sort_no;
	}
	
	/**
	 * 描述
	 * 
	 * @param dm_remark
	 */
	public void setDm_remark(String dm_remark) {
		this.dm_remark = dm_remark;
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
	 * @param integer
	 */
	public void setCreate_user_id(Integer integer) {
		this.create_user_id = integer;
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
	 * 开发负责人
	 * 
	 * @param coding_user_name
	 */
	public void setCoding_user_name(String coding_user_name) {
		this.coding_user_name = coding_user_name;
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
	 * 測試負責人
	 * 
	 * @param test_user_name
	 */
	public void setTest_user_name(String test_user_name) {
		this.test_user_name = test_user_name;
	}
	
	/**
	 * 备注
	 * 
	 * @param remarks
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getTest_code() {
		return test_code;
	}
	public void setTest_code(String test_code) {
		this.test_code = test_code;
	}
	

}