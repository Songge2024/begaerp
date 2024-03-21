<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projRoleTypes_grid" 
	url="projRoleTypesService.page" 
	onrender="projRoleTypes_query" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="projRoleTypes_menu.jsp"%>
	<%@ include file="projRoleTypes_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projRoleTypes_columns.jsp"%>
</aos:gridpanel>