package com.bl3.pm.quality.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.quality.dao.po.BugManagePO;

/**
 * <b>qa_bug_manage[qa_bug_manage]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author yiping
 * @date 2017-12-08 11:13:48
 */
@Dao("bugManageDao")
public interface BugManageDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param qa_bug_managePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(BugManagePO bugManagePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param BugManagePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(BugManagePO bugManagePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param BugManagePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(BugManagePO bugManagePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return BugManagePO
	 */
	BugManagePO selectByKey(@Param(value = "bug_id") Integer integer);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return BugManagePO
	 */
	BugManagePO selectByCopyBugId(@Param(value = "bug_id") Integer integer);


	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return BugManagePO
	 */
	BugManagePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "bug_id") Integer integer);
	
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
	 * 获取内容列表
	 * return 返回一个数组类型
	 * */
	List<Dto> getNewsDate(Dto dto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> buglikeOrPage(Dto inDto);
	
	List<BugManagePO> bugVaguePage(Dto inDto);
	
	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	int buglikeOrCount(Dto inDto);
	
	int bugVagueCount(Dto inDto);
	
	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<BugManagePO>
	 */
	List<BugManagePO> bugSearch(Dto inDto);
	
	List<BugManagePO> bugTypeCountPage(Dto inDto);
	
	List<BugManagePO> bugDealCountPage(Dto inDto);
	
	List<BugManagePO> bugSolveCountPage(Dto inDto);
}
