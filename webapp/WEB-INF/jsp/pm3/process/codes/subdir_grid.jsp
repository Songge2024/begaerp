<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="subdir_grid" 
	url="subdirService.page" 
	 
	forceFit="true"
 	region="center"
 	columnWidth="0.4"
  	bodyBorder="1 0 1 0"
  	onitemclick="filetype_query"
  	onitemdblclick="subdir_win_show"
  >
	<%@ include file="subdir_menu.jsp"%>
	<%@ include file="subdir_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="subdir_columns.jsp"%>
</aos:gridpanel>


<!-- onrender="subdir_query" -->
