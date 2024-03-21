<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="接受" onclick="task_menu_receive_button_click" icon="add.png" />
	<aos:menuitem text="完成" onclick="task_menu_finish_button_click" icon="edit.png" />
	<aos:menuitem text="分解" onclick="task_menu_resolve_button_click" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="CurrentTaskGrid.reload()" icon="refresh.png" />
</aos:menu>

//接受任务事件处理
function task_menu_receive_button_click(){
	var record=AOS.selectone(task_grid, true);
	if(AOS.empty(record)){
		AOS.tip('请选择一条任务记录');
		return;
	}
	//选择所有草稿任务
	if(record.get("state")!="1002"){
		AOS.tip('不是待接受的任务，请选择其他任务');
		return;
	}
	CurrentTaskGrid.receive({task_id:record.get("task_id")},function(data){
		AOS.tip(data.appmsg);
		CurrentTaskGrid.reload();
	});
}
//完成任务事件处理
function task_menu_finish_button_click(){
	var task_record=AOS.selectone(task_grid, true);
	CurrentTaskGrid.finish(task_record,function(data){
		AOS.tip(data.appmsg);
		CurrentTaskGrid.reload();
	});
}