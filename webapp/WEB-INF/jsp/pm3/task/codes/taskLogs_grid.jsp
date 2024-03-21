<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="taskLogs_grid" 
	url="taskLogsService.page" 
	onrender="taskLogs_query" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  >
	<aos:selmodel type="checkbox" mode="multi" />
	<%-- <aos:column type="rowno" /> --%>
	<%@ include file="taskLogs_columns.jsp"%>
</aos:gridpanel>
//查询
function taskLogs_query() {
	var params= CurrentTaskGrid.params;
	params.task_id='<%=request.getAttribute("task_id") %>';
	taskLogs_grid_store.getProxy().extraParams = params;
    taskLogs_grid_store.loadPage(1);
}