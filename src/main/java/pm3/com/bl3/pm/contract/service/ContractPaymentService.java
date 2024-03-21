package com.bl3.pm.contract.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.contract.dao.ContractPaymentDao;
import com.bl3.pm.contract.dao.ContractPaymentDetailDao;
import com.bl3.pm.contract.dao.po.ContractPaymentPO;
import com.bl3.pm.contract.dao.po.ContractStagePO;
import com.bl3.pm.contract.dao.ContractStageDao;

/**
 * <b>bs_contract_payment[bs_contract_payment]业务逻辑层</b>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
 @Service
 public class ContractPaymentService{
 	private static Logger logger = LoggerFactory.getLogger(ContractPaymentService.class);
 	@Autowired
	private ContractPaymentDao contractPaymentDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ContractStageDao contractStageDao;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/contract/contractPayments/contractPayments_layout.jsp");
	}
	/**
	 * 查询新增余下应支付款项
	 * @param httpModel
	 */
	public void queryOtherMoney(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto>syjeDto=sqlDao.list("com.bl3.pm.contract.dao.ContractPaymentDao.queryOtherMoney", inDto);
		Dto outDto=Dtos.newDto();
		outDto.put("syje", syjeDto.get(0).get("syje"));
		if(syjeDto.get(0).getBigDecimal("syje").doubleValue()==0){
			httpModel.setOutMsg("当前实收金额已达到合同总金额");
			return;
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto payInDto = httpModel.getInDto();
		//inDto.remove("id");
		ContractPaymentPO contractPaymentPO=new ContractPaymentPO();
		int create_user_id = httpModel.getUserModel().getId();
		int ct_stage_id = inDto.getInteger("ct_stage_id");
		contractPaymentPO.copyProperties(inDto);
		contractPaymentPO.setCt_pay_id(idService.nextValue("seq_bs_contract_payment").intValue());
		contractPaymentPO.setCreate_user_id(create_user_id);
		contractPaymentPO.setState("1");
		String pay_remark = contractPaymentPO.getPay_remark();
		int ct_id = contractPaymentPO.getCt_id();
		payInDto.put("ct_id", ct_id);
		//选择阶段新增情况
		if(ct_stage_id != -1){
			double pay_money = contractPaymentPO.getPay_money().doubleValue();
			
			int pay_id = contractPaymentPO.getCt_pay_id();
			List<ContractStagePO> list = contractPaymentDao.queryContStageList(inDto);
			if(list.size()!=0){
			contractPaymentDao.insert(contractPaymentPO);
			for(ContractStagePO csPo : list){
				Double charge_amount = 0.00;//剩余金额
				int stage_id = csPo.getCt_stage_id();
				Double rece_amount = csPo.getRece_amount().doubleValue(); //应收
				Double pay_amount = contractPaymentPO.getPay_money().doubleValue();//实收
				//计算剩余
				//当实付款金额 < 应收金额时
				if(pay_amount <= rece_amount){
				//	charge_amount = rece_amount - pay_amount;//剩余
					Dto dto = httpModel.getInDto();
					dto.put("ct_id", ct_id);
					dto.put("ct_pay_id", pay_id);
					dto.put("ct_stage_id", stage_id);
					dto.put("pay_amount", pay_amount);
					dto.put("pay_remark", pay_remark);
					dto.put("create_user_id", create_user_id);
					//pay_money = pay_money - charge_amount;
					contractPaymentDao.updateContStagePaymoney(dto);
					contractPaymentDao.insertIntoDetail(dto);
					//if(pay_money == 0) break;
				}else{
					httpModel.setOutMsg("实收金额不能大于所选阶段应收金额,请重新输入!");
					return;
				}
			}
			}else{
				httpModel.setOutMsg("当前实收金额已等于应收金额,不能进行回款操作!");
				return;
			}
		}else{ //不选择阶段
			double pay_money = contractPaymentPO.getPay_money().doubleValue();
			//int ct_id = contractPaymentPO.getCt_id();
			int pay_id = contractPaymentPO.getCt_pay_id();
			List<ContractStagePO> list = contractPaymentDao.queryContStageList(inDto);
			if(list.size()!=0){
			contractPaymentDao.insert(contractPaymentPO);
			Double pay_amount = contractPaymentPO.getPay_money().doubleValue();//实收
			Double charge_amount = 0.00;//剩余金额
			Double total_amount = pay_amount;
			for(ContractStagePO csPo : list){
				int stage_id = csPo.getCt_stage_id();
				Double rece_amount = csPo.getRece_amount().doubleValue() -csPo.getPay_amount().doubleValue(); //应收
				//当实付款金额 < 应收金额时
				if(pay_amount <= rece_amount){
				//	charge_amount = rece_amount - pay_amount;//剩余
					Dto dto = httpModel.getInDto();
					dto.put("ct_id", ct_id);
					dto.put("ct_pay_id", pay_id);
					dto.put("ct_stage_id", stage_id);
					dto.put("pay_amount", pay_amount);
					dto.put("pay_remark", pay_remark);
					dto.put("create_user_id", create_user_id);
					//pay_money = pay_money - charge_amount;
					contractPaymentDao.updateContStagePaymoney(dto);
					contractPaymentDao.insertIntoDetail(dto);
					pay_amount = total_amount - rece_amount;
					total_amount = total_amount - rece_amount;
					if(pay_amount <= 0) break;
				}else{
					//charge_amount = rece_amount - pay_amount;//剩余
					Dto dto = httpModel.getInDto();
					dto.put("ct_id", ct_id);
					dto.put("ct_pay_id", pay_id);
					dto.put("ct_stage_id", stage_id);
					dto.put("pay_amount", rece_amount);
					dto.put("pay_remark", pay_remark);
					dto.put("create_user_id", create_user_id);
					//pay_money = pay_money - charge_amount;
					contractPaymentDao.updateContStagePaymoney(dto);
					contractPaymentDao.insertIntoDetail(dto);
					pay_amount = total_amount - rece_amount;
					total_amount = total_amount - rece_amount;
					if(pay_amount <= 0) break;
					
				}
			}
			}else{
				httpModel.setOutMsg("当前实收金额已等于应收金额,不能进行回款操作!");
				return;
			}
		}
		httpModel.setOutMsg("新增成功");
			/*int countPaymount = contractPaymentDao.countPayamout(payInDto);
			//实付金额=应收金额
				if(countPaymount==1){
					payInDto.put("state", 3);
					contractPaymentDao.updateStage(payInDto);
				}else{
					payInDto.put("state", 2);
					contractPaymentDao.updateStage(payInDto);
				}*/
				Dto outDto=Dtos.newDto();
				List<Dto>syjeDto=sqlDao.list("com.bl3.pm.contract.dao.ContractPaymentDao.queryEditMoney", inDto);
				outDto.put("ssje", syjeDto.get(0).getBigDecimal("hjje"));
				outDto.put("htje", syjeDto.get(0).getBigDecimal("zjje"));
				//httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
				
		Dto payInDto = httpModel.getInDto();
		//inDto.remove("id");
		int update_user_id = httpModel.getUserModel().getId();
		int create_user_id = httpModel.getUserModel().getId();
		ContractPaymentPO contractPaymentPO=new ContractPaymentPO();
		contractPaymentPO.copyProperties(inDto);
		inDto.put("ct_pay_id",contractPaymentPO.getCt_pay_id());
		inDto.put("update_user_id", update_user_id);
		inDto.put("ct_stage_id", -1);
		contractPaymentPO.setUpdate_user_id(update_user_id);
		List<Dto>syjeDto=sqlDao.list("com.bl3.pm.contract.dao.ContractPaymentDao.queryEditMoney", inDto);
		if(syjeDto.get(0).getBigDecimal("hjje").doubleValue()>(syjeDto.get(0).getBigDecimal("zjje").doubleValue())){
			httpModel.setOutMsg("总的实收金额不能大于合同总金额");
			return;
		}
		if(inDto.get("update_state").equals("1")){
		contractPaymentDao.updateByKey(contractPaymentPO);
		contractPaymentDao.updateStageByKey(inDto);
		contractPaymentDao.deleteDetail(inDto);
		//contractPaymentDao.deleteDetailByKey(inDto);
		//contractPaymentDao.deleteByKey(inDto);
	
		String pay_remark = contractPaymentPO.getPay_remark();
		double pay_money = contractPaymentPO.getPay_money().doubleValue();
		int ct_id = contractPaymentPO.getCt_id();
		payInDto.put("ct_id", ct_id);
		payInDto.put("update_user_id", update_user_id);
		int pay_id = contractPaymentPO.getCt_pay_id();
		List<ContractStagePO> list = contractPaymentDao.queryContStageList(inDto);
		if(list.size()!=0){
		Double pay_amount = contractPaymentPO.getPay_money().doubleValue();//实收
		Double charge_amount = 0.00;//剩余金额
		Double total_amount = pay_amount;
		for(ContractStagePO csPo : list){
			int stage_id = csPo.getCt_stage_id();
			Double rece_amount = csPo.getRece_amount().doubleValue() -csPo.getPay_amount().doubleValue(); //应收
			//当实付款金额 < 应收金额时
			if(pay_amount <= rece_amount){
			//	charge_amount = rece_amount - pay_amount;//剩余
				Dto dto = httpModel.getInDto();
				dto.put("ct_id", ct_id);
				dto.put("ct_pay_id", pay_id);
				dto.put("ct_stage_id", stage_id);
				dto.put("pay_amount", pay_amount);
				dto.put("pay_remark", pay_remark);
				dto.put("create_user_id", create_user_id);
				//pay_money = pay_money - charge_amount;
				contractPaymentDao.updateContStagePaymoney(dto);
				contractPaymentDao.insertIntoDetail(dto);
				pay_amount = total_amount - rece_amount;
				total_amount = total_amount - rece_amount;
				if(pay_amount <= 0) break;
			}else{
				//charge_amount = rece_amount - pay_amount;//剩余
				Dto dto = httpModel.getInDto();
				dto.put("ct_id", ct_id);
				dto.put("ct_pay_id", pay_id);
				dto.put("ct_stage_id", stage_id);
				dto.put("pay_amount", rece_amount);
				dto.put("pay_remark", pay_remark);
				dto.put("create_user_id", create_user_id);
				//pay_money = pay_money - charge_amount;
				contractPaymentDao.updateContStagePaymoney(dto);
				contractPaymentDao.insertIntoDetail(dto);
				pay_amount = total_amount - rece_amount;
				total_amount = total_amount - rece_amount;
				if(pay_amount <= 0) break;
				
			}
		}
		}else{
			httpModel.setOutMsg("当前实收金额已等于应收金额,不能进行回款操作!");
			return;
		}
		httpModel.setOutMsg("修改成功");
		/*int countPaymount = contractPaymentDao.countPayamout(payInDto);
		//实付金额=应收金额
		if(countPaymount==1){
			payInDto.put("state", 3);
			contractPaymentDao.updateStage(payInDto);
		}else{
			payInDto.put("state", 2);
			contractPaymentDao.updateStage(payInDto);
		}*/
		}else{
			contractPaymentDao.updateByKey(contractPaymentPO);
			httpModel.setOutMsg("修改成功");
		}
		outDto.put("ssje", syjeDto.get(0).getBigDecimal("hjje"));
		outDto.put("htje", syjeDto.get(0).getBigDecimal("zjje"));
		//httpModel.setOutMsg(AOSJson.toJson(outDto));
		
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
			inDto.put("ct_pay_id", Integer.valueOf(id));
			inDto.put("update_user_id", update_user_id);
			contractPaymentDao.updateStageByKey(inDto);
			contractPaymentDao.deleteDetailByKey(inDto);
			contractPaymentDao.deleteByKey(inDto);
			inDto.put("state", 2);
			contractPaymentDao.updateStage(inDto);
			
		}
		Dto outDto=Dtos.newDto();
		List<Dto>syjeDto=sqlDao.list("com.bl3.pm.contract.dao.ContractPaymentDao.queryEditMoney", inDto);
		outDto.put("ssje", syjeDto.get(0).getBigDecimal("hjje"));
		outDto.put("htje", syjeDto.get(0).getBigDecimal("zjje"));
		//outDto.setAppMsg("作废成功");
		httpModel.setOutMsg("作废成功");
		

	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ContractPaymentPO contractPaymentPO=contractPaymentDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(contractPaymentPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ContractPaymentPO> contractPaymentPOs = contractPaymentDao.listPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(contractPaymentPOs, inDto.getPageTotal()));
	}
	
	
	/**
	 * 表单数据加载
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loadFormInfo(HttpModel httpModel) {
		Dto dto =sqlDao.selectDto("com.bl3.pm.contract.dao.ContractPaymentDao.listProjInfo", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(dto));
	}
	
	
	
	/**
	 * 查询下拉框
	 * @param httpModel
	 */
	public void listComboBoxContractCata(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.contract.dao.ContractPaymentDao.listComboBoxContractData", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
 }