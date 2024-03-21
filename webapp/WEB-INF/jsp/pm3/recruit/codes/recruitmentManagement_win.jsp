<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="recruitmentManagement_create_win" 
	title="新增招聘信息"
	autoScroll="false"
>
	<aos:formpanel 
		id="recruitmentManagement_create_form"
	 	width="700"
	  	layout="column" 
	  	height="160"
	  	labelWidth="90"
	>
	<%@include file="recruitmentManagement_fields.jsp"  %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruitmentManagement_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruitmentManagement_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="recruitmentManagement_update_win" 
	title="修改招聘信息"
	autoScroll="false"
>
	<aos:formpanel 
		id="recruitmentManagement_update_form"
	 	width="700"
	 	height="160"
	  	layout="column" 
	  	labelWidth="90"
	>
	<%@include file="recruitmentManagement_fields.jsp"  %>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruitmentManagement_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruitmentManagement_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
