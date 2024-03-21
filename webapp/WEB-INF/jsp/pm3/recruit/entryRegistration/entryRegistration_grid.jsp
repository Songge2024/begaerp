<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="entryRegistration_grid" 
	url="entryRegistrationService.page" 
	forceFit="true"
	hidePagebar="true"
	columnLines="true"
  	bodyBorder="1 0 1 0"
  	features="summary"
 	region="center"
  >
	<%@ include file="entryRegistration_menu.jsp"%>
	<%@ include file="entryRegistration_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="entryRegistration_columns.jsp"%>
</aos:gridpanel>