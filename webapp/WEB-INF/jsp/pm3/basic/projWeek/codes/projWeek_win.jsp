<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projWeek_create_win" 
	title="新增项目周"
>
	<aos:formpanel 
		id="projWeek_create_form"
	 	width="650"
	  	layout="column" 
	  	labelWidth="70"
	  	msgTarget="qtip"
	>
		<%@ include file="projWeek_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projWeek_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projWeek_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="projWeek_update_win" 
	title="修改项目周"
>
	<aos:formpanel 
		id="projWeek_update_form"
	 	width="650"
	  	layout="column" 
	  	labelWidth="70"
	  	msgTarget="qtip"
	>
		<%@ include file="projWeek_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projWeek_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projWeek_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>