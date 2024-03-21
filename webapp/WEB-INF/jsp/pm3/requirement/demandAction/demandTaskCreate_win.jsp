<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="demand_task_create_win" title="新增任务" width="800"
	height="600"  autoScroll="true" draggable="false">
	<aos:panel layout="border" border="true">
	<aos:panel region="north" bodyBorder="0 0 1 0">
	<aos:formpanel id="demand_task_create_form" layout="column" labelWidth="85"
					header="false" border="false" >
		<!-- 隐藏 -->
		<aos:hiddenfield name="ad_content" fieldLabel="需求内容" />
		<aos:hiddenfield name="i_module_id" fieldLabel="模块" />
		<aos:hiddenfield name="module_id" fieldLabel="模块id" />
		<aos:hiddenfield name="plan_begin_time" fieldLabel="任务计划开始时间" />
		<aos:hiddenfield name="plan_end_time" fieldLabel="任务计划完成时间" />
		<aos:hiddenfield name="plan_wastage" fieldLabel="计划消耗天数" />
		<!-- 隐藏grid所需字段 -->
		<aos:hiddenfield name="proj_name" fieldLabel="项目名称" />
		<aos:hiddenfield name="task_name" fieldLabel="任务名称" />
		<aos:hiddenfield name="task_desc" fieldLabel="任务详情" />
		
		<aos:fieldset columnWidth="1" collapsible="false">
			<aos:fieldset columnWidth="0.4" collapsible="false" margin="5 5 5 5">
				<aos:combobox fieldLabel="关联项目" name="proj_id"
					id="demand_task_create_proj_id" readOnly="true"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
					columnWidth="0.9" allowBlank="false" margin="5 0 0 0" />
				<aos:combobox fieldLabel="任务分组" name="group_id" id="demand_group_id"
					editable="false" allowBlank="false" columnWidth="0.9" onselect="group_select"
					url="demandActionService.listtaskgroup" margin="5 0 0 0" />
			</aos:fieldset>

			<aos:fieldset columnWidth="0.4" collapsible="false" margin="5 5 5 5">
				<aos:hiddenfield name="demand_id" fieldLabel="需求id" />
				<aos:textfield name="demand_name" fieldLabel="关联需求"
					columnWidth="0.9" readOnly="true" margin="5 0 0 0" />
				<aos:textfield name="i_module_name" fieldLabel="关联模块"
					columnWidth="0.9" readOnly="true" margin="5 0 0 0" />
			</aos:fieldset>
		</aos:fieldset>
	</aos:formpanel>
	</aos:panel>
	<aos:gridpanel id="demand_task_create_grid" bodyBorder="1 0 1 0" hidePagebar="true"
		onitemdblclick="#demand_task_add_win_show('update');" forceFit="false"
		anchor="100% " region="center">
		<aos:docked forceBoder="1 0 1 0">
			<aos:dockeditem xtype="tbtext" text="任务明细" />
			<aos:dockeditem xtype="tbseparator" />
			<aos:dockeditem id="dis_add" xtype="button" text="添加任务"
				onclick="demand_task_add_win_show('add');" icon="add.png"
				columnWidth="0.07" margin="0 0 10 10" />
			<aos:dockeditem id="dis_update" text="修改"
				onclick="demand_task_add_win_show('update');" icon="edit.png" />
			<aos:dockeditem id="dis_delete" text="删除"
				onclick="demand_task_grid_delete();" icon="del.png" />
		</aos:docked>
		<aos:menu>
			<aos:menuitem id="dis_backend_update" text="修改"
				onclick="demand_task_add_win_show('update');" icon="edit.png" />
			<aos:menuitem xtype="menuseparator" />
			<aos:menuitem id="dis_backend_delete" text="删除"
				onclick="demand_task_grid_delete();" icon="del.png" />
		</aos:menu>
		<aos:selmodel type="checkbox" mode="multi" />
		<aos:hiddenfield name="demand_name" fieldLabel="需求名称" />
		<!-- 隐藏的内容 -->
		<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
		<aos:column header="分组id" dataIndex="group_id"  hidden="true"/>
		<aos:column header="需求id" dataIndex="demand_id" hidden="true" />
		<aos:column header="关联模块id" dataIndex="i_module_id" hidden="true" />
		<aos:column header="关联模块id" dataIndex="module_id"  hidden="true"/>
		<aos:column header="分组名称" dataIndex="group_name" hidden="true" />
		<aos:column header="处理人id" dataIndex="handler_user_id" hidden="true" />
		<aos:column header="抄送" dataIndex="cc_user_ids" hidden="true" />
		<aos:column header="任务描述" dataIndex="task_desc" hidden="true" />
		<aos:column header="备注" dataIndex="task_remark" hidden="true" />
		<!-- 显示内容 -->
		<aos:column header="项目名称" dataIndex="proj_name" width="120" />
		<aos:column header="任务名称" dataIndex="task_name" width="180" />
		<aos:column header="关联模块" dataIndex="i_module_name" width="120" />
		<aos:column header="关联需求" dataIndex="demand_name" width="120" />
		<aos:column header="计划开始时间" dataIndex="plan_begin_time" width="180" />
		<aos:column header="计划完成时间" dataIndex="plan_end_time" width="180" />
		<aos:column header="计划消耗天数" dataIndex="plan_wastage" width="120" />
		<aos:column header="任务类型" dataIndex="task_type" width="100"
			rendererField="task_type" />
		<aos:column header="优先级" dataIndex="task_level" width="60"
			rendererField="task_level" />
		<aos:column header="处理人" dataIndex="handler_user_name" width="200" />
		<aos:column header="抄送" dataIndex="cc_user_name" width="120" />

	</aos:gridpanel>
	
	</aos:panel>
	
	
	


	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="task_create_win_save_button_click" text="草稿"
			icon="ok.png" />
		<aos:dockeditem onclick="task_docked_create_publish_button_click"
			text="发布" icon="go.png" />
		<aos:dockeditem onclick="#demand_task_create_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">


