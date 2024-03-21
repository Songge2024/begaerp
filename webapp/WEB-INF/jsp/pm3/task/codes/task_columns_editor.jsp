<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="分组编码" dataIndex="group_id" width="65" hidden="true"/>
<aos:column header="编码" dataIndex="task_id" width="120" hidden="true"/>
<aos:column header="编码" dataIndex="task_code" width="100" align="center"/>
<aos:column header="状态" dataIndex="state" width="65" align="center" rendererFn="render_state" />
<aos:column header="任务名称" dataIndex="task_name" width="300" align="left">
	<aos:textareafield allowBlank="false"/>
</aos:column>
<aos:column header="任务延期状态" dataIndex="task_delay_state" rendererFn="fn_state" width="100" align="center"/>
<aos:column header="指派人" dataIndex="task_desc" width="150" align="center" hidden="true" />
<aos:column header="指派人" dataIndex="assign_user_id" width="100" align="center" rendererFn="renderUser" >
	<aos:combobox allowBlank="false" json="[]" id="task_grid_column_assign_user_id" />
</aos:column>
<aos:column header="处理人" dataIndex="handler_user_id" width="100" align="center" rendererFn="renderUser">
	<aos:combobox allowBlank="false" json="[]" id="task_grid_column_handler_user_id" />
</aos:column>
<aos:column header="关闭人" dataIndex="close_user_id" width="100" align="center" rendererFn="renderUser">
	<aos:combobox allowBlank="false" json="[]" id="task_grid_column_close_user_id" />
</aos:column>
<aos:column header="计划开始时间" dataIndex="plan_begin_time" type="date" width="140" format="Y-m-d H:i" align="center">
	<aos:datetimefield name="plan_begin_time" format="Y-m-d H:i" allowBlank="false"/>
</aos:column>
<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="140" format="Y-m-d H:i" align="center">
	<aos:datetimefield name="plan_end_time" format="Y-m-d H:i" allowBlank="false"/>
</aos:column>
<aos:column header="计划消耗时间" dataIndex="plan_wastage" width="100" align="right">
	<aos:textareafield allowBlank="false"/>
</aos:column>
<aos:column header="完成比例(%)" dataIndex="percent" width="100" align="right" rendererFn="render_percent"/>
<aos:column header="实际开始时间" dataIndex="real_begin_time" width="140" align="center" format="Y-m-d h:i"/>
<aos:column header="实际结束时间" dataIndex="real_end_time" width="140" align="center" format="Y-m-d h:i"/>

<aos:column header="更新时间" dataIndex="update_time" width="140" align="center" format="Y-m-d h:i"/>

<aos:column header="工作量核算天数" dataIndex="real_wastage" width="100" align="right"/>
<aos:column header="任务类型" dataIndex="task_type" width="65" align="center" rendererField="task_type">
	<aos:combobox allowBlank="false" dicField="task_type" dicDataType="char"/>
</aos:column>
<aos:column header="任务等级" dataIndex="task_level" width="65" rendererField="task_level" align="center">
<aos:combobox allowBlank="false" dicField="task_level" dicDataType="char"/>
</aos:column>
<aos:column header="项目" dataIndex="proj_id" width="150"  rendererFn="renderProject" align="left"/>
<aos:column header="需求" dataIndex="demand_id" width="150"  rendererFn="renderDemand" align="left"/>
<aos:column header="模块" dataIndex="module_id" width="150"  rendererFn="renderModule" align="left"/>
<aos:column header="任务描述" dataIndex="task_desc" width="150" align="center" hidden="true" />
<aos:column header="备注" dataIndex="remark" width="150" align="center" hidden="true" />


//初始化下拉数据加载
CurrentTaskPage.on("ready",function(){
	//初始化人员下拉数据
	task_grid_column_assign_user_id_store.loadData(CurrentTaskPage.projectUsers);
	task_grid_column_handler_user_id_store.loadData(CurrentTaskPage.projectUsers);
	task_grid_column_close_user_id_store.loadData(CurrentTaskPage.projectUsers);
});
<script>
	//完成百分比
	function render_percent(value){
		if(value)return value+"%";
		return "0%";
	}
	//拖延状体颜色
	function fn_state(value){
		if(value=='01')return '<span style="color:green">正常</span>'
		if(value=='02')return '<span style="color:red;">延期</span>'
	}
	//状态颜色
	function render_state(value){
		if(value=='1002')return '<span style="color:green;">已发布</span>'
		if(value=='1003')return '<span style="color:blue;">已接收</span>'
		if(value=='1004')return '<span style="color:red;">已完成</span>'
		if(value=='1005')return '<span style="color:gray;">已关闭</span>'
		if(value=='1007')return '<span style="color:#FF00FF;font-weight:bold;">已暂停</span>'
		return "草稿";
	}
	//完成百分比
	function render_percent(value){
		if(value)return value+"%";
		return "0%";
	}
</script>
