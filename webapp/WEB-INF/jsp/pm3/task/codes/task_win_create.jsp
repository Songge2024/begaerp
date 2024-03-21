<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="task_create_win" 
	title="新增任务"
	width="800"
	height="600"
	layout="anchor" 
	autoScroll="true"
	draggable="false"
	
>
	<aos:formpanel 
		id="task_create_form" 
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
		<aos:dockeditem onclick="task_create_win_save_button_click" text="草稿" icon="ok.png" />
		<aos:dockeditem id="task_docked_create_publish_button_id"      onclick="task_docked_create_publish_button_click" text="发布" icon="go.png" />
		<aos:dockeditem onclick="#task_create_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<aos:window id="w_org_find" title="项目树[双击选择]" height="-60" layout="fit" autoScroll="true">
			<aos:treepanel id="t_org_find" singleClick="false" width="320" bodyBorder="0 0 0 0" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" rootVisible="false" onitemdblclick="t_org_find_select" />
</aos:window>

<script type="text/javascript">
	//初始化表格基础数据
	CurrentTaskPage.on("ready",function(){
		//CurrentTaskPage.projectUsers;
		var users=[];

		Ext.Array.each(CurrentTaskPage.projectUsers,function(user){
			if(user.state==="1"){
				users.push(user);
			}
		});
// 		task_create_form.down("combobox[name='handler_user_id']").getStore().loadData(users);
		task_create_form.down("combobox[name='cc_user_ids']").getStore().loadData(users);
		task_create_form.down("combobox[name='proj_id']").getStore().loadData(CurrentTaskPage.projects);
		// task_create_form.down("combobox[name='module_id']").getStore().loadData(CurrentTaskPage.projectModules);
		task_create_form.down("combobox[name='demand_id']").getStore().loadData(CurrentTaskPage.projectDemands);

	});

	//任务新增窗口草稿按钮点击事件响应
	function task_create_win_save_button_click(){
		if(!task_create_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
		if(AOS.empty(task_desc_editor.getContent())){
			AOS.tip("任务描述不能为空");
			return;
		}
		
	    //如果任务类型选择的是开发和测试，则必须选择模块
		var task_type=Ext.getCmp("id_task_type").value;
			var module_id=0;
			if(task_type==1030 || task_type==1040 ){
				var i_module_id=Ext.getCmp("module_id").value;
				if(i_module_id==null || i_module_id==''){
					module_id=1;
				}
			}
			if(module_id==1){
				AOS.tip("如果任务类型是开发和测试,则必须选择关联模块.");
				return;
		  }
		var handler_user_id = task_handler_user_id.getValue();
		var plan_begin_time = task_plan_begin_time.getValue();
		var plan_end_time = task_plan_end_time.getValue();
		var group_id = group_name_all_id.getValue();
		var wastage_day = AOS.getValue("task_create_form.plan_wastage");
		AOS.ajax({
			params:{
				handler_user_id:handler_user_id,
				plan_begin_time:plan_begin_time,
				plan_end_time:plan_end_time,
				group_id:group_id,
				plan_wastage:wastage_day
			},
			url:'taskService.checkBeginEndTime',
			ok:function(data){
				var con = Number(data.appmsg);
// 				if(con == 0){
				if(con <= 25){
					var params=task_create_form.getValues();
					params.task_desc=task_desc_editor.getContent();
					params.remark=task_remark_editor.getContent();
					params.handler_user_id = handler_user_id;
					CurrentTaskGrid.create(params,function(data){
						AOS.tip(data.appmsg);
						CurrentTaskGrid.reload();
						task_create_win.hide();
					});
					taskGroup_win_reload();
				}else{
					var msg = AOS.merge('本月任务计划消耗天数已超过25人天，是否继续发布？');
					AOS.confirm(msg,function(btn){
						if(btn === 'cancel'){
							return;
						}
						var params=task_create_form.getValues();
						params.task_desc=task_desc_editor.getContent();
						params.remark=task_remark_editor.getContent();
						params.handler_user_id = handler_user_id;
						CurrentTaskGrid.create(params,function(data){
							AOS.tip(data.appmsg);
							CurrentTaskGrid.reload();
							task_create_win.hide();
						});
						taskGroup_win_reload();
					});	
				}
			}
		});
		/* var params=task_create_form.getValues();
		params.task_desc=task_desc_editor.getContent();
		params.remark=task_remark_editor.getContent();
		CurrentTaskGrid.create(params,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGrid.reload();
			task_create_win.hide();
		}); */
	}
	
	//发布任务按钮点击事件响应
	function task_docked_create_publish_button_click(){
		if(!task_create_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
		if(AOS.empty(task_desc_editor.getContent())){
			AOS.tip("任务描述不能为空");
			return;
		}
		//如果任务类型选择的是开发和测试，则必须选择模块
		var task_type=Ext.getCmp("id_task_type").value;
			var module_id=0;
			if(task_type==1030 || task_type==1040 ){
				var i_module_id=Ext.getCmp("module_id").value;
				if(i_module_id==null || i_module_id==''){
					module_id=1;
				}
			}
			if(module_id==1){
				AOS.tip("如果任务类型是开发和测试,则必须选择关联模块.");
				return;
		  }
		var handler_user_id = task_handler_user_id.getValue();
		var plan_begin_time = task_plan_begin_time.getValue();
		var plan_end_time = task_plan_end_time.getValue();
		var group_id = group_name_all_id.getValue();
		var wastage_day = AOS.getValue("task_create_form.plan_wastage");
		AOS.ajax({
			params:{
				handler_user_id:handler_user_id,
				plan_begin_time:plan_begin_time,
				plan_end_time:plan_end_time,
				group_id : group_id,
				plan_wastage:wastage_day
			},
			url:'taskService.checkBeginEndTime',
			ok : function(data){
				var con = Number(data.appmsg);
// 				if(con == 0){
				if(con <= 25){
					var params=task_create_form.getValues();
					params.task_desc=task_desc_editor.getContent();
					params.remark=task_remark_editor.getContent();
					CurrentTaskGrid.create_publish(params,function(data){
						AOS.tip(data.appmsg);
						CurrentTaskGrid.reload();
						task_create_win.hide();
					});
					taskGroup_win_reload();
				}else{
					var msg = AOS.merge('本月任务计划消耗天数已超过25人天，是否继续发布？');
					AOS.confirm(msg,function(btn){
						if(btn === 'cancel'){
							return;
						}
						var params=task_create_form.getValues();
						params.task_desc=task_desc_editor.getContent();
						params.remark=task_remark_editor.getContent();
						CurrentTaskGrid.create_publish(params,function(data){
							AOS.tip(data.appmsg);
							CurrentTaskGrid.reload();
							task_create_win.hide();
						});
						taskGroup_win_reload();
					});
				}
			}
		});
		 
		
	/* 	var myParams = {};
		myParams.handler_user_id = task_handler_user_id.getValue();
		myParams.plan_begin_time = task_plan_begin_time.getValue();
		myParams.plan_end_time = task_plan_end_time.getValue();
		var msg = AOS.merge('指派人中在当前计划时间内有其他的任务安排，是否继续？');
		AOS.confirm(msg,funtion(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				params: myParams,
				url:'taskService.checkBeginEndTime',
				ok : function(data){
					AOS.
				}
			});
		});  */
		
		/* var params=task_create_form.getValues();
		params.task_desc=task_desc_editor.getContent();
		params.remark=task_remark_editor.getContent();
		CurrentTaskGrid.create_publish(params,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGrid.reload();
			task_create_win.hide();
		});
		taskGroup_win_reload(); */
	}
	
</script>
