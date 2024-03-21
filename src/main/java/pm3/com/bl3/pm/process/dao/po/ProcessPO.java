package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_process[pr_process]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author heying
 * @date 2017-12-14 16:24:05
 */
public class ProcessPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 过程ID
	 */
	private Integer process_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 过程子目录ID
	 */
	private Integer process_subdir_id;
	
	/**
	 * 过程子目录名称
	 */
	private String process_name;
	
	/**
	 * 过程根目录ID
	 */
	private Integer rootdir_id;
	
	/**
	 * 过程根目录名称
	 */
	private String rootdir_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 是否必须
	 */
	private Integer flow_state;
	
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
	 * 是否必须流程 0 是 1 否
	 */
	private String state;
	
	
	private Integer templet_id;
	
	
	private Integer temp_filetype_id;
	
	
	private Integer temp_proc_id;
	
	
	private Integer filetype_id;
	
	
	private String proc_filetype_name;
	
	private Integer file_state;
	

	/**
	 * 过程ID
	 * 
	 * @return process_id
	 */
	public Integer getProcess_id() {
		return process_id;
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
	 * 过程子目录ID
	 * 
	 * @return process_subdir_id
	 */
	public Integer getProcess_subdir_id() {
		return process_subdir_id;
	}
	
	/**
	 * 过程子目录名称
	 * 
	 * @return process_name
	 */
	public String getProcess_name() {
		return process_name;
	}
	
	/**
	 * 过程根目录ID
	 * 
	 * @return rootdir_id
	 */
	public Integer getRootdir_id() {
		return rootdir_id;
	}
	
	/**
	 * 过程根目录名称
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
	 * 是否必须流程 0 是 1 否
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 过程ID
	 * 
	 * @param process_id
	 */
	public void setProcess_id(Integer process_id) {
		this.process_id = process_id;
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
	 * 过程子目录ID
	 * 
	 * @param process_subdir_id
	 */
	public void setProcess_subdir_id(Integer process_subdir_id) {
		this.process_subdir_id = process_subdir_id;
	}
	
	/**
	 * 过程子目录名称
	 * 
	 * @param process_name
	 */
	public void setProcess_name(String process_name) {
		this.process_name = process_name;
	}
	
	/**
	 * 过程根目录ID
	 * 
	 * @param rootdir_id
	 */
	public void setRootdir_id(Integer rootdir_id) {
		this.rootdir_id = rootdir_id;
	}
	
	/**
	 * 过程根目录名称
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
	 * 是否必须流程 0 是 1 否
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public Integer getTemplet_id() {
		return templet_id;
	}

	public void setTemplet_id(Integer templet_id) {
		this.templet_id = templet_id;
	}

	public Integer getFlow_state() {
		return flow_state;
	}

	public void setFlow_state(Integer flow_state) {
		this.flow_state = flow_state;
	}

	public Integer getTemp_filetype_id() {
		return temp_filetype_id;
	}

	public void setTemp_filetype_id(Integer temp_filetype_id) {
		this.temp_filetype_id = temp_filetype_id;
	}

	public Integer getTemp_proc_id() {
		return temp_proc_id;
	}

	public void setTemp_proc_id(Integer temp_proc_id) {
		this.temp_proc_id = temp_proc_id;
	}

	public Integer getFiletype_id() {
		return filetype_id;
	}

	public void setFiletype_id(Integer filetype_id) {
		this.filetype_id = filetype_id;
	}

	public String getProc_filetype_name() {
		return proc_filetype_name;
	}

	public void setProc_filetype_name(String proc_filetype_name) {
		this.proc_filetype_name = proc_filetype_name;
	}

	public Integer getFile_state() {
		return file_state;
	}

	public void setFile_state(Integer file_state) {
		this.file_state = file_state;
	}
	
	

}