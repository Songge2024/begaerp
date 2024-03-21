<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="interviewRecords_create_win" 
	title="新增面试记录"
>
	<aos:formpanel 
		id="interviewRecords_create_form"
	 	width="500"
	 	height="400"
	 	autoScroll="false"
	 	msgTarget="qtip"
	  	layout="column" 
	  	labelWidth="85"
	>
	<%@ include file="interviewRecords_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="interviewRecords_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#interviewRecords_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="interviewRecords_update_win" 
	title="修改面试记录"
>
	<aos:formpanel 
		id="interviewRecords_update_form"
	 	width="500"
	 	msgTarget="qtip"
	 	height="400"
	 	autoScroll="false"
	  	layout="column" 
	  	labelWidth="85"
	>
	<%@ include file="interviewRecords_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="interviewRecords_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#interviewRecords_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>