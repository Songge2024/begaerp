package com.bl3.pm.queryanalysis.dao;

import java.util.List;


import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

@Dao("workChecklistDao")
public interface WorkChecklistDao {
	List<Dto> likeOrPage(Dto pDto);
}
