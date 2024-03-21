package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_reply[bs_reply]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-26 15:42:53
 */
public class ReplyPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 回复编码
	 */
	private Integer id;
	
	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 主题/回复编码
	 */
	private Integer theme_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 回复类型 0:主题,1:回复的再回复
	 */
	private Integer reply_type;
	

	/**
	 * 回复编码
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
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
	 * 主题/回复编码
	 * 
	 * @return theme_id
	 */
	public Integer getTheme_id() {
		return theme_id;
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
	 * 回复类型 0:主题,1:回复的再回复
	 * 
	 * @return reply_type
	 */
	public Integer getReply_type() {
		return reply_type;
	}
	

	/**
	 * 回复编码
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
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
	 * 主题/回复编码
	 * 
	 * @param theme_id
	 */
	public void setTheme_id(Integer theme_id) {
		this.theme_id = theme_id;
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
	 * 回复类型 0:主题,1:回复的再回复
	 * 
	 * @param reply_type
	 */
	public void setReply_type(Integer reply_type) {
		this.reply_type = reply_type;
	}
	

}