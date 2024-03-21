package com.bl3.pm.quality.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;







import com.bl3.pm.quality.dao.po.FilesManagePO;
import com.bl3.pm.quality.dao.po.WeeklyDetailPO;
import com.bl3.pm.quality.dao.po.WeeklyPO;

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
@Dao("qaStorageDao")
public interface QaStorageDao {
	/** 
	 * 获取周报编码
	 * return 返回一个int类型
	 * */
	int  weeklyCode();
	/** 
	 * 获取项目名称以及编码
	 * return 返回一个数组类型
	 * */
	List<Dto> getProjN();
	
	
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
	List<Dto> bugConut(Dto dto);
	/**
	 * 项目名称
	 */
	List<Dto> getProjtPage(Dto pdto);
	/**
	 * 根据编码删除数据
	 */
	 int deleteTc(@Param(value = "test_code") String test_code);
	 /**
	  * 提交DTO类型的数据
	  */
	 int insertWd(Dto dto);
	 /**
	  * 判断是否存在周报主表数据
	  */
	 int weeklyCount(String  str);
	 /**
	  * 删除主表
	  */
	 int weeklyDel(@Param(value = "test_code") String test_code);
	 /**
	  * 删除明细表
	  */
	 int weeklyDeDel(@Param(value = "test_code") String test_code);
	 /**
	  * 查询项目信息表
	  */
	 List<Dto> listComboBoxUerid();
	 /**
	  * 查询文档信息
	  */
	 String  returnUserName(@Param(value = "id") Integer id);
	 /**
	  * 查询项目人员
	  */
	 List<Dto> listComboBoxProjId(Dto dto);
	 /**
	  * 获取评审列表
	 * @return 
	  */
	  FilesManagePO listMange(@Param(value = "manage_id") Integer manage_id);
	 /**
	  * 获取消息
	  */
	 List<Dto> likePageMessage(Dto dto);
	 /**
	  * 获取消息
	  */
	 List<Dto> listText(Dto dto);
	 /**
	  * 获取消息
	  */
	 List<Dto> listMsgid(Dto dto);
	 /**
		 * 根据Dto模糊查询并返回分页数据周报主表
		 * 
		 * @return List<WeeklyDetailPO>
		 */
	 List<WeeklyDetailPO> likeweekOrPage(Dto pDto);
	 /**
		 * 根据Dto模糊查询并返回分页数据周报明细
		 * 
		 * @return List<WeeklyDetailPO>
		 */
	 List<WeeklyPO> likedetailOrPage(Dto pDto);
	 /**
		 * 根据主题删除回复
		 *
		 * @return 影响行数
		 */
		int deleteReply(@Param(value = "id") Integer id);
}
