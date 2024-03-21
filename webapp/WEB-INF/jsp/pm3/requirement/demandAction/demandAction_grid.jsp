<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel id="demandAction_grid" url="demandActionService.page"
	onitemdblclick="demandAction_update"
	onselectionchange="demandActionFile_query" forceFit="false"
	region="center" bodyBorder="1 0 1 0">
	<%@ include file="demandAction_menu.jsp"%>
	<%@ include file="demandAction_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" header="序号" align="center" fixedWidth="35"/>
	<%@ include file="demandAction_columns.jsp"%>
</aos:gridpanel>