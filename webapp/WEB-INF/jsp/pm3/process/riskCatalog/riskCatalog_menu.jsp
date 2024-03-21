<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="riskCatalog_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="riskCatalog_win_show('update');" icon="edit.png" />
	<aos:menuitem text="启用" icon="go.gif"    onclick="riskCatalog_enable" />
	<aos:menuitem text="停用" icon="stop.gif"   onclick="riskCatalog_disable" />
	<aos:menuitem text="删除" onclick="riskCatalog_delete" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#riskCatalog_grid_store.reload();" icon="refresh.png" />
</aos:menu>