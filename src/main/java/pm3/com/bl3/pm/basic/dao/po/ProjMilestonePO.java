package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_proj_milestone[bs_proj_milestone]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yj
 * @date 2018-01-25 20:18:30
 */
public class ProjMilestonePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 里程碑ID
	 */
	private Integer milest_id;
	
	/**
	 * 里程碑编码
	 */
	private String milest_code;
	
	/**
	 * 里程碑名称
	 */
	private String milest_name;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 父ID
	 */
	private String parent_id;
	
	/**
	 * is_leaf
	 */
	private String is_leaf;
	
	/**
	 * sort_no
	 */
	private Integer sort_no;
	/**
	 * weekDay
	 */
	private Integer weekday;
	
	/**
	 * plan_wastage
	 */
	private BigDecimal plan_wastage;
	/**
	 * 计划工作量
	 */
	private BigDecimal plan_jobamount;
	/**
	 * 实际工作量
	 */
	private BigDecimal real_jobamount;
	/**
	 * 挣值
	 */
	private BigDecimal earned_value;
	
	/**
	 * 类型
	 */
	private String type;
	
	/**
	 * 计划开始时间
	 */
	private Date plan_begin_date;
	
	/**
	 * 计划结束时间
	 */
	private Date plan_end_date;
	/**
	 * 实际开始时间
	 */
	private Date real_begin_date;
	
	/**
	 * 实际结束时间
	 */
	private Date real_end_date;
	
	/**
	 * 说明
	 */
	private String comment;
	
	/**
	 * 设计人
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
	 * group_id
	 */
	private Integer group_id;
	
	/**
	 * 状态
	 */
	private String state;
	

	/**
	 * 里程碑ID
	 * 
	 * @return milest_id
	 */
	public Integer getMilest_id() {
		return milest_id;
	}
	
	/**
	 * 里程碑编码
	 * 
	 * @return milest_code
	 */
	public String getMilest_code() {
		return milest_code;
	}
	
	/**
	 * 里程碑名称
	 * 
	 * @return milest_name
	 */
	public String getMilest_name() {
		return milest_name;
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
	 * 父ID
	 * 
	 * @return parent_id
	 */
	public String getParent_id() {
		return parent_id;
	}
	
	/**
	 * is_leaf
	 * 
	 * @return is_leaf
	 */
	public String getIs_leaf() {
		return is_leaf;
	}
	
	/**
	 * sort_no
	 * 
	 * @return sort_no
	 */
	public Integer getSort_no() {
		return sort_no;
	}
	
	/**
	 * plan_wastage
	 * 
	 * @return plan_wastage
	 */
	public BigDecimal getPlan_wastage() {
		return plan_wastage;
	}
	
	/**
	 * 类型
	 * 
	 * @return type
	 */
	public String getType() {
		return type;
	}
	
	
	
	/**
	 * 说明
	 * 
	 * @return comment
	 */
	public String getComment() {
		return comment;
	}
	
	/**
	 * 设计人
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
	 * group_id
	 * 
	 * @return group_id
	 */
	public Integer getGroup_id() {
		return group_id;
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
	 * 里程碑ID
	 * 
	 * @param milest_id
	 */
	public void setMilest_id(Integer milest_id) {
		this.milest_id = milest_id;
	}
	
	/**
	 * 里程碑编码
	 * 
	 * @param milest_code
	 */
	public void setMilest_code(String milest_code) {
		this.milest_code = milest_code;
	}
	
	/**
	 * 里程碑名称
	 * 
	 * @param milest_name
	 */
	public void setMilest_name(String milest_name) {
		this.milest_name = milest_name;
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
	 * 父ID
	 * 
	 * @param parent_id
	 */
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	
	/**
	 * is_leaf
	 * 
	 * @param is_leaf
	 */
	public void setIs_leaf(String is_leaf) {
		this.is_leaf = is_leaf;
	}
	
	/**
	 * sort_no
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
	}
	
	/**
	 * plan_wastage
	 * 
	 * @param plan_wastage
	 */
	public void setPlan_wastage(BigDecimal plan_wastage) {
		this.plan_wastage = plan_wastage;
	}
	
	/**
	 * 类型
	 * 
	 * @param type
	 */
	public void setType(String type) {
		this.type = type;
	}
	
	
	
	/**
	 * 说明
	 * 
	 * @param comment
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	/**
	 * 设计人
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
	 * group_id
	 * 
	 * @param group_id
	 */
	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
	
	/**
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}

	public Integer getWeekday() {
		return weekday;
	}

	public void setWeekday(Integer weekday) {
		this.weekday = weekday;
	}

	public Date getPlan_begin_date() {
		return plan_begin_date;
	}

	public void setPlan_begin_date(Date plan_begin_date) {
		this.plan_begin_date = plan_begin_date;
	}

	public Date getPlan_end_date() {
		return plan_end_date;
	}

	public void setPlan_end_date(Date plan_end_date) {
		this.plan_end_date = plan_end_date;
	}

	public Date getReal_begin_date() {
		return real_begin_date;
	}

	public void setReal_begin_date(Date real_begin_date) {
		this.real_begin_date = real_begin_date;
	}

	public Date getReal_end_date() {
		return real_end_date;
	}

	public void setReal_end_date(Date real_end_date) {
		this.real_end_date = real_end_date;
	}

	public BigDecimal getPlan_jobamount() {
		return plan_jobamount;
	}

	public void setPlan_jobamount(BigDecimal plan_jobamount) {
		this.plan_jobamount = plan_jobamount;
	}

	public BigDecimal getEarned_value() {
		return earned_value;
	}

	public void setEarned_value(BigDecimal earned_value) {
		this.earned_value = earned_value;
	}

	public BigDecimal getReal_jobamount() {
		return real_jobamount;
	}

	public void setReal_jobamount(BigDecimal real_jobamount) {
		this.real_jobamount = real_jobamount;
	}
	

}