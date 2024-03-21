<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:docked forceBoder="0 0 1 0" id="taskGroup_docked">
<aos:dockeditem xtype="tbtext" text="选择项目" />
	<aos:dockeditem xtype="tbseparator" />
	<%--onchange 选择改变触发树形加载 --%>
	<%-- <aos:combobox 
		fieldLabel="选择项目" 
		labelAlign="right" 
		name="proj_id" 
		width="250"
		editable="false"
		json="[]"
		onselect="taskGroup_docked_project_combobox_select"	
		labelWidth="65"
	/> --%>
		<aos:triggerfield  id="tree_proj_name1" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show1" width="170" />
		<aos:hiddenfield id="id_proj_name1" name="id_proj_name"/>
		<aos:dockeditem xtype="button" text="导入" onclick="fn_import_excel" icon="up.png" margin="0 0 0 0"/>
<%-- 		<aos:dockeditem xtype="button" text="上传"   onclick="WBS_show_excel_win"  icon="icon70.png" margin="0 0 0 0"/> --%>
		<aos:dockeditem xtype="button" text="下载导入模板"  onclick="import_excel_upload"  icon="icon70.png" margin="0 0 0 0"/>
</aos:docked>
<aos:window id="w_org_find1" x="0" y="30" title="项目树[单击选择]" height="-30" width="300" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find1" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select1" />
</aos:window>
<aos:window id="importExcle_win" title="导入WBS模块">
	<aos:formpanel id="importExcle_form" width="450" layout="anchor"
		labelWidth="70">
		<aos:filefield id="excel_file" name="excel_file" fieldLabel="文件路径"
			buttonText="选择" labelWidth="60" allowBlank="false" />
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="importExcle_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#importExcle_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>

