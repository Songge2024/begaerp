<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="processTemplet_add_win" 
	title="新增项目过程"
>
	<aos:formpanel 
		id="processTemplet_add_form"
	 	width="500"
	  	layout="anchor" 
	  	labelWidth="100"
	  	msgTarget="qtip"
	  	>
	  <%@include file="processTemplet_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="processTemplet_add_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#processTemplet_add_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
	function processTemplet_add_save(){
		var createForm = AOS.getValue('processTemplet_add_form');
		var subdir_id = createForm.process_subdir_id;
		var url = '';
		if(subdir_id==''){
			url ='processService.createAll';
		}else{
			url ='processService.create'
		}
		AOS.ajax({
			forms : processTemplet_add_form,
			url : url,
			ok : function(data) {
				AOS.tip(data.appmsg);
				processCut_grid_store.reload();
				processTemplet_add_win.hide();
			}
		});
	}
</script>