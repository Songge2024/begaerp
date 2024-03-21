<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="processFileUpload_grid" 
	url="processFileUploadService.byProcPage" 
	autoScroll="true"
	split="true" 
	region="center"  
	bodyBorder="1 0 1 0"
	columnLines="true" 
  >
	<aos:menu>
		<aos:menuitem text="上传" onclick="show_excel_win" icon="add.png" />
		<aos:menuitem text="删除" onclick="file_grid_del" icon="del.png" />
		<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
		<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#processFileUpload_grid_store.reload();" icon="refresh.png" />
	</aos:menu>

	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="文件列表" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:dockeditem text="上传" icon="add.png" onclick="show_excel_win" />
		<aos:dockeditem text="删除" icon="del.png" onclick="file_grid_del" />
		<aos:dockeditem text="下载" icon="down.png"  onclick="g_acount_down" />
		<aos:dockeditem text="批量打包下载" icon="zipdown.png"  onclick="g_zip_down" />
	</aos:docked>

	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<aos:column header="标题" dataIndex="file_title" fixedWidth="300" />
	<aos:column header="版本号" dataIndex="version_num" fixedWidth="80" align="center"/>
	<aos:column header="大小" dataIndex="file_size" fixedWidth="70" align="right"/>
	<aos:column header="上传者" dataIndex="create_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="上传者" dataIndex="create_user_name" fixedWidth="100"/>
	<aos:column header="上传时间" dataIndex="create_time" fixedWidth="150" align="center"/>
	
	<aos:column header="上传文件路径" dataIndex="file_path" width="500" hidden="true"/>
	<aos:column header="上传文件URL" dataIndex="file_url" width="600"  hidden="true"/>
	<aos:column header="文件ID" dataIndex="file_id" width="100" hidden="true" />
	<aos:column header="过程ID" dataIndex="process_id" width="100" hidden="true" />
	<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true"/>
	<aos:column header="文件类型ID" dataIndex="proc_filetype_id" width="100" hidden="true"/>
	<aos:column header="文件编码" dataIndex="file_code" width="100" hidden="true"/>
	<aos:column header="上传文件备注" dataIndex="file_remark" width="100"  hidden="true"/>
	<aos:column header="排序号" dataIndex="sortno" width="100" hidden="true"/>
	
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
	
	<%-- 上传窗口 --%>
	<aos:window id="excel_win" title="上传文件">
		<aos:formpanel id="excel_win_form" width="450" layout="anchor" labelWidth="60">
		
			<aos:combobox id="id_filetype" fields="['proc_filetype_id','proc_filetype_name']" valueField="proc_filetype_id" displayField="proc_filetype_name" fieldLabel="文件类型" selectAll="true" allowBlank="false"
				json="[]"/>
				
			<aos:textfield id="id_ver_num" name="ver_num" fieldLabel="版本号" labelWidth="60" allowBlank="false" value="1.0"/>
			
			<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="60" allowBlank="false"/>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="excel_win_save" text="上传" icon="ok.png" />
			<aos:dockeditem onclick="#excel_win.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>

</aos:gridpanel>

