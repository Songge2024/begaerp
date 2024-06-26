<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="新增" onclick="projRoleTypes_win_show('create');" icon="add.png" />
	<aos:menuitem text="修改" onclick="projRoleTypes_win_show('update');" icon="edit.png" hidden="true"/>
	<aos:menuitem text="删除" onclick="projRoleTypes_delete" icon="del.png" hidden="true"/>
	<aos:menuitem text="停用" icon="stop.gif"    onclick="ProjRoleTypes_upstate" hidden="true"/>
	<aos:menuitem text="启用" icon="go.gif"    onclick="submitProjRoleTypes" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#projRoleTypes_grid_store.reload();" icon="refresh.png" />
</aos:menu>