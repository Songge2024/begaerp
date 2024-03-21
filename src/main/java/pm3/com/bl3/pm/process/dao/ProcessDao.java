package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.ProcessPO;

/**
 * <b>pr_process[pr_process]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author heying
 * @date 2017-12-14 16:24:05
 */
@Dao("processDao")
public interface ProcessDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_processPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProcessPO processPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(Dto pDto);
	
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pDto
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
	 * @param dto
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateProcessFiletype(Dto dto);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param dto
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateSeqence(Dto dto);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param dto
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateFiletype(Dto dto);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProcessPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProcessPO processPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProcessPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProcessPO processPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProcessPO
	 */
	ProcessPO selectByKey(@Param(value = "process_id") Integer process_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProcessPO
	 */
	ProcessPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> listPage(Dto pDto);
	
	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> listProcessPage(Dto pDto);
	
	
	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> listFiletypePage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "process_id") Integer process_id);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateByProcessId(@Param(value = "process_id") Integer process_id);
	
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
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> rootdirList(Dto pDto);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProcessPO>
	 */
	List<ProcessPO> subdirList(Dto pDto); 
	
	/**
	 * 根据Dto插入裁剪
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertProcessCut(Dto pDto); 
	
	/**
	 * 根据Dto插入裁剪
	 * 
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertProcessFiletype(Dto pDto); 
	
	
	/**
	 * 批量更新
	 * 
	 * @param Dto
	 *            
	 * @return 
	 */
	int updateCutFiletype(Dto pDto); 
	
	/**
	 * 更新Sort_no
	 * 
	 * @param Dto
	 *            
	 * @return 
	 */
	int updateProcessGridSortNo(Dto pDto); 
	
	/**
	 * 根据Dto统计是否重复
	 * 
	 * @param pDto
	 * @return
	 */
	int countProcessId(Dto pDto);
	
	
	/**
	 * 根据Dto统计是否重复
	 * 
	 * @param pDto
	 * @return
	 */
	int countProcessFiletype(Dto pDto);
	
	
}
