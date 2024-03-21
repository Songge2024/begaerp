<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="recruiterInformation_create_win" 
	title="新增招聘人员信息"
>
	<aos:formpanel 
		id="recruiterInformation_create_form"
	  	layout="column" 
	  	width="800"
	  	msgTarget="qtip"
	  	labelWidth="100"
	>
	<%@ include file="recruiterInformation_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruiterInformation_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruiterInformation_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="recruiterInformation_update_win" 
	title="修改招聘人员信息"
>
	<aos:formpanel 
		id="recruiterInformation_update_form"
	  	layout="column" 
	  	width="800"
	  	msgTarget="qtip"
	  	labelWidth="100"
	>
	<%@ include file="recruiterInformation_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruiterInformation_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruiterInformation_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>