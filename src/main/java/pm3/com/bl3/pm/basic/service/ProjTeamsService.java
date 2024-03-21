package com.bl3.pm.basic.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeBuilder;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;
import aos.system.dao.AosUserRoleDao;
import aos.system.dao.po.AosModulePO;
import aos.system.dao.po.AosUserRolePO;
import aos.system.modules.cache.CacheUserDataService;


import com.bl3.pm.basic.dao.ProjRoleTypesDao;
import com.bl3.pm.basic.dao.ProjTeamsDao;
import com.bl3.pm.basic.dao.po.ProjRoleTypesPO;
import com.bl3.pm.basic.dao.po.ProjTeamsPO;
import com.google.common.collect.Lists;

/**
 * <b>bs_proj_teams[bs_proj_teams]业务逻辑层</b>
 * 
 * @author yj
 * @date 2017-12-13 14:50:54
 */
 @Service
 public class ProjTeamsService{
 	private static Logger logger = LoggerFactory.getLogger(ProjTeamsService.class);
 	@Autowired
	private ProjTeamsDao projTeamsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private AosUserRoleDao aosUserRoleDao;
	@Autowired
	private CacheUserDataService cacheUserDataService;
	@Autowired
	private ProjRoleTypesDao projRoleTypesDao;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("projTeams/projTeams_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		String team_user_ids = inDto.getString("team_user_id");
		team_user_ids = team_user_ids.substring(0, team_user_ids.length()-1);
		for(int i=0;i<team_user_ids.split(",").length;i++){
			ProjTeamsPO projTeamsPO=new ProjTeamsPO();
			projTeamsPO.copyProperties(inDto);
			projTeamsPO.setTeam_user_id(Integer.valueOf(team_user_ids.split(",")[i].trim()));
			projTeamsPO.setJoin_date(AOSUtils.getDateTime());
			projTeamsDao.insert(projTeamsPO);
			
			
			AosUserRolePO aosUserRolePO = new AosUserRolePO();
			aosUserRolePO.setId(idService.nextValue(SystemCons.SEQ.SEQ_SYSTEM).intValue());
			aosUserRolePO.setRole_id(inDto.getInteger("aos_role_id"));
			aosUserRolePO.setUser_id(Integer.valueOf(Integer.valueOf(team_user_ids.split(",")[i].trim())));
			aosUserRolePO.setCreate_by(httpModel.getUserModel().getId());
			aosUserRolePO.setCreate_time(AOSUtils.getDateTime());
//			aosUserRoleDao.insert(aosUserRolePO);
			cacheUserDataService.resetGrantInfoOfUser(Integer.valueOf(team_user_ids.split(",")[i].trim()));
		}
		httpModel.setOutMsg("添加成功");
		/*final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		 httpModel.setOutMsg(token.toString());*/
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		ProjTeamsPO projTeamsPO=new ProjTeamsPO();
		projTeamsPO.copyProperties(inDto);
		projTeamsDao.updateByKey(projTeamsPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			ProjTeamsPO projTeamsPO=new ProjTeamsPO();
			projTeamsPO=projTeamsDao.selectByKey(Integer.valueOf(id));
			
			ProjRoleTypesPO projRoleTypesPO=new ProjRoleTypesPO();
			projRoleTypesPO=projRoleTypesDao.selectByKey(projTeamsPO.getTrp_code());
			
			AosUserRolePO aosUserRolePO = new AosUserRolePO();
			aosUserRolePO.setRole_id(projRoleTypesPO.getAos_role_id());
			aosUserRolePO.setUser_id(projTeamsPO.getTeam_user_id());
			
//			sqlDao.list("aos.system.dao.AosUserRoleDao.deleteByRoleidAndUserid", aosUserRolePO);
			int i=projTeamsDao.deleteByKey(Integer.valueOf(id));
			cacheUserDataService.resetGrantInfoOfUser(projTeamsPO.getTeam_user_id());
		}
		httpModel.setOutMsg("撤销成功");
		/*final String cacheKey =SystemCons.KEYS.CARDLIST+"Token";
		String token= JedisUtil.getString(cacheKey);
		 httpModel.setOutMsg(token.toString());*/
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjTeamsPO projTeamsPO=projTeamsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projTeamsPO));
	}
	/**
	 * 分页查询项目团队信息
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ProjTeamsDao.queryProjTeamDataPage", inDto);
//		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
		int count=projTeamsDao.projTeamCount(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, count));
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void query_aos_user(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ProAosUserDao.query_aos_user", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	
	/**
	 * 公司部门人员树
	 * 
	 * @param httpModel
	 */
	public void queryDepartmentTree(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TreeNode> treeNodes = Lists.newArrayList();
		List<Dto> list = sqlDao.list("ProAosUserDao.queryDepartmentTree", inDto);
		for (Dto dto : list) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId("org_"+dto.getString("id"));
			treeNode.setText(dto.getString("name"));
			treeNode.setParentId("org_"+dto.getString("parent_id").toString());
			treeNode.setIcon(dto.getString("icon_name"));
			//这个决定是否在节点上初选复选框，true为初始选中
			//treeNode.setChecked(false);
			treeNode.setLeaf(false);
			treeNode.setExpanded(true);
			treeNodes.add(treeNode);
		}
		
		List<Dto> AosUserlist = sqlDao.list("ProAosUserDao.queryAosUserTree", inDto);
		for (Dto dto : AosUserlist) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(dto.getString("id"));
			treeNode.setText(dto.getString("name"));
			treeNode.setParentId("org_"+dto.getString("org_id").toString());
			treeNode.setIcon("user8.png");
			//这个决定是否在节点上初选复选框，true为初始选中
			//treeNode.setChecked(false);
			treeNode.setLeaf(false);
			treeNode.setExpanded(true);
			treeNodes.add(treeNode);
		}
		
		String jsonString = TreeBuilder.build(treeNodes);
		httpModel.setOutMsg(jsonString);
	}
 }