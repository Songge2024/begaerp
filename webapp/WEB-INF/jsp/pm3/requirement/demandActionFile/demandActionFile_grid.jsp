<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="demandActionFile_grid" 
	url="demandActionFileService.page" 
	forceFit="true"
 	region="south"
 	split="true"
 	height="150"
  	bodyBorder="1 0 1 0"
  >
	<%@ include file="demandActionFile_menu.jsp"%>
	<%@ include file="demandActionFile_docked.jsp"%>
<%-- 	<aos:selmodel type="checkbox" mode="multi" /> --%>
	<aos:column type="rowno" />
	<%@ include file="demandActionFile_columns.jsp"%>
</aos:gridpanel>