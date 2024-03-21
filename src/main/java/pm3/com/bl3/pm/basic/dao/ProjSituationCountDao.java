package com.bl3.pm.basic.dao;

import java.util.List;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>bs_proj_situation_count[bs_proj_situation_count]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author zoucl
 * @date 2018-06-15 11:32:07
 */
@Dao("projSituationCountDao")
public interface ProjSituationCountDao {

	/**
	   查询汇总信息
	 */
	List<Dto> selectPage(Dto dto);
}
