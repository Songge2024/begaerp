package com.bl3.pm.task.dao;

import java.sql.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.bl3.pm.task.dao.po.DailyProductionPO;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>ta_daily_production[ta_daily_production]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author ZhaoJiaqi
 * @date 2020-03-20 15:32:23
 */
@Dao("dailyProductionDao")
public interface DailyProductionDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_daily_productionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(DailyProductionPO dailyProductionPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param DailyProductionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(DailyProductionPO dailyProductionPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param DailyProductionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(DailyProductionPO dailyProductionPO);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param DailyProductionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateIdByKey(DailyProductionPO dailyProductionPO);
	
	/**
	 * 根据日期修改数据持久化对象
	 * 
	 * @param DailyProductionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int deleteDateByKey(Date date);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckMainPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int reportUpdateByKey(Dto pDto);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return DailyProductionPO
	 */
	DailyProductionPO selectByKey(@Param(value = "daily_id") Integer daily_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return DailyProductionPO
	 */
	DailyProductionPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DailyProductionPO>
	 */
	List<DailyProductionPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "daily_id") Integer daily_id);
	
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
