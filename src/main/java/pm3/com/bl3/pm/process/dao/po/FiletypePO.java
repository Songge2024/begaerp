package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_filetype[pr_filetype]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2017-12-12 14:18:36
 */
public class FiletypePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 文件类型ID
	 */
	private Integer filetype_id;
	
	/**
	 * 根目录ID
	 */
	private Integer rootdir_id;
	
	/**
	 * 子目录ID
	 */
	private Integer subdir_id;
	
	/**
	 * 文件类型名称
	 */
	private String filetype_name;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 创建时间
	 */
	private Date create_date;
	
	/**
	 * 更新人
	 */
	private Integer update_user_id;
	
	/**
	 * 更新时间
	 */
	private Date update_date;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 创建人名称
	 */
	private String create_user_name;

	public String getCreate_user_name() {
		return create_user_name;
	}

	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}

	/**
	 * 文件类型ID
	 * 
	 * @return filetype_id
	 */
	public Integer getFiletype_id() {
		return filetype_id;
	}
	
	/**
	 * 根目录ID
	 * 
	 * @return rootdir_id
	 */
	public Integer getRootdir_id() {
		return rootdir_id;
	}
	
	/**
	 * 子目录ID
	 * 
	 * @return subdir_id
	 */
	public Integer getSubdir_id() {
		return subdir_id;
	}
	
	/**
	 * 文件类型名称
	 * 
	 * @return filetype_name
	 */
	public String getFiletype_name() {
		return filetype_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sort_no
	 */
	public Integer getsort_no() {
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
	 * @return create_date
	 */
	public Date getCreate_date() {
		return create_date;
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
	 * 文件类型ID
	 * 
	 * @param filetype_id
	 */
	public void setFiletype_id(Integer filetype_id) {
		this.filetype_id = filetype_id;
	}
	
	/**
	 * 根目录ID
	 * 
	 * @param rootdir_id
	 */
	public void setRootdir_id(Integer rootdir_id) {
		this.rootdir_id = rootdir_id;
	}
	
	/**
	 * 子目录ID
	 * 
	 * @param subdir_id
	 */
	public void setSubdir_id(Integer subdir_id) {
		this.subdir_id = subdir_id;
	}
	
	/**
	 * 文件类型名称
	 * 
	 * @param filetype_name
	 */
	public void setFiletype_name(String filetype_name) {
		this.filetype_name = filetype_name;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setsort_no(Integer sort_no) {
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
	 * @param create_date
	 */
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
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