<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="processFiletype_add_win" 
	title="新增输出文档"
>
	<aos:formpanel 
		id="processFiletype_add_form"
	 	width="400"
	  	layout="anchor" 
	  	labelWidth="90"
	  	msgTarget="qtip"
	  	>
	  <%@include file="processFiletype_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="processFiletype_add_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#processFiletype_add_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
	function processFiletype_add_save(){
		AOS.ajax({
			forms : processFiletype_add_form,
			url : 'processFiletypeService.create',
			ok : function(data) {
				AOS.tip(data.appmsg);
				processCutFiletype_grid_store.reload();
				processFiletype_add_win.hide();
			}
		});
	}
</script>