package com.bl3.pm.task.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.task.dao.po.WeekReportPO;

/**
 * <b>ta_week_report[ta_week_report]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zp
 * @date 2017-12-22 15:26:55
 */
@Dao("weekReportDao")
public interface WeekReportDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_week_reportPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(WeekReportPO weekReportPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param WeekReportPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(WeekReportPO weekReportPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param WeekReportPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(WeekReportPO weekReportPO);
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param WeekReportPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updatePlan(WeekReportPO weekReportPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return WeekReportPO
	 */
	WeekReportPO selectByKey(@Param(value = "id") Integer id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return WeekReportPO
	 */
	WeekReportPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WeekReportPO>
	 */
	List<WeekReportPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "id") Integer id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deletePlan(@Param(value = "id") Integer id);
	
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

	WeekReportPO getProjt(Dto inDto);
	
	int copy(WeekReportPO weekReportPO);
	
}
