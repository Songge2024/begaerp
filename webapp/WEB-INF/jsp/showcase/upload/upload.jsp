<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="上传下载管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north" bodyBorder="0 0 1 0">
			<aos:formpanel id="query_form" layout="column" labelWidth="70" header="false" border="false">
				<aos:textfield name="keyWords" columnWidth="0.5" emptyText="标题"/>
				<aos:button text="查询" onclick="aosUpload_grid_query" icon="query.png" margin="0 10 0 10" />
				<aos:button text="重置" onclick="AOS.reset(query_form);" icon="refresh.png"/>
			</aos:formpanel>
		</aos:panel>
		<aos:gridpanel id="aosUpload_grid" url="aosUploadService.page" onrender="aosUpload_grid_query"  
			forceFit="true" region="center"  bodyBorder="1 0 1 0">
			<aos:menu>
				<aos:menuitem text="上传" onclick="#excel_win.show();" icon="add.png" />
				<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png"/>
				<aos:menuitem text="导入" onclick="#import_excel_win.show();" icon="icon70.png"/>
				<aos:menuitem text="导出" onclick="fn_export_excel" icon="icon70.png"/>
				<aos:menuitem text="DIY导出" onclick="fn_export_diy_excel" icon="icon70.png"/>
				<aos:menuitem text="删除" onclick="card_grid_del" icon="del.png" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="#aosUpload_grid_store.reload();" icon="refresh.png" />
			</aos:menu>
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="信用卡信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="上传" icon="add.png" onclick="#excel_win.show();" />
				<aos:dockeditem text="下载" xtype="button" onclick="g_acount_down" icon="down.png"/>
				<aos:dockeditem text="导入" icon="add.png" onclick="#import_excel_win.show();" />
				<aos:dockeditem text="导出" xtype="button" onclick="fn_export_excel" icon="icon70.png"/>
				<aos:dockeditem text="批量删除" icon="del.png" onclick="card_grid_del" />
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="操作" rendererFn="fn_button_render" align="center" width="50" minWidth="50" maxWidth="50" />
			<aos:column header="编号" dataIndex="fileid" fixedWidth="100" hidden="true"/>
			<aos:column header="标题" dataIndex="title" width="100" />
			<aos:column header="文件访问路径" dataIndex="loadurl" celltip="true" fixedWidth="250"/>
			<aos:column header="文件保存路径" dataIndex="path" celltip="true" fixedWidth="250"/>
			<aos:column header="文件大小(字节)" dataIndex="filesize" fixedWidth="150"/>
			<aos:column header="备注" dataIndex="remark" celltip="true" fixedWidth="150">
			</aos:column>
		</aos:gridpanel>
		
		<%-- 上传窗口 --%>
		<aos:window id="excel_win" title="上传模版">
			<aos:formpanel id="excel_win_form" width="450" layout="anchor" labelWidth="120">
				<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="100" allowBlank="false"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="excel_win_save" text="上传" icon="ok.png" />
				<aos:dockeditem onclick="#excel_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
			<%-- 导入窗口 --%>
		<aos:window id="import_excel_win" title="导入模版">
			<aos:formpanel id="import_excel_win_form" width="450" layout="anchor" labelWidth="120">
				<aos:filefield id="importFile" name = "importFile" fieldLabel="文件路径" buttonText="选择" labelWidth="100" allowBlank="false"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="import_excel_win_save" text="导入" icon="ok.png" />
				<aos:dockeditem onclick="#import_excel_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>

		
		
		<script type="text/javascript">
		
			//按钮列转换
			function fn_button_render(value, metaData, record, rowIndex, colIndex,store) {
				return '<input type="button" value="下载" class="cbtn" onclick="fn_column_button_onclick();" />';
			}
			 //查询信用卡列表/分页
	        function aosUpload_grid_query() {
	        	var params = AOS.getValue('query_form');
	        	aosUpload_grid_store.getProxy().extraParams = params;
	        	aosUpload_grid_store.loadPage(1);
	        }
			//删除选中的信用卡
			function card_grid_del(){
				var selection = AOS.selection(aosUpload_grid, 'fileid');
				if(AOS.empty(selection)){
					AOS.tip('删除前请先选中数据。');
					return;
				}
				var rows = AOS.rows(aosUpload_grid);
				var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						AOS.tip('删除操作被取消。');
						return;
					}
					AOS.ajax({
						url : 'aosUploadService.delete',
						params:{
							fileid: selection
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							aosUpload_grid_store.reload();
						}
					});
				});
			}
			//导出excel
			function fn_export_excel(){
				//juid需要再这个页面的初始化方法中赋值,这里才引用得到
				AOS.file('do.jhtml?router=aosUploadService.exportExcel&juid=${juid}');
			}
			//DIY导出excel
			function fn_export_diy_excel(){
				AOS.file('do.jhtml?router=aosUploadService.exportDIYExcel&juid=${juid}');
			}
			 //下载
			 function g_acount_down(){
				 var selection = AOS.selection(aosUpload_grid, 'fileid');
				 var path = AOS.selection(aosUpload_grid, 'path');
				 var title = AOS.selection(aosUpload_grid, 'title');
				 var fileid = AOS.selection(aosUpload_grid, 'fileid');
					if(AOS.empty(selection)){
						AOS.tip('请选择要下载的文件!');
						return;
					}
					AOS.file('do.jhtml?router=aosUploadService.downloadFile&juid=${juid}&path='+path+'&title='+title+'&fileid='+fileid);
// 					var downloadIframe = document.createElement('iframe');
// 					downloadIframe.src = 'do.jhtml?router=aosUploadService.downloadFile&path='+path+'&title='+title+'&juid=${juid}';
// 					downloadIframe.style.display = "none";
// 					document.body.appendChild(downloadIframe);
			 }
			//导出excel
			/*function fn_export_excel(){
				var selection = AOS.selection(aosUpload_grid, 'fileid');
				//juid需要再这个页面的初始化方法中赋值,这里才引用得到
				AOS.file('do.jhtml?router=creditcardService.exportExcel&juid=${juid}');
			}*/
			function AllAreaExcel() {//整个表格拷贝到EXCEL中 
				AOS.file('do.jhtml?router=creditcardService.exportExcel2&juid=${juid}');
			}
