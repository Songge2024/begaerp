package com.bl3.pm.contract.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.contract.dao.po.ContractPaymentPO;
import com.bl3.pm.contract.dao.po.ContractStagePO;

/**
 * <b>bs_contract_payment[bs_contract_payment]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
@Dao("contractPaymentDao")
public interface ContractPaymentDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param bs_contract_paymentPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(ContractPaymentPO contractPaymentPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param ContractPaymentPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(ContractPaymentPO contractPaymentPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractPaymentPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(ContractPaymentPO contractPaymentPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return ContractPaymentPO
	 */
	ContractPaymentPO selectByKey(@Param(value = "ct_pay_id") Integer ct_pay_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return ContractPaymentPO
	 */
	ContractPaymentPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<ContractPaymentPO>
	 */
	List<ContractPaymentPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(Dto dto);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int updateStageByKey(Dto dto);
	
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteDetailByKey(Dto dto);
	
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
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<ContractStagePO>
	 */
	List<ContractStagePO> queryContStageList(Dto pDto);
	
	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param ContractStagePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateContStagePaymoney(Dto dto);
	
	
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertIntoDetail(Dto dto);
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int countPayamout(Dto dto);
	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param Dto
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int updateStage(Dto dto);
	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteDetail(Dto dto);
	
	
}
