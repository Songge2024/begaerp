<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkCatalog_update_win" 
	title="修改检查项目录"
>
	<aos:formpanel 
		id="checkCatalog_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	  	msgTarget="qtip"
	  	center="true"
	>
	<%@ include file="checkCatalog_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkCatalog_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkCatalog_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>