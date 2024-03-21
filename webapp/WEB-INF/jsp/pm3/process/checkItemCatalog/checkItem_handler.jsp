<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">


//显示新增或修改窗口
function checkItem_win_show(type){
	if(type=="create"){
		AOS.reset(checkItem_create_form);
		var rows_type = AOS.rows(checkProjType_grid);
		var rows_cata = AOS.rows(checkCatalog_grid);
		if(rows_type != 1 && rows_cata != 1){
			AOS.tip('新增前请先选择一个项目类型或检查项。');
			return;
		}
		
		//获取项目类型ID
		var select1 = AOS.select(checkProjType_grid,'type_code');
		var type_code = select1[0].data.type_code;
		//获取检查项ID
		var select2 = AOS.select(checkCatalog_grid,'check_cata_id');
		var check_cata_id = select2[0].data.check_cata_id;
		AOS.setValue('checkItem_create_form.type_code',type_code);
		AOS.setValue('checkItem_create_form.check_cata_id',check_cata_id)
		checkItem_create_win.show();
	}else{
		AOS.reset(checkItem_update_form);
		var record = AOS.selectone(checkItem_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的修改项明细。');
			return;
		}
		if(record.data.state == '1'){
			AOS.tip('已启用的明细项无法修改。');
			return;
		}
		checkItem_update_form.loadRecord(record);
		checkItem_update_win.show();
	}
}
//查询
function checkItem_query() {
	var record = AOS.selectone(checkProjType_grid, true);
	var record1 = AOS.selectone(checkCatalog_grid, true);
	var type_code;
	var check_cata_id;
	
	if(AOS.rows(checkProjType_grid)==1){
		type_code = record.data.type_code;
	}else{
		type_code = -1;
	}
	if(AOS.rows(checkCatalog_grid)==1){
		check_cata_id = record1.data.check_cata_id;
		checkItem_grid_store.getProxy().extraParams = {
			type_code : type_code,
			check_cata_id : check_cata_id
		};
	}else{
		checkItem_grid_store.getProxy().extraParams = {
			type_code : type_code
	  	};
	}
	
    checkItem_grid_store.loadPage(1);
}
//新增
function checkItem_create() {
	AOS.ajax({
		forms : checkItem_create_form,
		url : 'checkItemService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkItem_grid_store.reload();
			checkItem_create_win.hide();
		}
	});
}
//修改
function checkItem_update() {
	AOS.ajax({
		forms : checkItem_update_form,
		url : 'checkItemService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkItem_grid_store.reload();
			checkItem_update_win.hide();
		}
	});
}
//删除
function checkItem_delete(state){
	var selection = AOS.selection(checkItem_grid, 'check_item_id');
	if(AOS.empty(selection)){
		if(state==1){
			AOS.tip('请选择需要启用的数据。');
			return;
		}
		if(state==0){
			AOS.tip('请选择需要停用的数据。');
			return;
		}
		if(state==-1){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
	}
	var rows = AOS.rows(checkItem_grid);
	if(state == 1){
		var grid = AOS.select(checkItem_grid);
		var itemState = grid[0].data.state;
		if(itemState == 0){
			var grid = AOS.select(checkCatalog_grid);
			var catalogState = grid[0].data.state;
			if(catalogState ==1){
				var msg = AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('请先启用检查项的数据!');
				return;	
			}
		}else{
			AOS.tip('此数据已经启用!');
			return;
		}
	}
	if(state == 0){
		var grid = AOS.select(checkItem_grid);
		var itemState = grid[0].data.state;
		if(itemState == 1){
			var msg = AOS.merge('确认要停用选中的{0}条数据吗？', rows); 
		}else{
			AOS.tip('此数据已经停用!');
			return;
		}
	}
	if(state == -1){
		var grid = AOS.select(checkItem_grid);
		var itemState = grid[0].data.state;
		if(itemState == 0){
			var msg = AOS.merge('确认要删除选中的{0}条数据吗？', rows); 
		}else{
			AOS.tip('此数据已经启用,不得删除!');
			return;
		}
	}
	
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'checkItemService.delete',
			params:{
				aos_rows: selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				checkItem_grid_store.reload();
			}
		});
	});
}
//导入
function checkItem_import(){
	var record = AOS.selectone(checkCatalog_grid, true);
	if(AOS.empty(record)){
		AOS.tip("请先选择检查单类型！");
		return ;
	}
	checkItem_importExcle_win.show();
}
//导入保存
function checkItem_importExcle_save(){
	var filenPath = AOS.getValue('importExcle_form.excel_file');
	if(filenPath==''){
		AOS.tip("请选择一个文件！");
		return;
	}
	var record = AOS.selectone(checkCatalog_grid, true);
	var records = AOS.selectone(checkProjType_grid, true);
	var check_cata_id = record.data.check_cata_id;
	var type_code = records.data.type_code;
	var params = new Object();
	params.check_cata_id = check_cata_id;
	params.type_code = type_code;
	fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	if (fileExtension != ".xls" && fileExtension != ".xlsx") {
		AOS.tip('请选择excel文件进行导入!');
		return;
	}
	importExcle_form.getForm().fileUpload = true;
	importExcle_form.getForm().submit({
		type : 'POST',
		params : params,
		url:'do.jhtml?router=checkItemService.importFile&juid=${juid}',
		waitMsg:'文件导入中...',
		success: function(form, action) {
			AOS.tip(action.result.msg);
			checkItem_importExcle_win.hide(); 
			checkItem_grid_store.reload();
		},
		failure: function() {
			checkItem_importExcle_win.hide();
			AOS.tip("数据导入失败！");
		} 
	});
}
//上传窗口
function checkItem_show_excel_win(){
	checkItem_excel_win.show();
}
//上传保存
function checkItem_excel_win_save(){
	var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var filenPath = AOS.getValue('checkItem_excel_win_form.checkItem_excel_file');
    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
     {
		AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
		return;
    }
    checkItem_excel_win_form.getForm().fileUpload = true;
    checkItem_excel_win_form.getForm().encoding="multipart/form-data";
    checkItem_excel_win_form.getForm().submit({
		type : 'POST', 
		url:'do.jhtml?router=checkItemImportTemplateService.importFile&juid=${juid}',
		waitMsg:'文件上传中...',
		success: function(form, action) {
			AOS.tip(action.result.msg);
			checkItem_excel_win.hide(); 
			var token=action.result.msg;
			var count="{\"${user_name}上传"+"\"createTime\":\""+createTime+"\"}";
			var title="检查单目录文件"; 
			mesVO=   {
				"title"  : title, 
				 "content": count,
				 "extras": {createTime,sedTime},
				 "mesGroup": "CHANNEL",
			}
			AOS.weekSend(token,mesVO);
    	},
		failure: function() {
			checkItem_excel_win.hide();
			AOS.tip("文件上传失败！");
		}
	});
}
//下载导入模板
function import_excel_upload(){
	AOS.file('do.jhtml?router=checkItemImportTemplateService.downloadFile&juid=${juid}');
}
</script>