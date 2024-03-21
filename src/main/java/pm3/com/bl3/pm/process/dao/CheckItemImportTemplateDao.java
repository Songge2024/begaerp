package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.CheckItemImportTemplatePO;

/**
 * <b>pr_check_item_import_template[pr_check_item_import_template]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zhaojiaqi
 * @date 2020-08-26 09:56:54
 */
@Dao("checkItemImportTemplateDao")
public interface CheckItemImportTemplateDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_check_item_import_templatePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(CheckItemImportTemplatePO checkItemImportTemplatePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param CheckItemImportTemplatePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(CheckItemImportTemplatePO checkItemImportTemplatePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckItemImportTemplatePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(CheckItemImportTemplatePO checkItemImportTemplatePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckItemImportTemplatePO
	 */
	CheckItemImportTemplatePO selectByKey(@Param(value = "mould_id") Integer mould_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return CheckItemImportTemplatePO
	 */
	CheckItemImportTemplatePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemImportTemplatePO>
	 */
	List<CheckItemImportTemplatePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "mould_id") Integer mould_id);
	
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
