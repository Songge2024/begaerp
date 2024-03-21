<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="recruiterlist_grid" 
	url="recruiterResultService.page" 
	onrender="recruiterlist_query" 
	forceFit="false"
	onitemdblclick="recruiterlist_win_update"
	hidePagebar="true"
	features="summary"
	columnLines="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%--  <%@ include file="recruiterList_menu.jsp"%> --%>
	<%@ include file="recruiterList_docked.jsp"%> 
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="recruiterList_columns.jsp"%>
</aos:gridpanel>