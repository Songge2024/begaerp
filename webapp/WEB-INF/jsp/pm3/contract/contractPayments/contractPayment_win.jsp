<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="contractPayment_create_win" 
	title="新增回款信息"
	width="800"
	center="true"
>
	<aos:formpanel 
		id="contractPayment_create_form"
	  	layout="column" 
	  	labelWidth="90"
	  	msgTarget="qtip"
	>
	<%@ include file="contractPayment_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="contractPayment_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#contractPayment_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>