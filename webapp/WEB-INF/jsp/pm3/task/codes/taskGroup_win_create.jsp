<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="taskGroup_create_win" 
	title="新增任务分组"
>
	<aos:formpanel 
		id="taskGroup_create_form"
	 	width="650"
	  	layout="anchor" 
	  	labelWidth="85"
	>
	<%@ include file="taskGroup_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="taskGroup_create_win_save_button_click" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#taskGroup_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
	//页面初始化项目下拉选择
	CurrentTaskPage.on("ready", function() {
		taskGroup_create_form.down("combobox[name='proj_id']").getStore().loadData(CurrentTaskPage.projects);
		taskGroup_create_form.down("combobox[name='module_id']").getStore().loadData(CurrentTaskPage.projectModules);
		taskGroup_create_form.down("combobox[name='demand_id']").getStore().loadData(CurrentTaskPage.projectDemands);
	});
	//保存按钮响应
	function taskGroup_create_win_save_button_click(){
		if(!taskGroup_create_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
		CurrentTaskGroupTree.create(taskGroup_create_form.getValues(),function(data){
			AOS.tip(data.appmsg);
			taskGroup_win_reload();
			taskGroup_create_win.hide();
		});
	}
</script>
