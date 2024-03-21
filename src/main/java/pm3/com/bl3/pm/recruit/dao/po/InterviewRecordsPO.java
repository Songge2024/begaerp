package com.bl3.pm.recruit.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>bs_interview_records[bs_interview_records]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hege
 * @date 2018-05-02 15:02:41
 */
public class InterviewRecordsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	private Integer result_id;
	
	/**
	 * 登记Id
	 */
	private Integer register_id;
	
	/**
	 * 人员基本情况
	 */
	private String base_situation;
	
	/**
	 * 面试类型
	 */
	private String interview_type;
	/**
	 * 面试结论
	 */
	private String interview_result;
	
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
	private Date interview_date;
	

	
	/**
	 * 结论说明
	 */
	private String conclusion;
	
	
	/**
	 * 主键id
	 * 
	 * @return result_id
	 */
	public Integer getResult_id() {
		return result_id;
	}
	
	/**
	 * 登记Id
	 * 
	 * @return register_id
	 */
	public Integer getRegister_id() {
		return register_id;
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
	 * 登记Id
	 * 
	 * @param register_id
	 */
	public void setRegister_id(Integer register_id) {
		this.register_id = register_id;
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
	 * 结论说明
	 * 
	 * @param conclusion
	 */
	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	
	

	public Date getInterview_date() {
		return interview_date;
	}

	public void setInterview_date(Date interview_date) {
		this.interview_date = interview_date;
	}

	public String getInterview_result() {
		return interview_result;
	}

	public void setInterview_result(String interview_result) {
		this.interview_result = interview_result;
	}
	

}