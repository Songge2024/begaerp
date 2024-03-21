<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkCatalog_create_win" 
	title="新增检查项"
>
	<aos:formpanel 
		id="checkCatalog_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="80"
	>
	<%@ include file="checkCatalog_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkCatalog_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkCatalog_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>