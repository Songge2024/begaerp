package com.bl3.pm.basic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bl3.pm.basic.dao.po.ProjCodeVersionPO;
import com.bl3.pm.process.dao.po.CheckItemPO;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>bs_proj_code_version[bs_proj_code_version]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-03-08 13:39:11
 */
@Dao("projCodeVersionDao")
public interface ProjCodeVersionDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_proj_code_versionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProjCodeVersionPO projCodeVersionPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjCodeVersionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjCodeVersionPO projCodeVersionPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjCodeVersionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjCodeVersionPO projCodeVersionPO);
	
	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateStopByKey(@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateTestStopByKey(@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateRunByKey(@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateTestRunByKey(@Param(value = "code_version_id") Integer code_version_id);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjCodeVersionPO
	 */
	ProjCodeVersionPO selectByKey(@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckItemPO
	 */
	ProjCodeVersionPO selectStateByKey(@Param(value = "code_version_id") Integer code_version_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjCodeVersionPO
	 */
	ProjCodeVersionPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除代码版本号
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 根据主键删除测试版本号
	 *
	 * @return 影响行数
	 */
	int deleteTestByKey(@Param(value = "code_version_id") Integer code_version_id);
	
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
	 * 新增查询是否已存在的代码版本号
	 * @param versionNumber
	 * @return
	 */
	int codeVersionNumberCount(@Param(value = "code_version_number") String code_version_number,@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 修改查询是否已存在的代码版本号（除开自己）
	 * @param versionNumber
	 * @return
	 */
	int codeVersionNumberCount1(@Param(value = "code_version_number") String code_version_number,@Param(value = "test_version_id") Integer test_version_id,@Param(value = "code_version_id") Integer code_version_id);
	
	/**
	 * 启用时进行判断
	 * @param code_version_id
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjCodeVersionPO> selectByCodeVersinId(@Param(value = "code_version_id") Integer code_version_id);
}
