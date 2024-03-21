package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ProjVersionPO;

/**
 * <b>bs_proj_version[bs_proj_version]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-03-08 11:26:18
 */
@Dao("projVersionDao")
public interface ProjVersionDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_proj_versionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProjVersionPO projVersionPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjVersionPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjVersionPO projVersionPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjVersionPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjVersionPO projVersionPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjVersionPO
	 */
	ProjVersionPO selectByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjVersionPO
	 */
	ProjVersionPO selectStateByVersionKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjVersionPO
	 */
	ProjVersionPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteVersionByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteCodeVersionByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteTestVersionByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateVersionStateStopByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateCodeVersionStateStopByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateTestVersionStateStopByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateVersionStateRunByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateCodeVersionStateRunByKey(@Param(value = "version_id") Integer version_id);
	
	/**
	 * 根据主键删除除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateTestVersionStateRunByKey(@Param(value = "version_id") Integer version_id);
	
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
	 * 新增查询是否已存在的版本号
	 * 
	 * @param pDto
	 * @return String
	 */
	int versionNumberCount(@Param(value = "version_number") String version_number,@Param(value = "proj_id") Integer proj_id);
	
	/**
	 * 修改查询是否已存在的版本号
	 * 
	 * @param pDto
	 * @return String
	 */
	int versionNumberCount1(@Param(value = "version_number") String version_number,@Param(value = "proj_id") Integer proj_id,@Param(value = "version_id") Integer version_id);
	
	/**
	 * 启用时进行判断
	 * @param version_id
	 * @return List<ProjVersionPO>
	 */
	List<ProjVersionPO> selectByVersinId(@Param(value = "version_id") Integer version_id);
}
