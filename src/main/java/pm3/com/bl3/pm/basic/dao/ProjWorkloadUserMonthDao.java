package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ProjWorkloadUserMonthPO;

/**
 * <b>st_proj_workload_user_month[st_proj_workload_user_month]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zocl
 * @date 2018-05-26 22:48:54
 */
@Dao("projWorkloadUserMonthDao")
public interface ProjWorkloadUserMonthDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param st_proj_workload_user_monthPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(Dto dto);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjWorkloadUserMonthPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjWorkloadUserMonthPO projWorkloadUserMonthPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjWorkloadUserMonthPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjWorkloadUserMonthPO projWorkloadUserMonthPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjWorkloadUserMonthPO
	 */
	ProjWorkloadUserMonthPO selectByKey(@Param(value = "st_work_user_id") Integer st_work_user_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjWorkloadUserMonthPO
	 */
	ProjWorkloadUserMonthPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<Dto> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<ProjWorkloadUserMonthPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<ProjWorkloadUserMonthPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<ProjWorkloadUserMonthPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<ProjWorkloadUserMonthPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjWorkloadUserMonthPO>
	 */
	List<Dto> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "st_work_user_id") Integer st_work_user_id);
	
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