<!-- 上传窗口 -->
<aos:window id="WBS_excel_win" title="上传窗口">
	<aos:formpanel id="WBS_excel_win_form" width="450" layout="anchor" labelWidth="120">
		<aos:filefield id="WBS_excel_file" name="WBS_excel_file" fieldLabel="文件路径" buttonText="选择"  labelWidth="100" allowBlank="false"/>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="WBS_excel_win_save" text="上传" icon="ok.png" />
		<aos:dockeditem onclick="#WBS_excel_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<script type="text/javascript">
	
	function proj_name_query(){
		var proj_name = AOS.getValue('proj_name');
		t_org_find1_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	
	//初始化项目下拉选择
/* 	CurrentTaskPage.on("userProjectsReady", function(page, projects) {
		taskGroup_docked.down("combobox").getStore().loadData(projects);
	}); */
	/**
	 * 选择项目事件响应
	 */
	function taskGroup_docked_project_combobox_select() {
		var proj_id = id_proj_name1.getValue();
		/* if (AOS.empty(records)) {
			AOS.tip("请选择一个项目");
			return;
		}
		record = records[0]; */
		CurrentTaskPage.initParams({proj_id:proj_id},true);
		CurrentTaskGrid.initParams({proj_id:proj_id});
		CurrentTaskGroupTree.initParams({proj_id:proj_id});
		//基础数据准备完成后执行加载
		CurrentTaskPage.on("ready", function() {
			CurrentTaskGrid.reload();
			CurrentTaskGroupTree.reload();
		});
		/* id_handler_user_store.getProxy().extraParams = {
			proj_id : id_proj_name1.getValue()
		}
		id_handler_user_store.load({
			callback : function(records, operation, success) {
				//这个回调里还可以根据是否查询到二级模块再去做一些事情
				if (records.length > 0) {
					AOS.edit(bug_version_id);
				}else{
					AOS.read(bug_version_id);
				}
			}
		}); */
	}
	
	//框右边点击事件
	 function proj_tree_show1() {
		  	w_org_find1.show();
		  }
	 
	 //树的双击事件
	function t_org_find_select1() {
		var record = AOS.selectone(t_org_find1);
		//发布按钮授权
		 AOS.ajax({
			 params:{
					proj_id : record.raw.id
				},
				url : 'taskService.impowerIssue',
				ok : function(data) {
					var con=Number(data.appmsg);
					if(con==0){
						Ext.getCmp("task_docked_publish_button_id").hide();
						Ext.getCmp("task_batch_publishing_button_id").hide();
						Ext.getCmp("task_batch_close_button_id").hide();
					}else{
						Ext.getCmp("task_docked_publish_button_id").show();
						Ext.getCmp("task_batch_publishing_button_id").show();
						Ext.getCmp("task_batch_close_button_id").show();
					}
				}
		}); 
		if(record.raw.a=="1"){
		AOS.setValue('id_proj_name1',record.raw.id);
		AOS.setValue('tree_proj_name1',record.raw.text);
		taskGroup_docked_project_combobox_select();
		
		w_org_find1.hide();
	}else{
		AOS.tip("请选择项目!");
		return;
		//w_org_find.hide();
	}
	}
	 
	//树的默认加载方法 
	window.onload = function() {
		var proj_id = '${proj_id}';
		if(AOS.empty(proj_id)){
			return;
		}
		var proj_name = '${proj_name}';
		AOS.setValue('id_proj_name1',proj_id);
		AOS.setValue('tree_proj_name1',proj_name);
		var con='${con}';
		if(con==0){
			Ext.getCmp("task_docked_publish_button_id").hide();
			Ext.getCmp("task_batch_publishing_button_id").hide();
			Ext.getCmp("task_batch_close_button_id").hide();
		}else{
			Ext.getCmp("task_docked_publish_button_id").show();
			Ext.getCmp("task_batch_publishing_button_id").show();
			Ext.getCmp("task_batch_close_button_id").show();
		}
		CurrentTaskPage.initParams({proj_id:proj_id},true);
		CurrentTaskGrid.initParams({proj_id:proj_id});
		CurrentTaskGroupTree.initParams({proj_id:proj_id});
		//基础数据准备完成后执行加载
		CurrentTaskPage.on("ready", function() {
			CurrentTaskGrid.reload();
			CurrentTaskGroupTree.reload();
		});
		select_task_query();
		/* id_handler_user_store.getProxy().extraParams = {
			proj_id : id_proj_name1.getValue()
		}
		id_handler_user_store.load({
			callback : function(records, operation, success) {
				//这个回调里还可以根据是否查询到二级模块再去做一些事情
				if (records.length > 0) {
					AOS.edit(bug_version_id);
				}else{
					AOS.read(bug_version_id);
				}
			}
		}); */
	}
	
	//导入excel
	function fn_import_excel(){
		var record = AOS.selectone(taskGroup_tree);
		if(AOS.empty(record)){
			AOS.tip("导入前请先选择树结构。");
			return;
		}
		importExcle_win.show();
	}
	//导入保存
	function importExcle_save(){
		var record = AOS.selectone(taskGroup_tree);
		var id = record.data.id;
		var filenPath = AOS.getValue('importExcle_form.excel_file');
		if(filenPath==''){
			AOS.tip("请选择一个文件！");
			return;
		}
		var params = new Object();
		var proj_id = id_proj_name1.getValue();
		params.proj_id = proj_id;
		params.id = id;
		fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
		if (fileExtension != ".xls") {
			AOS.tip('请选择后缀名为xls的excel文件进行导入!');
			return;
		}
		importExcle_form.getForm().fileUpload = true;
		importExcle_form.getForm().submit({
			type : 'POST',
			params : params,
			url:'do.jhtml?router=taskGroupService.importFile&juid=${juid}',
			waitMsg:'文件导入中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				importExcle_win.hide(); 
				CurrentTaskPage.initParams({proj_id:proj_id},true);
				CurrentTaskGroupTree.initParams({proj_id:proj_id});
				CurrentTaskPage.on("ready", function() {
					CurrentTaskGroupTree.reload();
				});
			},
			failure: function() {
				importExcle_win.hide();
				AOS.tip("数据导入失败！");
			} 
		});
	}
	
	//上传窗口
	function WBS_show_excel_win(){
		WBS_excel_win.show();
	}
	
	//上传保存
	function WBS_excel_win_save(){
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var filenPath = AOS.getValue('WBS_excel_win_form.WBS_excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
			return;
	    }
	    WBS_excel_win_form.getForm().fileUpload = true;
	    WBS_excel_win_form.getForm().encoding="multipart/form-data";
	    WBS_excel_win_form.getForm().submit({
    		type : 'POST', 
			url:'do.jhtml?router=taskImportTemplateService.importFile&juid=${juid}',
			waitMsg:'文件上传中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				WBS_excel_win.hide(); 
				var token=action.result.msg;
				var count="{\"${user_name}上传"+"\"createTime\":\""+createTime+"\"}";
				var title="WBS文件"; 
				mesVO=   {
					"title"  : title, 
					 "content": count,
					 "extras": {createTime,sedTime},
					 "mesGroup": "CHANNEL",
				}
				AOS.weekSend(token,mesVO);
	    	},
			failure: function() {
				WBS_excel_win.hide();
				AOS.tip("文件上传失败！");
			}
		});
	}
	
	//下载导入模板
	function import_excel_upload(){
		AOS.file('do.jhtml?router=taskImportTemplateService.downloadFile&juid=${juid}');
	}
</script>

