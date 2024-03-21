package com.bl3.pm.task.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>ta_task_import_template[ta_task_import_template]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author zhaojiaqi
 * @date 2020-07-17 13:56:57
 */
public class TaskImportTemplatePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 导入模板
	 */
	private Integer mould_id;
	
	/**
	 * 文件编码
	 */
	private String file_code;
	
	/**
	 * 上传文件标题
	 */
	private String file_title;
	
	/**
	 * 上传文件大小
	 */
	private String file_size;
	
	/**
	 * 创建人ID
	 */
	private Integer create_user_id;
	
	/**
	 * 创建时间
	 */
	private Date create_time;
	

	/**
	 * 导入模板
	 * 
	 * @return mould_id
	 */
	public Integer getMould_id() {
		return mould_id;
	}
	
	/**
	 * 文件编码
	 * 
	 * @return file_code
	 */
	public String getFile_code() {
		return file_code;
	}
	
	/**
	 * 上传文件标题
	 * 
	 * @return file_title
	 */
	public String getFile_title() {
		return file_title;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @return file_size
	 */
	public String getFile_size() {
		return file_size;
	}
	
	/**
	 * 创建人ID
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
	 * 导入模板
	 * 
	 * @param mould_id
	 */
	public void setMould_id(Integer mould_id) {
		this.mould_id = mould_id;
	}
	
	/**
	 * 文件编码
	 * 
	 * @param file_code
	 */
	public void setFile_code(String file_code) {
		this.file_code = file_code;
	}
	
	/**
	 * 上传文件标题
	 * 
	 * @param file_title
	 */
	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}
	
	/**
	 * 上传文件大小
	 * 
	 * @param file_size
	 */
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	
	/**
	 * 创建人ID
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
	

}