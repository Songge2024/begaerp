<%@page import="aos.framework.core.utils.AOSUtils"%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:docked forceBoder="0 0 0 0" id="task_docked_manager">
		<aos:dockeditem xtype="tbtext" text="任务信息" />
		<aos:dockeditem xtype="tbseparator" />
	    <aos:dockeditem text="新增" tooltip="新增" icon="add.png" onclick="task_docked_create_button_click" />
	    <aos:dockeditem text="发布"   id="task_docked_publish_button_id" 	tooltip="发布" icon="go.png" onclick="task_docked_publish_button_click"   />
	    <aos:dockeditem text="批量发布"  id="task_batch_publishing_button_id" tooltip="批量发布" icon="go.png" onclick="task_batch_publishing_button_click"   />
	    <%-- <aos:dockeditem text="关闭" 	tooltip="关闭"		icon="close.png"	onclick="task_docked_close_button_click" /> --%>
	    <aos:dockeditem text="批量关闭"  id="task_batch_close_button_id" tooltip="批量关闭"  icon="close2.png" onclick="task_batch_close_button_click"/>
		<aos:dockeditem text="删除" 	tooltip="删除"		icon="del.png"		onclick="task_docked_delete_button_click" />
		<aos:dockeditem text="复制" 	tooltip="批量复制"	icon="copy.png"		onclick="task_docked_copy_button_click"/>
		<aos:dockeditem text="粘贴" 	tooltip="批量粘贴"	icon="save_all.png"	onclick="task_docked_copy_save_button_click"/>
		<aos:dockeditem text="导出" icon="icon70.png" onclick="task_export_excel"/>
		<%-- <aos:dockeditem text="降级" 	tooltip="降级任务"	icon="down.png"		onclick="task_docked_down_button_click"/> --%>
		<%-- <aos:dockeditem text="升级"  tooltip="升级任务"	icon="up.png"		onclick="task_docked_up_button_click"/> --%>
		<%-- <aos:dockeditem text="保存"  tooltip="保存修改"	icon="save.png"		onclick="task_docked_save_button_click"/> --%>
		
		<%-- <aos:combobox id="id_handler_user" fieldLabel="处理人查询" name="handler_user" margin="4" 
			editable="true"  labelWidth="80" queryMode="local"
			typeAhead="true" forceSelection="true" selectOnFocus="true" onchange="select_handler_user"
			url="taskService.listHandlerComboBox" width="150" emptyText="处理人查询">
		</aos:combobox> --%>
		<%-- <aos:combobox id="id_handler_user" fieldLabel="处理人查询" name="handler_user" margin="4" 
			editable="true"  labelWidth="80" queryMode="local" typeAhead="true" forceSelection="true" selectOnFocus="true" 
			url="taskService.listHandlerComboBox" width="150" >
		</aos:combobox> --%>
		<%-- <aos:combobox id="id_assign_user" fieldLabel="指派人查询" name="assign_user" margin="4" 
			editable="true"  labelWidth="80" queryMode="local" typeAhead="true" forceSelection="true" selectOnFocus="true" 
			url="taskService.listHandlerComboBox" width="150" >
		</aos:combobox> --%>
		<%-- <aos:triggerfield  id="id_assign_user" fieldLabel="指派人查询" labelWidth="80" name="assign_user" width="150" /> --%>
		<%-- <aos:dockeditem xtype="tbtext" text="222" /> --%>
		<%-- <aos:triggerfield  id="task_query_form" fieldLabel="任务名称查询" labelWidth="90"
			onenterkey="task_query" trigger1Cls="x-form-search-trigger" selectOnFocus="true"
			onchange="task_query" width="200" /> --%>
			
		<%-- <aos:combobox id="task_delay_state_form" fieldLabel="" name="task_delay_state" margin="4" 
			editable="true" columnWidth="0.3" labelWidth="10" queryMode="local"
			typeAhead="true" forceSelection="true" selectOnFocus="true" onchange="task_delay_query"
			url="taskService.listDelayComboBox" width="120" emptyText="延期状态查询"> --%>
		<%-- <aos:combobox id="task_delay_state_form" name="task_delay_state"  onchange="task_delay_query" width="160" 
			fieldLabel="任务延期状态" labelWidth="90">
							<aos:option value="01" display="正常" />
							<aos:option value="02" display="延期" />
		</aos:combobox> --%>
	 <%--    <aos:combobox  id="id_task_state" name="task_state" value="all" onselect="select_task_state" width="210" 
	    	fieldLabel="任务状态" labelWidth="60" multiSelect="true">
			<aos:option value="all" display="所有"/>
			<aos:option value="1000" display="未关闭" />
			<aos:option value="1002" display="已发布" />
			<aos:option value="1003" display="已接收"/>
			<aos:option value="1004" display="已完成" />
			<aos:option value="1005" display="已关闭" />
		</aos:combobox> --%>
		<%-- <aos:dockeditem xtype="button" text="重置"
			onclick="reset_task_select" icon="refresh.png" /> --%>
		<aos:dockeditem xtype="tbfill" />
	</aos:docked>
