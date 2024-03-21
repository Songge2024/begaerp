<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="contractStage_create_win" 
	title="新增pr_contract_stage"
>
	<aos:formpanel 
		id="contractStage_create_form"
	 	width="450"
	  	layout="anchor" 
	    labelWidth="73" 
	  	msgTarget="qtip"
	>
	<%@ include file="contractStage_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="contractStage_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#contractStage_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>