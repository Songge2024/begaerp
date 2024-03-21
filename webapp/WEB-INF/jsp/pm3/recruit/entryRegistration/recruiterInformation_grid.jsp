<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="recruiterInformation_grid" 
	url="recruiterInformationService.page" 
	onrender="recruiterInformation_query"
	forceFit="false"
	hidePagebar="true"
	onitemclick="recruiterInformation_itemquery"
	features="summary"
	width="600"
 	region="west"
 	columnLines="true"
  	bodyBorder="1 1 1 0"
  >
<%@ include file="recruiterInformation_menu.jsp"%>
	<%@ include file="recruiterInformation_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="recruiterInformation_columns.jsp"%>
</aos:gridpanel>