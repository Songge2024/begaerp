package com.bl3.pm.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.basic.dao.po.ProjClientContactsPO;

/**
 * <b>bs_proj_client_contacts[bs_proj_client_contacts]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author yj
 * @date 2017-12-13 14:59:53
 */
@Dao("projClientContactsDao")
public interface ProjClientContactsDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_proj_client_contactsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ProjClientContactsPO projClientContactsPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ProjClientContactsPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ProjClientContactsPO projClientContactsPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ProjClientContactsPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ProjClientContactsPO projClientContactsPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ProjClientContactsPO
	 */
	ProjClientContactsPO selectByKey(@Param(value = "cont_id") Integer cont_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ProjClientContactsPO
	 */
	ProjClientContactsPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ProjClientContactsPO>
	 */
	List<ProjClientContactsPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "cont_id") Integer cont_id);
	
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
