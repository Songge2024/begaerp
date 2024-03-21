<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="notice_create_win" 
	title="面试通知"
>
	<aos:formpanel 
		id="notice_create_form"
	 	width="500"
	 	height="300"
	 	autoScroll="false"
	 	msgTarget="qtip"
	  	layout="column" 
	  	labelWidth="90"
	>
	<%@ include file="notice_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="notice_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#notice_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

