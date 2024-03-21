package aos.system.dao.po;

import aos.framework.core.typewrap.PO;

/**
 * <b>aos_role_data_filter[aos_role_data_filter]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author Remexs
 * @date 2017-11-28 19:37:58
 */
public class AosRoleDataFilterPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 规则编码
	 */
	private Integer id;
	
	/**
	 * 角色编码
	 */
	private Integer role_id;
	
	/**
	 * 路径编码
	 */
	private Integer data_filter_id;
	
	/**
	 * 过滤规则
	 */
	private String filter;
	

	/**
	 * 规则编码
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	
	/**
	 * 角色编码
	 * 
	 * @return role_id
	 */
	public Integer getRole_id() {
		return role_id;
	}
	
	/**
	 * 路径编码
	 * 
	 * @return data_filter_id
	 */
	public Integer getData_filter_id() {
		return data_filter_id;
	}
	
	/**
	 * 过滤规则
	 * 
	 * @return filter
	 */
	public String getFilter() {
		return filter;
	}
	

	/**
	 * 规则编码
	 * 
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**
	 * 角色编码
	 * 
	 * @param role_id
	 */
	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}
	
	/**
	 * 路径编码
	 * 
	 * @param data_filter_id
	 */
	public void setData_filter_id(Integer data_filter_id) {
		this.data_filter_id = data_filter_id;
	}
	
	/**
	 * 过滤规则
	 * 
	 * @param filter
	 */
	public void setFilter(String filter) {
		this.filter = filter;
	}
	

}