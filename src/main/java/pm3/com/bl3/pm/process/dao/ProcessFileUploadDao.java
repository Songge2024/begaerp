package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.ProcessFileUploadPO;

/**
 * <b>pr_process_file_upload[pr_process_file_upload]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author heying
 * @date 2017-12-21 15:35:16
 */
@Dao("processFileUploadDao")
public interface ProcessFileUploadDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_process_file_uploadPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProcessFileUploadPO processFileUploadPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProcessFileUploadPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProcessFileUploadPO processFileUploadPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProcessFileUploadPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProcessFileUploadPO processFileUploadPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProcessFileUploadPO
	 */
	ProcessFileUploadPO selectByKey(@Param(value = "file_id") Integer file_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProcessFileUploadPO
	 */
	ProcessFileUploadPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "file_id") Integer file_id);
	
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
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProcessFileUploadPO>
	 */
	List<ProcessFileUploadPO> byProcListPage(Dto pDto);
	
}
