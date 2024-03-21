<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="recruitmentManagement_grid" 
	url="recruitmentManagementService.page" 
	onrender="recruitmentManagement_query" 
	onitemdblclick="recruitwin_show"
	onitemclick="interview_show"
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="recruitmentManagement_menu.jsp"%>
	<%@ include file="recruitmentManagement_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="recruitmentManagement_columns.jsp"%>
</aos:gridpanel>