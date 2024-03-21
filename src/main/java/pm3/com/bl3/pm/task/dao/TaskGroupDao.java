package com.bl3.pm.task.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.task.dao.po.TaskGroupPO;

/**
 * <b>ta_task_group[ta_task_group]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author remexs
 * @date 2018-01-22 11:10:34
 */
@Dao("taskGroupDao")
public interface TaskGroupDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param ta_task_groupPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TaskGroupPO taskGroupPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param TaskGroupPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(TaskGroupPO taskGroupPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TaskGroupPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TaskGroupPO taskGroupPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TaskGroupPO
	 */
	TaskGroupPO selectByKey(@Param(value = "group_id") Integer group_id);
	
	TaskGroupPO selectByFirstName(@Param(value = "group_name") String group_name,@Param(value = "proj_id") String proj_id);
	
	Integer selectFirst_id(@Param(value = "group_name") String group_name,@Param(value = "proj_id") String proj_id);
	
	Integer selectSecond_id(@Param(value = "parent_id") Integer first_id,@Param(value = "group_name") String secondName);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TaskGroupPO
	 */
	TaskGroupPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> list(Dto pDto);
	
	/**
	 * 根据父节点查找有效的子节点
	 * @param pDto
	 * @return
	 */
	List<TaskGroupPO> listChildrenByParentDto(Dto pDto);
	
	/**
	 * 根据父节点查找有效的子节点
	 * @param pDto
	 * @return
	 */
	List<Integer> listChildrenByParentId(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TaskGroupPO>
	 */
	List<TaskGroupPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "group_id") Integer group_id);
	
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
