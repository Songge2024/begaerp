package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.ProblemTracePO;

/**
 * <b>pr_problem_trace[pr_problem_trace]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-31 10:33:56
 */
@Dao("problemTraceDao")
public interface ProblemTraceDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_problem_tracePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProblemTracePO problemTracePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProblemTracePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProblemTracePO problemTracePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProblemTracePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProblemTracePO problemTracePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProblemTracePO
	 */
	ProblemTracePO selectByKey(@Param(value = "check_problem_id") Integer check_problem_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProblemTracePO
	 */
	ProblemTracePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProblemTracePO>
	 */
	List<ProblemTracePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "check_problem_id") Integer check_problem_id);
	
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
	
	/**
	 * 统一保存
	 */
	int problemUpdateByKey(Dto dto);
	
	/**
	 * 全部导出查询
	 */
	List<ProblemTracePO> searchProblemTrace(Dto dto);
	
	/**
	 * 定时查询
	 */
	List<ProblemTracePO> searchChangeTrace(Dto dto);
}
