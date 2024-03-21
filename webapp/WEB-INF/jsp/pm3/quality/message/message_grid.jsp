<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="message_grid" 
	url="messageService.page" 
	onrender="message_query" 
	onitemdblclick="message_grid_click_"
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="message_menu.jsp"%>
	<%@ include file="message_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="message_columns.jsp"%>
</aos:gridpanel>