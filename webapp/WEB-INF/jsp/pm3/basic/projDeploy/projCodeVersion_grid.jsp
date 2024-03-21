<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projCodeVersion_grid" 
	url="projCodeVersionService.page"  
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemdblclick="projCodeVersion_win_show"
  >
	<%@ include file="projCodeVersion_menu.jsp"%>
	<%@ include file="projCodeVersion_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projCodeVersion_columns.jsp"%>
</aos:gridpanel>

