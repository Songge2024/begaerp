<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projVersion_grid" 
	url="projVersionService.page" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="projTestVersion_query"
  	onitemdblclick="projVersion_win_show"
  >
	<%@ include file="projVersion_menu.jsp"%>
	<%@ include file="projVersion_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projVersion_columns.jsp"%>
</aos:gridpanel>

