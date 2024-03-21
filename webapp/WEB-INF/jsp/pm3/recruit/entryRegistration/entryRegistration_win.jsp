<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="entryRegistration_create_win" 
	title="新增入职信息"
	 width="700"
>
	<aos:formpanel 
		id="entryRegistration_create_form"
	 	height="400"
	 	autoScroll="false"
	  	layout="column" 
	  	labelWidth="100"
	  	msgTarget="qtip"
	>
	<%@ include file="entryRegistration_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="entryRegistration_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#entryRegistration_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<aos:window 
	id="entryRegistration_update_win" 
	title="修改入职信息"
	width="700"
>
	<aos:formpanel 
		id="entryRegistration_update_form"
	 	height="400"
	 	autoScroll="false"
	  	layout="column" 
	  	labelWidth="85"
	  	msgTarget="qtip"
	>
	<%@ include file="entryRegistration_fields.jsp" %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="entryRegistration_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#entryRegistration_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>