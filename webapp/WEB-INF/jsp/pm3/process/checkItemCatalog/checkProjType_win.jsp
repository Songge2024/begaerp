<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkProjType_create_win" 
	title="新增pr_check_proj_type"
>
	<aos:formpanel 
		id="checkProjType_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkProjType_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkProjType_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>