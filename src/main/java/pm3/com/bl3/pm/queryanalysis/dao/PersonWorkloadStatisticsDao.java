package com.bl3.pm.queryanalysis.dao;

import java.util.List;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

@Dao("personWorkloadStatisticsDao")
public interface PersonWorkloadStatisticsDao {
	List<Dto> likeOrPage(Dto pDto);
}
