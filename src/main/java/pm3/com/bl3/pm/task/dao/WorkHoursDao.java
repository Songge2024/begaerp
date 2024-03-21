package com.bl3.pm.task.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

import com.bl3.pm.task.dao.po.WorkHourPO;

/**
 * <b>ta_work_hour[ta_work_hour]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zocl
 * @date 2018-05-03 14:27:05
 */
@Dao("workHourDaos")
public interface WorkHoursDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_work_hourPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(WorkHourPO workHourPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param WorkHourPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(WorkHourPO workHourPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param WorkHourPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(WorkHourPO workHourPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return WorkHourPO
	 */
	WorkHourPO selectByKey(@Param(value = "work_id") Integer work_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return WorkHourPO
	 */
	WorkHourPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<WorkHourPO>
	 */
	List<WorkHourPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "work_id") Integer work_id);
	
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
