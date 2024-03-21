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



import com.bl3.pm.process.dao.RiskListDao;
import com.bl3.pm.process.dao.po.RiskListPO;

/**
 * <b>pr_risk_list[pr_risk_list]业务逻辑层</b>
 * 
 * @author huangtao
 * @date 2018-01-10 08:27:14
 */
 @Service
 public class RiskListService{
 	private static Logger logger = LoggerFactory.getLogger(RiskListService.class);
 	@Autowired
	private RiskListDao riskListDao;
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
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id = "";
		String proj_name="";
		if(getDto.get("proj_id")!=null){
		 proj_id = getDto.get("proj_id").toString();
	     proj_name= getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/process/projRisk/riskList_layout.jsp");
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
		RiskListPO riskListPO=new RiskListPO();
		int count = riskListDao.countRiskId(inDto);
		if(count==0){
		int create_user_id = httpModel.getUserModel().getId();
	//	riskListPO.setRisk_id(idService.nextValue("seq_pr_risk_list").intValue());
		riskListPO.copyProperties(inDto);
		riskListPO.setCreate_user_id(create_user_id);
		riskListPO.setState("1");
		riskListDao.insert(riskListPO);
		httpModel.setOutMsg("新增成功");
		} else {
			httpModel.setOutMsg("保存失败,存在相同的风险信息,请核对!");
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
		//inDto.remove("id");
		int update_user_id = httpModel.getUserModel().getId();
		RiskListPO riskListPO=new RiskListPO();
		riskListPO.copyProperties(inDto);
		riskListPO.setUpdate_user_id(update_user_id);
		riskListDao.updateByKey(riskListPO);
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
		int update_user_id = httpModel.getUserModel().getId();
		for (String id : selectionIds) {
			inDto.put("risk_id", id);
			inDto.put("update_user_id", update_user_id);
			riskListDao.updateState(inDto);
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
		RiskListPO riskListPO=riskListDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(riskListPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<RiskListPO> riskListPOs = riskListDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(riskListPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void riskComment(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<RiskListPO> riskListPOs = riskListDao.riskCataComment(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(riskListPOs));
	}
	
	
	/**
	 * 查询下拉框
	 * @param httpModel
	 */
	public void listComboBoxRiskCata(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.RiskListDao.listComboBoxRiskCata", null);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
 }