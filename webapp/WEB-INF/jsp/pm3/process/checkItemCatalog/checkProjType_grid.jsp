<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="checkProjType_grid" 
	url="checkProjTypeService.page" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
	onitemclick="checkCatalog_query" 
  >
	
	<%@ include file="checkProjType_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="checkProjType_columns.jsp"%>
</aos:gridpanel>