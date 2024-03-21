package com.bl3.pm.queryanalysis.dao;

import java.util.List;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

@Dao("ProjOverviewDao")
public interface ProjOverviewDao {
	
	/**
	 *  根据Dto模糊查询并返回分页数据Dto集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * @return List<Dto>
	 */
	List<Dto> likePage(Dto pDto);
	
	/**
	 * 根据Dto精准查询项目回款
	 * @param pDto
	 * @return List<Dto>
	 */
	List<Dto> moneyLikePage(Dto pDto);
	
	/**
	 * 根据Dto精准查询项目合同详情
	 * @param pDto
	 * @return List<Dto>
	 */
	List<Dto> contractLikePage(Dto pDto);
	
	/**
	 * 根据Dto精准查询项目风险信息
	 * @param pDto
	 * @return List<Dto>
	 */
	List<Dto> riskLikePage(Dto pDto);
	
	/**
	 * 根据Dto精准查询项目过程文件
	 * @param pDto
	 * @return List<Dto>
	 */
	List<Dto> fileLikePage(Dto pDto);
	
	/**
	 * 根据Dto精准查询项目团队信息
	 * @param pDto
	 * @return List<Dto>
	 */
	List<Dto> teamLikePage(Dto pDto);
}
