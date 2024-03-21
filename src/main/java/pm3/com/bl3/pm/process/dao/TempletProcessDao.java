package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

import com.bl3.pm.process.dao.po.TempletProcessPO;

/**
 * <b>pr_templet_process[pr_templet_process]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-11 16:46:36
 */
@Dao("templetProcessDao")
public interface TempletProcessDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_templet_processPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TempletProcessPO templetProcessPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(Dto pDto);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertFiletype(Dto pDto);
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertFiletypeAll(Dto pDto);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TempletProcessPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TempletProcessPO templetProcessPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TempletProcessPO
	 */
	TempletProcessPO selectByKey(@Param(value = "temp_proc_id") Integer temp_proc_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TempletProcessPO
	 */
	TempletProcessPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "temp_proc_id") Integer temp_proc_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateFiletypeByKey(@Param(value = "temp_proc_id") Integer temp_proc_id);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> rootdirList(Dto pDto);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TempletProcessPO>
	 */
	List<TempletProcessPO> subdirList(Dto pDto); 
	
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
	 * 根据Dto统计是否重复
	 * 
	 * @param pDto
	 * @return
	 */
	int countRootDirId(Dto pDto);
	
	/**
	 * 
	 * 
	 * @return Dto
	 */
	TempletProcessPO listTemplet(Dto pDto);
	
}
