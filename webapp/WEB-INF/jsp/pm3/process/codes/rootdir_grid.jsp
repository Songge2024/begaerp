<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="rootdir_grid" 
	url="rootdirService.page" 
	onrender="rootdir_query"
	forceFit="true"
	columnWidth="0.3"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="subdir_query"
  	onitemdblclick="rootdir_win_show"
  >
	<%@ include file="rootdir_menu.jsp"%>
	<%@ include file="rootdir_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="rootdir_columns.jsp"%>
</aos:gridpanel>
