package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>qa_weekly[qa_weekly]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author Z
 * @date 2017-12-19 09:42:27
 */
public class WeeklyPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 周报ID
	 */
	private Integer weekly_id;
	
	/**
	 * 周报明细编码
	 */
	private String test_code;
	
	/**
	 * 开始时间
	 */
	private Date begin_date;
	
	/**
	 * 结束时间
	 */
	private Date end_date;
	
	/**
	 * 测试组长
	 */
	private String test_leader;
	
	/**
	 * 记录人
	 */
	private String add_name;
	
	/**
	 * 记录时间
	 */
	private Date create_time;
	
	/**
	 * 备注
	 */
	private String remarks;
	
	/**
	 * 是否有效
	 */
	private String flag;
	

	/**
	 * 周报ID
	 * 
	 * @return weekly_id
	 */
	public Integer getWeekly_id() {
		return weekly_id;
	}
	
	/**
	 * 周报明细编码
	 * 
	 * @return test_code
	 */
	public String getTest_code() {
		return test_code;
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
	 * 结束时间
	 * 
	 * @return end_date
	 */
	public Date getEnd_date() {
		return end_date;
	}
	
	/**
	 * 测试组长
	 * 
	 * @return test_leader
	 */
	public String getTest_leader() {
		return test_leader;
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
	 * 记录时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
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
	 * 是否有效
	 * 
	 * @return flag
	 */
	public String getFlag() {
		return flag;
	}
	

	/**
	 * 周报ID
	 * 
	 * @param weekly_id
	 */
	public void setWeekly_id(Integer weekly_id) {
		this.weekly_id = weekly_id;
	}
	
	/**
	 * 周报明细编码
	 * 
	 * @param test_code
	 */
	public void setTest_code(String test_code) {
		this.test_code = test_code;
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
	 * 结束时间
	 * 
	 * @param end_date
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	/**
	 * 测试组长
	 * 
	 * @param test_leader
	 */
	public void setTest_leader(String test_leader) {
		this.test_leader = test_leader;
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
	 * 记录时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
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
	 * 是否有效
	 * 
	 * @param flag
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	

}