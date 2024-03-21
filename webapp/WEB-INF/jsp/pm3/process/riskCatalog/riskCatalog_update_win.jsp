<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="riskCatalog_update_win" 
	title="新增风险信息"
>
	<aos:formpanel 
		id="riskCatalog_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="85"
	  	msgTarget="qtip"
	>
	<%@ include file="riskCatalog_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="riskCatalog_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#riskCatalog_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>