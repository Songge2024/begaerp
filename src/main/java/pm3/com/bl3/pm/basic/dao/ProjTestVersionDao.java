package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ProjTestVersionPO;

/**
 * <b>bs_proj_test_version[bs_proj_test_version]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-07-03 10:08:11
 */
@Dao("projTestVersionDao")
public interface ProjTestVersionDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_proj_test_versionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProjTestVersionPO projTestVersionPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjTestVersionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjTestVersionPO projTestVersionPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjTestVersionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjTestVersionPO projTestVersionPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjTestVersionPO
	 */
	ProjTestVersionPO selectByKey(@Param(value = "test_version_id") Integer test_version_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjTestVersionPO
	 */
	ProjTestVersionPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjTestVersionPO>
	 */
	List<ProjTestVersionPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "test_version_id") Integer test_version_id);
	
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
	 * 新增查询是否有重名的测试版本号
	 * 
	 * @param pDto
	 * @return String
	 */
	int testVersionNumberCount(@Param(value = "test_version_number") String test_version_number,@Param(value = "version_id") Integer version_id);
	
	/**
	 * 修改查询是否已存在的测试版本号（除开自己）
	 * @param versionNumber
	 * @return
	 */
	int testVersionNumberCount1(@Param(value = "test_version_number") String test_version_number,@Param(value = "test_version_id") Integer test_version_id,@Param(value = "version_id") Integer version_id);

	/**
	 * 启用时进行判断
	 * @param test_version_id
	 * @return List<ProjCodeVersionPO>
	 */
	List<ProjTestVersionPO> selectByTestVersinId(@Param(value = "test_version_id") Integer test_version_id);
	
	/**
	 * 查询当前状态
	 * @param test_version_id
	 * @return ProjTestVersionPO
	 */
	ProjTestVersionPO selectStateByKey(@Param(value = "test_version_id") Integer test_version_id);
	
	/**
	 * 根据主键停用测试版本号
	 *
	 * @return 影响行数
	 */
	int updateStopByKey(@Param(value = "test_version_id") Integer test_version_id);
	
	/**
	 * 根据主键启用测试版本号
	 *
	 * @return 影响行数
	 */
	int updateRunByKey(@Param(value = "test_version_id") Integer test_version_id);
	
	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateCodeStopByKey(@Param(value = "test_version_id") Integer test_version_id);

	/**
	 * 根据主键修改数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateCodeRunByKey(@Param(value = "test_version_id") Integer test_version_id);
}


