<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="interviewRecords_grid" 
	url="interviewRecordsService.page" 
	onrender="interviewRecords_query" 
	onitemdblclick="interviewRecords_updateWin"
	forceFit="true"
	hidePagebar="true"
	features="summary"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="interviewRecords_menu.jsp"%>
	<%@ include file="interviewRecords_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="interviewRecords_columns.jsp"%>
</aos:gridpanel>