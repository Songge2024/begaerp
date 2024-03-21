<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projCommons_grid" 
	url="projCommonsService.page" 
	onrender="projCommons_query"
	onselectionchange="projTeams_grid_click"
	onitemdblclick="projCommons_update"
	forceFit="true"
	autoScroll="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
<!--   onitemclick="projTeams_grid_click" -->
	<%@ include file="projCommons_menu.jsp"%>
	<%@ include file="projCommons_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projCommons_columns.jsp"%>
</aos:gridpanel>