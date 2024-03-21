package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_process_filetype[pr_process_filetype]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author heying
 * @date 2017-12-14 16:24:05
 */
public class ProcessFiletypePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 文件类型ID
	 */
	private Integer proc_filetype_id;
	
	/**
	 * 所属过程对应pr_process.process_id
	 */
	private Integer process_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 模板文件类型IDpr_filetype.filetype_id
	 */
	private Integer filetype_id;
	
	/**
	 * 文件类型名称
	 */
	private String proc_filetype_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 是否必须文件 0 否 1 是
	 */
	private Integer file_state;
	
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
	 * 是否需要审核状态 0 否 1 是
	 */
	private String state;
	
	
	
	private Integer temp_filetype_id;
	
	
	
	private Integer flow_state;
	
	
	
	private String temp_filetype_name;
	
	
	private Integer subdir_id;
	
	private Integer file_num;
	

	public Integer getFile_num() {
		return file_num;
	}

	public void setFile_num(Integer file_num) {
		this.file_num = file_num;
	}

	/**
	 * 文件类型ID
	 * 
	 * @return proc_filetype_id
	 */
	public Integer getProc_filetype_id() {
		return proc_filetype_id;
	}
	
	/**
	 * 所属过程对应pr_process.process_id
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
	 * 模板文件类型IDpr_filetype.filetype_id
	 * 
	 * @return filetype_id
	 */
	public Integer getFiletype_id() {
		return filetype_id;
	}
	
	/**
	 * 文件类型名称
	 * 
	 * @return proc_filetype_name
	 */
	public String getProc_filetype_name() {
		return proc_filetype_name;
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
	 * 是否必须文件 0 否 1 是
	 * 
	 * @return file_state
	 */
	public Integer getFile_state() {
		return file_state;
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
	 * 是否需要审核状态 0 否 1 是
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 文件类型ID
	 * 
	 * @param proc_filetype_id
	 */
	public void setProc_filetype_id(Integer proc_filetype_id) {
		this.proc_filetype_id = proc_filetype_id;
	}
	
	/**
	 * 所属过程对应pr_process.process_id
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
	 * 模板文件类型IDpr_filetype.filetype_id
	 * 
	 * @param filetype_id
	 */
	public void setFiletype_id(Integer filetype_id) {
		this.filetype_id = filetype_id;
	}
	
	/**
	 * 文件类型名称
	 * 
	 * @param proc_filetype_name
	 */
	public void setProc_filetype_name(String proc_filetype_name) {
		this.proc_filetype_name = proc_filetype_name;
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
	 * 是否必须文件 0 否 1 是
	 * 
	 * @param file_state
	 */
	public void setFile_state(Integer file_state) {
		this.file_state = file_state;
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
	 * 是否需要审核状态 0 否 1 是
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public Integer getTemp_filetype_id() {
		return temp_filetype_id;
	}

	public void setTemp_filetype_id(Integer temp_filetype_id) {
		this.temp_filetype_id = temp_filetype_id;
	}

	public Integer getFlow_state() {
		return flow_state;
	}

	public void setFlow_state(Integer flow_state) {
		this.flow_state = flow_state;
	}

	public String getTemp_filetype_name() {
		return temp_filetype_name;
	}

	public void setTemp_filetype_name(String temp_filetype_name) {
		this.temp_filetype_name = temp_filetype_name;
	}

	public Integer getSubdir_id() {
		return subdir_id;
	}

	public void setSubdir_id(Integer subdir_id) {
		this.subdir_id = subdir_id;
	}
	
	
}