package com.bl3.pm.basic.service;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.basic.dao.ProjWeekDao;
import com.bl3.pm.basic.dao.po.ModuleDividePO;
import com.bl3.pm.basic.dao.po.ProjWeekPO;

/**
 * <b>bs_proj_week[bs_proj_week]业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-01-19 17:02:26
 */
 @Service
 public class ProjWeekService{
 	private static Logger logger = LoggerFactory.getLogger(ProjWeekService.class);
 	@Autowired
	private ProjWeekDao projWeekDao;
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
		httpModel.setViewPath("pm3/basic/projWeek/codes/projWeek_layout.jsp");
	}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//获得新增的开始时间
		List<Dto>beginList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryBegintime", inDto);
		Dto bdto=beginList.get(0);
		String begindate=bdto.getString("begin_time");
		inDto.put("begin_time", begindate);
		List<Dto>wList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeektime", inDto);
		Dto wbdto=wList.get(0);
		List<Dto>sList=sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryWeekSaturday", inDto);
		Dto sdto=sList.get(0);
		if(wbdto.getInteger("w_day")>1&&wbdto.getInteger("w_day")<7){
			inDto.put("begin_date", inDto.getString("begin_time"));
			inDto.put("end_date", sdto.getString("saturday"));
		}else if(wbdto.getInteger("w_day")==1){
			inDto.put("begin_date", inDto.getString("begin_time"));
			inDto.put("end_date", sdto.getString("saturday"));
		}else{
			inDto.put("begin_date", inDto.getString("begin_time"));
			inDto.put("end_date", inDto.getString("begin_time"));
		}
		ProjWeekPO projWeekPO=new ProjWeekPO();
		projWeekPO.copyProperties(inDto);
		projWeekPO.setWeek_id(idService.nextValue("seq_bs_proj_week").intValue());
		projWeekPO.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time=AOSUtils.getDateTime();
		projWeekPO.setCreate_time(create_time);
		projWeekPO.setState("0");
		projWeekDao.insert(projWeekPO);
		httpModel.setOutMsg("保存成功");
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
		ProjWeekPO projWeekPO=new ProjWeekPO();
		projWeekPO.copyProperties(inDto);
		projWeekPO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time=AOSUtils.getDateTime();
		projWeekPO.setUpdate_time(update_time);
		projWeekDao.updateByKey(projWeekPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 启用和停用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] codes = inDto.getString("aos_rows").split(",");
		for(int a=0; a<codes.length;a++){
			if(!codes[a].isEmpty()){
				inDto.put("week_id", codes[a]);	
			sqlDao.update("com.bl3.pm.basic.dao.ProjWeekDao.updateState", inDto);
		}
		}
		httpModel.setOutMsg("启用成功");
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
		ProjWeekPO projWeekPo = new ProjWeekPO();
		projWeekPo.copyProperties(inDto);
		for (String id : selectionIds) {
			sqlDao.update("com.bl3.pm.basic.dao.ProjWeekDao.updateDelState", id);
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
		ProjWeekPO projWeekPO=projWeekDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projWeekPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> projWeekDto= sqlDao.list("com.bl3.pm.basic.dao.ProjWeekDao.queryProjWeekPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projWeekDto, inDto.getPageTotal()));
	}
 }