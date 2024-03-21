<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projTestVersion_grid" 
	url="projTestVersionService.page" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="projCodeVersion_query"
  	onitemdblclick="projTestVersion_win_show"
  >
	<%@ include file="projTestVersion_menu.jsp"%>
	<%@ include file="projTestVersion_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projTestVersion_columns.jsp"%>
</aos:gridpanel>