package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ModuleDividePO;

/**
 * <b>re_module_divide[re_module_divide]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hege
 * @date 2017-12-11 11:17:18
 */
@Dao("moduleDivideDao")
public interface ModuleDivideDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param re_module_dividePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ModuleDividePO moduleDividePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ModuleDividePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ModuleDividePO moduleDividePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ModuleDividePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ModuleDividePO moduleDividePO);
	
	int insertByKey(ModuleDividePO moduleDividePO);
	
	int updatefirstByKey(ModuleDividePO moduleDividePO);
	
	int count(Dto qDto);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ModuleDividePO
	 */
	ModuleDividePO selectByKey(@Param(value = "dm_code") String dm_code);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ModuleDividePO
	 */
	ModuleDividePO selectOne(Dto pDto);
	ModuleDividePO selectByFirstName(@Param(value = "dm_name") String dm_name,@Param(value = "proj_id") String proj_id);
	ModuleDividePO selectBySecondName(@Param(value = "dm_parent_code") String first_id,@Param(value = "dm_name") String secondName,@Param(value = "proj_id") String proj_id);
	
	String selectFirst_id(@Param(value = "dm_name") String dm_name,@Param(value = "proj_id") String proj_id);
	String selectSecond_id(@Param(value = "dm_parent_code") String first_id,@Param(value = "dm_name") String secondName,@Param(value = "proj_id") String proj_id);
	
	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> list(Dto pDto);
	List<ModuleDividePO> listOnState(Dto pDto);
	List<ModuleDividePO> exportALLExcel(Dto pDto);
	List<ModuleDividePO> exportAExcel(Dto pDto);
	List<ModuleDividePO> codingUser(Dto pDto);
	List<ModuleDividePO> testUser(Dto pDto);
	String completeQuery(Dto pDto);
	String completeLeafQuery(Dto pDto);
	
	List<Dto> codingUserID(Dto pDto);
	List<Dto> testUserID(Dto pDto);
	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> listPage(Dto pDto);
	
	List<ModuleDividePO> dmCode(Dto pDto);
	
	List<ModuleDividePO> all(Dto pDto);
	
	String dmCod(Dto pDto);
	
	String testCode(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ModuleDividePO>
	 */
	List<ModuleDividePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "dm_code") String dm_code);
	
	/**
	 * 根据Dto统计行数
	 * 
	 * @param pDto
	 * @return
	 */
	int rows(Dto pDto);
	
	int saveGrid(Dto dto);
	
	/**
	 * 根据数学表达式进行数学运算
	 * 
	 * @param pDto
	 * @return String
	 */
	String calc(Dto pDto);
	
	//String selectFirst_id(@Param(value = "dm_name") String dm_name,@Param(value = "proj_id") String proj_id);
	
	String selectParent_id(@Param(value = "first_id") Integer first_id,@Param(value = "dm_name") String secondName);

	int dmParentCodeCounts(@Param(value = "dm_code") String dm_code);
	
}
