<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractPayInfo_grid" 
	url="contractPayInfoService.page" 
	hidePagebar="true"
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemdblclick="contractPayInfo_win_show"
  >
  <!-- onrender="contractPayInfo_query"  -->
	<%@ include file="contractPayInfo_menu.jsp"%>
	<%@ include file="contractPayInfo_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="contractPayInfo_columns.jsp"%>
</aos:gridpanel>