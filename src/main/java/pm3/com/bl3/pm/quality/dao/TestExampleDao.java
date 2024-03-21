package com.bl3.pm.quality.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.quality.dao.po.TestExamplePO;

/**
 * <b>qa_test_example[qa_test_example]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author wangjl
 * @date 2018-02-26 09:34:38
 */
@Dao("testExampleDao")
public interface TestExampleDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param qa_test_examplePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(TestExamplePO testExamplePO);
	
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param qa_test_examplePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertIntoLog(TestExamplePO testExamplePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param TestExamplePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(TestExamplePO testExamplePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param TestExamplePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(TestExamplePO testExamplePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return TestExamplePO
	 */
	TestExamplePO selectByKey(@Param(value = "standard_id") Integer standard_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return TestExamplePO
	 */
	TestExamplePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<TestExamplePO>
	 */
	List<TestExamplePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "standard_id") Integer standard_id);
	
	/**
	 * 根据Dto统计行数
	 * 
	 * @param pDto
	 * @return
	 */
	int rows(Dto pDto);
	
	/**
	 * 全部导出查询测试用例
	 */
	List<TestExamplePO> testSearch(Dto inDto);
	
	/**
	 * 根据数学表达式进行数学运算
	 * 
	 * @param pDto
	 * @return String
	 */
	String calc(Dto pDto);
	
	
	/**复制
	 * @param pDto
	 * @return
	 */
	int copyTestExample(Dto pDto);
	
	/**
	 * 根据主键查找，返回一个PO对象
	 * @param standard_id
	 * @return TestExamplePO
	 */
	TestExamplePO selectByStandardId(@Param(value = "standard_id") Integer standard_id);
	
	String queryTestCode(@Param(value = "proId") String proId,@Param(value = "testCode") String testCode );
	
	List<TestExamplePO> testExamplePage(Dto inDto);
	
	Dto selectStandId(@Param(value = "stand_id") String stand_id,@Param(value = "proj_id") Integer proj_id);
}
