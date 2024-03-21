package com.bl3.pm.requirement.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.requirement.dao.po.DemandActionUploadTemplatePO;

/**
 * <b>re_demand_action_upload_template[re_demand_action_upload_template]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zhaojiaqi
 * @date 2020-09-06 09:13:27
 */
@Dao("demandActionUploadTemplateDao")
public interface DemandActionUploadTemplateDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param re_demand_action_upload_templatePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(DemandActionUploadTemplatePO demandActionUploadTemplatePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param DemandActionUploadTemplatePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(DemandActionUploadTemplatePO demandActionUploadTemplatePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param DemandActionUploadTemplatePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(DemandActionUploadTemplatePO demandActionUploadTemplatePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return DemandActionUploadTemplatePO
	 */
	DemandActionUploadTemplatePO selectByKey(@Param(value = "mould_id") Integer mould_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return DemandActionUploadTemplatePO
	 */
	DemandActionUploadTemplatePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<DemandActionUploadTemplatePO>
	 */
	List<DemandActionUploadTemplatePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "mould_id") Integer mould_id);
	
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
