package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_code_version[bs_proj_code_version]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author hanjin
 * @date 2019-03-08 13:39:11
 */
public class ProjCodeVersionPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 代码版本号主键ID
	 */
	private Integer code_version_id;
	
	/**
	 * 代码版本号
	 */
	private String code_version_number;
	
	/**
	 * 项目版本号ID
	 */
	private Integer version_id;
	
	/**
	 * 测试版本号
	 */
	private Integer test_version_id;
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 排序号
	 */
	private Integer sortno;
	
	/**
	 * 创建人ID
	 */
	private Integer create_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	
	/**
	 * 修改人ID
	 */
	private Integer update_id;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 状态（1 有效 0 无效）
	 */
	private String state;
	
	/**
	 * 创建人
	 */
	private String create_name;
	
	/**
	 * 修改人
	 */
	private String update_name;
	
	/**
	 * 代码版本号主键ID
	 * 
	 * @return code_version_id
	 */
	public Integer getCode_version_id() {
		return code_version_id;
	}
	
	/**
	 * 代码版本号
	 * 
	 * @return code_version_number
	 */
	public String getCode_version_number() {
		return code_version_number;
	}
	
	/**
	 * 版本号ID
	 * 
	 * @return version_id
	 */
	public Integer getVersion_id() {
		return version_id;
	}
	
	/**
	 * 测试版本号ID
	 * 
	 * @return test_version_id
	 */
	public Integer getTest_version_id() {
		return test_version_id;
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
	 * 备注
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @return sortno
	 */
	public Integer getSortno() {
		return sortno;
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
	 * 创建时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 修改人ID
	 * 
	 * @return update_id
	 */
	public Integer getUpdate_id() {
		return update_id;
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
	 * 状态（1 有效 0 无效）
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	

	/**
	 * 代码版本号主键ID
	 * 
	 * @param code_version_id
	 */
	public void setCode_version_id(Integer code_version_id) {
		this.code_version_id = code_version_id;
	}
	
	/**
	 * 代码版本号
	 * 
	 * @param code_version_number
	 */
	public void setCode_version_number(String code_version_number) {
		this.code_version_number = code_version_number;
	}
	
	/**
	 * 版本号ID
	 * 
	 * @param version_id
	 */
	public void setVersion_id(Integer version_id) {
		this.version_id = version_id;
	}
	
	/**
	 * 版本号ID
	 * 
	 * @param test_version_id
	 */
	public void setTest_version_id(Integer test_version_id) {
		this.test_version_id = test_version_id;
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
	 * 备注
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	/**
	 * 排序号
	 * 
	 * @param sortno
	 */
	public void setSortno(Integer sortno) {
		this.sortno = sortno;
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
	 * 创建时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 修改人ID
	 * 
	 * @param update_id
	 */
	public void setUpdate_id(Integer update_id) {
		this.update_id = update_id;
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
	 * 状态（1 有效 0 无效）
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	

}