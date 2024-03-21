package com.bl3.pm.recruit.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_entry_registration[bs_entry_registration]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2018-04-20 16:20:30
 */
public class EntryRegistrationPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 入职主键id
	 */
	private Integer entry_id;
	
	/**
	 * 结果id
	 */
	private Integer result_id;
	
	/**
	 * 入职类型
	 */
	private String entry_type;
	
	/**
	 * 入职时间
	 */
	private Date entry_date;
	
	/**
	 * 入职岗位
	 */
	private String entry_post;
	
	/**
	 * 经验
	 */
	private String experience;
	
	/**
	 * 培训情况
	 */
	private String train_situation;
	
	/**
	 * 创建人Id
	 */
	private Integer create_user_id;
	
	/**
	 * 更新人id
	 */
	private Integer update_user_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 更新时间
	 */
	private Date update_time;
	
	/**
	 * 备注
	 */
	private String result_remark;
	

	/**
	 * 入职主键id
	 * 
	 * @return entry_id
	 */
	public Integer getEntry_id() {
		return entry_id;
	}
	
	/**
	 * 结果id
	 * 
	 * @return result_id
	 */
	public Integer getResult_id() {
		return result_id;
	}
	
	/**
	 * 入职类型
	 * 
	 * @return entry_type
	 */
	public String getEntry_type() {
		return entry_type;
	}
	
	/**
	 * 入职时间
	 * 
	 * @return entry_date
	 */
	public Date getEntry_date() {
		return entry_date;
	}
	
	/**
	 * 入职岗位
	 * 
	 * @return entry_post
	 */
	public String getEntry_post() {
		return entry_post;
	}
	
	/**
	 * 经验
	 * 
	 * @return experience
	 */
	public String getExperience() {
		return experience;
	}
	
	/**
	 * 培训情况
	 * 
	 * @return train_situation
	 */
	public String getTrain_situation() {
		return train_situation;
	}
	
	/**
	 * 创建人Id
	 * 
	 * @return create_user_id
	 */
	public Integer getCreate_user_id() {
		return create_user_id;
	}
	
	/**
	 * 更新人id
	 * 
	 * @return update_user_id
	 */
	public Integer getUpdate_user_id() {
		return update_user_id;
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
	 * 更新时间
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 备注
	 * 
	 * @return result_remark
	 */
	public String getResult_remark() {
		return result_remark;
	}
	

	/**
	 * 入职主键id
	 * 
	 * @param entry_id
	 */
	public void setEntry_id(Integer entry_id) {
		this.entry_id = entry_id;
	}
	
	/**
	 * 结果id
	 * 
	 * @param result_id
	 */
	public void setResult_id(Integer result_id) {
		this.result_id = result_id;
	}
	
	/**
	 * 入职类型
	 * 
	 * @param entry_type
	 */
	public void setEntry_type(String entry_type) {
		this.entry_type = entry_type;
	}
	
	/**
	 * 入职时间
	 * 
	 * @param entry_date
	 */
	public void setEntry_date(Date entry_date) {
		this.entry_date = entry_date;
	}
	
	/**
	 * 入职岗位
	 * 
	 * @param entry_post
	 */
	public void setEntry_post(String entry_post) {
		this.entry_post = entry_post;
	}
	
	/**
	 * 经验
	 * 
	 * @param experience
	 */
	public void setExperience(String experience) {
		this.experience = experience;
	}
	
	/**
	 * 培训情况
	 * 
	 * @param train_situation
	 */
	public void setTrain_situation(String train_situation) {
		this.train_situation = train_situation;
	}
	
	/**
	 * 创建人Id
	 * 
	 * @param create_user_id
	 */
	public void setCreate_user_id(Integer create_user_id) {
		this.create_user_id = create_user_id;
	}
	
	/**
	 * 更新人id
	 * 
	 * @param update_user_id
	 */
	public void setUpdate_user_id(Integer update_user_id) {
		this.update_user_id = update_user_id;
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
	 * 更新时间
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 备注
	 * 
	 * @param result_remark
	 */
	public void setResult_remark(String result_remark) {
		this.result_remark = result_remark;
	}
	

}