package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.CheckItemPO;

/**
 * <b>pr_check_item[pr_check_item]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author hanjin
 * @date 2019-10-10 13:58:43
 */
@Dao("checkItemDao")
public interface CheckItemDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_check_itemPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(CheckItemPO checkItemPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param CheckItemPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(CheckItemPO checkItemPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param CheckItemPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(CheckItemPO checkItemPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return CheckItemPO
	 */
	CheckItemPO selectByKey(@Param(value = "check_item_id") Integer check_item_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return CheckItemPO
	 */
	CheckItemPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<CheckItemPO>
	 */
	List<CheckItemPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "check_item_id") Integer check_item_id);
	
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
	 * 新增检查项明细，检查是否会重名
	 */
	int itemCount(@Param(value = "check_cata_id")String check_cata_id,@Param(value = "check_item_name")String check_item_name);
	
	/**
	 * 修改检查项明细，查询除开自己是否有其他重名 
	 */
	int itemOtCount(@Param(value = "check_cata_id")String check_cata_id,@Param(value = "check_item_name")String check_item_name,@Param(value = "check_item_id")String check_item_id);

	/**
	 * 停用
	 */
	int itemStopByKey(@Param(value = "check_item_id") Integer check_item_id);
	/**
	 * 启用
	 */
	int itemRunByKey(@Param(value = "check_item_id") Integer check_item_id);
}
