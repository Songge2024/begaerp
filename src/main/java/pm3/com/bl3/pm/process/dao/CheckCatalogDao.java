package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.CheckCatalogPO;

/**
 * <b>pr_check_catalog[pr_check_catalog]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-10 13:57:28
 */
@Dao("checkCatalogDao")
public interface CheckCatalogDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_check_catalogPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(CheckCatalogPO checkCatalogPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param CheckCatalogPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(CheckCatalogPO checkCatalogPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckCatalogPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(CheckCatalogPO checkCatalogPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckCatalogPO
	 */
	CheckCatalogPO selectByKey(@Param(value = "check_cata_id") Integer check_cata_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return CheckCatalogPO
	 */
	CheckCatalogPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckCatalogPO>
	 */
	List<CheckCatalogPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "check_cata_id") Integer check_cata_id);
	
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
	 * 新增检查项，检查是否会重名
	 */
	int catalogCount(@Param(value = "type_code")String type_code,@Param(value = "check_cata_name")String check_cata_name);
	
	/**
	 * 修改检查项，查询除开自己是否有其他重名 
	 */
	int catalogOtCount(@Param(value = "type_code")String type_code,@Param(value = "check_cata_name")String check_cata_name,@Param(value = "check_cata_id")String check_cata_id);

	/**
	 * 停用检查项
	 */
	int cataStopByKey(@Param(value = "check_cata_id") Integer check_cata_id);

	/**
	 * 停用检查项下检查单
	 */
	int itemStopByKey(@Param(value = "check_cata_id") Integer check_cata_id);

	/**
	 * 启用检查项
	 */
	int cataRunByKey(@Param(value = "check_cata_id") Integer check_cata_id);

	/**
	 * 启用检查项下检查单
	 */
	int itemRunByKey(@Param(value = "check_cata_id") Integer check_cata_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	Integer deleteItemByKey(@Param(value = "check_cata_id") Integer check_cata_id);



}
