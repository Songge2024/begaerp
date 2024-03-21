package com.bl3.pm.contract.service;

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


import com.bl3.pm.contract.dao.ContractStageDao;
import com.bl3.pm.contract.dao.po.ContractStagePO;

/**
 * <b>bs_contract_stage[bs_contract_stage]业务逻辑层</b>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
 @Service
 public class ContractStageService{
 	private static Logger logger = LoggerFactory.getLogger(ContractStageService.class);
 	@Autowired
	private ContractStageDao contractStageDao;
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
		httpModel.setViewPath("contractStage/contractStage_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("create_user_id", httpModel.getUserModel().getId());
		inDto.put("create_time", AOSUtils.getDateTimeStr());
		inDto.put("state", "1");
		ContractStagePO contractStagePO=new ContractStagePO();
		contractStagePO.copyProperties(inDto);
		contractStageDao.insert(contractStagePO);
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
		inDto.put("update_user_id", httpModel.getUserModel().getId());
		inDto.put("update_time", AOSUtils.getDateTimeStr());
		ContractStagePO contractStagePO=new ContractStagePO();
		contractStagePO.copyProperties(inDto);
		contractStageDao.updateByKey(contractStagePO);
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
		for (String ct_stage_id : selectionIds) {
			contractStageDao.deleteByKey(Integer.valueOf(ct_stage_id));
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
		ContractStagePO contractStagePO=contractStageDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(contractStagePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> contractStagePOs = sqlDao.list("ContractStageDao.listPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(contractStagePOs, inDto.getPageTotal()));
	}
 }