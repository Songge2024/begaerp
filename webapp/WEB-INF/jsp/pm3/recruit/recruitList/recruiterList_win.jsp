<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="recruiterlist_create_win" 
	title="新增招聘人员信息"
>
	<aos:formpanel 
		id="recruiterlist_create_form"
	  	layout="column" 
	  	width="800"
	  	msgTarget="qtip"
	  	labelWidth="100"
	>
	<%@ include file="recruiterList_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruiterlist_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruiterlist_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window 
	id="recruiterList_update_win" 
	title="修改招聘人员信息"
>
	<aos:formpanel 
		id="recruiterlist_update_form"
	  	layout="column" 
	  	width="800"
	  	msgTarget="qtip"
	  	labelWidth="100"
	>
	<%@ include file="recruiterList_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="recruiterlist_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#recruiterlist_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>