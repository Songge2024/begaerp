<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractStage_grid" 
	url="contractService.queryCommonContact" 
	forceFit="false"
 	hidePagebar="true"
 	onitemclick="onclickpayContact"
  >
	<%@ include file="contractStage_docked.jsp"%>
	<%@ include file="contractStage_columns.jsp"%>
</aos:gridpanel>