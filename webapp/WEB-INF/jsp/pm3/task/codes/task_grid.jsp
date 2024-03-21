<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//grid 公用配置信息
	//showModel=user||manager
	String showManager = (String) pageContext.getAttribute("showManager");
	String task_page_url = showManager.equals("user") ? "taskService.selectMyTaskPage" : "taskService.selectManagerTaskPage";
	//String task_grid_autoLoad = showManager.equals("user") ? "true" : "false";
%>
<aos:gridpanel 
	id="task_grid" 
	url="<%=task_page_url%>" 
	autoScroll="true"
	split="true" 
	region="center" 
	columnLines="true" 
	bodyBorder="0 0 1 0"
	forceFit="false"
	autoLoad="false"
	onitemdblclick="task_grid_dbclick"
>
	<%
		//引入使用者操作按钮
		if (showManager.equals("user")) {
	%>
		<%@ include file="task_docked.jsp" %>
		<%-- <%@ include file="task_menu.jsp"%> --%>
		<aos:selmodel type="checkbox" mode="multi" />
		<aos:column type="rowno" />
		<%@ include file="task_columns.jsp" %>
	<%
		} else {
		//引入管理者操作按钮
	%>
		<aos:plugins>
			<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1" onbeforeedit="onbeforeedit"/>
		</aos:plugins>
		<%@ include file="task_docked_manager.jsp" %>
		<aos:selmodel type="checkbox" mode="multi" />
		<aos:column type="rowno" width="40"/>
		<%@ include file="task_columns_editor.jsp" %>
	<%
		}
	%>
	
</aos:gridpanel>

<script type="text/javascript">

	//表格双击事件响应
	function task_grid_dbclick(grid, record) {
		//var src="do.jhtml?router=taskService.viewInit&juid=<%=request.getAttribute("juid") %>&task_id="+record.get("task_id");
		//task_showdetail.show();
		//task_showdetail.maximize();
		//task_showdetail.update("<iframe src='"+src+"' width='100%'  height='100%'></iframe>");
	    //	var aa  =  record.get("task_desc");
	    //	AOS.tip(aa);
		
	    var task_desc =  record.raw.task_desc ;  
		var remark  =  record.raw.remark
		//AOS.tip(task_desc);
		//AOS.tip(remark); 
		var manager = '${showManager}'
		if ('${showManager}' === 'user') {
			window.open('do.jhtml?router=taskService.myTaskViewInit&juid=<%=request.getAttribute("juid") %>&task_id='+record.get("task_id")+'&proj_id='+record.get("proj_id")+'&task_code='+record.data.task_code+'&task_name='+record.data.task_name);
		}else{
		  	window.open('do.jhtml?router=taskService.taskViewInit&juid=<%=request.getAttribute("juid") %>&task_id='+record.get("task_id")+'&proj_id='+record.get("proj_id")+'&task_code='+record.data.task_code+'&task_name='+record.data.task_name);
		}
	}
</script>
