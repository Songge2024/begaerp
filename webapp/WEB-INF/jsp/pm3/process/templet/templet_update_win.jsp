<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="templet_update_win" 
	title="修改过程模板"
	width="400"
>
	<aos:formpanel 
		id="templet_update_form"
	 	width="400"
	  	layout="anchor" 
	  	labelWidth="80"
	  	center="true"
	>
	<%@ include file="templet_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templet_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templet_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>