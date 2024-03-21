<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="task_update_win" 
	title="修改任务"
	width="800"
	height="600"
	layout="anchor" 
	autoScroll="true"
	draggable="false"
	
>
	<aos:formpanel 
		id="task_update_form" 
		layout="column" 
		labelWidth="90" 
		margin="5" 
		anchor="100%" 
		autoScroll="true" 
		border="false"
	>
	<%@ include file="task_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="task_update_win_save_button_click" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#task_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
	//初始化表格基础数据

	function task_update_win_save_button_click(){
	
	}
</script>
