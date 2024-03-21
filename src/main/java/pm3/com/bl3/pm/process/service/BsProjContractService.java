package com.bl3.pm.process.service;

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


import com.bl3.pm.process.dao.BsProjContractDao;
import com.bl3.pm.process.dao.po.BsProjContractPO;

/**
 * <b>bs_proj_contract[bs_proj_contract]业务逻辑层</b>
 * 
 * @author gaoyong
 * @date 2017-12-21 16:29:14
 */
 @Service
 public class BsProjContractService{
 	private static Logger logger = LoggerFactory.getLogger(BsProjContractService.class);
 	@Autowired
	private BsProjContractDao bsProjContractDao;
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
		httpModel.setViewPath("/pm3/bsProjContract/bsProjContract_list.jsp");
	}
	/**
	 * 查询项目名称下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxCascadeData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.BsProjContractDao.listComboBoxCascadeData", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 通过下拉框项目ID获取合同明细
	 * 
	 * @param httpModel
	 */
	public void contract(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
			List<BsProjContractPO> bsProjContractPOs = bsProjContractDao.likeOrPage(inDto);
			httpModel.setOutMsg(AOSJson.toGridJson(bsProjContractPOs, inDto.getPageTotal()));
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
		BsProjContractPO bsProjContractPO=new BsProjContractPO();
		//bsProjContractPO.setId(idService.nextValue("seq_bs_proj_contract").intValue());
		bsProjContractPO.copyProperties(inDto);
		bsProjContractDao.insert(bsProjContractPO);
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
		BsProjContractPO bsProjContractPO=new BsProjContractPO();
		bsProjContractPO.copyProperties(inDto);
		bsProjContractDao.updateByKey(bsProjContractPO);
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
			bsProjContractDao.deleteByKey(Integer.valueOf(id));
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
		BsProjContractPO bsProjContractPO=bsProjContractDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(bsProjContractPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<BsProjContractPO> bsProjContractPOs = bsProjContractDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(bsProjContractPOs, inDto.getPageTotal()));
	}
 }