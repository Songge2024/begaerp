<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="testExample_grid" 
	url="testExampleService.page" 
	onrender="testExample_query" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="testExample_menu.jsp"%>
	<%@ include file="testExample_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="testExample_columns.jsp"%>
</aos:gridpanel>