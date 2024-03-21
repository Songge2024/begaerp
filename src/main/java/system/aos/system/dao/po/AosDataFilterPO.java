package aos.system.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>aos_data_filter[aos_data_filter]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author Remexs
 * @date 2017-11-25 17:21:38
 */
public class AosDataFilterPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 路径编码
	 */
	private Integer id;
	
	/**
	 * 模块编码
	 */
	private String sqlid;
	
	/**
	 * 过滤路径
	 */
	private String path;
	
	/**
	 * 过滤路径名称
	 */
	private String name;
	
	/**
	 * 提示
	 */
	private String remark;
	

	/**
	 * 路径编码
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @return sqlid
	 */
	public String getSqlid() {
		return sqlid;
	}
	
	/**
	 * 过滤路径
	 * 
	 * @return path
	 */
	public String getPath() {
		return path;
	}
	
	/**
	 * 过滤路径名称
	 * 
	 * @return name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * 提示
	 * 
	 * @return remark
	 */
	public String getRemark() {
		return remark;
	}
	

	/**
	 * 路径编码
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 模块编码
	 * 
	 * @param sqlid
	 */
	public void setSqlid(String sqlid) {
		this.sqlid = sqlid;
	}
	
	/**
	 * 过滤路径
	 * 
	 * @param path
	 */
	public void setPath(String path) {
		this.path = path;
	}
	
	/**
	 * 过滤路径名称
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 提示
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	

}