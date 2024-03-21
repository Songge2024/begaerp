package com.bl3.pm.quality.dao;

import java.util.List;

import com.bl3.pm.quality.dao.po.FilesManageLogsPO;
import com.bl3.pm.task.dao.po.TaskLogsPO;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

@Dao("FilesManageLogsDao")
public interface FilesManageLogsDao {
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param qa_files_managePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(FilesManageLogsPO FilesManageLogsPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param FilesManagePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(FilesManageLogsPO FilesManageLogsPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param FilesManagePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(FilesManageLogsPO FilesManageLogsPO);
	
	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskLogsPO>
	 */
	List<FilesManageLogsPO> likeOrPage(Dto pDto);
	
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
