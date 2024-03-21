<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projCodeVersion_update_win" 
	title="修改代码版本号"
>
	<aos:formpanel 
		id="projCodeVersion_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="80"
	  	center="true"
	  	msgTarget="qtip"
	>
	<%@ include file="projCodeVersion_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projCodeVersion_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projCodeVersion_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>