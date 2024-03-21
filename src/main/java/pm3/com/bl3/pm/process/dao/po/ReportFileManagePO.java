package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_report_file_manage[pr_report_file_manage]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author heying
 * @date 2018-01-23 13:30:44
 */
public class ReportFileManagePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 文档ID
	 */
	private Integer re_file_id;
	
	/**
	 * 文档标题
	 */
	private String re_file_title;
	
	/**
	 * 上传文件路径
	 */
	private String re_file_path;
	
	/**
	 * 上传文件URL
	 */
	private String re_file_url;
	
	/**
	 * 上传文件大小
	 */
	private String re_file_size;
	
	/**
	 * 文档类型（1周总结、2月总结、3季度总结、4年度总结）
	 */
	private Integer re_file_type;
	
	/**
	 * 年份
	 */
	private String re_file_year;
	
	/**
	 * 上传文件备注
	 */
	private String re_file_mark;
	
	/**
	 * 上传人
	 */
	private Integer create_user_id;
	
	/**
	 * 上传时间
	 */
	private Date create_time;
	
	/**
	 * 提交查阅人
	 */
	private Integer submit_user_id;
	
	/**
	 * 更新人
	 */
	private Integer update_user_id;
	
	/**
	 * 更新时间
	 */
	private Date update_time;
	
	/**
	 * 状态 0 未提交 1已提交
	 */
	private String state;
	
	/**
	 * 下载次数
	 */
	private Integer down_num;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	public String getCreate_user_name() {
		return create_user_name;
	}

	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}

	public String getSubmit_user_name() {
		return submit_user_name;
	}

	public void setSubmit_user_name(String submit_user_name) {
		this.submit_user_name = submit_user_name;
	}

	private String create_user_name;
	
	private String submit_user_name;
	

	/**
	 * 文档ID
	 * 
	 * @return re_file_id
	 */
	public Integer getRe_file_id() {
		return re_file_id;
	}
	
	/**
	 * 文档标题
	 * 
	 * @return re_file_title
	 */
	public String getRe_file_title() {
		return re_file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @return re_file_path
	 */
	public String getRe_file_path() {
		return re_file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @return re_file_url
	 */
	public String getRe_file_url() {
		return re_file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @return re_file_size
	 */
	public String getRe_file_size() {
		return re_file_size;
	}
	
	/**
	 * 文档类型（1周总结、2月总结、3季度总结、4年度总结）
	 * 
	 * @return re_file_type
	 */
	public Integer getRe_file_type() {
		return re_file_type;
	}
	
	/**
	 * 年份
	 * 
	 * @return re_file_year
	 */
	public String getRe_file_year() {
		return re_file_year;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @return re_file_mark
	 */
	public String getRe_file_mark() {
		return re_file_mark;
	}
	
	/**
	 * 上传人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 上传时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 提交查阅人
	 * 
	 * @return submit_user_id
	 */
	public Integer getSubmit_user_id() {
		return submit_user_id;
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
	 * 状态 0 未提交 1已提交
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 下载次数
	 * 
	 * @return down_num
	 */
	public Integer getDown_num() {
		return down_num;
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
	 * 文档ID
	 * 
	 * @param re_file_id
	 */
	public void setRe_file_id(Integer re_file_id) {
		this.re_file_id = re_file_id;
	}
	
	/**
	 * 文档标题
	 * 
	 * @param re_file_title
	 */
	public void setRe_file_title(String re_file_title) {
		this.re_file_title = re_file_title;
	}
	
	/**
	 * 上传文件路径
	 * 
	 * @param re_file_path
	 */
	public void setRe_file_path(String re_file_path) {
		this.re_file_path = re_file_path;
	}
	
	/**
	 * 上传文件URL
	 * 
	 * @param re_file_url
	 */
	public void setRe_file_url(String re_file_url) {
		this.re_file_url = re_file_url;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @param re_file_size
	 */
	public void setRe_file_size(String re_file_size) {
		this.re_file_size = re_file_size;
	}
	
	/**
	 * 文档类型（1周总结、2月总结、3季度总结、4年度总结）
	 * 
	 * @param re_file_type
	 */
	public void setRe_file_type(Integer re_file_type) {
		this.re_file_type = re_file_type;
	}
	
	/**
	 * 年份
	 * 
	 * @param re_file_year
	 */
	public void setRe_file_year(String re_file_year) {
		this.re_file_year = re_file_year;
	}
	
	/**
	 * 上传文件备注
	 * 
	 * @param re_file_mark
	 */
	public void setRe_file_mark(String re_file_mark) {
		this.re_file_mark = re_file_mark;
	}
	
	/**
	 * 上传人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 上传时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 提交查阅人
	 * 
	 * @param submit_user_id
	 */
	public void setSubmit_user_id(Integer submit_user_id) {
		this.submit_user_id = submit_user_id;
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
	 * 状态 0 未提交 1已提交
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 下载次数
	 * 
	 * @param down_num
	 */
	public void setDown_num(Integer down_num) {
		this.down_num = down_num;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
	}
	

}