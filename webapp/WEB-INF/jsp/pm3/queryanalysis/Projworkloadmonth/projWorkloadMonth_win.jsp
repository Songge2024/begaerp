<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projWorkloadMonth_create_win" 
	title="新增st_proj_workload_month"
>
	<aos:formpanel 
		id="projWorkloadMonth_create_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projWorkloadMonth_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projWorkloadMonth_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>