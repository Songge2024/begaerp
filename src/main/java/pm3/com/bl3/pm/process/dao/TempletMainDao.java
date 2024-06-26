package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.TempletMainPO;

/**
 * <b>pr_templet_main[pr_templet_main]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
@Dao("templetMainDao")
public interface TempletMainDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_templet_mainPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TempletMainPO templetMainPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param TempletMainPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(TempletMainPO templetMainPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TempletMainPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TempletMainPO templetMainPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TempletMainPO
	 */
	TempletMainPO selectByKey(@Param(value = "templet_id") Integer templet_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TempletMainPO
	 */
	TempletMainPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletMainPO>
	 */
	List<TempletMainPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "templet_id") Integer templet_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteProcessByKey(@Param(value = "templet_id") Integer templet_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteFiletypeByKey(@Param(value = "templet_id") Integer templet_id);
	
	/**
	 * 根据主键启用数据持久化对象
	 *
	 * @return 影响行数
	 */
	int enableByKey(@Param(value = "templet_id") Integer templet_id);
	
	/**
	 * 根据主键停数据持久化对象
	 *
	 * @return 影响行数
	 */
	int disableByKey(@Param(value = "templet_id") Integer templet_id);
	
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
