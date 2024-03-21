package com.bl3.pm.process.service;

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


import com.bl3.pm.process.dao.CheckDetailDao;
import com.bl3.pm.process.dao.CheckMainDao;
import com.bl3.pm.process.dao.po.CheckDetailPO;
import com.bl3.pm.process.dao.po.CheckMainPO;

/**
 * <b>pr_check_detail[pr_check_detail]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-22 20:32:10
 */
 @Service
 public class CheckDetailService{
 	private static Logger logger = LoggerFactory.getLogger(CheckDetailService.class);
 	@Autowired
	private CheckDetailDao checkDetailDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private CheckMainDao checkMainDao;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("checkDetail/checkDetail_list.jsp");
	}
	
	/**
	 * 复制pr_check_item到pr_check_detail
	 * 并加入扣分标准
	 * @param httpModel
	 * @return
	 */
	public void copy(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int create_user_id = httpModel.getUserModel().getId();
		int check_id = (int) sqlDao.selectOne("com.bl3.pm.process.dao.CheckDetailDao.select_check_id", inDto.getString("check_cata_id"));
		List<CheckDetailPO> pos = sqlDao.list("com.bl3.pm.process.dao.CheckDetailDao.cata_item", inDto.getString("check_cata_id"));
		for(CheckDetailPO po : pos){
			Dto dto = sqlDao.selectDto("com.bl3.pm.process.dao.CheckDetailDao.point", po.getProblem_level());
			po.setDeduct_point(dto.getString("deduct_point"));
			po.setSolve_deduct_point(dto.getString("solve_deduct_point"));
			po.setSolve_times(dto.getString("solve_times"));
			po.setCreate_user_id(create_user_id);
			po.setCreate_time(new Date());
			po.setCheck_id(check_id);
			po.setProj_id(inDto.getInteger("proj_id"));
			po.setState("1");
			checkDetailDao.insert(po);
		}
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		CheckDetailPO checkDetailPO=new CheckDetailPO();
		checkDetailPO.copyProperties(inDto);
		checkDetailDao.insert(checkDetailPO);
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 保存
	 * 
	 * @param httpModel
	 * @return
	 */
	public void checkCountByKey(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			CheckDetailPO po = checkDetailDao.selectByCheckId(Integer.valueOf(id));
			checkDetailDao.checkCountByKey(po);
		}
		httpModel.setOutMsg("保存成功");
	}
	
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateGrid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer update_user_id = httpModel.getUserModel().getId();
		List<Dto> modifies = inDto.getRows();
		if(modifies.isEmpty()){
			httpModel.setOutMsg("请先选择需保存的检查项!");
			return;
		}
		for (Dto dto : modifies) {
			dto.put("update_user_id", update_user_id);
			checkDetailDao.checkUpdateByKey(dto);
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
		CheckDetailPO checkDetailPO=new CheckDetailPO();
		checkDetailPO.copyProperties(inDto);
		checkDetailDao.updateByKey(checkDetailPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 复制
	 */
	public void copyDetail(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int create_user_id = httpModel.getUserModel().getId();
		String[] selectionIds = inDto.getRows();
		CheckMainPO statePo = checkMainDao.selectStateByKey(inDto.getInteger("check_id"));
		if(statePo.getState().equals("0")){
			for (String id : selectionIds) {
				CheckDetailPO checkDetailPO = checkDetailDao.selectAllDetail(Integer.valueOf(id));
				checkDetailPO.setCreate_user_id(create_user_id);
				checkDetailPO.setCreate_time(new Date());
				checkDetailDao.insert(checkDetailPO);
			}
		}else{
			httpModel.setOutMsg("该检查项已提交,不能进行复制。");
			return;
		}
		httpModel.setOutMsg("复制成功");
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
		CheckMainPO statePo = checkMainDao.selectStateByKey(inDto.getInteger("check_id"));
		if(statePo.getState().equals("0")){
			for (String id : selectionIds) {
				checkDetailDao.deleteByKey(Integer.valueOf(id));
			}
		}else{
			httpModel.setOutMsg("该检查项已提交,不得删除");
			return;
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
		CheckDetailPO checkDetailPO=checkDetailDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(checkDetailPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckDetailPO> checkDetailPOs = checkDetailDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkDetailPOs, inDto.getPageTotal()));
	}
 }