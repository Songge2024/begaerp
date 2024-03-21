<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="templet_create_win" 
	title="新增过程模板"
	width="400"
>
	<aos:formpanel 
		id="templet_create_form"
	 	width="400"
	  	layout="anchor"
	  	labelWidth="70"
	  	msgTarget="qtip"
	  	center="true"
	>
	<%@ include file="templet_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templet_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templet_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">

//新增
function templet_create() {
	AOS.ajax({
		forms : templet_create_form,
		url : 'templetMainService.create',
		ok : function(data) {
			AOS.tip("新增成功!");
			templet_grid_store.reload();
			templet_create_win.hide();
		}
	});
}
</script>