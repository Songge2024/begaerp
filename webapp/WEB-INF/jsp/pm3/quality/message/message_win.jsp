<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="message_create_win" 
	title="新增消息"
	height="400"
>
	<aos:formpanel 
		id="message_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	<%@ include file="message_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="message_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#message_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
