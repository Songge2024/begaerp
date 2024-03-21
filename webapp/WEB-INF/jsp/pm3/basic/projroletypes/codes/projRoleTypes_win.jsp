<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projRoleTypes_create_win" 
	title="新增项目角色分类"
>
	<aos:formpanel 
		id="projRoleTypes_create_form"
	 	width="450"
	  	layout="column"
	  	msgTarget="qtip"
	  	labelWidth="70"
	>
		<%@ include file="projRoleTypes_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projRoleTypes_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projRoleTypes_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="projRoleTypes_update_win" 
	title="修改项目角色分类"
	onshow="projRoleTypes_win_show"
>
	<aos:formpanel 
		id="projRoleTypes_update_form"
	 	width="450"
	 	msgTarget="qtip"
	layout="column"
	  	labelWidth="70"
	>
		<%@ include file="projRoleTypes_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projRoleTypes_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projRoleTypes_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>