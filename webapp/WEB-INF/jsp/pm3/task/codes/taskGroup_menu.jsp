<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu >
	<aos:menuitem text="新增" onclick="taskGroup_win_show('create');" hidden="true" id="taskGroup_win_create_button" icon="add.png" />
	<aos:menuitem text="修改" onclick="taskGroup_win_show('update');" hidden="true" id="taskGroup_win_update_button" icon="edit.png" />
	<aos:menuitem text="删除" onclick="taskGroup_delete_menu_click"   hidden="true" id="taskGroup_win_delete_button" icon="del.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="taskGroup_win_reload" icon="refresh.png" />
</aos:menu>
<%@ include file="taskGroup_win_create.jsp"%>
<%@ include file="taskGroup_win_update.jsp"%>
<script type="text/javascript">

  function taskGroup_win_reload(){
      
	   //var proj_id = Ext.getCmp("taskGroup_docked").down("combobox[name='proj_id']").getValue();
	    var proj_id = Ext.getCmp("taskGroup_docked").down("hiddenfield[name='id_proj_name']").getValue();
		CurrentTaskPage.initParams({proj_id:proj_id},true);
		CurrentTaskGrid.initParams({proj_id:proj_id});
		CurrentTaskGroupTree.initParams({proj_id:proj_id});
		//基础数据准备完成后执行加载
		CurrentTaskGrid.reload();
		CurrentTaskGroupTree.reload();

  }
	//显示新增或修改分组窗口
	function taskGroup_win_show(type) {
		var record = AOS.selectone(taskGroup_tree, true);
		if (AOS.empty(record)) {
			AOS.tip('请选择一条分组记录');
			return;
		}
		//获得分组记录
		CurrentTaskGroupTree.get({group_id:record.raw.id}, function(data) {
			if (type == "create") {
				data.parent_id = data.group_id;
				taskGroup_update_form.down("textfield[name=parent_group_name]").show().enable();
				data.parent_group_name = data.group_name;
				//打开新增窗口
				AOS.reset(taskGroup_create_form);
				if(AOS.empty(data.proj_id))data.proj_id=CurrentTaskGroupTree.params.proj_id;
				data.proj_id=Number(data.proj_id);
				var currentDate=new Date();
				var time_begin=" 08:30:00";
				var time_end=" 17:30:00";
				data.plan_begin_time = new Date(Ext.Date.format(currentDate, "Y-m-d") + time_begin);
				data.plan_end_time=new Date(Ext.Date.format(currentDate, "Y-m-d") + time_end);
				data.plan_wastage = 1 ;
				taskGroup_create_form.getForm().setValues(data);
				taskGroup_create_win.show();
			} else {
				//打开修改窗口
				taskGroup_update_form.down("textfield[name=parent_group_name]").hide().disable();
				AOS.reset(taskGroup_update_form);
				if(AOS.empty(data.proj_id))data.proj_id=CurrentTaskGroupTree.params.proj_id;
				data.proj_id = Number(data.proj_id);
				data.demand_id=Number(data.demand_id);
				data.module_id=Number(data.module_id);
				taskGroup_update_form.getForm().setValues(data);
				taskGroup_update_win.show();
			}
		});
	}
	//删除菜单事件响应
	function taskGroup_delete_menu_click() {
		var records = taskGroup_tree.getSelectionModel().getSelection();
		if (AOS.empty(records)) {
			AOS.tip('没有要删除的分组。');
			return;
		}
		var group_ids = '';
		Ext.Array.each(records, function(record) {
			group_ids += record.get("id") + ",";
		});
		CurrentTaskGroupTree.deleted({
			aos_rows : group_ids
		}, function(data) {
			AOS.tip(data.appmsg);
			taskGroup_win_reload();
		});
	}


</script>
