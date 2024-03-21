<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="bsProjContract_grid" 
	url="bsProjContractService.page" 
	onrender="bsProjContract_query" 
	forceFit="true"
 	region="center"
 	autoLoad="false"
  	bodyBorder="1 0 1 0"
  	onitemclick="bsProjContract_grid_click"
  >
	<%@ include file="bsProjContract_menu.jsp"%>
	<%@ include file="bsProjContract_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="bsProjContract_columns.jsp"%>
</aos:gridpanel>