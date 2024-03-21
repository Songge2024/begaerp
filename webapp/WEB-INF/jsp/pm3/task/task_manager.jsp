<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="任务管理" base="http" lib="ext,ueditor">
<%
	pageContext.setAttribute("showManager", "manager");
%>
<aos:body>
<%@ include file="../comm/curd.jsp"%>
<%@ include file="model/TaskPage.jsp"%>
<%@ include file="model/TaskGrid.jsp"%>
<%@ include file="model/TaskGroupTree.jsp"%>
	<div id="theme_list" style="width:100% ; height: 98%;border: 0;">
		<iframe id="theme_iframe" style="border: 5; width:100% ; height: 100%" src="do.jhtml?router=themeService.init&juid=${juid}&theme_type=task&refrence_id=<%=request.getAttribute("task_id") %>"></iframe>
	</div>
	<div id="task_desc_div" style="width:100% ; height: 98%; border: 1; ">
		<script type="text/plain" id="task_desc_editor" style="text-align: left; height:150px!important;"></script>
	</div>
	<div id="task_remark_div">
		<script type="text/plain" id="task_remark_editor" style="text-align: left; margin-top:5px; width:75%;height:150px;"></script>
	</div>
	<div id='taskPage_refresh' onclick="task_refresh()"></div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" frame="true">
		<aos:panel region="west" width="420" collapsible="true">
			if(AOS.empty('${id}')){
				<%@ include file="codes/taskGroup_tree.jsp" %>
			}else{
				<%@ include file="codes/taskGroup_treeShow.jsp" %>
			}
		</aos:panel>
		<aos:panel region="center" layout="border" border="true">
			<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
<%-- 				<aos:formpanel id="f_query"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" > --%>
				<aos:formpanel id="f_query" layout="column" labelWidth="100" header="false" border="false" anchor= "100%">
					<aos:docked forceBoder="0 0 1 0">
						<aos:dockeditem xtype="tbtext" text="查询条件" />
					</aos:docked>
					<aos:textfield emptyText="处理人查询" fieldLabel="处理人" name="handler_user" id="id_handler_user"
								columnWidth="0.2"  labelWidth="80" width="150"/>
					<aos:textfield emptyText="指派人查询" fieldLabel="指派人" name="assign_user" id="id_assign_user"
								columnWidth="0.2"  labelWidth="80" width="150"/>
				 	<aos:combobox id="task_delay_state_form" name="task_delay_state" width="160" fieldLabel="任务延期状态" labelWidth="90" columnWidth="0.2">
							<aos:option value="01" display="正常" />
							<aos:option value="02" display="延期" />
					</aos:combobox>
					<aos:textfield  id="task_query_form" emptyText="任务名称/编码查询" fieldLabel="任务名称" labelWidth="90" selectOnFocus="false" width="100" columnWidth="0.2"/>
					<aos:combobox  id="id_task_states" name="task_states" width="100" fieldLabel="任务状态" labelWidth="60" value="1000" columnWidth="0.2">
						<aos:option value="all"  display="所有"  />
						<aos:option value="1000" display="未关闭" />
						<aos:option value="1001" display="草稿"  />
						<aos:option value="1002" display="已发布" />
						<aos:option value="1003" display="已接收" />
						<aos:option value="1004" display="已完成" />
						<aos:option value="1005" display="已关闭" />
						<aos:option value="1007" display="已暂停" />
					</aos:combobox>
					<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
						<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem xtype="button" text="查询" onclick="select_task_query" icon="query.png" margin="0 5 0 5"/>
							<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query);" icon="refresh.png"  margin="0 5 0 5" />
						<aos:dockeditem xtype="tbfill" />
					</aos:docked>
				</aos:formpanel>
			</aos:panel>
			<%@ include file="codes/task_grid.jsp" %>
		</aos:panel>
	</aos:viewport>
	var CurrentTaskGroupTree = new TaskGroupTree({tree:taskGroup_tree});
	var CurrentTaskGrid = new TaskGrid({grid:task_grid});
	CurrentTaskPage.getUserProjects();
	function onbeforeedit(){
		return false;
	}
	var task_desc_editor,task_remark_editor;
	<script type="text/javascript">
	//查询按钮
	function select_task_query(){
		 var task_handler_user_name = AOS.getValue('id_handler_user');
		 var task_assign_user_name = AOS.getValue('id_assign_user');
		 var task_query_pa = AOS.getValue('task_query_form');
		 var task_delay_state_pa = AOS.getValue('task_delay_state_form');
		 var task_states = AOS.getValue('id_task_states');
		//选择所有
    	 if(task_states =='all'){
    		 task_states = '1001,1002,1003,1004,1005,1007';
    	 }
    	 //选择未关闭的
    	 if(task_states == '1000'){
    		 task_states = '1001,1002,1003,1004,1007';
    	 }
		 CurrentTaskGrid.reload({
				query_pa : task_query_pa,
				handler_user_name : task_handler_user_name,
				assign_user_name : task_assign_user_name,
				task_delay_state : task_delay_state_pa,
				task_states : task_states
			});
	}
	</script>
</aos:onready>

<script type="text/javascript">
	function task_refresh() {
		AOS.get('task_grid').getStore().reload();
	}
</script>
