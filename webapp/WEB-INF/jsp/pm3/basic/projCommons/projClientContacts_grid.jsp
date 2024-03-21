<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projClientContacts_grid" 
	url="projClientContactsService.page" 
	forceFit="true"
 	region="center"
 	onitemdblclick="projClientContacts_update"
  >
<!--   	onrender="projClientContacts_query"  -->
	<%@ include file="projClientContacts_menu.jsp"%>
	<%@ include file="projClientContacts_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" align="center"/>
	<%@ include file="projClientContacts_columns.jsp"%>
</aos:gridpanel>