package com.bl3.pm.contacts.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.contacts.dao.TopContactsDao;
import com.bl3.pm.contacts.dao.po.TopContactsPO;

/**
 * <b>qa_top_contacts[qa_top_contacts]业务逻辑层</b>
 * 
 * @author zhaojiaqi
 * @date 2020-03-30 15:54:55
 */
 @Service
 public class TopContactsService{
 	private static Logger logger = LoggerFactory.getLogger(TopContactsService.class);
 	@Autowired
	private TopContactsDao topContactsDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/contacts/topContacts_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer create_id = httpModel.getUserModel().getId();
		String top_name = inDto.getString("top_name");
		String top_name_=top_name.replace("[","");
		String _top_name_=top_name_.replace("]","");
		String[] str=_top_name_.split(",");
		for (int i=0 ; i<str.length;i++) {
			String name = str[i];
			inDto.put("name", name);
			inDto.put("create_id", create_id);
			int countUser = (int) sqlDao.selectOne("com.bl3.pm.contacts.dao.TopContactsDao.countUser", inDto);
			if (countUser == 0){
				List<Dto> list = sqlDao.list("com.bl3.pm.contacts.dao.TopContactsDao.listUserID", name);
				for(Dto dto : list){
					TopContactsPO topContactsPO=new TopContactsPO();
					topContactsPO.copyProperties(dto);
					topContactsPO.setUser_id(dto.getInteger("id"));
					topContactsPO.setTop_sex(dto.getString("sex"));
					topContactsPO.setCreate_id(create_id);
					topContactsPO.setCreate_time(new Date());
					topContactsPO.setTop_name(name);
					topContactsPO.setTop_org_name_id(dto.getString("org_id"));
					topContactsPO.setTop_org_name(dto.getString("org_name"));
					topContactsPO.setTop_role_name(dto.getString("name"));
					topContactsDao.insert(topContactsPO);
					httpModel.setOutMsg("新增成功");
				}
			}else{
				
			}
		}
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TopContactsPO topContactsPO=new TopContactsPO();
		topContactsPO.copyProperties(inDto);
		topContactsDao.updateByKey(topContactsPO);
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
			topContactsDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 常用联系人部门下拉框
	 */
	public void listPrincipalOrg(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.contacts.dao.TopContactsDao.listPrincipalOrg", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void topUserPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.contacts.dao.TopContactsDao.topUserPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void topUsersPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.contacts.dao.TopContactsDao.topUsersPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TopContactsPO topContactsPO=topContactsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(topContactsPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TopContactsPO> topContactsPOs = topContactsDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(topContactsPOs, inDto.getPageTotal()));
	}
 }