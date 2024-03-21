<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="reportFileUpload_grid" 
	url="reportFileManageService.currPage" 
	forceFit="true" 
	region="center"  
	bodyBorder="1 0 1 0"
  >
	<aos:menu>
		<aos:menuitem text="上传" onclick="show_excel_win" icon="add.png" />
		<aos:menuitem text="删除" onclick="file_grid_del" icon="del.png" />
		<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
		<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#reportFileUpload_grid_store.reload();" icon="refresh.png" />
	</aos:menu>

	<aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="文件列表" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:combobox id="id_file_year" name="c_file_year" dicField="re_file_year" fieldLabel="年份" labelWidth="45" emptyText="年份"
			selectAll="true" width="150"
			onchange="reportFileUpload_query" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:combobox id="id_file_type" name="c_file_type" dicField="re_file_type" fieldLabel="文件类型" labelWidth="68" emptyText="文件类型"
			selectAll="true" width="200"
			onchange="reportFileUpload_query" />
		<aos:dockeditem xtype="tbseparator" />
			
		<aos:dockeditem text="上传" icon="add.png" onclick="show_excel_win" />
		<aos:dockeditem text="删除" icon="del.png" onclick="file_grid_del" />
		<aos:dockeditem text="下载" icon="down.png"  onclick="g_acount_down" />
		<aos:dockeditem text="批量打包下载" icon="zipdown.png"  onclick="g_zip_down" />
	</aos:docked>

	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<aos:column header="文件标题" dataIndex="re_file_title" width="300"/>
	<aos:column header="上传者" dataIndex="create_user_name" fixedWidth="80"/>
	<aos:column header="上传日期" dataIndex="create_time" fixedWidth="100"  align="center" type="date" format="Y-m-d"/>
	<aos:column header="文件大小" dataIndex="re_file_size" fixedWidth="80" align="right"/>
	<aos:column header="文档类型" dataIndex="re_file_type" fixedWidth="80" rendererFn= "file_type" align="center"/>
	<aos:column header="年份" dataIndex="re_file_year" fixedWidth="70" align="center"/>
	<aos:column header="下载次数" dataIndex="down_num" fixedWidth="100"  align="right" hidden="true"/>
	
	<aos:column header="提交状态" dataIndex="state" fixedWidth="100"  align="center" rendererFn= "submit_state" hidden="true"/><!-- 0 未提交 1 已提交 -->
	<aos:column header="提交给" dataIndex="submit_user_name" fixedWidth="80" hidden="true"/>
	<aos:column header="提交给" dataIndex="submit_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="文件ID" dataIndex="re_file_id" width="300" hidden="true"/>
	<aos:column header="上传文件路径" dataIndex="re_file_path" width="100" hidden="true"/>
	<aos:column header="上传文件URL" dataIndex="re_file_url" width="100" hidden="true"/>
	<aos:column header="上传文件备注" dataIndex="re_file_mark" width="100" hidden="true"/>
	<aos:column header="上传人ID" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100"  hidden="true"/>
	<aos:column header="排序号" dataIndex="sort_no" width="100"  hidden="true"/>
	
	<%-- 上传窗口 --%>
	<aos:window id="excel_win" title="上传文件">
		<aos:formpanel id="excel_win_form" width="450" layout="column" labelWidth="60">
				
			<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="60" allowBlank="false" columnWidth="0.99"/>
			
			<aos:combobox id="id_re_file_year" name="file_year" dicField="re_file_year" fieldLabel="年份" allowBlank="false" columnWidth="0.39"/>
			
			<aos:combobox id="id_re_file_type" name="file_type" dicField="re_file_type" fieldLabel="文件类型" allowBlank="false" columnWidth="0.6"/>

			<%--  <aos:combobox id="id_submit_user_id" name="submit_user_id" editable="false" fieldLabel="提交给" selectAll="true" allowBlank="false" columnWidth="0.7" url="reportFileManageService.listComboBoxUserData"/> --%>
			
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
	function reportFileUpload_query(){
		var params = {};
		
// 		var record = AOS.selectone(aos_user_tree);
// 		if(!AOS.empty(record)){
// 	 		params.user_param = record.raw.id;
// 		}
		
		//获取选中的年份
		var re_file_year = id_file_year.getValue();
		if(!AOS.empty(re_file_year)){
			params.re_file_year = re_file_year;
		}
		
		//获取选中的文件类型
		var re_file_type = id_file_type.getValue();
		if(!AOS.empty(re_file_type)){
			params.re_file_type = re_file_type;
		}
		reportFileUpload_grid_store.getProxy().extraParams = params;
		reportFileUpload_grid_store.loadPage(1);
	}

	//显示上传文件窗口
	function show_excel_win(){
		excel_win.show();
	}
	
	//上传保存
	function excel_win_save(){
			var re_file_type = id_re_file_type.getValue();
			if(AOS.empty(re_file_type)){ 
				return; 
			}
			
			var re_file_year = id_re_file_year.getValue();
			if(AOS.empty(re_file_year)){ 
				return; 
			}
			
			var params = {
				re_file_type : re_file_type,
				re_file_year : re_file_year
			};
		
			var filenPath = AOS.getValue('excel_win_form.excel_file');
		    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
		    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip")
		     {
					AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip格式的');
					return;
		    }
		    excel_win_form.getForm().fileUpload = true;
		    excel_win_form.getForm().submit({
		    		type : 'POST', 
					url:'do.jhtml?router=reportFileManageService.importFile&juid=${juid}',
					waitMsg:'文件上传中...',
					success: function(form, action) {
							AOS.tip(action.result.msg);
							excel_win.hide(); 
							reportFileUpload_grid_store.reload();
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
		var selection = AOS.selection(reportFileUpload_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(reportFileUpload_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
		return;
		}
		var re_file_path = AOS.selection(reportFileUpload_grid, 're_file_path');
		var re_file_title = AOS.selection(reportFileUpload_grid, 're_file_title');
		var re_file_id = AOS.selection(reportFileUpload_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=reportFileManageService.downloadFile&juid=${juid}&re_file_path='+re_file_path+'&re_file_title='+re_file_title+'&re_file_id='+re_file_id);
	}
	 

	function g_zip_down(){
		var proj_name = id_file_type.getRawValue();
		var selection = AOS.selection(reportFileUpload_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要批量打包下载的文件!');
			return;
		}
		
		var rows = AOS.rows(reportFileUpload_grid);
		var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.file('do.jhtml?router=reportFileManageService.downloadFileByZip&juid=${juid}&proj_name='+proj_name+'&aos_rows='+selection);
		});
		
	}
	 
	//删除选中的文件
	function file_grid_del(){
		var selection = AOS.selection(reportFileUpload_grid, 're_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据!');
			return;
		}
		var rows = AOS.rows(reportFileUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'reportFileManageService.delete',
				params:{
					file_id: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					reportFileUpload_grid_store.reload();
				}
			});
		});
	}
	
	function submit_state(value, metaData, record) {
		if (value == '1') {
			return "<span style='color:green; font-weight:bold'>已提交</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>未提交</span>";
		}
		return value;
	}
	
	function file_type(value, metaData, record) {
		if (value == '1') {
			value = "周总结";
		}
		if (value == '2') {
			value = "月总结";
		}
		if (value == '3') {
			value = "季度总结";
		}
		if (value == '4') {
			value = "年度总结";
		}
		return value;
	}
	
	//默认选中第一个项目
	window.onload = function combobox_select(){
		//var value = AOS.get('id_file_type').store.getAt(0).raw.value;
		AOS.get('id_file_type').setValue('4');
		AOS.get('id_file_year').setValue('2018');
		AOS.get('id_re_file_type').setValue('4');
		AOS.get('id_re_file_year').setValue('2018');
	}
</script>