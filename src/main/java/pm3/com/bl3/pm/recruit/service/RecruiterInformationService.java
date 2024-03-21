package com.bl3.pm.recruit.service;

import java.text.SimpleDateFormat;
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
import aos.system.common.model.UserModel;

import com.bl3.pm.recruit.dao.RecruiterInformationDao;
import com.bl3.pm.recruit.dao.po.RecruiterInformationPO;

/**
 * <b>bs_recruiter_information[bs_recruiter_information]业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-04-18 11:34:16
 */
 @Service
 public class RecruiterInformationService{
 	private static Logger logger = LoggerFactory.getLogger(RecruiterInformationService.class);
 	@Autowired
	private RecruiterInformationDao recruiterInformationDao;
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
		httpModel.setViewPath("pm3/recruit/recruiterInformation/recruiterInformation_layout.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		RecruiterInformationPO recruiterInformationPO=new RecruiterInformationPO();
		recruiterInformationPO.setRegister_Id(idService.nextValue("seq_bs_recruiter_information").intValue());
		Date reDate=new Date();
		SimpleDateFormat datef=new SimpleDateFormat("yyyy-MM-dd");
		inDto.put("register_date", datef.format(reDate));
		recruiterInformationPO.setRegister_user_id(httpModel.getUserModel().getId());
		recruiterInformationPO.copyProperties(inDto);
		recruiterInformationDao.insert(recruiterInformationPO);
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
//		RecruiterInformationPO recruiterInformationPO=new RecruiterInformationPO();
//		recruiterInformationPO.copyProperties(inDto);
		//recruiterInformationDao.updateByKey(recruiterInformationPO);
		sqlDao.update("com.bl3.pm.recruit.dao.RecruiterInformationDao.updateRecruiter", inDto);
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
			recruiterInformationDao.deleteByKey(Integer.valueOf(id));
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
		RecruiterInformationPO recruiterInformationPO=recruiterInformationDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(recruiterInformationPO));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
	//	List<RecruiterInformationPO> recruiterInformationPOs = recruiterInformationDao.likeOrPage(inDto);
		List <RecruiterInformationPO>reList=sqlDao.list("com.bl3.pm.recruit.dao.RecruiterInformationDao.queryRecruiterInformation", inDto);
		httpModel.setOutMsg(AOSJson.toJson(reList));
	}
 }