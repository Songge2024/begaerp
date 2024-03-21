package com.bl3.pm.recruit.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.recruit.dao.po.InterviewRecordsPO;

/**
 * <b>bs_interview_records[bs_interview_records]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hege
 * @date 2018-05-02 15:02:41
 */
@Dao("interviewRecordsDao")
public interface InterviewRecordsDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_interview_recordsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(InterviewRecordsPO interviewRecordsPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param InterviewRecordsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(InterviewRecordsPO interviewRecordsPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param InterviewRecordsPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(InterviewRecordsPO interviewRecordsPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return InterviewRecordsPO
	 */
	InterviewRecordsPO selectByKey(@Param(value = "result_id") Integer result_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return InterviewRecordsPO
	 */
	InterviewRecordsPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<InterviewRecordsPO>
	 */
	List<InterviewRecordsPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "result_id") Integer result_id);
	
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
