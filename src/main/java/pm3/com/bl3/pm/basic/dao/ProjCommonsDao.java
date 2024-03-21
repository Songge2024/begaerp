package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import aos.system.dao.po.AosModulePO;

import com.bl3.pm.basic.dao.po.ProjCommonsPO;

/**
 * <b>bs_proj_commons[bs_proj_commons]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author yj
 * @date 2017-12-11 10:44:06
 */
@Dao("projCommonsDao")
public interface ProjCommonsDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_proj_commonsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProjCommonsPO projCommonsPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjCommonsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjCommonsPO projCommonsPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjCommonsPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjCommonsPO projCommonsPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjCommonsPO
	 */
	ProjCommonsPO selectByKey(@Param(value = "proj_id") Integer proj_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjCommonsPO
	 */
	ProjCommonsPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjCommonsPO>
	 */
	List<ProjCommonsPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "proj_id") Integer proj_id);
	
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
	 * 查询项目列表
	 * 
	 * @param pDto
	 * @return String
	 */
	List<ProjCommonsPO> listTree(Dto pDto);
}
