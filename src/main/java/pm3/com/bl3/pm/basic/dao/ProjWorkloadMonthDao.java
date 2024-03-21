package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ProjWorkloadMonthPO;

/**
 * <b>st_proj_workload_month[st_proj_workload_month]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zocl
 * @date 2018-05-26 21:01:53
 */
@Dao("projWorkloadMonthDao")
public interface ProjWorkloadMonthDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param st_proj_workload_monthPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(Dto dto);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjWorkloadMonthPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjWorkloadMonthPO projWorkloadMonthPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjWorkloadMonthPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjWorkloadMonthPO projWorkloadMonthPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjWorkloadMonthPO
	 */
	ProjWorkloadMonthPO selectByKey(@Param(value = "st_work_id") Integer st_work_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjWorkloadMonthPO
	 */
	ProjWorkloadMonthPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<Dto> list(Dto pDto);
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<Dto> listtaide(Dto pDto);
	

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<ProjWorkloadMonthPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<Dto> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<ProjWorkloadMonthPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<ProjWorkloadMonthPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadMonthPO>
	 */
	List<Dto> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "st_work_id") Integer st_work_id);
	
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
