package com.bl3.pm.queryanalysis.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.queryanalysis.dao.ProjOverviewDao;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

@Service
public class ProjOverviewService {
	private static Logger logger = LoggerFactory.getLogger(ProjOverviewService.class);
 	@Autowired
	private ProjOverviewDao projOverviewDao;
	@Autowired
	private SqlDao sqlDao;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/queryanalysis/projOverview.jsp");
	}
	
	/**
	 * 项目总览 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.likePage(inDto);
		for (int i = 0; i < testExampleDtos.size(); i++) {
			Dto testExampleDto = testExampleDtos.get(i);
			String begin_date = (String) testExampleDto.get("M_BEGIN_DATE");
			String end_date = (String) testExampleDto.get("END_DATE");
			long begin_time = 0;
	     	long end_time = 0;
	     	String WEEKDAY_PERIOD = "0/0";
			if(!begin_date.equals("0")){
				SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
				try {
					begin_time =  formatter.parse(begin_date).getTime();
					end_time =  formatter.parse(end_date).getTime();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				long date = new Date().getTime();
				int bigin = (int)Math.ceil((double)(date-begin_time)/(1000*60*60*24*7));
				int end =  (int)Math.ceil((double)(end_time-begin_time)/(1000*60*60*24*7));
				if(bigin>end){
					bigin = end;
				}
				WEEKDAY_PERIOD = bigin+"/"+end;
			}
	     	testExampleDto.put("WEEKDAY_PERIOD", WEEKDAY_PERIOD);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
	
	/**
	 * 项目回款 分页查询
	 * 
	 * @param httpModel
	 */
	public void moneyPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.moneyLikePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
	
	/**
	 * 合同详情 分页查询
	 * 
	 * @param httpModel
	 */
	public void contractPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.contractLikePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
	
	/**
	 * 项目风险信息 分页查询
	 * 
	 * @param httpModel
	 */
	public void riskPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.riskLikePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
	
	/**
	 * 项目过程文件 分页查询
	 * 
	 * @param httpModel
	 */
	public void filePage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.fileLikePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
	
	/**
	 * 项目团队信息 分页查询
	 * 
	 * @param httpModel
	 */
	public void teamPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = projOverviewDao.teamLikePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	} 
}
