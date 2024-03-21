<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="修改" onclick="checkDetail_win_show('update');" icon="edit.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#checkDetail_grid_store.reload();" icon="refresh.png" />
</aos:menu>