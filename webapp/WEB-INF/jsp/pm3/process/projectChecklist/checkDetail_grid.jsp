<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="checkDetail_grid" 
	url="checkDetailService.page" 
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  	hidePagebar="true"
  >
	<%@ include file="checkDetail_menu.jsp"%>
	<%@ include file="checkDetail_docked.jsp"%>
	<aos:plugins>
			<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
	</aos:plugins>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="checkDetail_columns.jsp"%>
</aos:gridpanel>