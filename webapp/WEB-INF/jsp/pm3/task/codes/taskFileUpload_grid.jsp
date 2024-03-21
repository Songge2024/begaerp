<%@page import="aos.system.common.model.UserModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>


<%
	UserModel userModel=AOSCxt.getUserModel((String)request.getAttribute("juid"));
	Integer current_user_id=userModel.getId();
%>
<aos:gridpanel 
	id="taskFileUpload_grid" 
	url="taskFileUploadService.page" 
  	split="true"
	anchor="100% 100%"
 	region="center"
 	forceFit="false"
 	columnLines="true"
  	bodyBorder="1 0 1 0"
  >
  <!-- onrender="taskFileUpload_query"  -->
	<aos:menu>
		<aos:menuitem text="上传" onclick="show_excel_win" icon="add.png" />
		<aos:menuitem text="删除" onclick="file_grid_del" icon="del.png" />
		<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
		<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#taskFileUpload_grid_store.reload();" icon="refresh.png" />
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
	<%@ include file="taskFileUpload_columns.jsp"%>
	<%-- 上传窗口 --%>
	<aos:window id="excel_win" title="上传文件">
		<aos:formpanel id="excel_win_form" width="450" layout="anchor" labelWidth="60">
		
			<aos:combobox id="id_taskFileType" fieldLabel="文件类型" dicField="task_file_type" allowBlank="false" />
			
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
	//显示上传文件窗口
	function show_excel_win(){
		excel_win.show();
	}
	
	//文件上传
	function excel_win_save(){
		
		var filenPath = AOS.getValue('excel_win_form.excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
				AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
				return;
	    }
	  //文件类型
		var task_file_type = id_taskFileType.getValue();
	    var task_id = '<%=request.getAttribute("task_id") %>';
	    var proj_id = '<%=request.getAttribute("proj_id") %>';
	    var params = {
	    		task_file_type : task_file_type,
				task_id : task_id,
				proj_id : proj_id
			};
	    excel_win_form.getForm().fileUpload = true;
	    excel_win_form.getForm().encoding="multipart/form-data";
	    excel_win_form.getForm().submit({
	    		type : 'POST', 
				url:'do.jhtml?router=taskFileUploadService.importFile&juid=${juid}',
				waitMsg:'文件上传中...',
				success: function(form, action) {
						AOS.tip(action.result.msg);
						excel_win.hide(); 
						taskFileUpload_grid_store.reload();
						var token=action.result.msg;
						var task_file_type = id_taskFileType.getRawValue();
						var count="{\"proj_id\":\""+proj_id+"\","+","+"\"content\":\""+"${user_name}上传"
							+task_file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
						var title="任务文件"; 
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
	var selection = AOS.selection(taskFileUpload_grid, 'file_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要下载的文件!');
		return;
	}
	var rows = AOS.rows(taskFileUpload_grid);
	if(rows > 1){
		AOS.tip('请只选择一条需要下载的文件!');
	return;
	}
	var file_path = AOS.selection(taskFileUpload_grid, 'file_path');
	var file_title = AOS.selection(taskFileUpload_grid, 'file_title');
	var file_id = AOS.selection(taskFileUpload_grid, 'file_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择要下载的文件!');
		return;
	}
	AOS.file('do.jhtml?router=taskFileUploadService.downloadFile&juid=${juid}&file_path='+file_path+'&file_title='+file_title+'&file_id='+file_id);
	}
	
	
	//删除选中的文件
	function file_grid_del(){
		var selection = AOS.selection(taskFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据!');
			return;
		}
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var record = AOS.selectone(taskFileUpload_grid);
		var rows = AOS.rows(taskFileUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'taskFileUploadService.delete',
				params:{
					file_id: selection,
					create_user_id:record.data.create_user_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					taskFileUpload_grid_store.reload();
					var token=data.appmsg;
					var proj_id = '';//id_proj_name.getValue();
					var file_type = '';//record.data.file_title;
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
	
	//文件类型查询
	function taskFiletype_query() {
		var task_id = '<%=request.getAttribute("task_id") %>';
    var proj_id = '<%=request.getAttribute("proj_id") %>';
	if(AOS.empty(task_id)){ 
		return; 
	}
	var params = { 
			proj_id : proj_id,
			task_id : task_id
		};
	taskFileUpload_grid_store.getProxy().extraParams = params;
    taskFileUpload_grid_store.loadPage(1);
  	
}
</script>