//添加任务
   function demand_task_add_win_show(model){
	   //添加
	   if(model=='add'){
		   demand_task_add_win.setTitle("新增任务");
		   AOS.reset(demand_task_add_form);
		   AOS.get('demand_task_add_form').editModel='insert';
		   if(Ext.isEmpty(demand_group_id.getValue())){
			   AOS.tip("请先选择任务分组");
				return;
		   }
		   var  proj_id = AOS.getValue('demand_task_create_proj_id');
		   //指派人下拉筛选数据
		   AOS.get('demand_task_add_form.handler_user_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
		   AOS.get('demand_task_add_form.handler_user_id').getStore().load({
				callback : function(records, operation, success) {
				}
			});
		   //抄送下拉筛选数据
		   AOS.get('demand_task_add_form.cc_user_ids').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('demand_task_add_form.cc_user_ids').getStore().load({
				callback : function(records, operation, success) {
				}
			});
			AOS.setValue("demand_task_add_form.proj_id",proj_id);
			AOS.setValue("demand_task_add_form.proj_name",demand_task_create_proj_id.getRawValue());
			AOS.setValue("demand_task_add_form.group_id",demand_group_id.getValue());
			AOS.setValue("demand_task_add_form.group_name",demand_group_id.getRawValue());
			AOS.setValue("demand_task_add_form.demand_id",AOS.getValue("demand_task_create_form.demand_id"));
			AOS.setValue("demand_task_add_form.demand_name",AOS.getValue("demand_task_create_form.demand_name"));
			AOS.setValue("demand_task_add_form.i_module_id",AOS.getValue("demand_task_create_form.i_module_id"));
			AOS.setValue("demand_task_add_form.module_id",AOS.getValue("demand_task_create_form.module_id"));
			AOS.setValue("demand_task_add_form.i_module_name",AOS.getValue("demand_task_create_form.i_module_name"));
			
			AOS.setValue("demand_task_add_form.plan_begin_time",AOS.getValue("demand_task_create_form.plan_begin_time"));
			AOS.setValue("demand_task_add_form.plan_end_time",AOS.getValue("demand_task_create_form.plan_end_time"));
			AOS.setValue("demand_task_add_form.plan_wastage",AOS.getValue("demand_task_create_form.plan_wastage"));
			
			var msg =  AOS.merge('是否将需求内容填入任务描述');
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					demand_task_add_win.show();
					return;
				}
				AOS.setValue("demand_task_add_form.task_desc",AOS.getValue("demand_task_create_form.ad_content"));
				 demand_task_add_win.show();
			});
			
		  
		   
	   }else{
		    AOS.get('demand_task_add_form').editModel='update';
		    var record = AOS.selectone(demand_task_create_grid,true);
		    demand_task_add_win.setTitle("修改任务");
			var records = AOS.select(demand_task_create_grid, true);
			if(AOS.empty(records) || records.length>1){
				AOS.tip('请选择一条需要修改的数据。');
				return;
			}
			demand_task_add_form.loadRecord(record);
			demand_task_add_win.show();
	   }
		
	}
	//删除表格中任务
   function demand_task_grid_delete(){
	   var selection = AOS.selection(demand_task_create_grid, 'task_name');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
		var rows=AOS.rows(demand_task_create_grid);
		var msg =  AOS.merge('确认要删除选中的{0}条数据吗?，此数据未保存，删除后将全部消失！', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			//前台定位删除数据
			for(var i=rows;i>=0;i--){
				var dataindex=demand_task_create_grid.getStore().indexOf(demand_task_create_grid.getSelectionModel().getSelection()[i]);
				demand_task_create_grid.store.removeAt(dataindex);
			}
			AOS.tip('删除成功！');
			demand_task_add_win.hide();
		});
	}
   //新增任务
   function task_create_win_save_button_click(){
	   if(!demand_task_create_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
	   var record=demand_task_create_grid.getStore().getAt(0);
	   if(AOS.empty(record)){
		   AOS.tip('任务明细为空，无法新增任务！');
		   return;
	   }
	   
	   var count= demand_task_create_grid.getStore().getCount();
	   for(var rowIndex=0;rowIndex<count;rowIndex++){
		   var record=demand_task_create_grid.getStore().getAt(rowIndex);
		   var rowIndexNum=rowIndex+1;
		   if(AOS.empty(record.data.handler_user_id)){
			   AOS.tip("第"+rowIndexNum+"行任务处理人为空,请先修改");
			   return;
		   }
		   //demand_task_create_grid.getStore().updateRow( i, rowData );
	   }
	   
	   var store = demand_task_create_grid.getStore();
	   var listRecord = [];
	   store.each(function(rec){
		   listRecord.push(rec.data);
	   })
	   
	    AOS.ajax({
			url : 'taskService.demandcreatetask',
			params:{
				details: JSON.stringify(listRecord)
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				demand_task_create_win.hide();
			}
		});
	}
   //新增并发布任务
   function task_docked_create_publish_button_click (){
	   if(!demand_task_create_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
	   var record=demand_task_create_grid.getStore().getAt(0);
	   if(AOS.empty(record)){
		   AOS.tip('任务明细为空，无法新增任务！');
		   return;
	   }
	   var count= demand_task_create_grid.getStore().getCount();
	   for(var rowIndex=0;rowIndex<count;rowIndex++){
		   var record=demand_task_create_grid.getStore().getAt(rowIndex);
		   var rowIndexNum=rowIndex+1;
		   if(AOS.empty(record.data.handler_user_id)){
			   AOS.tip("第"+rowIndexNum+"行任务处理人为空,请先修改");
			   return;
		   }
		   //demand_task_create_grid.getStore().updateRow( i, rowData );
	   }
	   //将grid数据传入后台保存
	   var store = demand_task_create_grid.getStore();
	   var listRecord = [];
	   store.each(function(rec){
		   listRecord.push(rec.data);
	   })
	   
	    AOS.ajax({
			url : 'taskService.demand_publish_task',
			params:{
				details: JSON.stringify(listRecord)
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				demand_task_create_win.hide();
			}
		});
	}

   //任务分组选择事件
  function group_select(){
	   var group_name=demand_group_id.getRawValue();
	   var group_id=demand_group_id.getValue();
	   var rowData = {group_name:group_name	,group_id:group_id}
	   var count= demand_task_create_grid.getStore().getCount();
	   for(var rowIndex=0;rowIndex<count;rowIndex++){
		   //demand_task_create_grid.getStore().updateRow( i, rowData );
		   demand_task_create_grid.getStore().getAt(rowIndex).set('group_name',group_name);
		   demand_task_create_grid.getStore().getAt(rowIndex).set('group_id',group_id);
	   }
	   
	   
   }

	
</script>
