<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>



<aos:gridpanel 
	id="workHour_grid" 
	url="workHourService.page" 
	onrender="workHour_query" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="workHour_menu.jsp"%>
	<%@ include file="workHour_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="workHour_columns.jsp"%>
</aos:gridpanel>