<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel id="projMilestone_grid" url="projMilestoneService.page"
	onrender="projMilestone_query" onitemdblclick="projMilestone_win_show"
	region="center" forceFit="true" bodyBorder="1 0 1 0">
	<%@ include file="projMilestone_menu.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projMilestone_columns.jsp"%>
</aos:gridpanel>