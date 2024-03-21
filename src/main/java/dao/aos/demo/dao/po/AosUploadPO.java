package  aos.demo.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>aos_upload[aos_upload]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author z
 * @date 2018-01-21 15:53:01
 */
public class AosUploadPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 文件ID
	 */
	private Integer fileid;
	
	/**
	 * 文件标题
	 */
	private String title;
	
	/**
	 * 文件存储相对路径
	 */
	private String path;
	
	/**
	 * 文件大小(字节)
	 */
	private String filesize;
	
	/**
	 * 文件描述
	 */
	private String remark;
	
	/**
	 * 文件访问路径
	 */
	private String loadurl;
	
	/**
	 * 评审附件关联字段
	 */
	private String manin_id;
	

	/**
	 * 文件ID
	 * 
	 * @return fileid
	 */
	public Integer getFileid() {
		return fileid;
	}
	
	/**
	 * 文件标题
	 * 
	 * @return title
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * 文件存储相对路径
	 * 
	 * @return path
	 */
	public String getPath() {
		return path;
	}
	
	/**
	 * 文件大小(字节)
	 * 
	 * @return filesize
	 */
	public String getFilesize() {
		return filesize;
	}
	
	/**
	 * 文件描述
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
	}
	
	/**
	 * 文件访问路径
	 * 
	 * @return loadurl
	 */
	public String getLoadurl() {
		return loadurl;
	}
	
	/**
	 * 评审附件关联字段
	 * 
	 * @return manin_id
	 */
	public String getManin_id() {
		return manin_id;
	}
	

	/**
	 * 文件ID
	 * 
	 * @param fileid
	 */
	public void setFileid(Integer fileid) {
		this.fileid = fileid;
	}
	
	/**
	 * 文件标题
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * 文件存储相对路径
	 * 
	 * @param path
	 */
	public void setPath(String path) {
		this.path = path;
	}
	
	/**
	 * 文件大小(字节)
	 * 
	 * @param filesize
	 */
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	/**
	 * 文件描述
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	/**
	 * 文件访问路径
	 * 
	 * @param loadurl
	 */
	public void setLoadurl(String loadurl) {
		this.loadurl = loadurl;
	}
	
	/**
	 * 评审附件关联字段
	 * 
	 * @param manin_id
	 */
	public void setManin_id(String manin_id) {
		this.manin_id = manin_id;
	}
	

}