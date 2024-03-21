<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="projClientContacts_create_win" 
	title="新增bs_proj_client_contacts"
>
	<aos:formpanel 
		id="projClientContacts_create_form"
	 	width="800"
	  	layout="column" 
	  	labelWidth="100"
	  	msgTarget="qtip"
	>
		<%@ include file="projClientContacts_commons_fields.jsp"%> 
	<aos:fieldset title="项目联系人信息" labelWidth="100" columnWidth="1" border="true">
		<%@ include file="projClientContacts_fields.jsp"%>
	</aos:fieldset>
	
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projClientContacts_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projClientContacts_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>