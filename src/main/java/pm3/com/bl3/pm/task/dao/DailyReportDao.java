package com.bl3.pm.task.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.task.dao.po.DailyReportPO;

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
@Dao("dailyReportDao")
public interface DailyReportDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_daily_reportPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(DailyReportPO dailyReportPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param DailyReportPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(DailyReportPO dailyReportPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param DailyReportPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(DailyReportPO dailyReportPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return DailyReportPO
	 */
	DailyReportPO selectByKey(@Param(value = "id") Integer id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return DailyReportPO
	 */
	DailyReportPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyReportPO>
	 */
	List<DailyReportPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "id") Integer id);
	
	/**
	 * 根据Dto统计行数
	 * 
	 * @param pDto
	 * @return
	 */
	int rows(Dto pDto);
	
	/**
	 * 根据数学表达式进行数学运算
	 * 
	 * @param pDto
	 * @return String
	 */
	String calc(Dto pDto);
	
}