// 			 function getObjectURL(file){    
// 		            var url=null     
// 		            if(window.createObjectURL!=undefined){ // basic    
// 		                url=window.createObjectURL(file)    
// 		            }else if(window.URL!=undefined){ // mozilla(firefox)    
// 		                url=window.URL.createObjectURL(file)    
// 		            } else if(window.webkitURL!=undefined){ // webkit or chrome    
// 		                url=window.webkitURL.createObjectURL(file)    
// 		            }    
// 		            return url  ;  
// 		        } 
			//导入保存
			function import_excel_win_save(){
			   var path = AOS.getValue('import_excel_win_form.importFile');
			    fileExtension = path.substring(path.lastIndexOf('.')).toLowerCase();
			    if (fileExtension != ".xls" && fileExtension != ".xlsx") {
	 				AOS.tip('选择的数据文件必须为excel格式');
	 				return;
			    }
// 			    import_excel_win_form.getForm().fileUpload = true;
			    import_excel_win_form.getForm().submit({
			    		type : 'POST', 
						url:'do.jhtml?router=aosUploadService.importExcelFile&juid=${juid}&path='+path,
						waitMsg:'数据导入中...',
						success: function(form, action) {
								AOS.tip(action.result.msg);
								import_excel_win.hide(); 
								aosUpload_grid_store.reload();
				    	},
						 failure: function() {
							 excel_win.hide();
							AOS.tip("数据导入失败！");
						 } 
				 });
			}
			//上传保存
			function excel_win_save(){
			   var filenPath = AOS.getValue('excel_win_form.excel_file');
			    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
			    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".txt" && fileExtension != ".css") {
	 				AOS.tip('选择的文件必须是excel、txt、css格式的');
	 				return;
			    }
			    excel_win_form.getForm().fileUpload = true;
			    excel_win_form.getForm().submit({
			    		type : 'POST', 
						url:'do.jhtml?router=aosUploadService.importFile&juid=${juid}',
						waitMsg:'文件上传中...',
						success: function(form, action) {
								AOS.tip(action.result.msg);
								excel_win.hide(); 
								aosUpload_grid_store.reload();
				    	},
						 failure: function() {
							 excel_win.hide();
							AOS.tip("文件上传失败！");
						 } 
				 });
			}
		</script>
	</aos:viewport>
</aos:onready>
	<script type="text/javascript">
		function fn_column_button_onclick() {
			var record = AOS.selectone(Ext.getCmp('aosUpload_grid'));
// 			AOS.tip("可以获取当前行的任意数据传给后台: " + "[卡号：" + record.data.fileid + "]");
			window.open(record.data.loadurl);
		}
	</script>