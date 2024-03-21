package com.bl3.pm.process.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>pr_check_main[pr_check_main]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-22 20:33:19
 */
public class CheckMainPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 检查单目录ID
	 */
	private Integer check_id;
	
	/**
	 * 检查项编码
	 */
	private String check_code;
	
	/**
	 * proj_id
	 */
	private Integer proj_id;
	
	/**
	 * 检查项维护ID
	 */
	private Integer check_cata_id;
	
	/**
	 * 检查单名称
	 */
	private String check_name;
	
	/**
	 * 说明
	 */
	private String comment;
	
	/**
	 * 统计 符合数
	 */
	private Integer yes_num;
	
	/**
	 * 统计 不符合数
	 */
	private Integer no_num;
	
	/**
	 * 统计 不适应数
	 */
	private Integer none_num;
	
	/**
	 * 建议与意见
	 */
	private String suggest;
	
	/**
	 * 检查人
	 */
	private Integer check_user_id;
	
	/**
	 * 检查时间
	 */
	private Date check_time;
	
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
	 * 状态
	 */
	private String state;
	
	private String check_user_name;
	
	private Integer all_num;
	
	private Integer problem_num;
	
	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public Integer getAll_num() {
		return all_num;
	}

	public void setAll_num(Integer all_num) {
		this.all_num = all_num;
	}

	public Integer getProblem_num() {
		return problem_num;
	}

	public void setProblem_num(Integer problem_num) {
		this.problem_num = problem_num;
	}

	/**
	 * 计划检查时间
	 */
	private Date plan_check_time;
	
	private String check_cata_name;
	
	
	

	public String getCheck_cata_name() {
		return check_cata_name;
	}

	public void setCheck_cata_name(String check_cata_name) {
		this.check_cata_name = check_cata_name;
	}

	/**
	 * 检查单目录ID
	 * 
	 * @return check_id
	 */
	public Integer getCheck_id() {
		return check_id;
	}
	
	/**
	 * 检查项编码
	 * 
	 * @return check_code
	 */
	public String getCheck_code() {
		return check_code;
	}
	
	/**
	 * proj_id
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 检查项维护ID
	 * 
	 * @return check_cata_id
	 */
	public Integer getCheck_cata_id() {
		return check_cata_id;
	}
	
	/**
	 * 检查单名称
	 * 
	 * @return check_name
	 */
	public String getCheck_name() {
		return check_name;
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
	 * 统计 符合数
	 * 
	 * @return yes_num
	 */
	public Integer getYes_num() {
		return yes_num;
	}
	
	/**
	 * 统计 不符合数
	 * 
	 * @return no_num
	 */
	public Integer getNo_num() {
		return no_num;
	}
	
	/**
	 * 统计 不适应数
	 * 
	 * @return none_num
	 */
	public Integer getNone_num() {
		return none_num;
	}
	
	/**
	 * 建议与意见
	 * 
	 * @return suggest
	 */
	public String getSuggest() {
		return suggest;
	}
	
	/**
	 * 检查人
	 * 
	 * @return check_user_id
	 */
	public Integer getCheck_user_id() {
		return check_user_id;
	}
	
	/**
	 * 检查时间
	 * 
	 * @return check_time
	 */
	public Date getCheck_time() {
		return check_time;
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
	 * 状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 计划检查时间
	 * 
	 * @return plan_check_time
	 */
	public Date getPlan_check_time() {
		return plan_check_time;
	}
	

	/**
	 * 检查单目录ID
	 * 
	 * @param check_id
	 */
	public void setCheck_id(Integer check_id) {
		this.check_id = check_id;
	}
	
	/**
	 * 检查项编码
	 * 
	 * @param check_code
	 */
	public void setCheck_code(String check_code) {
		this.check_code = check_code;
	}
	
	/**
	 * proj_id
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 检查项维护ID
	 * 
	 * @param check_cata_id
	 */
	public void setCheck_cata_id(Integer check_cata_id) {
		this.check_cata_id = check_cata_id;
	}
	
	/**
	 * 检查单名称
	 * 
	 * @param check_name
	 */
	public void setCheck_name(String check_name) {
		this.check_name = check_name;
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
	 * 统计 符合数
	 * 
	 * @param yes_num
	 */
	public void setYes_num(Integer yes_num) {
		this.yes_num = yes_num;
	}
	
	/**
	 * 统计 不符合数
	 * 
	 * @param no_num
	 */
	public void setNo_num(Integer no_num) {
		this.no_num = no_num;
	}
	
	/**
	 * 统计 不适应数
	 * 
	 * @param none_num
	 */
	public void setNone_num(Integer none_num) {
		this.none_num = none_num;
	}
	
	/**
	 * 建议与意见
	 * 
	 * @param suggest
	 */
	public void setSuggest(String suggest) {
		this.suggest = suggest;
	}
	
	/**
	 * 检查人
	 * 
	 * @param check_user_id
	 */
	public void setCheck_user_id(Integer check_user_id) {
		this.check_user_id = check_user_id;
	}
	
	/**
	 * 检查时间
	 * 
	 * @param check_time
	 */
	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
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
	
	/**
	 * 状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 计划检查时间
	 * 
	 * @param plan_check_time
	 */
	public void setPlan_check_time(Date plan_check_time) {
		this.plan_check_time = plan_check_time;
	}
	

}