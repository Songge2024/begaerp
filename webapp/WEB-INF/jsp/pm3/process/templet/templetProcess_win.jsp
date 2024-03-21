<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="templetProcess_create_win" 
	title="新增/修改"
>
	<aos:formpanel 
		id="templetProcess_create_form"
	 	width="500"
	  	layout="anchor" 
	  	labelWidth="100"
	  	msgTarget="qtip"
	>
	<%@ include file="templetProcess_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templetProcess_createSave" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templetProcess_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>