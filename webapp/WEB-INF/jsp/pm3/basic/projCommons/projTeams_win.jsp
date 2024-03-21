<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projTeams_create_win" 
	title="新增bs_proj_teams"
>
	<aos:formpanel 
		id="projTeams_create_form"
	 	width="800"
	  	layout="column" 
	  	labelWidth="120"
	  	msgTarget="qtip"
	>
		<%@ include file="projCommons_fields_readOnly.jsp"%>
	<aos:fieldset title="项目团队信息" labelWidth="100" columnWidth="1" border="true">
		<%@ include file="projTeams_fields.jsp"%>
	</aos:fieldset>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projTeams_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projTeams_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>