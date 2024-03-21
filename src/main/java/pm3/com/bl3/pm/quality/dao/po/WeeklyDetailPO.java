package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>qa_weekly_detail[qa_weekly_detail]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author z
 * @date 2018-01-07 21:50:42
 */
public class WeeklyDetailPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 周报ID
	 */
	private Integer test_id;
	
	/**
	 * 周报编码
	 */
	private String test_code;
	
	/**
	 * 序列号
	 */
	private Integer detail;
	
	/**
	 * 项目名称
	 */
	private String proj_name;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 工作内容
	 */
	private String job_content;
	
	/**
	 * 本周任务数
	 */
	private Integer input_cond;
	
	/**
	 * 任务接收情况
	 */
	private String accept_cond;
	
	/**
	 * 任务完成情况
	 */
	private String finish_cond;
	
	/**
	 * 负责人
	 */
	private String charge;
	
	/**
	 * 记录时间
	 */
	private Date add_time;
	
	/**
	 * 记录人
	 */
	private String add_name;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 修改人
	 */
	private String update_name;
	
	/**
	 * 备注
	 */
	private String remarks;
	
	/**
	 * 问题描述
	 */
	private String trouble_bewrite;
	
	/**
	 * 建议
	 */
	private String trouble_advise;
	
	/**
	 * 活动内容
	 */
	private String job_plan;
	
	/**
	 * 缺陷总数
	 */
	private Integer bug_input_num;
	
	/**
	 * 本周新增缺陷数
	 */
	private Integer bug_add_num;
	
	/**
	 * 本周关闭缺陷数
	 */
	private Integer lately_close_num;
	
	/**
	 * 缺陷已解决总数
	 */
	private Integer bug_finish_num;
	
	/**
	 * 缺陷未解决数
	 */
	private Integer bug_unfinish_num;
	
	/**
	 * 缺陷关闭数
	 */
	private Integer bug_close_num;
	

	/**
	 * 周报ID
	 * 
	 * @return test_id
	 */
	public Integer getTest_id() {
		return test_id;
	}
	
	/**
	 * 周报编码
	 * 
	 * @return test_code
	 */
	public String getTest_code() {
		return test_code;
	}
	
	/**
	 * 序列号
	 * 
	 * @return detail
	 */
	public Integer getDetail() {
		return detail;
	}
	
	/**
	 * 项目名称
	 * 
	 * @return proj_name
	 */
	public String getProj_name() {
		return proj_name;
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
	 * 工作内容
	 * 
	 * @return job_content
	 */
	public String getJob_content() {
		return job_content;
	}
	
	/**
	 * 本周任务数
	 * 
	 * @return input_cond
	 */
	public Integer getInput_cond() {
		return input_cond;
	}
	
	/**
	 * 任务接收情况
	 * 
	 * @return accept_cond
	 */
	public String getAccept_cond() {
		return accept_cond;
	}
	
	/**
	 * 任务完成情况
	 * 
	 * @return finish_cond
	 */
	public String getFinish_cond() {
		return finish_cond;
	}
	
	/**
	 * 负责人
	 * 
	 * @return charge
	 */
	public String getCharge() {
		return charge;
	}
	
	/**
	 * 记录时间
	 * 
	 * @return add_time
	 */
	public Date getAdd_time() {
		return add_time;
	}
	
	/**
	 * 记录人
	 * 
	 * @return add_name
	 */
	public String getAdd_name() {
		return add_name;
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
	 * @return update_name
	 */
	public String getUpdate_name() {
		return update_name;
	}
	
	/**
	 * 备注
	 * 
	 * @return remarks
	 */
	public String getRemarks() {
		return remarks;
	}
	
	/**
	 * 问题描述
	 * 
	 * @return trouble_bewrite
	 */
	public String getTrouble_bewrite() {
		return trouble_bewrite;
	}
	
	/**
	 * 建议
	 * 
	 * @return trouble_advise
	 */
	public String getTrouble_advise() {
		return trouble_advise;
	}
	
	/**
	 * 活动内容
	 * 
	 * @return job_plan
	 */
	public String getJob_plan() {
		return job_plan;
	}
	
	/**
	 * 缺陷总数
	 * 
	 * @return bug_input_num
	 */
	public Integer getBug_input_num() {
		return bug_input_num;
	}
	
	/**
	 * 本周新增缺陷数
	 * 
	 * @return bug_add_num
	 */
	public Integer getBug_add_num() {
		return bug_add_num;
	}
	
	/**
	 * 本周关闭缺陷数
	 * 
	 * @return lately_close_num
	 */
	public Integer getLately_close_num() {
		return lately_close_num;
	}
	
	/**
	 * 缺陷已解决总数
	 * 
	 * @return bug_finish_num
	 */
	public Integer getBug_finish_num() {
		return bug_finish_num;
	}
	
	/**
	 * 缺陷未解决数
	 * 
	 * @return bug_unfinish_num
	 */
	public Integer getBug_unfinish_num() {
		return bug_unfinish_num;
	}
	
	/**
	 * 缺陷关闭数
	 * 
	 * @return bug_close_num
	 */
	public Integer getBug_close_num() {
		return bug_close_num;
	}
	

	/**
	 * 周报ID
	 * 
	 * @param test_id
	 */
	public void setTest_id(Integer test_id) {
		this.test_id = test_id;
	}
	
	/**
	 * 周报编码
	 * 
	 * @param test_code
	 */
	public void setTest_code(String test_code) {
		this.test_code = test_code;
	}
	
	/**
	 * 序列号
	 * 
	 * @param detail
	 */
	public void setDetail(Integer detail) {
		this.detail = detail;
	}
	
	/**
	 * 项目名称
	 * 
	 * @param proj_name
	 */
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
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
	 * 工作内容
	 * 
	 * @param job_content
	 */
	public void setJob_content(String job_content) {
		this.job_content = job_content;
	}
	
	/**
	 * 本周任务数
	 * 
	 * @param input_cond
	 */
	public void setInput_cond(Integer input_cond) {
		this.input_cond = input_cond;
	}
	
	/**
	 * 任务接收情况
	 * 
	 * @param accept_cond
	 */
	public void setAccept_cond(String accept_cond) {
		this.accept_cond = accept_cond;
	}
	
	/**
	 * 任务完成情况
	 * 
	 * @param finish_cond
	 */
	public void setFinish_cond(String finish_cond) {
		this.finish_cond = finish_cond;
	}
	
	/**
	 * 负责人
	 * 
	 * @param charge
	 */
	public void setCharge(String charge) {
		this.charge = charge;
	}
	
	/**
	 * 记录时间
	 * 
	 * @param add_time
	 */
	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}
	
	/**
	 * 记录人
	 * 
	 * @param add_name
	 */
	public void setAdd_name(String add_name) {
		this.add_name = add_name;
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
	 * @param update_name
	 */
	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}
	
	/**
	 * 备注
	 * 
	 * @param remarks
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	/**
	 * 问题描述
	 * 
	 * @param trouble_bewrite
	 */
	public void setTrouble_bewrite(String trouble_bewrite) {
		this.trouble_bewrite = trouble_bewrite;
	}
	
	/**
	 * 建议
	 * 
	 * @param trouble_advise
	 */
	public void setTrouble_advise(String trouble_advise) {
		this.trouble_advise = trouble_advise;
	}
	
	/**
	 * 活动内容
	 * 
	 * @param job_plan
	 */
	public void setJob_plan(String job_plan) {
		this.job_plan = job_plan;
	}
	
	/**
	 * 缺陷总数
	 * 
	 * @param bug_input_num
	 */
	public void setBug_input_num(Integer bug_input_num) {
		this.bug_input_num = bug_input_num;
	}
	
	/**
	 * 本周新增缺陷数
	 * 
	 * @param bug_add_num
	 */
	public void setBug_add_num(Integer bug_add_num) {
		this.bug_add_num = bug_add_num;
	}
	
	/**
	 * 本周关闭缺陷数
	 * 
	 * @param lately_close_num
	 */
	public void setLately_close_num(Integer lately_close_num) {
		this.lately_close_num = lately_close_num;
	}
	
	/**
	 * 缺陷已解决总数
	 * 
	 * @param bug_finish_num
	 */
	public void setBug_finish_num(Integer bug_finish_num) {
		this.bug_finish_num = bug_finish_num;
	}
	
	/**
	 * 缺陷未解决数
	 * 
	 * @param bug_unfinish_num
	 */
	public void setBug_unfinish_num(Integer bug_unfinish_num) {
		this.bug_unfinish_num = bug_unfinish_num;
	}
	
	/**
	 * 缺陷关闭数
	 * 
	 * @param bug_close_num
	 */
	public void setBug_close_num(Integer bug_close_num) {
		this.bug_close_num = bug_close_num;
	}
	

}