<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="checkCatalog_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="checkCatalog_win_show('update');" icon="edit.png" />
	<aos:menuitem text="启用" icon="go.gif"     onclick="checkCatalog_delete(1)"/>
	<aos:menuitem text="停用" icon="stop.gif"   onclick="checkCatalog_delete(0)"/>
	<aos:menuitem text="删除" onclick="checkCatalog_delete(-1)" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#checkCatalog_grid_store.reload();" icon="refresh.png" />
</aos:menu>