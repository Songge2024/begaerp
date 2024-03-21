package com.bl3.pm.basic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bl3.pm.basic.dao.po.ProjOverallPO;
import com.bl3.pm.task.dao.po.TaskGroupPO;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

@Dao("projOverallDao")
public interface ProjOverallDao {
	int saveGrid(Dto dto);
	
	int saveCascade(Dto inDto);
	
	int saveparentSecondId(Dto inDto);
	
	List<ProjOverallPO> likePage(Dto inDto);

	ProjOverallPO selectByKey(@Param(value = "group_id") Integer group_id);
	
	List<ProjOverallPO> listChildrenByParentDto(Dto pDto);
	
	List<ProjOverallPO> exportALLExcel(Dto pDto);
	
	List<ProjOverallPO> exportExcel(Dto pDto);
	
	List<Integer> listChildrenByParentId(Dto pDto);

	List<ProjOverallPO> groups(Dto inDto);

	List<ProjOverallPO> list(Dto inDto);
}
