package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>ta_task_group[ta_task_group]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author remexs
 * @date 2018-01-22 11:10:34
 */
public class TaskGroupPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 分组编码
	 */
	private Integer group_id;
	
	/**
	 * 分组名称
	 */
	private String group_name;
	
	/**
	 * cascade_id
	 */
	private String cascade_id;
	
	/**
	 * 父类编码
	 */
	private Integer parent_id;
	
	/**
	 * 是否叶子节点
	 */
	private String is_leaf;
	
	/**
	 * 是否自动展开
	 */
	private String is_auto_expand;
	
	/**
	 * 节点图标文件名称
	 */
	private String icon_name;
	
	/**
	 * 任务分组来源
	 */
	private Integer group_from;
	
	/**
	 * 计划结束时间
	 */
	private Date plan_end_time;
	
	/**
	 * 计划开始时间
	 */
	private Date plan_begin_time;
	
	/**
	 * 计划消耗天数
	 */
	private BigDecimal plan_wastage;
	
	/**
	 * 排序号
	 */
	private Integer sort_no;
	
	/**
	 * 创建时间
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
	 * remark
	 */
	private String remark;
	
	/**
	 * 项目编码
	 */
	private String proj_id;
	
	/**
	 * 模块编码
	 */
	private String module_id;
	
	/**
	 * 需求编码
	 */
	private String demand_id;
	
	/**
	 * 分组状态
	 */
	private String state;
	

	/**
	 * 分组编码
	 * 
	 * @return group_id
	 */
	public Integer getGroup_id() {
		return group_id;
	}
	
	/**
	 * 分组名称
	 * 
	 * @return group_name
	 */
	public String getGroup_name() {
		return group_name;
	}
	
	/**
	 * cascade_id
	 * 
	 * @return cascade_id
	 */
	public String getCascade_id() {
		return cascade_id;
	}
	
	/**
	 * 父类编码
	 * 
	 * @return parent_id
	 */
	public Integer getParent_id() {
		return parent_id;
	}
	
	/**
	 * 是否叶子节点
	 * 
	 * @return is_leaf
	 */
	public String getIs_leaf() {
		return is_leaf;
	}
	
	/**
	 * 是否自动展开
	 * 
	 * @return is_auto_expand
	 */
	public String getIs_auto_expand() {
		return is_auto_expand;
	}
	
	/**
	 * 节点图标文件名称
	 * 
	 * @return icon_name
	 */
	public String getIcon_name() {
		return icon_name;
	}
	
	/**
	 * 任务分组来源
	 * 
	 * @return group_from
	 */
	public Integer getGroup_from() {
		return group_from;
	}
	
	/**
	 * 计划结束时间
	 * 
	 * @return plan_end_time
	 */
	public Date getPlan_end_time() {
		return plan_end_time;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @return plan_begin_time
	 */
	public Date getPlan_begin_time() {
		return plan_begin_time;
	}
	
	/**
	 * 计划消耗天数
	 * 
	 * @return plan_wastage
	 */
	public BigDecimal getPlan_wastage() {
		return plan_wastage;
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
	 * 创建时间
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
	 * remark
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
	}
	
	/**
	 * 项目编码
	 * 
	 * @return proj_id
	 */
	public String getProj_id() {
		return proj_id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @return module_id
	 */
	public String getModule_id() {
		return module_id;
	}
	
	/**
	 * 需求编码
	 * 
	 * @return demand_id
	 */
	public String getDemand_id() {
		return demand_id;
	}
	
	/**
	 * 分组状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 分组编码
	 * 
	 * @param group_id
	 */
	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
	
	/**
	 * 分组名称
	 * 
	 * @param group_name
	 */
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	
	/**
	 * cascade_id
	 * 
	 * @param cascade_id
	 */
	public void setCascade_id(String cascade_id) {
		this.cascade_id = cascade_id;
	}
	
	/**
	 * 父类编码
	 * 
	 * @param parent_id
	 */
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	
	/**
	 * 是否叶子节点
	 * 
	 * @param is_leaf
	 */
	public void setIs_leaf(String is_leaf) {
		this.is_leaf = is_leaf;
	}
	
	/**
	 * 是否自动展开
	 * 
	 * @param is_auto_expand
	 */
	public void setIs_auto_expand(String is_auto_expand) {
		this.is_auto_expand = is_auto_expand;
	}
	
	/**
	 * 节点图标文件名称
	 * 
	 * @param icon_name
	 */
	public void setIcon_name(String icon_name) {
		this.icon_name = icon_name;
	}
	
	/**
	 * 任务分组来源
	 * 
	 * @param group_from
	 */
	public void setGroup_from(Integer group_from) {
		this.group_from = group_from;
	}
	
	/**
	 * 计划结束时间
	 * 
	 * @param plan_end_time
	 */
	public void setPlan_end_time(Date plan_end_time) {
		this.plan_end_time = plan_end_time;
	}
	
	/**
	 * 计划开始时间
	 * 
	 * @param plan_begin_time
	 */
	public void setPlan_begin_time(Date plan_begin_time) {
		this.plan_begin_time = plan_begin_time;
	}
	
	/**
	 * 计划消耗天数
	 * 
	 * @param plan_wastage
	 */
	public void setPlan_wastage(BigDecimal plan_wastage) {
		this.plan_wastage = plan_wastage;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sort_no
	 */
	public void setSort_no(Integer sort_no) {
		this.sort_no = sort_no;
	}
	
	/**
	 * 创建时间
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
	 * remark
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	/**
	 * 项目编码
	 * 
	 * @param proj_id
	 */
	public void setProj_id(String proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @param module_id
	 */
	public void setModule_id(String module_id) {
		this.module_id = module_id;
	}
	
	/**
	 * 需求编码
	 * 
	 * @param demand_id
	 */
	public void setDemand_id(String demand_id) {
		this.demand_id = demand_id;
	}
	
	/**
	 * 分组状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}