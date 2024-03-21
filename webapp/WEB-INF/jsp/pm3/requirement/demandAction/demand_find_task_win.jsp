<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="demand_find_task_win" title="任务缺陷列表" width="800"
	height="600"  autoScroll="true" draggable="false">
	<aos:panel layout="anchor" >
	<aos:gridpanel id="demand_task_find_grid" bodyBorder="1 0 1 0" hidePagebar="true"
		forceFit="false" url="demandActionService.findTask"
		anchor="100% 50%">
		<aos:docked forceBoder="1 0 1 0">
			<aos:dockeditem xtype="tbtext" text="任务明细" />
			<aos:dockeditem xtype="tbseparator" />
		</aos:docked>
		<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
		<!-- 显示内容 -->
		<aos:column header="任务编码" dataIndex="task_code" width="100" align="center"/>
		<aos:column header="任务名称" dataIndex="task_name" width="180" align="center"/>
		<aos:column header="当前状态" dataIndex="state" width="100" align="center"  rendererFn="fn_task_state"/>
		<aos:column header="关联模块" dataIndex="dm_name" width="120" align="center"/>
		<aos:column header="计划开始时间" dataIndex="plan_begin_time" width="180" align="center"/>
		<aos:column header="计划完成时间" dataIndex="plan_end_time" width="180" align="center"/>
		<aos:column header="计划消耗天数" dataIndex="plan_wastage" width="120" align="center"/>
		<aos:column header="任务类型" dataIndex="task_type" width="100" align="center"
			rendererField="task_type" />
		<aos:column header="优先级" dataIndex="task_level" width="60" align="center"
			rendererField="task_level" />
		<aos:column header="处理人" dataIndex="deal_man_name" width="120" align="center"/>
		<aos:column header="指派人" dataIndex="create_name" width="120" align="center"/>

	</aos:gridpanel>
	<aos:gridpanel id="demand_bug_find_grid" bodyBorder="1 0 1 0" hidePagebar="true" url="demandActionService.findBug"
		forceFit="false"
		anchor="100% 50%" >
		<aos:docked forceBoder="1 0 1 0">
			<aos:dockeditem xtype="tbtext" text="缺陷明细" />
			<aos:dockeditem xtype="tbseparator" />
		</aos:docked>
		<aos:column type="rowno" header="序号" align="center" fixedWidth="35"/>
				<!-- 显示的列 -->
				<aos:column header="缺陷编码" dataIndex="bug_code" width="130"
					align="center" />
				<aos:column header="缺陷名称" dataIndex="bug_name" width="200" />
				<aos:column header="当前状态" dataIndex="state" width="100"
					align="center"  rendererFn="fn_bug_state"/>
				<aos:column header="关联模块" dataIndex="dm_name" width="100" align="center" />
				<aos:column header="缺陷位置" dataIndex="bug_addr" width="100"
					rendererField="bug_addr" align="center" />
				<aos:column header="优先级" dataIndex="priority" width="60"
					align="center" rendererField="bug_priority" />
				<aos:column header="严重程度" dataIndex="severity" width="80"
					align="center"  rendererField="bug_severity"/>
				<aos:column header="类型" dataIndex="bug_type" width="50"
					align="center" rendererField="bug_type" />
				<aos:column header="出现频率" dataIndex="rate" width="100"
					align="center" rendererField="bug_rate" />
				<aos:column header="来源方" dataIndex="source" width="100"
					align="center" rendererField="bug_source" />
				<aos:column header="发现人" dataIndex="find_name" width="100"
					align="center" />
				<aos:column header="创建人" dataIndex="bug_create_name" width="100"
					align="center" />
				<aos:column header="处理人" dataIndex="deal_man_name" width="100"
					align="center" />
				<aos:column header="发现时间" dataIndex="find_time" width="150"
					align="center" />
				<aos:column header="关闭人" dataIndex="close_name" width="100"
					align="center" />
				<aos:column header="关闭时间" dataIndex="close_time" width="150"
					align="center" />

	</aos:gridpanel>
	</aos:panel>


	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="#demand_find_task_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">


//缺陷状态渲染
function fn_bug_state(value, metaData, record){
	if(value =='1000'){
		return "<span >未解决</span>"; 
	}else if(value == '1002'){
		return "<span style='color:blue; font-weight:bold'>延期处理</span>"; 
	}else if(value == '1004'){
		return "<span style='color:red; font-weight:bold'>拒绝</span>"; 
	}else if(value == '1001'){
		return "<span style='color:green; font-weight:bold'>已解决</span>"; 
	}else if(value == '1003'){
		return "<span style='font-weight:bold'>关闭</span>"; 
	}
}

//任务状态渲染
function fn_task_state(value, metaData, record){
	if(value =='1001'){
		return "<span >草稿</span>"; 
	}else if(value == '1002'){
		return "<span style='color:green; font-weight:bold'>已发布</span>"; 
	}else if(value == '1003'){
		return "<span style='color:blue; font-weight:bold'>已接收</span>"; 
	}else if(value == '1004'){
		return "<span style='color:red; font-weight:bold'>已完成</span>"; 
	}else if(value == '1005'){
		return "<span style='font-weight:bold'>关闭</span>"; 
	}
}

	
</script>
