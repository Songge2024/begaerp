<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projSituationCount_grid" 
	url="projSituationCountService.selectPage" 
	onrender="projSituationCount_query" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="projSituationCount_menu.jsp"%>
	<%@ include file="projSituationCount_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projSituationCount_columns.jsp"%>
</aos:gridpanel>