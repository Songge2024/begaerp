package com.bl3.pm.basic.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.bl3.pm.basic.dao.ReplyDao;
import com.bl3.pm.basic.dao.ThemeDao;
import com.bl3.pm.basic.dao.po.ReplyPO;
import com.bl3.pm.basic.dao.po.ThemePO;
import com.bl3.pm.task.dao.po.TaskPO;
import com.bl3.pm.task.service.TaskService;

/**
 * <b>bs_theme[bs_theme]业务逻辑层</b>
 * 
 * @author remexs
 * @date 2018-01-24 15:46:52
 */
 @Service
 public class ThemeService{
 	private static Logger logger = LoggerFactory.getLogger(ThemeService.class);
 	@Autowired
	private ThemeDao themeDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
 	@Autowired
	private ReplyDao replyDao;
	
	/**
	 * 
	 * @param insertDto {<br>
	 * 	tags:必填,<br>
	 * 	title:必填,<br>
	 * 	content:必填,<br>
	 * 	theme_type:必填,<br>
	 * 	refrence_id:必填,<br>
	 * 	top:选填<br>
	 *}
	 * @return
	 */
	@Transactional
	public Integer create(Dto insertDto){
		ThemePO themePO=new ThemePO();
		Integer id=idService.nextValue("seq_bs_theme").intValue();
		themePO.copyProperties(insertDto);
		themePO.setCreate_time(AOSUtils.getDateTime());
		themePO.setState("1001");
		themePO.setCreate_user_id(insertDto.getInteger("user_id"));
		themePO.setId(id);
		themeDao.insert(themePO);
		return id;
	}
	/**
	 * 根据ID查询
	 * 
	 * @param theme_id
	 * @return
	 */
	public ThemePO get(Integer theme_id) {
		return themeDao.selectByKey(theme_id);
	}
	
	public void init_ueditor(HttpModel httpModel){
		httpModel.setViewPath("common/ueditor.jsp");
	}
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		Dto inDto=httpModel.getInDto();
		ThemePO themePO=themeDao.selectOne(inDto);
		if(!AOSUtils.isEmpty(themePO)){
			List<Dto> replyPOs=sqlDao.list("Theme.selectReplys", Dtos.newDto("theme_id", themePO.getId()));
			httpModel.setAttribute("has_theme", true);
			httpModel.setAttribute("theme", themePO);
			if(AOSUtils.isEmpty(replyPOs)){
				httpModel.setAttribute("has_reply", false);
			}else{
				httpModel.setAttribute("has_reply", true);
				httpModel.setAttribute("replys", replyPOs);
			}
		}else{
			httpModel.setAttribute("has_theme", false);
		}
		httpModel.setAttribute("juid", httpModel.getUserModel().getJuid());
		httpModel.setViewPath("pm3/theme/theme_view.jsp");
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		ThemePO themePO=themeDao.selectOne(inDto);
		if(AOSUtils.isEmpty(themePO)){
			inDto.put("user_id", user_id);
			this.create(inDto);
			httpModel.setOutMsg("新增成功");
		}else{
			themePO.copyProperties(inDto);
			themePO.setState("1001");
			themePO.setUpdate_time(AOSUtils.getDateTime());
			themePO.setUpdate_user_id(user_id);
			themeDao.updateByKey(themePO);
			httpModel.setOutMsg("修改成功");
		}
	}
	
	/**
	 * 新增回复
	 * 
	 * @param httpModel
	 * @return
	 */
	public void createReply(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		Integer theme_id=inDto.getInteger("theme_id");
		ReplyPO replyPO=new ReplyPO();
		replyPO.setId(idService.nextValue("seq_bs_reply").intValue());
		replyPO.setCreate_user_id(user_id);
		replyPO.setCreate_time(AOSUtils.getDateTime());
		replyPO.copyProperties(inDto);
		replyDao.insert(replyPO);
		ThemePO themePO=themeDao.selectByKey(theme_id);
		themePO.setLast_reply_time(AOSUtils.getDateTime());
		themePO.setLast_reply_user_id(user_id);
		themePO.setReply_num(themePO.getReply_num()+1);
		themeDao.updateByKey(themePO);
		httpModel.setOutMsg("新增成功");
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
		ThemePO themePO=new ThemePO();
		themePO.copyProperties(inDto);
		themeDao.updateByKey(themePO);
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
			themeDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ThemePO themePO=themeDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(themePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ThemePO> themePOs = themeDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(themePOs, inDto.getPageTotal()));
	}
 }