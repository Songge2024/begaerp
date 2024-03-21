package com.bl3.pm.recruit.service;

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


import com.bl3.pm.recruit.dao.InterviewRecordsDao;
import com.bl3.pm.recruit.dao.RecruitmentManagementDao;
import com.bl3.pm.recruit.dao.po.InterviewRecordsPO;
import com.bl3.pm.recruit.dao.po.RecruitmentManagementPO;

/**
 * <b>bs_interview_records[bs_interview_records]业务逻辑层</b>
 * 
 * @author hege
 * @date 2018-05-02 11:06:35
 */
 @Service
 public class InterviewRecordsService{
 	private static Logger logger = LoggerFactory.getLogger(InterviewRecordsService.class);
 	@Autowired
	private InterviewRecordsDao interviewRecordsDao;
 	@Autowired
	private RecruitmentManagementDao recruitmentManagementDao;
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
		httpModel.setViewPath("pm3/recruit/interviewRecords/interviewRecords_layout.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		InterviewRecordsPO interviewRecordsPO=new InterviewRecordsPO();
		interviewRecordsPO.setResult_id(idService.nextValue("seq_bs_interview_records").intValue());
		interviewRecordsPO.copyProperties(inDto);
		interviewRecordsDao.insert(interviewRecordsPO);
		RecruitmentManagementPO recruitmentManagementPO=new RecruitmentManagementPO();
		recruitmentManagementPO.copyProperties(inDto);
		if(AOSUtils.isNotEmpty(interviewRecordsPO.getInterview_result())){
			recruitmentManagementPO.setState("3");
		}
		recruitmentManagementDao.updateByKey(recruitmentManagementPO);
		httpModel.setOutMsg("操作成功");
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		InterviewRecordsPO interviewRecordsPO=new InterviewRecordsPO();
		interviewRecordsPO.copyProperties(inDto);
		interviewRecordsDao.updateByKey(interviewRecordsPO);
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
			interviewRecordsDao.deleteByKey(Integer.valueOf(id));
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
		InterviewRecordsPO interviewRecordsPO=interviewRecordsDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(interviewRecordsPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
//		List<InterviewRecordsPO> interviewRecordsPOs = interviewRecordsDao.likeOrPage(inDto);
		List<InterviewRecordsPO> interviewRecordsPOs = sqlDao.list("com.bl3.pm.recruit.dao.InterviewRecordsDao.queryInterviewRecord", inDto);
		httpModel.setOutMsg(AOSJson.toJson(interviewRecordsPOs));
	}
 }