package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>ta_task_file_upload[ta_task_file_upload]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author heying
 * @date 2019-01-12 15:37:07
 */
public class TaskFileUploadPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 文件ID
	 */
	private Integer file_id;
	
	/**
	 * 过程ID
	 */
	private Integer task_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 任务文件类型（1 发布文件 2 回复文件）
	 */
	private Integer task_file_type;
	
	/**
	 * 文件编码
	 */
	private String file_code;
	
	/**
	 * 上传文件标题
	 */
	private String file_title;
	
	/**
	 * 上传文件路径
	 */
	private String file_path;
	
	/**
	 * 上传文件URL
	 */
	private String file_url;
	
	/**
	 * 上传文件大小
	 */
	private String file_size;
	
	/**
	 * 版本号
	 */
	private String version_num;
	
	/**
	 * 上传文件备注
	 */
	private String file_remark;
	
	/**
	 * 排序号
	 */
	private Integer sortno;
	
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
	
	private String create_user_name;
	
	public String getTask_name() {
		return task_name;
	}

	private String task_name;
	
	private String proj_name;
	

	/**
	 * 文件ID
	 * 
	 * @return file_id
	 */
	public Integer getFile_id() {
		return file_id;
	}
	
	/**
	 * 过程ID
	 * 
	 * @return task_id
	 */
	public Integer getTask_id() {
		return task_id;
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
	 * 任务文件类型（1 发布文件 2 回复文件）
	 * 
	 * @return task_file_type
	 */
	public Integer getTask_file_type() {
		return task_file_type;
	}
	
	/**
	 * 文件编码
	 * 
	 * @return file_code
	 */
	public String getFile_code() {
		return file_code;
	}
	
	/**
	 * 上传文件标题
	 * 
	 * @return file_title
	 */
	public String getFile_title() {
		return file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @return file_path
	 */
	public String getFile_path() {
		return file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @return file_url
	 */
	public String getFile_url() {
		return file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @return file_size
	 */
	public String getFile_size() {
		return file_size;
	}
	
	/**
	 * 版本号
	 * 
	 * @return version_num
	 */
	public String getVersion_num() {
		return version_num;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @return file_remark
	 */
	public String getFile_remark() {
		return file_remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sortno
	 */
	public Integer getSortno() {
		return sortno;
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
	 * 文件ID
	 * 
	 * @param file_id
	 */
	public void setFile_id(Integer file_id) {
		this.file_id = file_id;
	}
	
	/**
	 * 过程ID
	 * 
	 * @param task_id
	 */
	public void setTask_id(Integer task_id) {
		this.task_id = task_id;
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
	 * 任务文件类型（1 发布文件 2 回复文件）
	 * 
	 * @param task_file_type
	 */
	public void setTask_file_type(Integer task_file_type) {
		this.task_file_type = task_file_type;
	}
	
	/**
	 * 文件编码
	 * 
	 * @param file_code
	 */
	public void setFile_code(String file_code) {
		this.file_code = file_code;
	}
	
	/**
	 * 上传文件标题
	 * 
	 * @param file_title
	 */
	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @param file_path
	 */
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @param file_url
	 */
	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @param file_size
	 */
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	
	/**
	 * 版本号
	 * 
	 * @param version_num
	 */
	public void setVersion_num(String version_num) {
		this.version_num = version_num;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @param file_remark
	 */
	public void setFile_remark(String file_remark) {
		this.file_remark = file_remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sortno
	 */
	public void setSortno(Integer sortno) {
		this.sortno = sortno;
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
	
	public void setTask_name(String task_name) {
		this.task_name = task_name;
	}

	public String getProj_name() {
		return proj_name;
	}

	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	
	public String getCreate_user_name() {
		return create_user_name;
	}

	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}

	

}