package com.bl3.pm.recruit.dao.po;

import aos.framework.core.typewrap.PO;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_recruiter_result[bs_recruiter_result]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2018-04-17 17:14:23
 */
public class RecruiterResultPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Integer register_id;
	
	/**
	 * 登记日期
	 */
	private Date register_date;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 性别
	 */
	private String sex;
	
	/**
	 * 联系方式
	 */
	private String link_phone;
	
	/**
	 * 来源
	 */
	private String source;
	
	/**
	 * 登记备注
	 */
	private String register_remark;
	
	/**
	 * 登记人
	 */
	private Integer register_user_id;
	
	/**
	 * 联系日期
	 */
	private Date contact_date;
	
	/**
	 * 联系人
	 */
	private Integer contact_user_id;
	
	/**
	 * 联系结果
	 */
	private String contact_result;
	
	/**
	 * 联系情况
	 */
	private String contact_information;
	
	/**
	 * 约定面试日期
	 */
	private Date interview_date;
	
	/**
	 * 通知入职时间
	 */
	private Date notify_entry_time;
	

	/**
	 * 主键id
	 */
	private Integer result_id;
	

	/**
	 * 人员基本情况
	 */
	private String base_situation;
	
	/**
	 * 面试类型
	 */
	private String interview_type;
	
	/**
	 * 笔试分数
	 */
	private BigDecimal written_score;
	
	/**
	 * 面试分数
	 */
	private BigDecimal interview_score;
	
	/**
	 * 面试官
	 */
	private String interviewer;
	
	/**
	 * 实际面试时间
	 */
	private Date real_interviewer_time;
	
	/**
	 * 面试结果
	 */
	private String interview_result;
	
	/**
	 * 结论说明
	 */
	private String conclusion;
	
	/**
	 * 入职主键id
	 */
	private Integer entry_id;
	

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
	 * 登记人
	 */
	private String register_user_name;
	
	/**
	 * 联系人
	 */
	private String contact_user_name;
	
	/**
	 * 性别
	 */
	private String sex_name;
	
	/**
	 *面试结果
	 */
	private String interview_result_name;
	
	/**
	 *入职类型
	 */
	private String entry_type_name;
	
	/**
	 *入职岗位
	 */
	private String entry_post_name;

	/**
	 * id
	 * 
	 * @return id
	 */
	public Integer getRegister_Id() {
		return register_id;
	}
	
	/**
	 * 登记日期
	 * 
	 * @return register_date
	 */
	public Date getRegister_date() {
		return register_date;
	}
	
	/**
	 * 姓名
	 * 
	 * @return name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * 性别
	 * 
	 * @return sex
	 */
	public String getSex() {
		return sex;
	}
	
	/**
	 * 联系方式
	 * 
	 * @return link_phone
	 */
	public String getLink_phone() {
		return link_phone;
	}
	
	/**
	 * 来源
	 * 
	 * @return source
	 */
	public String getSource() {
		return source;
	}
	
	/**
	 * 登记备注
	 * 
	 * @return register_remark
	 */
	public String getRegister_remark() {
		return register_remark;
	}
	
	/**
	 * 登记人
	 * 
	 * @return register_user_id
	 */
	public Integer getRegister_user_id() {
		return register_user_id;
	}
	
	/**
	 * 联系日期
	 * 
	 * @return contact_date
	 */
	public Date getContact_date() {
		return contact_date;
	}
	
	/**
	 * 联系人
	 * 
	 * @return contact_user_id
	 */
	public Integer getContact_user_id() {
		return contact_user_id;
	}
	
	/**
	 * 联系结果
	 * 
	 * @return contact_result
	 */
	public String getContact_result() {
		return contact_result;
	}
	
	/**
	 * 联系情况
	 * 
	 * @return contact_information
	 */
	public String getContact_information() {
		return contact_information;
	}
	
	/**
	 * 约定面试日期
	 * 
	 * @return 
interview_date
	 */
	public Date getinterview_date() {
		return 
interview_date;
	}
	
	/**
	 * 通知入职时间
	 * 
	 * @return notify_entry_time
	 */
	public Date getNotify_entry_time() {
		return notify_entry_time;
	}
	

	/**
	 * id
	 * 
	 * @param id
	 */
	public void setRegister_Id(Integer register_Id) {
		this.register_id = register_Id;
	}
	
	/**
	 * 登记日期
	 * 
	 * @param register_date
	 */
	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	
	/**
	 * 姓名
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 性别
	 * 
	 * @param sex
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	/**
	 * 联系方式
	 * 
	 * @param link_phone
	 */
	public void setLink_phone(String link_phone) {
		this.link_phone = link_phone;
	}
	
	/**
	 * 来源
	 * 
	 * @param source
	 */
	public void setSource(String source) {
		this.source = source;
	}
	
	/**
	 * 登记备注
	 * 
	 * @param register_remark
	 */
	public void setRegister_remark(String register_remark) {
		this.register_remark = register_remark;
	}
	
	/**
	 * 登记人
	 * 
	 * @param register_user_id
	 */
	public void setRegister_user_id(Integer register_user_id) {
		this.register_user_id = register_user_id;
	}
	
	/**
	 * 联系日期
	 * 
	 * @param contact_date
	 */
	public void setContact_date(Date contact_date) {
		this.contact_date = contact_date;
	}
	
	/**
	 * 联系人
	 * 
	 * @param contact_user_id
	 */
	public void setContact_user_id(Integer contact_user_id) {
		this.contact_user_id = contact_user_id;
	}
	
	/**
	 * 联系结果
	 * 
	 * @param contact_result
	 */
	public void setContact_result(String contact_result) {
		this.contact_result = contact_result;
	}
	
	/**
	 * 联系情况
	 * 
	 * @param contact_information
	 */
	public void setContact_information(String contact_information) {
		this.contact_information = contact_information;
	}
	
	/**
	 * 约定面试日期
	 * 
	 * @param 
interview_date
	 */
	public void setinterview_date(Date interview_date) {
		this.interview_date = interview_date;
	}
	
	/**
	 * 通知入职时间
	 * 
	 * @param notify_entry_time
	 */
	public void setNotify_entry_time(Date notify_entry_time) {
		this.notify_entry_time = notify_entry_time;
	}
	/**
	 * 主键id
	 * 
	 * @return result_id
	 */
	public Integer getResult_id() {
		return result_id;
	}
	

	/**
	 * 人员基本情况
	 * 
	 * @return base_situation
	 */
	public String getBase_situation() {
		return base_situation;
	}
	
	/**
	 * 面试类型
	 * 
	 * @return interview_type
	 */
	public String getInterview_type() {
		return interview_type;
	}
	
	/**
	 * 笔试分数
	 * 
	 * @return written_score
	 */
	public BigDecimal getWritten_score() {
		return written_score;
	}
	
	/**
	 * 面试分数
	 * 
	 * @return interview_score
	 */
	public BigDecimal getInterview_score() {
		return interview_score;
	}
	
	/**
	 * 面试官
	 * 
	 * @return interviewer
	 */
	public String getInterviewer() {
		return interviewer;
	}
	
	/**
	 * 实际面试时间
	 * 
	 * @return real_interviewer_time
	 */
	public Date getReal_interviewer_time() {
		return real_interviewer_time;
	}
	
	/**
	 * 面试结果
	 * 
	 * @return interview_result
	 */
	public String getInterview_result() {
		return interview_result;
	}
	
	/**
	 * 结论说明
	 * 
	 * @return conclusion
	 */
	public String getConclusion() {
		return conclusion;
	}
	

	/**
	 * 主键id
	 * 
	 * @param result_id
	 */
	public void setResult_id(Integer result_id) {
		this.result_id = result_id;
	}
	

	
	/**
	 * 人员基本情况
	 * 
	 * @param base_situation
	 */
	public void setBase_situation(String base_situation) {
		this.base_situation = base_situation;
	}
	
	/**
	 * 面试类型
	 * 
	 * @param interview_type
	 */
	public void setInterview_type(String interview_type) {
		this.interview_type = interview_type;
	}
	
	/**
	 * 笔试分数
	 * 
	 * @param written_score
	 */
	public void setWritten_score(BigDecimal written_score) {
		this.written_score = written_score;
	}
	
	/**
	 * 面试分数
	 * 
	 * @param interview_score
	 */
	public void setInterview_score(BigDecimal interview_score) {
		this.interview_score = interview_score;
	}
	
	/**
	 * 面试官
	 * 
	 * @param interviewer
	 */
	public void setInterviewer(String interviewer) {
		this.interviewer = interviewer;
	}
	
	/**
	 * 实际面试时间
	 * 
	 * @param real_interviewer_time
	 */
	public void setReal_interviewer_time(Date real_interviewer_time) {
		this.real_interviewer_time = real_interviewer_time;
	}
	
	/**
	 * 面试结果
	 * 
	 * @param interview_result
	 */
	public void setInterview_result(String interview_result) {
		this.interview_result = interview_result;
	}
	
	/**
	 * 结论说明
	 * 
	 * @param conclusion
	 */
	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	
	/**
	 * 入职主键id
	 * 
	 * @return entry_id
	 */
	public Integer getEntry_id() {
		return entry_id;
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

	public Integer getRegister_id() {
		return register_id;
	}

	public void setRegister_id(Integer register_id) {
		this.register_id = register_id;
	}

	public Date getInterview_date() {
		return interview_date;
	}

	public void setInterview_date(Date interview_date) {
		this.interview_date = interview_date;
	}

	public String getRegister_user_name() {
		return register_user_name;
	}

	public void setRegister_user_name(String register_user_name) {
		this.register_user_name = register_user_name;
	}

	public String getContact_user_name() {
		return contact_user_name;
	}

	public void setContact_user_name(String contact_user_name) {
		this.contact_user_name = contact_user_name;
	}

	public String getSex_name() {
		return sex_name;
	}

	public void setSex_name(String sex_name) {
		this.sex_name = sex_name;
	}

	public String getInterview_result_name() {
		return interview_result_name;
	}

	public void setInterview_result_name(String interview_result_name) {
		this.interview_result_name = interview_result_name;
	}

	public String getEntry_type_name() {
		return entry_type_name;
	}

	public void setEntry_type_name(String entry_type_name) {
		this.entry_type_name = entry_type_name;
	}

	public String getEntry_post_name() {
		return entry_post_name;
	}

	public void setEntry_post_name(String entry_post_name) {
		this.entry_post_name = entry_post_name;
	}
	
	
	
	
}