<%@ include file="task_win_create.jsp"%>

<script type="text/javascript">
	//新增修改窗口显示响应 
	function task_docked_create_button_click(){
		if(!task_desc_editor){
			task_desc_editor=UM.getEditor('task_desc_editor',{
				autoHeightEnabled:false
			});
		}
		if(!task_remark_editor){
			task_remark_editor=UM.getEditor('task_remark_editor',{
				autoHeightEnabled:false
			});
		}
		var params = task_create_form.getValues();
		console.log(params);
		var task_id = params.task_id;
		if (AOS.empty(task_id)){
			temp_taskFileUpload_grid.show();
			create_taskFileUpload_grid.hide();
		}
		var record = AOS.selectone(taskGroup_tree, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条分组记录');
			return;
		}
		if(record.isRoot()){
			AOS.tip('根节点不能新增任务请选择其他节点或新增节点');
			return;
		}
		CurrentTaskGroupTree.get({group_id:record.raw.id},function(data){
			console.log(new Date())
			AOS.reset(task_create_form);
			//发布按钮授权
			 AOS.ajax({
				 params:{
						proj_id : data.proj_id
					},
					url : 'taskService.impowerIssue',
					ok : function(data) {
						var con=Number(data.appmsg);
						if(con==0){
							Ext.getCmp("task_docked_create_publish_button_id").hide();
						}else{
							Ext.getCmp("task_docked_create_publish_button_id").show();
						}
					}
			});
			
			task_desc_editor.setContent('');
			task_remark_editor.setContent('');
			data.task_type='1030';
			data.task_level='1010';
			var plan_begin_time_value=new Date();
		 	data.plan_begin_time = new Date(Ext.Date.format(new Date(), "Y-m-d 09:00:00"));
			data.plan_end_time=  new Date(Ext.Date.format(Ext.Date.add(new Date(),Ext.Date.DAY,3), "Y-m-d 23:59:59"));
			 
			console.log(plan_begin_time_value);
			//alert(plan_begin_time_value);
			//var plan_begin_time=task_create_form.down("datetimefield[name=plan_begin_time]");
			//var plan_end_time=task_create_form.down("datetimefield[name=plan_end_time]");
			//设置计划时间区间
			
			//plan_begin_time.setMinValue(data.plan_begin_time);
			//plan_begin_time.setMaxValue(Ext.Date.add(new Date(data.plan_end_time),Ext.Date.DAY,1));
			
		    //plan_end_time.setMinValue(data.plan_begin_time);
			//plan_end_time.setMaxValue(Ext.Date.add(new Date(data.plan_end_time),Ext.Date.DAY,1));

			data.plan_wastage=3;
			
			if(AOS.empty(data.proj_id))data.proj_id=CurrentTaskGroupTree.params.proj_id;
			data.proj_id = Number(data.proj_id);
			if(AOS.empty(data.group_id))data.group_id=CurrentTaskGroupTree.params.group_id;
			data.group_name_all_id = Number(data.group_id);
			data.group_name_all = data.group_name;
			data.demand_id=AOS.empty(data.demand_id)?null:Number(data.demand_id);
			data.module_id=AOS.empty(data.demand_id)?null:Number(data.module_id);
			task_create_form.getForm().setValues(data);
			
			
			AOS.ajax({
				url : 'taskService.getTemp_task_id',
				ok : function(data) {
					AOS.setValue('task_create_form.temp_task_id',data.appmsg)
				}
			});
			task_create_win.show();
			task_create_win.maximize();
		});
	}
	
	//发布任务按钮点击事件响应
	function task_docked_publish_button_click(){
		var record = AOS.selectone(task_grid);
		var handler_user_id = record.data.handler_user_id;
		AOS.ajax({
			params:{
				handler_user_id:handler_user_id
			},
			url: 'taskService.checkSumBeginEndTime',
			ok:function(data){
				var con = Number(data.appmsg);
				if(con <= 25){
					var records = AOS.select(task_grid,false);
					CurrentTaskGrid.publish(records,function(data){
						AOS.tip(data.appmsg);
						CurrentTaskGrid.reload();
					});
					taskGroup_win_reload();
				}else{
					var msg = AOS.merge('本月任务计划消耗天数已超过25人天，是否继续发布？');
					AOS.confirm(msg,function(btn){
						if(btn === 'cancel'){
							return;
						}
						var records = AOS.select(task_grid,false);
						CurrentTaskGrid.publish(records,function(data){
							AOS.tip(data.appmsg);
							CurrentTaskGrid.reload();
						});
						taskGroup_win_reload();
					});
				}
			}
		});
	}
	
	//批量关闭按钮点击事件响应
	function task_batch_close_button_click(){
		var selection = AOS.selection(task_grid, 'task_id');
		if(AOS.empty(selection)){
			AOS.tip('没有待关闭的任务。');
			return;
		}
		var records = AOS.select(task_grid,false);
		//选择所有已完成任务
		var task_ids = AOS.SelectionInRecordsArray(records, 'task_id', "state","1004");
		if(AOS.empty(task_ids)){
			AOS.tip('没有待关闭的任务。');
			return;
		}
		var msg = AOS.merge('确定要批量关闭吗?');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'taskService.batchClose',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					CurrentTaskGrid.reload();
				}
			});
		});
	}
	
	//批量发布按钮点击事件响应
	function task_batch_publishing_button_click(){
		var selection = AOS.selection(task_grid, 'task_id');
		if(AOS.empty(selection)){
			AOS.tip('没有待发布的任务。');
			return;
		}
		var records = AOS.select(task_grid,false);
		//选择所有草稿任务
		var task_ids = AOS.SelectionInRecordsArray(records, 'task_id', "state","1001");
		if(AOS.empty(task_ids)){
			AOS.tip('没有待发布的任务。');
			return;
		}
		var grid1 = AOS.get('task_grid').store;
		var grid1Records = grid1.data.items;
		Ext.each(grid1Records, function (grid1Record) {
			var handler_user_id = grid1Record.data.handler_user_id;
			AOS.ajax({
				params:{
					handler_user_id:handler_user_id
				},
				url: 'taskService.checkSumBeginEndTime',
				ok:function(data){
					var con = Number(data.appmsg);
					if(con <= 25){
						var msg = AOS.merge('确定要批量发布吗?');
						AOS.confirm(msg, function(btn){
							if(btn === 'cancel'){
								return;
							}
							AOS.ajax({
								url : 'taskService.batchPublishing',
								params:{
									aos_rows: selection
								},
								ok : function(data) {
									AOS.tip(data.appmsg);
									CurrentTaskGrid.reload();
								}
							});
						});
					}else{
						var msg = AOS.merge('批量发布任务中有人本月任务计划消耗天数已超过25人天，是否继续发布？');
						AOS.confirm(msg,function(btn){
							if(btn === 'cancel'){
								return;
							}
							var msg = AOS.merge('确定要批量发布吗?');
							AOS.confirm(msg, function(btn){
								if(btn === 'cancel'){
									return;
								}
								AOS.ajax({
									url : 'taskService.batchPublishing',
									params:{
										aos_rows: selection
									},
									ok : function(data) {
										AOS.tip(data.appmsg);
										CurrentTaskGrid.reload();
									}
								});
							});
						});
					}
				}
			});
	    });
	}
	
	//关闭任务按钮点击事件响应
	function task_docked_close_button_click(){
		//选择所有草稿任务
		var records = AOS.select(task_grid);
		CurrentTaskGrid.close(records,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGrid.reload();
		});
	}
	//删除
	function task_docked_delete_button_click(){
		//选择所有草稿任务
		var records = AOS.select(task_grid);
		CurrentTaskGrid.deleted(records,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGrid.reload();
		});
	}
	//批量复制
	function task_docked_copy_button_click(){
		var records=AOS.select(task_grid);
		CurrentTaskGrid.copyRecords(records);
	}
	//保存批量复制
	function task_docked_copy_save_button_click(){
		var task_group_record = AOS.selectone(taskGroup_tree, true);
		if(AOS.empty(task_group_record)){
			AOS.tip('请选择一条分组记录');
			return;
		}
		CurrentTaskGrid.saveCopy(task_group_record.raw.id,function(){
			CurrentTaskGrid.reload();
		});
	}
	//升级任务
	function task_docked_up_button_click(){
		var task_record = AOS.selectone(task_grid, true);
		CurrentTaskGrid.up(task_record,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGrid.reload();
		});
	}
	//降级任务
	function task_docked_down_button_click(){
	var task_record = AOS.selectone(task_grid, true);
		CurrentTaskGrid.down(task_record,function(data){
			AOS.tip(data.appmsg);
			CurrentTaskGroupTree.reload();
			CurrentTaskGrid.reload();
		});
	}
	//保存修改
	function task_docked_save_button_click(){
	var datas = AOS.mr(task_grid, true);
		CurrentTaskGrid.updates(datas,function(){
			CurrentTaskGroupTree.reload();
			CurrentTaskGrid.reload();
		});
	}
	//选择处理人
	function select_handler_user(){
		var task_handler_user_id = id_handler_user.getValue();
		//console.log(task_handler_user_id);
		//var params = {handler_user_id:task_handler_user_id}
		var task_query_pa = AOS.getValue('task_query_form');
		CurrentTaskGrid.reload({
			query_pa:task_query_pa,handler_user_id:task_handler_user_id
		});
	}
	//选择任务
    function select_task_state(){
		var task_state = id_task_state.getValue();
		var proj_id =id_proj_name1.getValue();
		
		//var proj_id = AOS.getValue('t_org_find1');
		//选择所有
		if(task_state =='all'){
		 task_state = '1001,1002,1003,1004,1005';
		}
		//选择未关闭的
		if(task_state == '1000'){
		 task_state = '1001,1002,1003,1004';
		}
		//CurrentTaskPage.initParams({task_state:task_state},true);
		//CurrentTaskGrid.initParams({task_state:task_state});
		//CurrentTaskGroupTree.initParams({task_state:task_state});
		CurrentTaskGrid.reload({
			proj_id: proj_id,
			states: task_state
		});
	}
	//任务名称查询
    function task_query(){
    	var task_handler_user_id = id_handler_user.getValue();
		var task_query_pa = AOS.getValue('task_query_form'); 
		//var params = {query_pa:task_query_pa,handler_user_id:task_handler_user_id};
		//task_grid_store.getProxy().extraParams = params;
		//task_grid_store.loadPage(1);
		CurrentTaskGrid.reload({
			query_pa:task_query_pa,handler_user_id:task_handler_user_id
		}); 
	}
	//延期状态查询
	function task_delay_query(){
		var task_handler_user_id = id_handler_user.getValue();
		var task_query_pa = AOS.getValue('task_query_form');
		var task_delay_state_pa = AOS.getValue('task_delay_state_form');
		CurrentTaskGrid.reload({
			query_pa:task_query_pa,handler_user_id:task_handler_user_id,task_delay_state:task_delay_state_pa
		});
	}
	//任务导出
	function task_export_excel(){
		var selection = AOS.selection(task_grid,'task_id');
		if(selection == null || selection.length ==0){
			AOS.tip("导出前请选择数据！！");
		}else{
			AOS.file('do.jhtml?router=taskService.exportExcel&juid=${juid}&selection='+selection);
		}
	}
	//查询按钮
	function select_task_query(){
		 var task_handler_user_name = AOS.getValue('id_handler_user');
		 var task_assign_user_name = AOS.getValue('id_assign_user');
		 var task_query_pa = AOS.getValue('task_query_form');
		 var task_delay_state_pa = AOS.getValue('task_delay_state_form');
		 var task_states = AOS.getValue('id_task_states');
		 CurrentTaskGrid.reload({
				query_pa : task_query_pa,
				handler_user_name : task_handler_user_name,
				assign_user_name : task_assign_user_name,
				task_delay_state : task_delay_state_pa,
				task_states : task_states
			});
	}
	//重置按钮
	function reset_task_select(){
		AOS.reset(task_grid.id_task_states);
	}
</script>
