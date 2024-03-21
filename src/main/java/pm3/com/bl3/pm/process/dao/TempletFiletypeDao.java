package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.TempletFiletypePO;

/**
 * <b>pr_templet_filetype[pr_templet_filetype]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author huangtao
 * @date 2017-12-14 09:48:51
 */
@Dao("templetFiletypeDao")
public interface TempletFiletypeDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_templet_filetypePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TempletFiletypePO templetFiletypePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param TempletFiletypePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(TempletFiletypePO templetFiletypePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertFiletype(Dto pDto);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TempletFiletypePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TempletFiletypePO templetFiletypePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param dto
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateFiletype(Dto dto);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TempletFiletypePO
	 */
	TempletFiletypePO selectByKey(@Param(value = "temp_filetype_id") Integer temp_filetype_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TempletFiletypePO
	 */
	TempletFiletypePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TempletFiletypePO>
	 */
	List<TempletFiletypePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "temp_filetype_id") Integer temp_filetype_id);
	
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
	int countFiletypeId (Dto pDto);
}
