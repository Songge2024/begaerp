package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>qa_files_manage[qa_files_manage]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author huangtao
 * @date 2018-06-13 15:54:21
 */
public class FilesManagePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 评审id
	 */
	private Integer manage_id;
	
	/**
	 * 评审编码
	 */
	private String manage_code;
	
	/**
	 * 评审主题
	 */
	private String theme;
	
	/**
	 * 评审内容
	 */
	private String file_note;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 参与人(内部)ID
	 */
	private String attende_id;
	
	/**
	 * 参加人员(内部)
	 */
	private String attende_mans;
	
	/**
	 * 结论
	 */
	private String result;
	
	/**
	 * 创建人
	 */
	private Integer create_name;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 文档地址
	 */
	private String file_addr;
	
	/**
	 * 意见
	 */
	private String opinion;
	
	/**
	 * 意见编码
	 */
	private String opinion_code;
	
	/**
	 * 评审状态
	 */
	private String state_flag;
	
	/**
	 * 文档标题
	 */
	private String file_title;
	
	/**
	 * 结束时间
	 */
	private Date end_date;
	
	/**
	 * 是否通过
	 */
	private Integer pass_flag;
	
	/**
	 * 开始时间
	 */
	private Date begin_date;
	
	/**
	 * 参与人(外部)
	 */
	private String attende_mans_out;
	
	/**
	 * 主持人
	 */
	private Integer compere;
	
	/**
	 * 发起人
	 */
	private Integer initiator;
	
	/**
	 * 评审地点
	 */
	private String review_addre;
	
	/**
	 * 评论开始时间
	 */
	private Date manage_begin_date;
	
	/**
	 * 评审方式(1.会议，2在线，3邮件)
	 */
	private Integer review_type;
	
	/**
	 * 会议类型（1.项目周例会,2.评审会议,3.专题会议,4.其它）
	 */
	private Integer meeting_type;
	
	/**
	 * 评论结束时间
	 */
	private Date manage_end_date;
	
	/**
	 * 评审工作量
	 */
	private BigDecimal workload;
	
	private String proj_name;
	
	private Date update_time;
	
	private Integer update_id;
	
	private Date recall_time;
	
	public Date getRecall_time() {
		return recall_time;
	}

	public void setRecall_time(Date recall_time) {
		this.recall_time = recall_time;
	}

	public Integer getRecall_id() {
		return recall_id;
	}

	public void setRecall_id(Integer recall_id) {
		this.recall_id = recall_id;
	}

	private Integer recall_id;

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public Integer getUpdate_id() {
		return update_id;
	}

	public void setUpdate_id(Integer update_id) {
		this.update_id = update_id;
	}

	public String getProj_name() {
		return proj_name;
	}

	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}

	public Integer getProj_id() {
		return proj_id;
	}

	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}

	public Integer getMeeting_type() {
		return meeting_type;
	}

	public void setMeeting_type(Integer meeting_type) {
		this.meeting_type = meeting_type;
	}

	/**
	 * 评审id
	 * 
	 * @return manage_id
	 */
	public Integer getManage_id() {
		return manage_id;
	}
	
	/**
	 * 评审编码
	 * 
	 * @return manage_code
	 */
	public String getManage_code() {
		return manage_code;
	}
	
	/**
	 * 评审主题
	 * 
	 * @return theme
	 */
	public String getTheme() {
		return theme;
	}
	
	/**
	 * 评审内容
	 * 
	 * @return file_note
	 */
	public String getFile_note() {
		return file_note;
	}
	
	/**
	 * 参与人(内部)ID
	 * 
	 * @return attende_id
	 */
	public String getAttende_id() {
		return attende_id;
	}
	
	/**
	 * 参加人员(内部)
	 * 
	 * @return attende_mans
	 */
	public String getAttende_mans() {
		return attende_mans;
	}
	
	/**
	 * 结论
	 * 
	 * @return result
	 */
	public String getResult() {
		return result;
	}
	
	/**
	 * 创建人
	 * 
	 * @return create_name
	 */
	public Integer getCreate_name() {
		return create_name;
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
	 * 文档地址
	 * 
	 * @return file_addr
	 */
	public String getFile_addr() {
		return file_addr;
	}
	
	/**
	 * 意见
	 * 
	 * @return opinion
	 */
	public String getOpinion() {
		return opinion;
	}
	
	/**
	 * 意见编码
	 * 
	 * @return opinion_code
	 */
	public String getOpinion_code() {
		return opinion_code;
	}
	
	/**
	 * 评审状态
	 * 
	 * @return state_flag
	 */
	public String getState_flag() {
		return state_flag;
	}
	
	/**
	 * 文档标题
	 * 
	 * @return file_title
	 */
	public String getFile_title() {
		return file_title;
	}
	
	/**
	 * 结束时间
	 * 
	 * @return end_date
	 */
	public Date getEnd_date() {
		return end_date;
	}
	
	/**
	 * 是否通过
	 * 
	 * @return pass_flag
	 */
	public Integer getPass_flag() {
		return pass_flag;
	}
	
	/**
	 * 开始时间
	 * 
	 * @return begin_date
	 */
	public Date getBegin_date() {
		return begin_date;
	}
	
	/**
	 * 参与人(外部)
	 * 
	 * @return attende_mans_out
	 */
	public String getAttende_mans_out() {
		return attende_mans_out;
	}
	
	/**
	 * 主持人
	 * 
	 * @return compere
	 */
	public Integer getCompere() {
		return compere;
	}
	
	/**
	 * 发起人
	 * 
	 * @return initiator
	 */
	public Integer getInitiator() {
		return initiator;
	}
	
	/**
	 * 评审地点
	 * 
	 * @return review_addre
	 */
	public String getReview_addre() {
		return review_addre;
	}
	
	/**
	 * 评论开始时间
	 * 
	 * @return manage_begin_date
	 */
	public Date getManage_begin_date() {
		return manage_begin_date;
	}
	
	/**
	 * 评审方式(1.会议，2在线，3邮件)
	 * 
	 * @return review_type
	 */
	public Integer getReview_type() {
		return review_type;
	}
	
	/**
	 * 评论结束时间
	 * 
	 * @return manage_end_date
	 */
	public Date getManage_end_date() {
		return manage_end_date;
	}
	
	/**
	 * 评审工作量
	 * 
	 * @return workload
	 */
	public BigDecimal getWorkload() {
		return workload;
	}
	

	/**
	 * 评审id
	 * 
	 * @param manage_id
	 */
	public void setManage_id(Integer manage_id) {
		this.manage_id = manage_id;
	}
	
	/**
	 * 评审编码
	 * 
	 * @param manage_code
	 */
	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	
	/**
	 * 评审主题
	 * 
	 * @param theme
	 */
	public void setTheme(String theme) {
		this.theme = theme;
	}
	
	/**
	 * 评审内容
	 * 
	 * @param file_note
	 */
	public void setFile_note(String file_note) {
		this.file_note = file_note;
	}
	
	/**
	 * 参与人(内部)ID
	 * 
	 * @param attende_id
	 */
	public void setAttende_id(String attende_id) {
		this.attende_id = attende_id;
	}
	
	/**
	 * 参加人员(内部)
	 * 
	 * @param attende_mans
	 */
	public void setAttende_mans(String attende_mans) {
		this.attende_mans = attende_mans;
	}
	
	/**
	 * 结论
	 * 
	 * @param result
	 */
	public void setResult(String result) {
		this.result = result;
	}
	
	/**
	 * 创建人
	 * 
	 * @param create_name
	 */
	public void setCreate_name(Integer create_name) {
		this.create_name = create_name;
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
	 * 文档地址
	 * 
	 * @param file_addr
	 */
	public void setFile_addr(String file_addr) {
		this.file_addr = file_addr;
	}
	
	/**
	 * 意见
	 * 
	 * @param opinion
	 */
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	/**
	 * 意见编码
	 * 
	 * @param opinion_code
	 */
	public void setOpinion_code(String opinion_code) {
		this.opinion_code = opinion_code;
	}
	
	/**
	 * 评审状态
	 * 
	 * @param state_flag
	 */
	public void setState_flag(String state_flag) {
		this.state_flag = state_flag;
	}
	
	/**
	 * 文档标题
	 * 
	 * @param file_title
	 */
	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}
	
	/**
	 * 结束时间
	 * 
	 * @param end_date
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	/**
	 * 是否通过
	 * 
	 * @param pass_flag
	 */
	public void setPass_flag(Integer pass_flag) {
		this.pass_flag = pass_flag;
	}
	
	/**
	 * 开始时间
	 * 
	 * @param begin_date
	 */
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	
	/**
	 * 参与人(外部)
	 * 
	 * @param attende_mans_out
	 */
	public void setAttende_mans_out(String attende_mans_out) {
		this.attende_mans_out = attende_mans_out;
	}
	
	/**
	 * 主持人
	 * 
	 * @param compere
	 */
	public void setCompere(Integer compere) {
		this.compere = compere;
	}
	
	/**
	 * 发起人
	 * 
	 * @param initiator
	 */
	public void setInitiator(Integer initiator) {
		this.initiator = initiator;
	}
	
	/**
	 * 评审地点
	 * 
	 * @param review_addre
	 */
	public void setReview_addre(String review_addre) {
		this.review_addre = review_addre;
	}
	
	/**
	 * 评论开始时间
	 * 
	 * @param manage_begin_date
	 */
	public void setManage_begin_date(Date manage_begin_date) {
		this.manage_begin_date = manage_begin_date;
	}
	
	/**
	 * 评审方式(1.会议，2在线，3邮件)
	 * 
	 * @param review_type
	 */
	public void setReview_type(Integer review_type) {
		this.review_type = review_type;
	}
	
	/**
	 * 评论结束时间
	 * 
	 * @param manage_end_date
	 */
	public void setManage_end_date(Date manage_end_date) {
		this.manage_end_date = manage_end_date;
	}
	
	/**
	 * 评审工作量
	 * 
	 * @param workload
	 */
	public void setWorkload(BigDecimal workload) {
		this.workload = workload;
	}
	

}