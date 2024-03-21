package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.SubdirPO;

/**
 * <b>pr_subdir[pr_subdir]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author remexs
 * @date 2017-12-12 14:18:36
 */
@Dao("subdirDao")
public interface SubdirDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_subdirPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(SubdirPO subdirPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param SubdirPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(SubdirPO subdirPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param SubdirPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(SubdirPO subdirPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	SubdirPO selectByKey(@Param(value = "subdir_id") Integer subdir_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	int selectByKey1(@Param(value = "subdir_id") Integer subdir_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	int selectByKey2(@Param(value = "subdir_id") Integer subdir_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	String selectByKey3(@Param(value = "subdir_id") Integer subdir_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	int selectByKey4(@Param(value = "subdir_id") Integer subdir_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	String selectByKey5(@Param(value = "rootdir_id") Integer rootdir_id);
	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return SubdirPO
	 */
	SubdirPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<SubdirPO>
	 */
	List<SubdirPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "subdir_id") Integer subdir_id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey1(@Param(value = "subdir_id") Integer subdir_id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey12(@Param(value = "subdir_id") Integer subdir_id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey13(@Param(value = "subdir_id") Integer subdir_id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey41(@Param(value = "subdir_id") Integer subdir_id);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey51(@Param(value = "subdir_id") Integer subdir_id);
	
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
