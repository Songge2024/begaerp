<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:window id="demandActionFile_create_win" title="上传文件">
	<aos:formpanel id="demandActionFile_create_form" width="450" layout="anchor" labelWidth="120" msgTarget="qtip">
		<aos:filefield id="demandActionFile_file" name = "demandActionFile_create_file" fieldLabel="文件路径" buttonText="选择" labelWidth="100" allowBlank="false"/>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="demandActionFile_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#demandActionFile_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<%-- <aos:window  --%>
<%-- 	id="demandActionFile_create_win"  --%>
<%-- 	title="新增re_demand_action_file" --%>
<%-- > --%>
<%-- 	<aos:formpanel  --%>
<%-- 		id="demandActionFile_create_form" --%>
<%-- 	 	width="450" --%>
<%-- 	  	layout="anchor"  --%>
<%-- 	  	labelWidth="70" --%>
<%-- 	> --%>
<%-- 	</aos:formpanel> --%>
<%-- 	<aos:docked dock="bottom" ui="footer"> --%>
<%-- 		<aos:dockeditem xtype="tbfill" /> --%>
<%-- 		<aos:dockeditem onclick="demandActionFile_create" text="保存" icon="ok.png" /> --%>
<%-- 		<aos:dockeditem onclick="#demandActionFile_create_win.hide();" text="关闭" icon="close.png" /> --%>
<%-- 	</aos:docked> --%>
<%-- </aos:window> --%>