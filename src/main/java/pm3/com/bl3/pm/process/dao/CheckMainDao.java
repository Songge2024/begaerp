package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.CheckMainPO;
import com.bl3.pm.process.dao.po.CheckProjTypePO;
import com.bl3.pm.process.dao.po.ProblemTracePO;

/**
 * <b>pr_check_main[pr_check_main]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-22 20:33:19
 */
@Dao("checkMainDao")
public interface CheckMainDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_check_mainPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(CheckMainPO checkMainPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param CheckMainPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(CheckMainPO checkMainPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckMainPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(CheckMainPO checkMainPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckMainPO
	 */
	CheckMainPO selectByKey(@Param(value = "check_id") Integer check_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return CheckMainPO
	 */
	CheckMainPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "check_id") Integer check_id);
	
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
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> mainList(Dto pDto);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> detailList(Dto pDto);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckMainPO
	 */
	String selectStateByCheckCode(@Param(value = "check_code") String check_code);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return String 
	 */
	String selectTypeCode(Dto pDto);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckMainPO
	 */
	CheckMainPO selectStateByKey(@Param(value = "check_id") Integer check_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckMainPO
	 */
	CheckMainPO selectNumByKey(@Param(value = "check_id") Integer check_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param Integer
	 * @return int 返回影响行数
	 */
	int updateDeStateByKey(Integer integer);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteDetailByKey(@Param(value = "check_id") Integer check_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteProblemByKey(@Param(value = "check_id") Integer check_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param Integer
	 * @return int 返回影响行数
	 */
	int updateStateByKey(Integer integer);
	
	int updateStateNoSubmit(Integer integer);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckMainPO>
	 */
	List<CheckMainPO> CountLikeOrPage(Dto inDto);
	
	List<ProblemTracePO> problemCountPage(Dto inDto);
	
}
