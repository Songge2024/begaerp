package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_theme[bs_theme]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-26 15:42:53
 */
public class ThemePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 主题编码
	 */
	private Integer id;
	
	/**
	 * 标签
	 */
	private String tags;
	
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 回复数量
	 */
	private Integer reply_num;
	
	/**
	 * 最后回复人编码
	 */
	private Integer last_reply_user_id;
	
	/**
	 * 最后回复时间
	 */
	private Date last_reply_time;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 修改人
	 */
	private Integer update_user_id;
	
	/**
	 * 主题类型
	 */
	private String theme_type;
	
	/**
	 * 是否置顶
	 */
	private Integer top;
	
	/**
	 * 文件地址编码
	 */
	private String fileid;
	
	/**
	 * 文件标题
	 */
	private String file_title;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 关联编码
	 */
	private Integer refrence_id;
	

	/**
	 * 主题编码
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 标签
	 * 
	 * @return tags
	 */
	public String getTags() {
		return tags;
	}
	
	/**
	 * 标题
	 * 
	 * @return title
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * 内容
	 * 
	 * @return content
	 */
	public String getContent() {
		return content;
	}
	
	/**
	 * 回复数量
	 * 
	 * @return reply_num
	 */
	public Integer getReply_num() {
		return reply_num;
	}
	
	/**
	 * 最后回复人编码
	 * 
	 * @return last_reply_user_id
	 */
	public Integer getLast_reply_user_id() {
		return last_reply_user_id;
	}
	
	/**
	 * 最后回复时间
	 * 
	 * @return last_reply_time
	 */
	public Date getLast_reply_time() {
		return last_reply_time;
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
	 * 创建人
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
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
	 * 修改人
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
	}
	
	/**
	 * 主题类型
	 * 
	 * @return theme_type
	 */
	public String getTheme_type() {
		return theme_type;
	}
	
	/**
	 * 是否置顶
	 * 
	 * @return top
	 */
	public Integer getTop() {
		return top;
	}
	
	/**
	 * 文件地址编码
	 * 
	 * @return fileid
	 */
	public String getFileid() {
		return fileid;
	}
	
	/**
	 * 文件标题
	 * 
	 * @return file_title
	 */
	public String getFile_title() {
		return file_title;
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
	 * 关联编码
	 * 
	 * @return refrence_id
	 */
	public Integer getRefrence_id() {
		return refrence_id;
	}
	

	/**
	 * 主题编码
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 标签
	 * 
	 * @param tags
	 */
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	/**
	 * 标题
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * 内容
	 * 
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 回复数量
	 * 
	 * @param reply_num
	 */
	public void setReply_num(Integer reply_num) {
		this.reply_num = reply_num;
	}
	
	/**
	 * 最后回复人编码
	 * 
	 * @param last_reply_user_id
	 */
	public void setLast_reply_user_id(Integer last_reply_user_id) {
		this.last_reply_user_id = last_reply_user_id;
	}
	
	/**
	 * 最后回复时间
	 * 
	 * @param last_reply_time
	 */
	public void setLast_reply_time(Date last_reply_time) {
		this.last_reply_time = last_reply_time;
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
	 * 创建人
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
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
	 * 修改人
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
	}
	
	/**
	 * 主题类型
	 * 
	 * @param theme_type
	 */
	public void setTheme_type(String theme_type) {
		this.theme_type = theme_type;
	}
	
	/**
	 * 是否置顶
	 * 
	 * @param top
	 */
	public void setTop(Integer top) {
		this.top = top;
	}
	
	/**
	 * 文件地址编码
	 * 
	 * @param fileid
	 */
	public void setFileid(String fileid) {
		this.fileid = fileid;
	}
	
	/**
	 * 文件标题
	 * 
	 * @param file_title
	 */
	public void setFile_title(String file_title) {
		this.file_title = file_title;
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
	 * 关联编码
	 * 
	 * @param refrence_id
	 */
	public void setRefrence_id(Integer refrence_id) {
		this.refrence_id = refrence_id;
	}
	

}