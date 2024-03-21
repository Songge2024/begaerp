package com.bl3.pm.task.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;



import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>qa_reply_news[qa_reply_news]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件为，生成以外需要要用到的SQL语句，自定义功能方法。
 * </p>
 * 
 * @author Z
 * @date 2017-12-14 11:27:19
 */
@Dao("weStorageDao")
public interface WeStorageDao {
	/** 
	 * 获取周报编码
	 * return 返回一个int类型
	 * */
	int  weeklyCode();
	
	
	/** 
	 * 获取周报n
	 * return 返回一个int类型
	 * */
	int  weekFlag(@Param(value = "proj_id") String proj_id);
	/** 
	 * 获取项目编码
	 * return 
	 * */
	int getProjN();
	/** 
	 * 获取评审编码
	 * return 返回一个总数
	 * */
	int getManageCode();
	/** 
	 * 获取意见编码
	 * return 返回一个总数
	 * */
	int getOpinionCode();
	/** 
	 * 获取内容列表
	 * return 返回一个数组类型
	 * */
	List<Dto> userText(Dto dto);
	/**
	 * bug数量的汇总
	 */
	List<Dto> week_name(Dto dto);
	List<Dto> week_T(Dto dto);
	List<Dto> week_N(Dto dto);
	/**
	 * 项目名称
	 */
	List<Dto> getProjt();
	/**
	 * 根据编码删除数据
	 */
	 int deleteTc(@Param(value = "test_code") String test_code);
	 /**
		 * 根据编码删除数据
		 */
		 int deleteMx(@Param(value = "test_code") String test_code);
	 /**
	  * 提交DTO类型的数据
	  */
	 int insert(Dto dto);
	 /**
	  * 提交DTO类型的数据
	  */
	 int insert_week_plan(Dto dto);
	 /**
	  * 根据编码删除数据
	  */
	 int deleteTh(@Param(value = "test_code") String test_code);
	
	 /**
	  * 判断是否存在周报主表数据
	  */
	 int weeklyCount(String  test_code_);
	 /**
	  * 判断是否存在数据
	  */
	 int weekhsCount(Dto  str);
	 /**
	  * 判断是否存在数据
	  */
	 int weekusCount(String  str);
	 /**
	  * 删除主表
	  */
	 int weeklyDel(@Param(value = "test_code") String test_code);
	 /**
	  * 删除明细表
	  */
	 int weeklyDeDel(@Param(value = "test_code") String test_code);
	 /**
	  * 删除工期表
	  */
	 int weeklyDelH(@Param(value = "test_code") String test_code);



}
