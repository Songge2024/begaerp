<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="需求信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"
		onclick="demandAction_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png"
		onclick="demandAction_win_show('update');" />
	<aos:dockeditem text="完成" id="complete" icon="ok1.png"
		onclick="demandAction_delete('2')" />
	<aos:dockeditem text="启用" id="enable" icon="go.gif"
		onclick="demandAction_delete('1')" />
	<aos:dockeditem text="停用" id="disable"
		onclick="demandAction_delete('0')" icon="stop.gif" />
	<aos:dockeditem text="作废" icon="del.png"
		onclick="demandAction_delete('9999')" />
	<aos:dockeditem text="生成任务" id="make_task" icon="plugin.png"
		onclick="task_make()" />
	<aos:dockeditem text="查看任务缺陷" id="find_task_qa" icon="query.png"
		onclick="find_task()" />
	<aos:dockeditem text="需求导入"  id="demand_import" icon="up.png" onclick="demand_import_excel"/>
<%-- 	<aos:dockeditem xtype="button" text="上传"   onclick="WBS_show_excel_win"  icon="icon70.png" margin="0 0 0 0"/> --%>
	<aos:dockeditem xtype="button" text="下载导入模板"  onclick="import_excel_upload"  icon="icon70.png" margin="0 0 0 0"/>
	<aos:dockeditem xtype="tbtext" text="选择状态:" />
	<aos:combobox id="combobox_state" width="80" value="4" name="state">
		<aos:option value="4" display="所有" />
		<aos:option value="0" display="未启用" />
		<aos:option value="1" display="已启用" />
		<aos:option value="2" display="已完成"/>
		<aos:option value="9999" display="已作废" />
	</aos:combobox>
	<aos:dockeditem xtype="tbtext" text="需求名称:" />
	<aos:triggerfield emptyText="名称" id="query_form"
		onenterkey="demandAction_query" trigger1Cls="x-form-search-trigger"
		onTrigger1Click="demandAction_query" width="180" />
</aos:docked>

