<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<!-- 任务分组导航 -->
<aos:treepanel 
	id="taskGroup_tree" 
	region="west" 
	width="300"
	
	splitterBorder="1 0 1 1"
	bodyBorder="0 1 0 0" 
	singleClick="false"
	rootVisible="true" 
	onselectionchange="taskGroup_tree_setmenu"
	onitemclick="taskGroup_tree_itemclick"
>
<%@ include file="taskGroup_menu.jsp"%>
<%@ include file="taskGroup_docked.jsp"%>
</aos:treepanel>
<script type="text/javascript">
window.onload = function combobox_select(){
		var record = t_org_find1;
		AOS.get('id_proj_name1').setValue('${proj_id}');
		AOS.get('tree_proj_name1').setValue('${proj_name}');
		CurrentTaskPage.initParams({proj_id:'${proj_id}',id:'${id}',states:'${states}'},true);
		CurrentTaskGrid.initParams({proj_id:'${proj_id}',id:'${id}',states:'${states}',plan_begin_time:'${plan_begin_time}',plan_end_time:'${plan_end_time}'});
		CurrentTaskGroupTree.initParams({proj_id:'${proj_id}'});
		//基础数据准备完成后执行加载
		CurrentTaskPage.on("ready", function() {
			CurrentTaskGrid.reload();
			CurrentTaskGroupTree.reload();
		});
}
//树形选择改变事件
function taskGroup_tree_itemclick(tree,record){
	CurrentTaskGrid.reload({
		group_id:record.raw.id
	});
}

//根据根节点级别控制需要展示的功能
function taskGroup_tree_setmenu (){
	
	var taskGroup_tree_dep = AOS.selectone(taskGroup_tree, true).data.depth+"1";
	
	if(taskGroup_tree_dep == '01'){
	Ext.getCmp("taskGroup_win_create_button").hide();
	Ext.getCmp("taskGroup_win_update_button").hide();
	Ext.getCmp("taskGroup_win_delete_button").hide();
	}else if(taskGroup_tree_dep == '11'){
		Ext.getCmp("taskGroup_win_create_button").show();
		Ext.getCmp("taskGroup_win_update_button").hide();
		Ext.getCmp("taskGroup_win_delete_button").hide();	
	}else{
		Ext.getCmp("taskGroup_win_create_button").show();
		Ext.getCmp("taskGroup_win_update_button").show();
		Ext.getCmp("taskGroup_win_delete_button").show();
	}
}

</script>

