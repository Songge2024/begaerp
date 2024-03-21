<%@page import="aos.system.common.model.UserModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="回复内容信息" base="http" lib="ext,ueditor">
<script type="text/javascript" src="${cxt}/static/weblib/ueditor/third-party/zeroclipboard/ZeroClipboard.js"></script>
<aos:body>
	<div id="theme_list" style="width:100% ; height: 98%;border: 0;">
		<iframe id="theme_iframe" style=" width:100% ; height: 100%" src="do.jhtml?router=themeService.init&juid=${juid}&theme_type=task&refrence_id=<%=request.getAttribute("task_id") %>"></iframe>
	</div>
	<div id="task_desc_div">
		<script type="text/plain" id="task_desc_editor" style="text-align: left; margin-top:5px; margin-right:5px; width:99%;height:150px;"></script>
	</div>
	<div id="task_remark_div">
		<script type="text/plain" id="task_remark_editor" style="text-align: left; margin-top:5px; width:99%;height:150px;"></script>
	</div>
</aos:body>
</aos:html>
<%@ include file="../comm/curd.jsp"%>
<%@ include file="model/TaskPage.jsp"%>
<%@ include file="model/TaskGrid.jsp"%>
<%@ include file="model/TaskForm.jsp"%>
<%
	UserModel userModel=AOSCxt.getUserModel((String)request.getAttribute("juid"));
	Integer current_user_id=userModel.getId();
%>
<aos:onready>
	<aos:viewport layout="fit">
		<aos:tabpanel>
			<aos:tab title="任务详情" closable="false" id="task_view" onrender="aa">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="<center>任务详情</center>" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem xtype="tbtext" id="showText"/>
					
					<aos:dockeditem text="保存" 	hidden="true"  icon="save.png"   onclick="task_view_docked_save_button_click" any="name:'task_view_docked_save_button'"/>
					<aos:dockeditem text="撤回" 	hidden="true"  icon="redo.png"	onclick="task_view_docked_back_button_click" any="name:'task_view_docked_back_button'"/>
					<aos:dockeditem text="接受任务" hidden="true" icon="ok1.png"	onclick="task_view_docked_acc_button_click" any="name:'task_view_docked_acc_button'"/>
					<aos:dockeditem text="完成任务" hidden="true"	icon="edit.png" onclick="task_view_docked_finish_button_click" any="name:'task_view_docked_finish_button'"/>
					<aos:dockeditem text="关闭任务" hidden="true"	icon="close.png"    onclick="task_view_docked_close_button_click" any="name:'task_view_docked_close_button'"/>
					<aos:dockeditem text="暂停任务" hidden="true"	icon="stop.gif"    onclick="task_view_docked_pause_button_click" any="name:'task_view_docked_pause_button'"/>
					<aos:dockeditem text="重启任务" hidden="true"	icon="go.gif"    onclick="task_view_docked_play_button_click" any="name:'task_view_docked_play_button'"/>
				   <aos:dockeditem text="任务信息复制" id="taskCopy" 	onclick="copyTaskMessage" hidden="true"/>
				</aos:docked>
				<aos:formpanel 
					id="task_view_form"                                                                                     
					layout="column" 
					labelWidth="90" 
					anchor="100%" 
					autoScroll="true" 
					border="false"
				>
				<aos:hiddenfield name="task_id"/>
				<aos:hiddenfield name="state"/>
				<%@ include file="codes/task_fields.jsp"%>
				</aos:formpanel>
			</aos:tab>
			<aos:tab title="历史记录" closable="false" layout="border">
				<%@ include file="codes/taskLogs_grid.jsp"%>
			</aos:tab>
			<aos:tab title="评论信息" closable="false" contentEl="theme_list" autoScroll="true">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="<center>任务评论信息</center>" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="生成评论" icon="add.png"   onclick="task_to_theme_docked_save_button_click" any="name:'task_to_theme_docked_save_button'"/>
				</aos:docked>
			</aos:tab>
			<aos:tab title="任务分解" closable="false" id="task_tab_resolve" disabled="false" layout="anchor">
				<aos:gridpanel 
					id="task_resolve_grid" 
					autoScroll="true"
					url="taskService.selectResolveTaskPage"
					onrender="task_resolve_grid_query" 
					split="true"
					anchor="100% 100%"
				 	region="center"
				 	forceFit="false"
				 	columnLines="true"
				  	bodyBorder="1 0 1 0"
				>
				<aos:plugins>
					<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1" onbeforeedit="onbeforeedit"/>
				</aos:plugins>
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="任务分解" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="新增分解任务"  icon="add.png" onclick="task_docked_resolve_add_button_click"/>
					<aos:dockeditem text="保存分解任务" icon="save.png" onclick="task_docked_resolve_save_button_click"/>
					<aos:dockeditem text="保存并发布任务" icon="go.png" onclick="task_docked_save_resolve_button_click"/>
				</aos:docked>
