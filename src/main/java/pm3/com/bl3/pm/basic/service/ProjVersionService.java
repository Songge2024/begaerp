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

import com.bl3.pm.basic.dao.ProjCodeVersionDao;
import com.bl3.pm.basic.dao.ProjVersionDao;
import com.bl3.pm.basic.dao.po.ProjVersionPO;

/**
 * <b>bs_proj_version[bs_proj_version]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-03-08 11:26:18
 */
 @Service
 public class ProjVersionService{
 	private static Logger logger = LoggerFactory.getLogger(ProjVersionService.class);
 	@Autowired
	private ProjVersionDao projVersionDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ProjCodeVersionDao projCodeVersionDao;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id  = "";
		String proj_name = "";
		if(getDto.get("proj_id")!=null){
		    proj_id = getDto.get("proj_id").toString();
		    proj_name = getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/basic/projDeploy/projVersion_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int result = projVersionDao.versionNumberCount(inDto.getString("version_number"),inDto.getInteger("proj_id"));
		if(result == 1){
			httpModel.setOutMsg("版本号已存在！");
			return;
		}
		ProjVersionPO projVersionPO = new ProjVersionPO();
		Integer create_id = httpModel.getUserModel().getId();
		projVersionPO.copyProperties(inDto);
		//projVersionPO.setProj_id(idService.nextValue("seq_bs_proj_version").intValue());
		projVersionPO.setCreate_id(create_id);
		projVersionPO.setCreate_time(new Date());
		projVersionPO.setState("0");
		projVersionDao.insert(projVersionPO);
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
		int result = projVersionDao.versionNumberCount1(inDto.getString("version_number"),inDto.getInteger("proj_id"),inDto.getInteger("version_id"));
		if(result == 0){
			ProjVersionPO projVersionPO=new ProjVersionPO();
			Integer update_id = httpModel.getUserModel().getId();
			projVersionPO.copyProperties(inDto);
			projVersionPO.setUpdate_id(update_id);
			projVersionPO.setUpdate_time(new Date());
			projVersionDao.updateByKey(projVersionPO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("无法修改，版本号已存在！");
			return;
		}
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
		String state = inDto.getString("state");
		List<ProjVersionPO> versionIds = projVersionDao.selectByVersinId(Integer.valueOf(inDto.getInteger("version_id")));
		if(state.equals("-1")){
			for (String id : selectionIds) {
				if(AOSUtils.isNotEmpty(versionIds)){
					httpModel.setOutMsg("当前版本号已存在其它项目下，无法删除！");
					return;
				}else{
					projVersionDao.deleteVersionByKey(Integer.valueOf(id));
					projVersionDao.deleteCodeVersionByKey(Integer.valueOf(id));
					projVersionDao.deleteTestVersionByKey(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("删除成功");
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				if(projVersionDao.selectStateByVersionKey(Integer.valueOf(id)).equals("0")){
					return;
				}else{
					if(AOSUtils.isNotEmpty(versionIds)){
						httpModel.setOutMsg("当前版本号已存在其它项目下，无法停用！");
						return;
					}else{
						projVersionDao.updateVersionStateStopByKey(Integer.valueOf(id));
						projVersionDao.updateCodeVersionStateStopByKey(Integer.valueOf(id));
						projVersionDao.updateTestVersionStateStopByKey(Integer.valueOf(id));
					}
				}
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for (String id : selectionIds) {
				if(projVersionDao.selectStateByVersionKey(Integer.valueOf(id)).equals("1")){
					return;
				}else{
					projVersionDao.updateVersionStateRunByKey(Integer.valueOf(id));
					projVersionDao.updateCodeVersionStateRunByKey(Integer.valueOf(id));
					projVersionDao.updateTestVersionStateRunByKey(Integer.valueOf(id));
				}
			}
			httpModel.setOutMsg("启用成功");
		}
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProjVersionPO projVersionPO=projVersionDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(projVersionPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProjVersionPO> projVersionPOs = projVersionDao.likePage(inDto); //projVersionDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projVersionPOs, inDto.getPageTotal()));
	}
	
 }