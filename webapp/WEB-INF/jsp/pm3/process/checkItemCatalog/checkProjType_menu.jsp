<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="checkProjType_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="checkProjType_win_show('update');" icon="edit.png" />
	<aos:menuitem text="删除" onclick="checkProjType_delete" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#checkProjType_grid_store.reload();" icon="refresh.png" />
</aos:menu>