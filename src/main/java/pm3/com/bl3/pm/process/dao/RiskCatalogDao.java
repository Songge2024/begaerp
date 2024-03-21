package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.RiskCatalogPO;

/**
 * <b>pr_risk_catalog[pr_risk_catalog]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author huangtao
 * @date 2018-01-09 09:18:47
 */
@Dao("riskCatalogDao")
public interface RiskCatalogDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_risk_catalogPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(RiskCatalogPO riskCatalogPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param RiskCatalogPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(RiskCatalogPO riskCatalogPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param RiskCatalogPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(RiskCatalogPO riskCatalogPO);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param Dto
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateState(Dto pDto);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return RiskCatalogPO
	 */
	RiskCatalogPO selectByKey(@Param(value = "risk_cata_id") Integer risk_cata_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return RiskCatalogPO
	 */
	RiskCatalogPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<RiskCatalogPO>
	 */
	List<RiskCatalogPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "risk_cata_id") Integer risk_cata_id);
	
	/**
	 * 根据主键启用数据持久化对象
	 *
	 * @return 影响行数
	 */
	int enableByKey(@Param(value = "risk_cata_id") Integer risk_cata_id);
	
	/**
	 * 根据主键停数据持久化对象
	 *
	 * @return 影响行数
	 */
	int disableByKey(@Param(value = "risk_cata_id") Integer risk_cata_id);
	
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
