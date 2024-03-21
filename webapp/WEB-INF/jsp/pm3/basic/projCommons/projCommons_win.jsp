<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="projCommons_create_win" title="项目基础信息维护">
	<aos:formpanel id="projCommons_create_form" width="800" layout="column"
		labelWidth="120" msgTarget="qtip">
		<%@ include file="projCommons_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projCommons_create" id="projCommons_create_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projCommons_create_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>