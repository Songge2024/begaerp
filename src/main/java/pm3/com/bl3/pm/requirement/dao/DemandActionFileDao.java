package com.bl3.pm.requirement.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.requirement.dao.po.DemandActionFilePO;

/**
 * <b>re_demand_action_file[re_demand_action_file]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author yj
 * @date 2017-12-24 17:03:57
 */
@Dao("demandActionFileDao")
public interface DemandActionFileDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param re_demand_action_filePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(DemandActionFilePO demandActionFilePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param DemandActionFilePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(DemandActionFilePO demandActionFilePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param DemandActionFilePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(DemandActionFilePO demandActionFilePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return DemandActionFilePO
	 */
	DemandActionFilePO selectByKey(@Param(value = "fad_id") Integer fad_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return DemandActionFilePO
	 */
	DemandActionFilePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionFilePO>
	 */
	List<DemandActionFilePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "fad_id") Integer fad_id);
	
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
