package com.bl3.pm.task.service;

import java.util.List;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>ta_daily_report[ta_daily_report]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author luojh
 * @date 2017-12-27 15:21:21
 */
@Dao("daiReportimplDao")
public interface DaiReportimplDao {
	/**
	 * 获取日报文本
	 */
  List<Dto>  getDaiReport(Dto dto);
}
