package com.bl3.pm.process.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.process.dao.po.ContractPayInfoPO;

/**
 * <b>pr_contract_pay_info[pr_contract_pay_info]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author gaoyong
 * @date 2017-12-21 14:27:43
 */
@Dao("contractPayInfoDao")
public interface ContractPayInfoDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_contract_pay_infoPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ContractPayInfoPO contractPayInfoPO);
	
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param pr_contract_pay_infoPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert1(ContractPayInfoPO contractPayInfoPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ContractPayInfoPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ContractPayInfoPO contractPayInfoPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPayInfoPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ContractPayInfoPO contractPayInfoPO);
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPayInfoPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey1(ContractPayInfoPO contractPayInfoPO);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPayInfoPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey2(ContractPayInfoPO contractPayInfoPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPayInfoPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey3(ContractPayInfoPO contractPayInfoPO);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPayInfoPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey4(ContractPayInfoPO contractPayInfoPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ContractPayInfoPO
	 */
	ContractPayInfoPO selectByKey(@Param(value = "pay_id") Integer pay_id);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return int
	 */
	int selectByKey1(@Param(value = "pay_id") Integer pay_id);
	
	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ContractPayInfoPO
	 */
	int selectByKey2(@Param(value = "pay_id") Integer pay_id);
	
	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ContractPayInfoPO
	 */
	ContractPayInfoPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "pay_id") Integer pay_id);
	
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
	 * 回款合同查询
	 * 
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> getmoney(Dto pDto);
	/**
	 * 回款阶段查询
	 * 
	 * 
	 * @return List<ContractPayInfoPO>
	 */
	List<ContractPayInfoPO> getmoney1(Dto pDto);
	
}