<%-- 				<aos:selmodel type="checkbox" mode="multi" /> --%>
<%-- 				<aos:column type="rowno" width="40"/> --%>
				<%@ include file="codes/task_columns_editor.jsp"%>
  				</aos:gridpanel>
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>
	<script type="text/javascript">
	
	function aa() {
		task_desc_editor=UM.getEditor('task_desc_editor',{
			autoHeightEnabled:false,
			autoFloatEnabled:true
		});
		task_remark_editor=UM.getEditor('task_remark_editor',{
			autoHeightEnabled:false,
			autoFloatEnabled:true
		});
		
		var task_desc_value ='${task_desc}';
		var remark_value = '${remark}';
		task_desc_editor.setContent(task_desc_value);
		task_remark_editor.setContent(remark_value);
	  
	};
	
	//var clip = null;
	//复制任务信息
	function copyTaskMessage(){
		 // var url=window.location.href; //获取当前url地址  
         var clip =  new ZeroClipboard( document.getElementById('taskCopy'), {  
            moviePath: "ZeroClipboard.swf"  
         });    
		 //初始化  
         clip.clearData();
//          var txt="任务"+"-"+"${task_code}"+"-"+"${task_name}";
         var txt='任务'+'-'+'${task_code}'+'-'+'${task_name}';
         clip.setData("Text", txt);
         AOS.tip("任务信息复制成功");
	}
	
	task_desc_editor=UM.getEditor('task_desc_editor',{
		autoHeightEnabled:false,
		autoFloatEnabled:true
	});
	task_remark_editor=UM.getEditor('task_remark_editor',{
		autoHeightEnabled:false,
		autoFloatEnabled:true
	});
	var CurrentTaskGrid = new TaskGrid({grid:task_resolve_grid});
	var CurrentTaskForm = new TaskForm({form:task_view_form});
	CurrentTaskPage.getUserProjects();
	var current_user_id=<%=current_user_id%>;
	var task_info={};
	
	//任务信息
	function getHandlerType(){
		var url=window.location.href;
		if(url.indexOf('handler_type')!=-1){
			return parseInt(url.substr(url.lastIndexOf('=')+1));
		}else{
			return null;
		}
	};
	
	//相关附件隐藏、显示
	var task_id = '<%=request.getAttribute("task_id") %>';
	if (!AOS.empty(task_id)){
		temp_taskFileUpload_grid.hide();
		create_taskFileUpload_grid.show();
	}
	
	var handler_type=getHandlerType();
	//初始化项目下拉选择
	CurrentTaskPage.on("userProjectsReady", function(page, projects) {
		task_view_form.down("combobox[name='proj_id']").getStore().loadData(CurrentTaskPage.projects);
		CurrentTaskPage.initParams({proj_id:<%=request.getAttribute("proj_id")%>},true);
		CurrentTaskGrid.initParams({proj_id:<%=request.getAttribute("proj_id")%>});
	});
	CurrentTaskPage.on("ready",function(){
// 		task_view_form.down("combobox[name='handler_user_id']").getStore().loadData(CurrentTaskPage.projectUsers);
		task_view_form.down("combobox[name='cc_user_ids']").getStore().loadData(CurrentTaskPage.projectUsers);
		// task_view_form.down("combobox[name='module_id']").getStore().loadData(CurrentTaskPage.projectModules);
		task_view_form.down("combobox[name='demand_id']").getStore().loadData(CurrentTaskPage.projectDemands);
		CurrentTaskGrid.get({id:<%=request.getAttribute("task_id")%>},function(data){
			//获取模块名称
			 AOS.ajax({
				 params:{
					 module_id : data.module_id
				},
				url : 'taskService.getmoduleId',
				ok : function(data) {
					AOS.setValue('module_name',data.appmsg);
				}
			});
			task_info=data;
			//查询所有父节点
			AOS.ajax({
				params : {group_id:data.group_id},
				url : 'taskService.getParentId',
				ok : function(data){
					task_view_form.down("textfield[name=group_name_all]").setValue(data.group_name_all);
				}
			});
			//获得上级时间区域范围
			AOS.ajax({
				url : 'taskGroupService.get',
				params : {group_id:data.group_id},
				ok : function(group) {
					var plan_begin_time=task_view_form.down("datetimefield[name=plan_begin_time]")
					var plan_end_time=task_view_form.down("datetimefield[name=plan_end_time]");
// 					task_view_form.down("textfield[name=group_id]").setValue(group.group_id);
// 					task_view_form.down("textfield[name=group_name]").setValue(group.group_name);
				//	plan_begin_time.setMinValue(group.plan_begin_time);
				//	plan_begin_time.setMaxValue(Ext.Date.add(new Date(group.plan_end_time),Ext.Date.DAY,1));
					
				//	plan_end_time.setMinValue(group.plan_begin_time);
				//	plan_end_time.setMaxValue(Ext.Date.add(new Date(group.plan_end_time),Ext.Date.DAY,1));
				}
			});
			//获取指派人
			AOS.ajax({
				 params:{
					 handler_user_id : data.handler_user_id
				},
				url : 'taskService.getHandlerUserID',
				ok : function(datas) {
					task_view_form.down("triggerfield[name=handler_user_name]").setValue(datas.appmsg);
				}
			});
			
			//设置计划时间区间
			data.proj_id = Number(data.proj_id);
			data.demand_id=AOS.empty(data.demand_id)?null:Number(data.demand_id);
			data.module_id=AOS.empty(data.module_id)?null:(data.module_id);
			
			task_view_form.getForm().setValues(data);
			task_view_form.down("datetimefield[name=plan_begin_time]").setValue(new Date(data.plan_begin_time));//.setRawValue(data.plan_begin_time);
			task_view_form.down("datetimefield[name=plan_end_time]").setValue(new Date(data.plan_end_time));//.setRawValue(data.plan_end_time);
			//task_view_form.down("textfield[name='group_name']").hide();
			CurrentTaskForm.comboSelect("task_type","value",data.task_type);
			CurrentTaskForm.comboSelect("task_level","value",data.task_level);
			
			//设置编辑器内容
			task_desc_editor.setContent(task_info.task_desc||"");
			task_remark_editor.setContent(task_info.remark||"");
			var  task_view_docked_chage_role_button=task_view.down("button[name=task_view_docked_change_role_button]");
			var  task_view_docked_save_button=task_view.down("button[name=task_view_docked_save_button]");
			var  task_view_docked_back_button=task_view.down("button[name=task_view_docked_back_button]")
			var  task_view_docked_acc_button=task_view.down("button[name=task_view_docked_acc_button]");
			var  task_view_docked_finish_button=task_view.down("button[name=task_view_docked_finish_button]");
			var  task_view_docked_close_button=task_view.down("button[name=task_view_docked_close_button]");
			var  task_view_docked_pause_button=task_view.down("button[name=task_view_docked_pause_button]");
			var  task_view_docked_play_button=task_view.down("button[name=task_view_docked_play_button]");
			var real_wastage_value = finish_wastage.down("numberfield[name=real_wastage]");
			
			//设置处理者按钮
			if(data.state=='1003'||data.state=='1004')finish_percent.show();
			function set_hanlder_button(){
				//CurrentTaskForm.setAllFieldsReads();
				var feilds=[
					"group_name",
					"proj_id",
					"assign_user_id",
					"module_id",
					"module_text",
					"demand_id",
					"task_type",
					"task_level",
					"plan_wastage",
					"handler_user_id",
// 					"handler_user_name",
					"task_name",
					"plan_begin_time",
					"plan_end_time",
					"cc_user_ids",
					"group_name_all_id",
					"group_name_all"
				];
				task_desc_editor.setDisabled(true);
				//task_remark_editor.setDisabled(true);
				task_remark_editor.setEnabled();
				//草稿
				if(data.handler_user_id === current_user_id && data.assign_user_id===current_user_id){
					if(data.state=="1001"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//发布
					else if(data.state=="1002"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.show();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//接受
					else if(data.state=="1003"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.show();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.show();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
						real_wastage_value.setReadOnly(false);
					}
					//完成
					else if(data.state=="1004"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.show();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}
					//关闭
					else if(data.state=="1005"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
					}
					//暂停
					else if(data.state=="1007"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.show();
					}
					try{
						AOS.reads(task_view_form, feilds.toString());
					}catch(e){
						console.log(e);	
					}
				}
				else{
					if(data.state=="1001"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					//发布
					}else if(data.state=="1002"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.show();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//接受
					else if(data.state=="1003"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.show();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
						real_wastage_value.setReadOnly(false);
					}
					//完成
					else if(data.state=="1004"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}
					//关闭
					else if(data.state=="1005"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(true);
					}
					//暂停
					else if(data.state=="1007"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
					}
					try{
						AOS.reads(task_view_form, feilds.toString());
					}catch(e){
						console.log(e);	
					}
				}
			}
			//设置发布者按钮
			function set_assign_button(){
				task_desc_editor.setEnabled();
				task_remark_editor.setEnabled();
				//草稿
				if(data.handler_user_id === current_user_id && data.assign_user_id===current_user_id){
					if(data.state=="1001"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//发布
					else if(data.state=="1002"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.show();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//接受
					else if(data.state=="1003"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.show();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.show();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//完成
					else if(data.state=="1004"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.show();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}
					//关闭
					else if(data.state=="1005"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(true);
					}
					//暂停
					else if(data.state=="1007"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.show();
					}
				}else{
					if(data.state=="1001"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//发布
					else if(data.state=="1002"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//接受
					else if(data.state=="1003"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.show();
						task_view_docked_play_button.hide();
						//task_tab_resolve.enable();
					}
					//完成
					else if(data.state=="1004"){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.show();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}
					//关闭
					else if(data.state=="1005"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}
					//暂停
					else if(data.state=="1007"){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						task_view_docked_pause_button.hide();
						task_view_docked_play_button.show();
					}
				}
			}
				
			if(handler_type){
				if(handler_type==1){
					set_hanlder_button();
				}
				if(handler_type==2){
					set_assign_button();
				}
			}else{
				if(data.handler_user_id === current_user_id && data.assign_user_id!=current_user_id){
					set_hanlder_button();
					handler_type=1;
				}else if(data.assign_user_id===current_user_id){
					set_assign_button();
					handler_type=2;
				}else{
					task_view_docked_save_button.hide();
					task_view_docked_back_button.hide();
					task_view_docked_acc_button.hide();
					task_view_docked_finish_button.hide();
					task_view_docked_close_button.hide();
					//task_tab_resolve.disable();
				}
			}
			//任务确认人
	        AOS.ajax({
				params:{
					proj_id : data.proj_id,
					team_user_id:data.handler_user_id
				},
				url : 'taskService.getTaskoKUser',
				ok : function(datas) {
					var con=Number(datas.appmsg);
					if(con=== current_user_id && data.state=="1004"&&con!=data.assign_user_id ){
						task_view_docked_save_button.show();
						task_view_docked_back_button.hide();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.show();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}else if(con=== current_user_id && data.state=="1005"&&con!=data.assign_user_id){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(true);
					}
				}
			});
	      //项目经理
	        AOS.ajax({
				params:{
					proj_id : data.proj_id,
					team_user_id:data.handler_user_id
				},
				url : 'taskService.getProjTprCode',
				ok : function(datas) {
					var cons=Number(datas.appmsg);
// 					if(cons=== current_user_id && data.state=="1003"&&cons!=data.assign_user_id ){
// 						task_view_docked_save_button.show();
// 						task_view_docked_back_button.hide();
// 						task_view_docked_acc_button.hide();
// 						task_view_docked_finish_button.hide();
// 						task_view_docked_close_button.hide();
// 						//task_tab_resolve.disable();
// 						finish_wastage.show();
// 						real_wastage_value.setReadOnly(false);
// 					}else 
					if(cons=== current_user_id && data.state=="1004"&&cons!=data.assign_user_id ){
						task_view_docked_save_button.show();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.show();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(false);
					}else if(cons=== current_user_id && data.state=="1005"&&cons!=data.assign_user_id){
						task_view_docked_save_button.hide();
						task_view_docked_back_button.show();
						task_view_docked_acc_button.hide();
						task_view_docked_finish_button.hide();
						task_view_docked_close_button.hide();
						//task_tab_resolve.disable();
						finish_wastage.show();
						real_wastage_value.setReadOnly(true);
					}
				}
			});
		});
	});
	
	//开启编辑
	function onbeforeedit(editor,context){
		if(context.field=='assign_user_id')return false;
		if(!AOS.empty(context.record.get("task_id"))){
			return false;
		}
		return true;
	}
	
	//切换角色
	function task_view_docked_change_role_button_click(){
		var url=window.location.href;
		if(url.indexOf('handler_type')!=-1){
			url=url.substr(0,url.lastIndexOf('&'));
			if(handler_type==1){window.location=url+'&handler_type='+2;}
			else{window.location=url+'&handler_type='+1;}
		}else{
			if(handler_type==1){window.location=url+'&handler_type='+2;}
			else{window.location=url+'&handler_type='+1;}
		}
	}
	
	//接受任务
	function task_view_docked_acc_button_click(){
		CurrentTaskGrid.receive(task_info,function(data){
			AOS.tip(data.appmsg);
			window.location.reload();
		});
	}
		
	//保存任务修改
	function task_view_docked_save_button_click(){
		var handler_user_id=(task_view_form.getValues().handler_user_id);
		var handler_user_id_=String(handler_user_id)
		var len=handler_user_id_.length;
		var lenArray=[];
		var item=handler_user_id_.split(",");
		Ext.each(item,function(items){
			lenArray.push(items);
		});
		var len_= lenArray.length;
		if (len_>1){
			AOS.tip("处理人不能变更为多人！");
			return;
		}
// 		var params = AOS.getValue('task_view_form');
		if(!task_view_form.isValid()){
			AOS.tip("表单验证失败！");
			return;
		} 
		var params=task_view_form.getValues();
		if(params.percent == 100){
			params.state = 1004;
		}
		params.task_desc=task_desc_editor.getContent();
		params.remark=task_remark_editor.getContent();
		var begin_date=AOS.getValue('task_view_form.real_begin_time');
 		var end_date=AOS.getValue('task_view_form.real_end_time');
 		if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
 			  AOS.setValue('task_view_form.real_end_time',null);
 			  AOS.tip("结束时间不能小于开始时间,请重新选择!");
 			  return;
 		}
		CurrentTaskGrid.update(params,function(data){
			if(data.appmsg == "结束时间不能大于开始时间！"){
				AOS.tip(data.appmsg);
			}else{
				AOS.tip(data.appmsg);
				window.location.reload();
			}
		});
		var flag = 2;
		return flag;
	}
	
	//打回
	function task_view_docked_back_button_click(){
		CurrentTaskGrid.back(task_info,function(data){
			AOS.tip(data.appmsg);
			window.location.reload();
		});
	}
	
	//完成任务事件处理
	function task_view_docked_finish_button_click(){
		var begin_date=AOS.getValue('task_view_form.real_begin_time');
 		var end_date=AOS.getValue('task_view_form.real_end_time');
 		if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
 			  AOS.setValue('task_view_form.real_end_time',null);
 			  AOS.tip("结束时间不能小于开始时间,请重新选择!");
 			  return;
 		}
		task_view_docked_save_button_click();
		if(!task_view_form.isValid()){
			AOS.tip("表单验证失败！");
			return;
		}
		var real_wastage=(task_view_form.getValues().real_wastage);
		var params=task_view_form.getValues();
		console.log(params);
		params.percent=100;
		if(real_wastage != ""){
			params.real_wastage=real_wastage;
		}else{
			params.real_wastage="";
		}
		CurrentTaskGrid.finish(params,function(data){
			if(data.appmsg == "结束时间不能大于开始时间！"){
				AOS.tip(data.appmsg);
			}else{
				AOS.tip(data.appmsg);
				window.location.reload();
			}
			var token=data.token;
			var getTaskoKUser=data.getTaskoKUser;
			if(data.task_type=="1030"){
			 	var proj_id=params.proj_id;
				//指派人
				var assign_user_id=params.assign_user_id;
				//任务确认人
				var getTaskoKUser=data.getTaskoKUser;
				//处理人
				var aandler_user_id=params.aandler_user_id;
				//任务编码
				var task_code=data.task_code;
				var user_id=data.user_id;
				var message=data.message;
				if(message>0){
					var  count="任务编码:"+task_code+"已完成";
			    	mesVO={
						"title"  : "任务跟踪", 
						"content": count,
						"mesGroup": "CUSTOM",
						"toUserAccounts": [
							getTaskoKUser
						]
			    	} 
					AOS.weekSend(token,mesVO);
			 	}
			}
		});
	}
	
	//查询分解任务列表
	function task_resolve_grid_query(){
		var params={};
		params.task_id='<%=request.getAttribute("task_id") %>';
		task_resolve_grid_store.getProxy().extraParams = params;
		task_resolve_grid_store.loadPage(1);
	}
	
	//分解任务
	function task_docked_resolve_add_button_click(){
		var data=Ext.clone(task_info);
		data.task_id="";
		data.state=1001;
		data.real_begin_time="";
		data.real_end_time="";
		data.real_wastage="";
		data.update_time="";
		data.update_id="";
		data.percent="";
		data.assign_user_id=<%=current_user_id+""%>
		task_resolve_grid_store.insert(task_resolve_grid_store.getCount(),data);
	}
	
	//保存分解
	function task_docked_resolve_save_button_click(){
		var records=AOS.mr(task_resolve_grid);
		var datas=[];
		Ext.Array.each(records,function(record){
			var data={};
			for(var pro in record){
				data[pro] = Ext.isNumber(record[pro]) ? "" + record[pro] : record[pro];
			}
			datas.push(data);
		});
		CurrentTaskGrid.resolve(task_info, datas, function(data) {
			AOS.tip(data.appmsg);
			if (data.appcode != -1) {
				window.location.reload();
				//window.close();
			}
		});
	}
	//任务分解保存并发布
	function task_docked_save_resolve_button_click() {
		var records=AOS.mr(task_resolve_grid);
		var datas=[];
		Ext.Array.each(records,function(record){
			var data={};
			for(var pro in record){
				data[pro] = Ext.isNumber(record[pro]) ? "" + record[pro] : record[pro];
			}
			datas.push(data);
		});
		CurrentTaskGrid.resolves(task_info, datas, function(data) {
			AOS.tip(data.appmsg);
			if (data.appcode != -1) {
				window.location.reload();
				//window.close();
			}
		});
	}
	//关闭任务
	function task_view_docked_close_button_click() {
		var flag = task_view_docked_save_button_click();
		if(flag == 2 ){
		  	var params = task_view_form.getValues();
		  	var proj_id=params.proj_id;
			CurrentTaskGrid.close([ params ], function(data) {
			AOS.tip(data.appmsg);
			window.location.reload();
			var token=data.token;
			var message=data.message;
			var proj_id=params.proj_id;
			var demand_id=data.demand_id;
			var demand_name=data.demand_name;
			var user_id=data.user_id;
			var task_code=data.task_code;
				if(message>0){
					var demand_array=[];
					var demand_id_=demand_id.split(",");
					Ext.each(demand_id_,function(item){
						if(item!=user_id){
						var count="需求名称:"+demand_name+",任务编码:"+task_code+"已关闭";
						mesVO={
							"title"  : "任务跟踪", 
							"content": count,
							"mesGroup": "CUSTOM",
							"toUserAccounts": [
								item
							]
				    	 } 
				    	AOS.weekSend(token,mesVO);
						}
					})
				}
			});
		}
	}

	//暂停任务
	function task_view_docked_pause_button_click(){
		CurrentTaskGrid.pause(task_info,function(data){
			AOS.tip(data.appmsg);
			window.location.reload();
		});
	}
	
	//重启任务
	function task_view_docked_play_button_click(){
		CurrentTaskGrid.play(task_info,function(data){
			AOS.tip(data.appmsg);
			window.location.reload();
		});
	}
	
	//生成评论信息
	function task_to_theme_docked_save_button_click(){
		AOS.ajax({
			url:"themeService.create",
			params:{
				theme_type:'task',
				refrence_id:'<%=request.getAttribute("task_id")%>',
				title:''+task_info.task_name,
				tags:['task'],
				content:(task_info.task_desc||null)
			},
			ok:function(data){
				Ext.get('theme_iframe').dom.contentWindow.location.reload();
			}
		});
	}
	
	</script>
</aos:onready>