<script type="text/javascript">
	//选择文件列表查询
	function processFileUpload_query(){
		var file_record = AOS.selectone(Ext.getCmp('processFiletype_grid'));
		if(AOS.rows(processFiletype_grid) == 1){
			processFileUpload_grid_store.getProxy().extraParams = {
		    	proj_id : file_record.data.proj_id,
		    	process_id : file_record.data.process_id,
		    	proc_filetype_id : file_record.data.proc_filetype_id
	    	};
	   		processFileUpload_grid_store.loadPage(1);
		}else{
			var proj_id = id_proj_name.getValue();
			if(AOS.empty(proj_id)){ 
				return; 
			}
			var params = { proj_id : proj_id };
			
			//获取项目过程树节点
			var record = AOS.selectone(process_module);
			if(!AOS.empty(record)){
		 		params.tree_param = record.raw.id;
			}
			processFileUpload_grid_store.getProxy().extraParams = params;
	   		processFileUpload_grid_store.loadPage(1);
		}
		
		//加载文件下载窗口的combo
 		var data = AOS.recordsToArray(file_record);
 		filetypeCombo_query(data, true);
	}
	
	function filetypeCombo_query(data, flag){
		id_filetype.reset();
		id_filetype_store.loadData(data);	
		if(flag) {
			var value = AOS.get('id_filetype').store.getAt(0).raw.proc_filetype_id;
			AOS.get('id_filetype').setValue(value);
		}
	}

	//选择项目和过程列表树查询
	function processFileUploadByProc_query() {
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(proj_id)){ 
			return; 
		}
		var params = { proj_id : proj_id };
		
		//获取项目过程树节点
		var record = AOS.selectone(process_module);
		if(!AOS.empty(record)){
	 		params.tree_param = record.raw.id;
		}
		
		processFileUpload_grid_store.getProxy().extraParams = params;
		processFileUpload_grid_store.loadPage(1);
	}

	//显示上传文件窗口
	function show_excel_win(){
		excel_win.show();
	}
	
	//上传保存
	function excel_win_save(){
		var proc_filetype_id = id_filetype.getValue();
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		if(AOS.empty(proc_filetype_id)){ 
			return; 
		}
		var version_num = id_ver_num.getValue();
		if(AOS.empty(version_num)){ 
			return; 
		}
		var params = {
				proc_filetype_id : proc_filetype_id,
				version_num : version_num
			};
	   var filenPath = AOS.getValue('excel_win_form.excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
				AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
				return;
	    }
	    
	    excel_win_form.getForm().fileUpload = true;
	    excel_win_form.getForm().encoding="multipart/form-data";
	    excel_win_form.getForm().submit({
	    		type : 'POST', 
				url:'do.jhtml?router=processFileUploadService.importFile&juid=${juid}',
				waitMsg:'文件上传中...',
				success: function(form, action) {
						AOS.tip(action.result.msg);
						excel_win.hide(); 
						processFileUpload_grid_store.reload();
						processFiletype_grid_store.reload();
						var token=action.result.msg;
						var proj_id = id_proj_name.getValue();
						var file_type = id_filetype.getRawValue();
						var count="{\"proj_id\":\""+proj_id+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}上传"
							+file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
						var title="项目过程文档"; 
						var projid = proj_id;
						mesVO=   {
								"title"  : title, 
								 "content": count,
								 "extras": {proj_id,proj_name,createTime,sedTime},
								 "mesGroup": "CHANNEL",
									}
						AOS.weekSend(token,mesVO);
		    	},
				 failure: function() {
					 excel_win.hide();
					AOS.tip("文件上传失败！");
				 },
				 params : params
		 });
	}
	
	//下载
	function g_acount_down(){
		var selection = AOS.selection(processFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(processFileUpload_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
		return;
		}
		var file_path = AOS.selection(processFileUpload_grid, 'file_path');
		var file_title = AOS.selection(processFileUpload_grid, 'file_title');
		var file_id = AOS.selection(processFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=processFileUploadService.downloadFile&juid=${juid}&file_path='+file_path+'&file_title='+file_title+'&file_id='+file_id);
	}
	 

	function g_zip_down(){
		var proj_name = id_proj_name.getRawValue();
		var selection = AOS.selection(processFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要批量打包下载的文件!');
			return;
		}
		
		var rows = AOS.rows(processFileUpload_grid);
		var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.file('do.jhtml?router=processFileUploadService.downloadFileByZip&juid=${juid}&proj_name='+proj_name+'&aos_rows='+selection);
		});
		
	}
	 
	//删除选中的文件
	function file_grid_del(){
		var selection = AOS.selection(processFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据!');
			return;
		}
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var record = AOS.selectone(processFileUpload_grid);
		var rows = AOS.rows(processFileUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'processFileUploadService.delete',
				params:{
					file_id: selection,
					create_user_id:record.data.create_user_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					processFileUpload_grid_store.reload();
					processFiletype_grid_store.reload();
					var token=data.appmsg;
					var proj_id = id_proj_name.getValue();
					var file_type = record.data.file_title;
					var count="{\"proj_id\":\""+proj_id+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}删除"
						+file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
					var title="项目过程文档"; 
					var projid = proj_id;
					mesVO={
							"title"  : title, 
							 "content": count,
							 "extras": {proj_id,proj_name,createTime,sedTime},
							 "mesGroup": "CHANNEL",
						}
					AOS.weekSend(token,mesVO);
				}
			});
		});
	}
</script>