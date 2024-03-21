package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>qa_reply_news[qa_reply_news]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zocl
 * @date 2018-03-26 09:26:55
 */
public class ReplyNewsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 流水号
	 */
	private Integer id;
	
	/**
	 * 消息编码
	 */
	private String text_code;
	
	/**
	 * 回复内容
	 */
	private String text_note;
	
	/**
	 * 有效值
	 */
	private String flag_id;
	
	/**
	 * 回复人
	 */
	private String text_name;
	
	/**
	 * 回复时间
	 */
	private Date text_date;
	
	/**
	 * ##索引
	 */
	private Integer is_pass;
	
	/**
	 * 回复人ID
	 */
	private Integer text_name_id;
	

	/**
	 * 流水号
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 消息编码
	 * 
	 * @return text_code
	 */
	public String getText_code() {
		return text_code;
	}
	
	/**
	 * 回复内容
	 * 
	 * @return text_note
	 */
	public String getText_note() {
		return text_note;
	}
	
	/**
	 * 有效值
	 * 
	 * @return flag_id
	 */
	public String getFlag_id() {
		return flag_id;
	}
	
	/**
	 * 回复人
	 * 
	 * @return text_name
	 */
	public String getText_name() {
		return text_name;
	}
	
	/**
	 * 回复时间
	 * 
	 * @return text_date
	 */
	public Date getText_date() {
		return text_date;
	}
	
	/**
	 * ##索引
	 * 
	 * @return is_pass
	 */
	public Integer getIs_pass() {
		return is_pass;
	}
	
	/**
	 * 回复人ID
	 * 
	 * @return text_name_id
	 */
	public Integer getText_name_id() {
		return text_name_id;
	}
	

	/**
	 * 流水号
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 消息编码
	 * 
	 * @param text_code
	 */
	public void setText_code(String text_code) {
		this.text_code = text_code;
	}
	
	/**
	 * 回复内容
	 * 
	 * @param text_note
	 */
	public void setText_note(String text_note) {
		this.text_note = text_note;
	}
	
	/**
	 * 有效值
	 * 
	 * @param flag_id
	 */
	public void setFlag_id(String flag_id) {
		this.flag_id = flag_id;
	}
	
	/**
	 * 回复人
	 * 
	 * @param text_name
	 */
	public void setText_name(String text_name) {
		this.text_name = text_name;
	}
	
	/**
	 * 回复时间
	 * 
	 * @param text_date
	 */
	public void setText_date(Date text_date) {
		this.text_date = text_date;
	}
	
	/**
	 * ##索引
	 * 
	 * @param is_pass
	 */
	public void setIs_pass(Integer is_pass) {
		this.is_pass = is_pass;
	}
	
	/**
	 * 回复人ID
	 * 
	 * @param text_name_id
	 */
	public void setText_name_id(Integer text_name_id) {
		this.text_name_id = text_name_id;
	}
	

}