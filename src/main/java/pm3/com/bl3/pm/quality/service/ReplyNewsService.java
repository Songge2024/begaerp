package com.bl3.pm.quality.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;




import com.bl3.pm.quality.dao.ReplyNewsDao;
import com.bl3.pm.quality.dao.po.ReplyNewsPO;

/**
 * <b>qa_reply_news[qa_reply_news]业务逻辑层</b>
 * 
 * @author Z
 * @date 2017-12-14 11:27:19
 */
 @Service
 public class ReplyNewsService{
 	private static Logger logger = LoggerFactory.getLogger(ReplyNewsService.class);
 	@Autowired
	private ReplyNewsDao replyNewsDao;
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
		httpModel.setViewPath("replyNews/replyNews_list.jsp");
	}
	
	/**
	 * 删除收藏
	 * 
	 * @param httpModel
	 * @return
	 */
	public void removeCollect(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String module_id=inDto.getString("module_id");
		int user_id=httpModel.getUserModel().getId();
		Dto outDto = Dtos.newDto();
		outDto.put("user_id", user_id);
		outDto.put("mode_id", module_id);
		sqlDao.delete("WeeklyStorage.removeCollect", outDto);
		httpModel.setOutMsg("已删除!");
	}
	/**
	 * 添加收藏
	 * 
	 * @param httpModel
	 * @return
	 */
	public void addCollect(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int module_id=inDto.getInteger("module_id");
		int user_id=httpModel.getUserModel().getId();
		int root_id=inDto.getInteger("root_id");
		Dto outDto = Dtos.newDto();
		outDto.put("user_id", user_id);
		outDto.put("mode_id", module_id);
		outDto.put("root_id", root_id);
		outDto.put("create_time", AOSUtils.getDateTime());
		//判断重复收藏
		int con=(int) sqlDao.selectOne("WeeklyStorage.diffAddCollect", outDto);
		if(con>0){
			httpModel.setOutMsg("请勿重复收藏!");
			return;
		}
		sqlDao.insert("WeeklyStorage.addCollect", outDto);
		httpModel.setOutMsg("已添加!");
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
		ReplyNewsPO replyNewsPO=new ReplyNewsPO();
		replyNewsPO.setId(idService.nextValue("seq_qa_reply_news").intValue());
		replyNewsPO.copyProperties(inDto);
		replyNewsDao.insert(replyNewsPO);
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
		ReplyNewsPO replyNewsPO=new ReplyNewsPO();
		replyNewsPO.copyProperties(inDto);
		replyNewsDao.updateByKey(replyNewsPO);
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
			replyNewsDao.deleteByKey(Integer.valueOf(id));
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
		ReplyNewsPO replyNewsPO=replyNewsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(replyNewsPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ReplyNewsPO> replyNewsPOs = replyNewsDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(replyNewsPOs, inDto.getPageTotal()));
	}
 }