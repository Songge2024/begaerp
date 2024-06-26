<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projTestVersion_update_win" 
	title="修改测试版本号"
>
	<aos:formpanel 
		id="projTestVersion_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	  	msgTarget="qtip"
	  	center="true"
	>
		<%@ include file="projTestVersion_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projTestVersion_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projTestVersion_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>