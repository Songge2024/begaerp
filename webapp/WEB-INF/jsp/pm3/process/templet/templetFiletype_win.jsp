<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="templetFiletype_create_win" 
	title="新增输出文档"
	width="400"
>
	<aos:formpanel 
		id="templetFiletype_create_form"
	 	width="400"
	  	layout="anchor" 
	  	labelWidth="90" 
	  	msgTarget="qtip"
	  	center="true"
	>
	<%@ include file="templetFiletype_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templetFiletype_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templetFiletype_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>