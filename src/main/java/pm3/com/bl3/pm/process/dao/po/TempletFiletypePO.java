package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_templet_filetype[pr_templet_filetype]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-14 09:48:51
 */
public class TempletFiletypePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 模板文件类型ID
	 */
	private Integer temp_filetype_id;
	
	/**
	 * 模板ID
	 */
	private Integer templet_id;
	
	/**
	 * 所属过程子目录pr_templet_process.templet_process_id
	 */
	private Integer temp_proc_id;
	
	/**
	 * 模板过程文档文件类型ID
	 */
	private Integer filetype_id;
	
	/**
	 * 模板过程文档文件类型名称
	 */
	private String temp_filetype_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 是否必须流程 0 否 1 是
	 */
	private Integer flow_state;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 创建人
	 */
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
	 * 子目录id
	 */
	private Integer subdir_id;

	/**
	 * 模板文件类型ID
	 * 
	 * @return temp_filetype_id
	 */
	public Integer getTemp_filetype_id() {
		return temp_filetype_id;
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
	 * 所属过程子目录pr_templet_process.templet_process_id
	 * 
	 * @return temp_proc_id
	 */
	public Integer getTemp_proc_id() {
		return temp_proc_id;
	}
	
	/**
	 * 模板过程文档文件类型ID
	 * 
	 * @return filetype_id
	 */
	public Integer getFiletype_id() {
		return filetype_id;
	}
	
	/**
	 * 模板过程文档文件类型名称
	 * 
	 * @return temp_filetype_name
	 */
	public String getTemp_filetype_name() {
		return temp_filetype_name;
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
	
	/**
	 * 创建人
	 * 
	 * @return create_user_id
	 */
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
	 * 模板文件类型ID
	 * 
	 * @param temp_filetype_id
	 */
	public void setTemp_filetype_id(Integer temp_filetype_id) {
		this.temp_filetype_id = temp_filetype_id;
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
	 * 所属过程子目录pr_templet_process.templet_process_id
	 * 
	 * @param temp_proc_id
	 */
	public void setTemp_proc_id(Integer temp_proc_id) {
		this.temp_proc_id = temp_proc_id;
	}
	
	/**
	 * 模板过程文档文件类型ID
	 * 
	 * @param filetype_id
	 */
	public void setFiletype_id(Integer filetype_id) {
		this.filetype_id = filetype_id;
	}
	
	/**
	 * 模板过程文档文件类型名称
	 * 
	 * @param temp_filetype_name
	 */
	public void setTemp_filetype_name(String temp_filetype_name) {
		this.temp_filetype_name = temp_filetype_name;
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
	
	/**
	 * 创建人
	 * 
	 * @param create_user_id
	 */
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

	public Integer getSubdir_id() {
		return subdir_id;
	}

	public void setSubdir_id(Integer subdir_id) {
		this.subdir_id = subdir_id;
	}
	
	

}