<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="riskList_create_win" 
	title="新增项目风险信息"
	center ="true"
>
	<aos:formpanel 
		id="riskList_create_form"
	  	layout="column" 
	  	labelWidth="90"
	  	width="800"
	  	msgTarget="qtip"
	>
	<%@ include file="riskList_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="riskList_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#riskList_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>