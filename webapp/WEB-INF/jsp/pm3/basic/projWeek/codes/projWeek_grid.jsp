<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projWeek_grid" 
	url="projWeekService.page" 
	forceFit="true"
 	region="center"
 	onitemdblclick="projWeek_win_show"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="projWeek_menu.jsp"%>
	<%@ include file="projWeek_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projWeek_columns.jsp"%>
</aos:gridpanel>