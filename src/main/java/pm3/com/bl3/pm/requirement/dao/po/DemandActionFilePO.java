package com.bl3.pm.requirement.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>re_demand_action_file[re_demand_action_file]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yj
 * @date 2017-12-24 17:03:57
 */
public class DemandActionFilePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private Integer fad_id;
	
	/**
	 * AD_ID
	 */
	private Integer ad_id;
	
	/**
	 * 文件名称
	 */
	private String fad_name;
	
	/**
	 * 文件大小
	 */
	private String fad_size;
	
	/**
	 * 文件存放位置
	 */
	private String fad_path;
	
	/**
	 * 文件访问地址
	 */
	private String fad_adress;
	
	/**
	 * 修改人员
	 */
	private Integer update_user_id;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 创建人
	 */
	private Integer create_user_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 文件编码
	 */
	private String fad_code;

	public String getFad_code() {
		return fad_code;
	}

	public void setFad_code(String fad_code) {
		this.fad_code = fad_code;
	}

	/**
	 * ID
	 * 
	 * @return fad_id
	 */
	public Integer getFad_id() {
		return fad_id;
	}
	
	/**
	 * AD_ID
	 * 
	 * @return ad_id
	 */
	public Integer getAd_id() {
		return ad_id;
	}
	
	/**
	 * 文件名称
	 * 
	 * @return fad_name
	 */
	public String getFad_name() {
		return fad_name;
	}
	
	/**
	 * 文件大小
	 * 
	 * @return fad_size
	 */
	public String getFad_size() {
		return fad_size;
	}
	
	/**
	 * 文件存放位置
	 * 
	 * @return fad_path
	 */
	public String getFad_path() {
		return fad_path;
	}
	
	/**
	 * 文件访问地址
	 * 
	 * @return fad_adress
	 */
	public String getFad_adress() {
		return fad_adress;
	}
	
	/**
	 * 修改人员
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
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
	 * 状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * ID
	 * 
	 * @param fad_id
	 */
	public void setFad_id(Integer fad_id) {
		this.fad_id = fad_id;
	}
	
	/**
	 * AD_ID
	 * 
	 * @param ad_id
	 */
	public void setAd_id(Integer ad_id) {
		this.ad_id = ad_id;
	}
	
	/**
	 * 文件名称
	 * 
	 * @param fad_name
	 */
	public void setFad_name(String fad_name) {
		this.fad_name = fad_name;
	}
	
	/**
	 * 文件大小
	 * 
	 * @param fad_size
	 */
	public void setFad_size(String fad_size) {
		this.fad_size = fad_size;
	}
	
	/**
	 * 文件存放位置
	 * 
	 * @param fad_path
	 */
	public void setFad_path(String fad_path) {
		this.fad_path = fad_path;
	}
	
	/**
	 * 文件访问地址
	 * 
	 * @param fad_adress
	 */
	public void setFad_adress(String fad_adress) {
		this.fad_adress = fad_adress;
	}
	
	/**
	 * 修改人员
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
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
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}