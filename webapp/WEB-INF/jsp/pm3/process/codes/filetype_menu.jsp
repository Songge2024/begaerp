<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="filetype_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="filetype_win_show('update');" icon="edit.png" />
	<aos:menuitem text="启用" onclick="filetype_delete('1')" icon="go.gif" />
	<aos:menuitem text="停用" onclick="filetype_delete('0')" icon="stop.gif" />
	<aos:menuitem text="删除" onclick="filetype_delete('-1')" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#filetype_grid_store.reload();" icon="refresh.png" />
</aos:menu>