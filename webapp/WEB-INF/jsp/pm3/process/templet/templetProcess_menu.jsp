<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="templetProcess_win_show" icon="add.png" />
	<aos:menuitem text="修改" onclick="templetProcess_update_win_show" icon="edit.png" />
	<aos:menuitem text="删除" onclick="templetProcess_delete" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#templetProcess_grid_store.reload();" icon="refresh.png" />
</aos:menu>