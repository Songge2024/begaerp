<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目角色分类维护" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="projRoleTypes_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="projRoleTypes_win_show('update');" hidden="true"/>
	<aos:dockeditem text="删除" icon="del.png"    onclick="projRoleTypes_delete" hidden="true"/>
	<aos:dockeditem text="停用" icon="stop.gif"    onclick="ProjRoleTypes_upstate" hidden="true"/>
	<aos:dockeditem text="启用" icon="go.gif"    onclick="submitProjRoleTypes" />
	<aos:triggerfield emptyText="项目角色名称" id="query_form" onenterkey="projRoleTypes_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="projRoleTypes_query" width="180" />
</aos:docked>