<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="demand_task_add_win" title="填写任务" width="900"
	height="550" layout="anchor" autoScroll="true" draggable="true">
	<aos:formpanel id="demand_task_add_form" layout="column"
		labelWidth="90" margin="5" anchor="100%" autoScroll="true"
		border="false">
		<aos:hiddenfield name="proj_id" fieldLabel="项目编码" />
		<aos:hiddenfield name="proj_name" fieldLabel="项目名称" />
		<aos:hiddenfield name="group_id" fieldLabel="分组编码" />
		<aos:hiddenfield name="group_name" fieldLabel="分组名称" />
		<aos:hiddenfield name="demand_id" fieldLabel="需求编码" />
		<aos:hiddenfield name="demand_name" fieldLabel="需求名称" />
		<aos:hiddenfield name="i_module_name" fieldLabel="模块名称" />
		<aos:hiddenfield name="i_module_id" fieldLabel="模块id" />
		<aos:hiddenfield name="module_id" fieldLabel="模块id" />
		<aos:hiddenfield name="handler_user_name" fieldLabel="处理人姓名" />
		<aos:hiddenfield name="cc_user_name" fieldLabel="抄送人姓名" />
		<aos:fieldset columnWidth="1" collapsible="false">
			<aos:fieldset columnWidth="0.45" collapsible="false" margin="5 5 5 5">
				<aos:datetimefield fieldLabel="计划开始时间" name="plan_begin_time"
					format="Y-m-d H:i:s" columnWidth="0.9" allowBlank="false"
					msgTarget="qtip" />
				<aos:datetimefield fieldLabel="计划结束时间" name="plan_end_time"
					format="Y-m-d H:i:s" columnWidth="0.9" allowBlank="false"
					msgTarget="qtip" />
				<aos:combobox fieldLabel="指派给" name="handler_user_id"
					id="handler_user_id" multiSelect="true" columnWidth="0.9"
					allowBlank="false" url="projCommonsService.listComboBoxProjId"
					msgTarget="qtip" />
				<aos:textfield fieldLabel="任务名称" name="task_name" columnWidth="0.9"
					allowBlank="false" />
			</aos:fieldset>

			<aos:fieldset columnWidth="0.45" collapsible="false" margin="5 5 5 5">
				<aos:numberfield fieldLabel="计划消耗天数" name="plan_wastage"
					columnWidth="0.9" editable="false" step="0.5" decimalPrecision="1"
					 minValue="0.1" maxValue="999" />
				<aos:combobox fieldLabel="任务类型" name="task_type" value="1030"
					columnWidth="0.9" dicField="task_type" allowBlank="false" />
				<aos:combobox fieldLabel="优先级" name="task_level" value="1010"
					columnWidth="0.9" dicField="task_level" allowBlank="false" />
				<aos:combobox fieldLabel="抄送" name="cc_user_ids" columnWidth="0.9"
					id="cc_user_ids" url="projCommonsService.listComboBoxProjId"
					multiSelect="true" />
			</aos:fieldset>


		</aos:fieldset>
		<aos:htmleditor name="task_desc" fieldLabel="任务描述" allowBlank="false"
			columnWidth=".99" />
		<aos:htmleditor name="task_remark" fieldLabel="备注" columnWidth=".99" />


	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="task_add_win_save_button_click" text="确认"
			icon="add.png" />
		<aos:dockeditem onclick="#demand_task_add_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">


//添加任务
   function task_add_win_save_button_click (){
		if(!demand_task_add_form.isValid()){
			AOS.tip("必填项没完成");
			return;
		}
		//计划开始时间
		var plan_begin_time = AOS.getValue("demand_task_add_form.plan_begin_time");    
		//计划结束时间
		var plan_end_time =  AOS.getValue("demand_task_add_form.plan_end_time"); 
		
		if(!(Ext.isEmpty(plan_begin_time)) && !(Ext.isEmpty(plan_end_time))){
			if(plan_begin_time>plan_end_time){
				AOS.tip('计划开始时间不能大于结束时间');
				return;
			}
		 }
		AOS.setValue("demand_task_add_form.handler_user_name", handler_user_id.getRawValue());
		AOS.setValue("demand_task_add_form.cc_user_name", cc_user_ids.getRawValue());
		if(AOS.get('demand_task_add_form').editModel=='update'){
			
		var record = AOS.selectone(demand_task_create_grid,true);
		//修改
		if(!AOS.empty(record.data.proj_id)){
			var dataindex=demand_task_create_grid.getStore().indexOf(demand_task_create_grid.getSelectionModel().getSelection()[0] );
			if(dataindex!=null){
				var values = demand_task_add_form.getValues();
				demand_task_create_grid.store.getAt(dataindex).set(values);
				AOS.tip('数据修改成功!');
				demand_task_add_win.hide();
			  }
		}
		//添加
		}else{
			demand_task_create_grid_store.insert(0,demand_task_add_form.getValues());
			AOS.reset(demand_task_add_form);
			demand_task_add_win.hide();
		}
		
	}
  
	
</script>
