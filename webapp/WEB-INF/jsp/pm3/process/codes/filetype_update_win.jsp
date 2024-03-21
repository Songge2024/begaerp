<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="filetype_update_win" 
	title="修改过程文件"
>
	<aos:formpanel 
		id="filetype_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	<%@ include file="filetype_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="filetype_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#filetype_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>