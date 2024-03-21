<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="preservePoint_update_win" 
	title="修改扣分标准"
>
	<aos:formpanel 
		id="preservePoint_update_form"
	 	width="450"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	<%@ include file="preservePoint_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="preservePoint_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#preservePoint_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>