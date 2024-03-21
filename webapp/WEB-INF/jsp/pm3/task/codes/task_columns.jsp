<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="分组编码" dataIndex="group_id" fixedWidth="200" hidden="true"/>
<aos:column header="编码" dataIndex="task_id" width="200" hidden="true"/>
<aos:column header="编码" dataIndex="task_code" width="120" />
<aos:column header="状态" dataIndex="state" width="65" align="center" rendererFn="render_state"/>
<aos:column header="任务名称" dataIndex="task_name" width="250" align="left"/>
<aos:column header="指派人" dataIndex="assign_name" width="65" align="center"/>
<aos:column header="处理人" dataIndex="handler_name" width="65" align="center"/>
<aos:column header="计划开始时间" dataIndex="plan_begin_time" width="140" align="center" format="Y-m-d h:i" />
<aos:column header="计划完成时间" dataIndex="plan_end_time" width="140" align="center" format="Y-m-d h:i"/>
<aos:column header="计划消耗时间" dataIndex="plan_wastage" width="65" align="right"/>
<aos:column header="完成比例(%)" dataIndex="percent" width="80" align="right" rendererFn="render_percent"/>
<aos:column header="实际开始时间" dataIndex="real_begin_time" width="140" align="center" format="Y-m-d h:i"/>
<aos:column header="实际完成时间" dataIndex="real_end_time" width="140" align="center" format="Y-m-d h:i"/>
<aos:column header="工作量核算天数" dataIndex="real_wastage" width="65" align="right"/>
<aos:column header="任务类型" dataIndex="task_type" width="65" align="center" rendererField="task_type"/>
<aos:column header="任务等级" dataIndex="task_level" width="65" align="center" rendererField="task_level"/>
<aos:column header="项目" dataIndex="proj_name" width="150" align="left" />
<aos:column header="项目" dataIndex="proj_id" width="150"  align="left" hidden="true"/>
<aos:column header="需求" dataIndex="demand_name" width="150" align="left"/>
<aos:column header="模块" dataIndex="module_name" width="150" align="left"/>

<script>
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
