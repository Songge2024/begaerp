package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_types[bs_proj_types]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2017-12-11 11:40:02
 */
public class ProjTypesPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 类型CODE
	 */
	private String type_code;
	
	/**
	 * 类型名称
	 */
	private String type_name;
	
	/**
	 * 类型描述
	 */
	private String type_desc;
	
	/**
	 * 开发模型
	 */
	private String model;
	
	/**
	 * 状态
	 */
	private String state;
	
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
	 * 类型CODE
	 * 
	 * @return type_code
	 */
	public String getType_code() {
		return type_code;
	}
	
	/**
	 * 类型名称
	 * 
	 * @return type_name
	 */
	public String getType_name() {
		return type_name;
	}
	
	/**
	 * 类型描述
	 * 
	 * @return type_desc
	 */
	public String getType_desc() {
		return type_desc;
	}
	
	/**
	 * 开发模型
	 * 
	 * @return model
	 */
	public String getModel() {
		return model;
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
	 * 类型CODE
	 * 
	 * @param type_code
	 */
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	
	/**
	 * 类型名称
	 * 
	 * @param type_name
	 */
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	
	/**
	 * 类型描述
	 * 
	 * @param type_desc
	 */
	public void setType_desc(String type_desc) {
		this.type_desc = type_desc;
	}
	
	/**
	 * 开发模型
	 * 
	 * @param model
	 */
	public void setModel(String model) {
		this.model = model;
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
	

}