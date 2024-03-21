<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkItem_update_win" 
	title="修改检查项明细"
>
	<aos:formpanel 
		id="checkItem_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	  	msgTarget="qtip"
	  	center="true"
	>
	<%@ include file="checkItem_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkItem_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkItem_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>