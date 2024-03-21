<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projTeams_grid" 
	url="projTeamsService.page"
	forceFit="false"
 	region="center"
 	autoScroll="true"
 	
  >
<!--   onrender="projTeams_query" -->
	<%@ include file="projTeams_menu.jsp"%>
	<%@ include file="projTeams_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" align="center"/>
	<%@ include file="projTeams_columns.jsp"%>
</aos:gridpanel>