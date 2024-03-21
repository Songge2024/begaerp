package com.bl3.pm.contract.service;

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


import com.bl3.pm.contract.dao.ContractPaymentDetailDao;
import com.bl3.pm.contract.dao.po.ContractPaymentDetailPO;

/**
 * <b>bs_contract_payment_detail[bs_contract_payment_detail]业务逻辑层</b>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
 @Service
 public class ContractPaymentDetailService{
 	private static Logger logger = LoggerFactory.getLogger(ContractPaymentDetailService.class);
 	@Autowired
	private ContractPaymentDetailDao contractPaymentDetailDao;
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
		httpModel.setViewPath("contractPaymentDetail/contractPaymentDetail_list.jsp");
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
		ContractPaymentDetailPO contractPaymentDetailPO=new ContractPaymentDetailPO();
		contractPaymentDetailPO.setCt_detail_id(idService.nextValue("seq_bs_contract_payment_detail").intValue());
		contractPaymentDetailPO.copyProperties(inDto);
		contractPaymentDetailDao.insert(contractPaymentDetailPO);
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
		ContractPaymentDetailPO contractPaymentDetailPO=new ContractPaymentDetailPO();
		contractPaymentDetailPO.copyProperties(inDto);
		contractPaymentDetailDao.updateByKey(contractPaymentDetailPO);
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
			contractPaymentDetailDao.deleteByKey(Integer.valueOf(id));
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
		ContractPaymentDetailPO contractPaymentDetailPO=contractPaymentDetailDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(contractPaymentDetailPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ContractPaymentDetailPO> contractPaymentDetailPOs = contractPaymentDetailDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(contractPaymentDetailPOs, inDto.getPageTotal()));
	}
 }