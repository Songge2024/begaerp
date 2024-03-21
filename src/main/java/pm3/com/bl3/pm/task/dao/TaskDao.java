package com.bl3.pm.task.dao;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.task.dao.po.TaskPO;

/**
 * <b>ta_task[ta_task]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author remexs
 * @date 2018-01-22 11:10:33
 */
@Dao("taskDao")
public interface TaskDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_taskPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TaskPO taskPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param TaskPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(TaskPO taskPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TaskPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TaskPO taskPO);
	
	int updateDecomposed (Dto dto);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TaskPO
	 */
	TaskPO selectByKey(@Param(value = "task_id") Integer task_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TaskPO
	 */
	TaskPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskPO>
	 */
	List<TaskPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "task_id") Integer task_id);
	
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
	 * 判断新增时间段是否重叠
	 * 
	 * @param pDto
	 * @return Integer
	 */
	Integer judgePlanTime(Dto pDto );
	
	/**
	 * 判断新增时间段计划消耗天数
	 * 
	 * @param pDto
	 * @return Integer
	 */
	Double judgePlanWastage(Dto pDto );
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckMainPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int taskUpdateByKey(Dto pDto);
}
