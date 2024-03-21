<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkMain_update_win" 
	title="修改QA检查单类型"
>
	<aos:formpanel 
		id="checkMain_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="checkMain_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#checkMain_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>