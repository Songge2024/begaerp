package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_templet_process[pr_templet_process]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
public class TempletProcessPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 模板明细ID
	 */
	private Integer temp_proc_id;
	
	/**
	 * 模板ID
	 */
	private Integer templet_id;
	
	/**
	 * 过程子目录ID
	 */
	private Integer subdir_id;
	
	/**
	 * 过程子目录名称
	 */
	private String temp_proc_name;
	
	/**
	 * 所属过程根目录ID
	 */
	private Integer rootdir_id;
	
	/**
	 * 所属过程根目录名称
	 */
	private String rootdir_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 是否必须流程 0 否 1 是
	 */
	private Integer flow_state;
	
	/**
	 * 是否必须流程 0 否 1 是
	 */
	private String flow_state_name;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	private String create_user_name;
	
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
	 * 模板明细ID
	 * 
	 * @return temp_proc_id
	 */
	public Integer getTemp_proc_id() {
		return temp_proc_id;
	}
	
	/**
	 * 模板ID
	 * 
	 * @return templet_id
	 */
	public Integer getTemplet_id() {
		return templet_id;
	}
	
	/**
	 * 过程子目录ID
	 * 
	 * @return subdir_id
	 */
	public Integer getSubdir_id() {
		return subdir_id;
	}
	
	/**
	 * 过程子目录名称
	 * 
	 * @return temp_proc_name
	 */
	public String getTemp_proc_name() {
		return temp_proc_name;
	}
	
	/**
	 * 所属过程根目录ID
	 * 
	 * @return rootdir_id
	 */
	public Integer getRootdir_id() {
		return rootdir_id;
	}
	
	/**
	 * 所属过程根目录名称
	 * 
	 * @return rootdir_name
	 */
	public String getRootdir_name() {
		return rootdir_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sort_no
	 */
	public Integer getSort_no() {
		return sort_no;
	}
	
	/**
	 * 是否必须流程 0 否 1 是
	 * 
	 * @return flow_state
	 */
	public Integer getFlow_state() {
		return flow_state;
	}
	
	/**
	 * 创建人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	public String getCreate_user_name() {
		return create_user_name;
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
	 * 模板明细ID
	 * 
	 * @param temp_proc_id
	 */
	public void setTemp_proc_id(Integer temp_proc_id) {
		this.temp_proc_id = temp_proc_id;
	}
	
	/**
	 * 模板ID
	 * 
	 * @param templet_id
	 */
	public void setTemplet_id(Integer templet_id) {
		this.templet_id = templet_id;
	}
	
	/**
	 * 过程子目录ID
	 * 
	 * @param subdir_id
	 */
	public void setSubdir_id(Integer subdir_id) {
		this.subdir_id = subdir_id;
	}
	
	/**
	 * 过程子目录名称
	 * 
	 * @param temp_proc_name
	 */
	public void setTemp_proc_name(String temp_proc_name) {
		this.temp_proc_name = temp_proc_name;
	}
	
	/**
	 * 所属过程根目录ID
	 * 
	 * @param rootdir_id
	 */
	public void setRootdir_id(Integer rootdir_id) {
		this.rootdir_id = rootdir_id;
	}
	
	/**
	 * 所属过程根目录名称
	 * 
	 * @param rootdir_name
	 */
	public void setRootdir_name(String rootdir_name) {
		this.rootdir_name = rootdir_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
	}
	
	/**
	 * 是否必须流程 0 否 1 是
	 * 
	 * @param flow_state
	 */
	public void setFlow_state(Integer flow_state) {
		this.flow_state = flow_state;
	}
	
	/**
	 * 创建人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
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

	public String getFlow_state_name() {
		return flow_state_name;
	}

	public void setFlow_state_name(String flow_state_name) {
		this.flow_state_name = flow_state_name;
	}
	

}