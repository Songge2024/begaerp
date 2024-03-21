<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="checkItem_grid" 
	url="checkItemService.page" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemdblclick="checkItem_win_show"
  >
	<%@ include file="checkItem_menu.jsp"%>
	<%@ include file="checkItem_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="checkItem_columns.jsp"%>
</aos:gridpanel>