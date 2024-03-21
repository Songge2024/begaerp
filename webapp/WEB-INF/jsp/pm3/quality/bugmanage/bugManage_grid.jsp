<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="bugManage_grid" 
	url="bugManageService.page" 
	onrender="bugManage_query" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="bugManage_menu.jsp"%>
	<%@ include file="bugManage_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="bugManage_columns.jsp"%>
</aos:gridpanel>