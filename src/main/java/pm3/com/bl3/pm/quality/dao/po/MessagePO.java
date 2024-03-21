package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <b>qa_message[qa_message]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author z
 * @date 2018-01-31 15:43:01
 */
public class MessagePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 消息ID
	 */
	private Integer msg_id;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 消息内容
	 */
	private String msg_note;
	
	/**
	 * 接收时间(评审开始时间)
	 */
	private Date begin_date;
	
	/**
	 * 评审结束时间
	 */
	private Date end_date;
	
	/**
	 * 评审入口
	 */
	private String mang_id;
	
	/**
	 * 接收人ID
	 */
	private Integer user_id;
	
	/**
	 * 接收人名称
	 */
	private String user_name;
	
	/**
	 * 发送者ID
	 */
	private Integer send_id;
	
	/**
	 * 发送者名称
	 */
	private String send_name;
	
	/**
	 * 消息状态
	 */
	private String msg_state;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 创建人ID
	 */
	private Integer create_id;
	
	/**
	 * 创建人名称
	 */
	private String create_name;
	
	/**
	 * 意见入口
	 */
	private String opinion_code;
	
	/**
	 * 有效标志
	 */
	private String flag;
	
	/**
	 * 综合信息
	 */
	private String remarks;
	
	/**
	 * 评审状态
	 */
	private String state_flag;
	
	/**
	 * 是否通过(通过 2，不通过1)
	 */
	private Integer pass_flag;
	
	/**
	 * 图标
	 */
	private String ico;
	
	/**
	 * 主题
	 */
	private String theme;
	
	/**
	 * 附件
	 */
	private String fileload;
	
	/**
	 * 会议工作量
	 */
	private BigDecimal workload;
	
	
	
	

	public BigDecimal getWorkload() {
		return workload;
	}

	public void setWorkload(BigDecimal workload) {
		this.workload = workload;
	}

	public Integer getProj_id() {
		return proj_id;
	}

	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}

	/**
	 * 消息ID
	 * 
	 * @return msg_id
	 */
	public Integer getMsg_id() {
		return msg_id;
	}
	
	/**
	 * 消息内容
	 * 
	 * @return msg_note
	 */
	public String getMsg_note() {
		return msg_note;
	}
	
	/**
	 * 接收时间(评审开始时间)
	 * 
	 * @return begin_date
	 */
	public Date getBegin_date() {
		return begin_date;
	}
	
	/**
	 * 评审结束时间
	 * 
	 * @return end_date
	 */
	public Date getEnd_date() {
		return end_date;
	}
	
	/**
	 * 评审入口
	 * 
	 * @return mang_id
	 */
	public String getMang_id() {
		return mang_id;
	}
	
	/**
	 * 接收人ID
	 * 
	 * @return user_id
	 */
	public Integer getUser_id() {
		return user_id;
	}
	
	/**
	 * 接收人名称
	 * 
	 * @return user_name
	 */
	public String getUser_name() {
		return user_name;
	}
	
	/**
	 * 发送者ID
	 * 
	 * @return send_id
	 */
	public Integer getSend_id() {
		return send_id;
	}
	
	/**
	 * 发送者名称
	 * 
	 * @return send_name
	 */
	public String getSend_name() {
		return send_name;
	}
	
	/**
	 * 消息状态
	 * 
	 * @return msg_state
	 */
	public String getMsg_state() {
		return msg_state;
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
	 * 创建人ID
	 * 
	 * @return create_id
	 */
	public Integer getCreate_id() {
		return create_id;
	}
	
	/**
	 * 创建人名称
	 * 
	 * @return create_name
	 */
	public String getCreate_name() {
		return create_name;
	}
	
	/**
	 * 意见入口
	 * 
	 * @return opinion_code
	 */
	public String getOpinion_code() {
		return opinion_code;
	}
	
	/**
	 * 有效标志
	 * 
	 * @return flag
	 */
	public String getFlag() {
		return flag;
	}
	
	/**
	 * 综合信息
	 * 
	 * @return remarks
	 */
	public String getRemarks() {
		return remarks;
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
	 * 是否通过(通过 2，不通过1)
	 * 
	 * @return pass_flag
	 */
	public Integer getPass_flag() {
		return pass_flag;
	}
	
	/**
	 * 图标
	 * 
	 * @return ico
	 */
	public String getIco() {
		return ico;
	}
	
	/**
	 * 主题
	 * 
	 * @return theme
	 */
	public String getTheme() {
		return theme;
	}
	
	/**
	 * 附件
	 * 
	 * @return fileload
	 */
	public String getFileload() {
		return fileload;
	}
	

	/**
	 * 消息ID
	 * 
	 * @param msg_id
	 */
	public void setMsg_id(Integer msg_id) {
		this.msg_id = msg_id;
	}
	
	/**
	 * 消息内容
	 * 
	 * @param msg_note
	 */
	public void setMsg_note(String msg_note) {
		this.msg_note = msg_note;
	}
	
	/**
	 * 接收时间(评审开始时间)
	 * 
	 * @param begin_date
	 */
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	
	/**
	 * 评审结束时间
	 * 
	 * @param end_date
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	/**
	 * 评审入口
	 * 
	 * @param mang_id
	 */
	public void setMang_id(String mang_id) {
		this.mang_id = mang_id;
	}
	
	/**
	 * 接收人ID
	 * 
	 * @param user_id
	 */
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	
	/**
	 * 接收人名称
	 * 
	 * @param user_name
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	/**
	 * 发送者ID
	 * 
	 * @param send_id
	 */
	public void setSend_id(Integer send_id) {
		this.send_id = send_id;
	}
	
	/**
	 * 发送者名称
	 * 
	 * @param send_name
	 */
	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	
	/**
	 * 消息状态
	 * 
	 * @param msg_state
	 */
	public void setMsg_state(String msg_state) {
		this.msg_state = msg_state;
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
	 * 创建人ID
	 * 
	 * @param create_id
	 */
	public void setCreate_id(Integer create_id) {
		this.create_id = create_id;
	}
	
	/**
	 * 创建人名称
	 * 
	 * @param create_name
	 */
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	
	/**
	 * 意见入口
	 * 
	 * @param opinion_code
	 */
	public void setOpinion_code(String opinion_code) {
		this.opinion_code = opinion_code;
	}
	
	/**
	 * 有效标志
	 * 
	 * @param flag
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	/**
	 * 综合信息
	 * 
	 * @param remarks
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	 * 是否通过(通过 2，不通过1)
	 * 
	 * @param pass_flag
	 */
	public void setPass_flag(Integer pass_flag) {
		this.pass_flag = pass_flag;
	}
	
	/**
	 * 图标
	 * 
	 * @param ico
	 */
	public void setIco(String ico) {
		this.ico = ico;
	}
	
	/**
	 * 主题
	 * 
	 * @param theme
	 */
	public void setTheme(String theme) {
		this.theme = theme;
	}
	
	/**
	 * 附件
	 * 
	 * @param fileload
	 */
	public void setFileload(String fileload) {
		this.fileload = fileload;
	}
	

}