<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="下载" onclick="demandActionFile_update" icon="down.png" />
	<aos:menuitem text="删除" onclick="demandActionFile_delete" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#demandActionFile_grid_store.reload();" icon="refresh.png" />
</aos:menu>