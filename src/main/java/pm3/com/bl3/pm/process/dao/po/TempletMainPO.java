package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_templet_main[pr_templet_main]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
public class TempletMainPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 模板ID
	 */
	private Integer templet_id;
	
	/**
	 * 模板名称
	 */
	private String templet_name;
	
	/**
	 * 模板说明
	 */
	private String templet_comment;
	
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
	 * 模板ID
	 * 
	 * @return templet_id
	 */
	public Integer getTemplet_id() {
		return templet_id;
	}
	
	/**
	 * 模板名称
	 * 
	 * @return templet_name
	 */
	public String getTemplet_name() {
		return templet_name;
	}
	
	/**
	 * 模板说明
	 * 
	 * @return templet_comment
	 */
	public String getTemplet_comment() {
		return templet_comment;
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
	 * 模板ID
	 * 
	 * @param templet_id
	 */
	public void setTemplet_id(Integer templet_id) {
		this.templet_id = templet_id;
	}
	
	/**
	 * 模板名称
	 * 
	 * @param templet_name
	 */
	public void setTemplet_name(String templet_name) {
		this.templet_name = templet_name;
	}
	
	/**
	 * 模板说明
	 * 
	 * @param templet_comment
	 */
	public void setTemplet_comment(String templet_comment) {
		this.templet_comment = templet_comment;
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
	

}