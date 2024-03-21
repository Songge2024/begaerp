package com.bl3.pm.basic.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>bs_proj_teams[bs_proj_teams]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yj
 * @date 2017-12-11 15:19:57
 */
public class ProjTeamsPO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 团队ID
	 */
	private Integer team_id;
	
	/**
	 * 角色CODE
	 */
	private String trp_code;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 成员
	 */
	private Integer team_user_id;
	
	/**
	 * 加入时间
	 */
	private Date join_date;
	
	/**
	 * 成员说明
	 */
	private String jp_desc;
	/**
	 * 任务确认人
	 */
	private String develop_task_user;

	/**
	 * 任务确认人
	 */
	public String getDevelop_task_user() {
		return develop_task_user;
	}
	/**
	 * 任务确认人
	 */
	public void setDevelop_task_user(String develop_task_user) {
		this.develop_task_user = develop_task_user;
	}

	/**
	 * 团队ID
	 * 
	 * @return team_id
	 */
	public Integer getTeam_id() {
		return team_id;
	}
	
	/**
	 * 角色CODE
	 * 
	 * @return trp_code
	 */
	public String getTrp_code() {
		return trp_code;
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
	 * 成员
	 * 
	 * @return team_user_id
	 */
	public Integer getTeam_user_id() {
		return team_user_id;
	}
	
	/**
	 * 加入时间
	 * 
	 * @return join_date
	 */
	public Date getJoin_date() {
		return join_date;
	}
	
	/**
	 * 成员说明
	 * 
	 * @return jp_desc
	 */
	public String getJp_desc() {
		return jp_desc;
	}
	

	/**
	 * 团队ID
	 * 
	 * @param team_id
	 */
	public void setTeam_id(Integer team_id) {
		this.team_id = team_id;
	}
	
	/**
	 * 角色CODE
	 * 
	 * @param trp_code
	 */
	public void setTrp_code(String trp_code) {
		this.trp_code = trp_code;
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
	 * 成员
	 * 
	 * @param team_user_id
	 */
	public void setTeam_user_id(Integer team_user_id) {
		this.team_user_id = team_user_id;
	}
	
	/**
	 * 加入时间
	 * 
	 * @param join_date
	 */
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	
	/**
	 * 成员说明
	 * 
	 * @param jp_desc
	 */
	public void setJp_desc(String jp_desc) {
		this.jp_desc = jp_desc;
	}
	

}