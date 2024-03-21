<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="filetype_grid" 
	url="filetypeService.page" 
	forceFit="true"
	columnWidth="0.4"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemdblclick="filetype_win_show"
  >
	<%@ include file="filetype_menu.jsp"%>
	<%@ include file="filetype_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="filetype_columns.jsp"%>
</aos:gridpanel>


<!-- onrender="filetype_query" -->
