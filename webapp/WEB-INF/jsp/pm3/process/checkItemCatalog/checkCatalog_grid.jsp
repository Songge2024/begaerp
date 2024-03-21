<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="checkCatalog_grid" 
	url="checkCatalogService.page" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="checkItem_query"
  	onitemdblclick="checkCatalog_win_show"
  >
	<%@ include file="checkCatalog_menu.jsp"%>
	<%@ include file="checkCatalog_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="checkCatalog_columns.jsp"%>
</aos:gridpanel>