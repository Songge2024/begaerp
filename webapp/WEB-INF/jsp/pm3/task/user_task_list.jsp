<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="我的任务" base="http" lib="ext,filter,ueditor">
<%
	//设置视图使用者
	pageContext.setAttribute("showManager", "user");
	//页面初始化数据加载
%>
<%@ include file="../comm/curd.jsp"%> 
<%@ include file="model/TaskPage.jsp"%>
<%@ include file="model/TaskGrid.jsp"%>
<aos:body>
	<div id='myTask_refresh' onclick="myTask_refresh()"></div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	<%@ include file="codes/task_grid.jsp" %>
	</aos:viewport>
	<script>
		var CurrentTaskGrid = new TaskGrid({grid:task_grid});
		CurrentTaskPage.getUserProjects();
		//var task_state = id_task_state.getValue();
    	//var proj_id = id_proj_name.getValue();
		//task_docked_project_combobox_select();

	</script>
</aos:onready>

<script type="text/javascript">
	function myTask_refresh() {
		AOS.get('task_grid').getStore().reload();
	}
</script>