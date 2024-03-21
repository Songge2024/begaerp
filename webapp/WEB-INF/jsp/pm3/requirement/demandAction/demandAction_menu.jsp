<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="demandAction_win_show('create');"
		icon="add.png" />
	<aos:menuitem text="修改" onclick="demandAction_win_show('update');"
		icon="edit.png" />
	<aos:menuitem text="完成" id="men_complete"
		onclick="demandAction_delete('2')" icon="ok1.png" />
	<aos:menuitem text="启用" id="men_enable"
		onclick="demandAction_delete('1')" icon="go.gif" />
	<aos:menuitem text="停用" id="men_disable"
		onclick="demandAction_delete('0')" icon="stop.gif" />
	<aos:menuitem text="作废" onclick="demandAction_delete('9999')"
		icon="del.png" />
	<aos:menuitem text="生成任务" id="men_make_task" icon="plugin.png"
		onclick="task_make()" />
	<aos:menuitem text="查看任务缺陷" id="men_find_task_qa" icon="query.png"
		onclick="find_task()" />
	<aos:menuitem text="上传文件" onclick="demandActionFile_win_show();"
		icon="add.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#demandAction_grid_store.reload();"
		icon="refresh.png" />
</aos:menu>