<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="contractPayInfo_create_win" 
	title="新增回款信息"
>
	<aos:formpanel 
		id="contractPayInfo_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	<%@ include file="contractPayInfo_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="contractPayInfo_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#contractPayInfo_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>