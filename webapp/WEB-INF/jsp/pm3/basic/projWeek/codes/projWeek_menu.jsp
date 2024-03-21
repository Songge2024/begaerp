<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="projWeek_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="projWeek_win_show('update');" icon="edit.png" />
	<aos:menuitem text="删除" onclick="projWeek_delete" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#projWeek_grid_store.reload();" icon="refresh.png" />
	<aos:menuitem text="停用" onclick="g_module_upstate" icon="stop.gif" />
	<aos:menuitem text="启用" onclick="g_module_submit" icon="go.gif" />
</aos:menu>