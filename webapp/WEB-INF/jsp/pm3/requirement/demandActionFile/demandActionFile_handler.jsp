<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function demandActionFile_win_show(){
var record = AOS.selectone(demandAction_grid,true);
		if(AOS.empty(record)){
<!-- 			AOS.tip('请先需要添加文件的需求数据。'); -->
			return;
		}
		if(AOS.rows(demandAction_grid)>1){
<!-- 			AOS.tip('请选择一条需求数据。'); -->
			return;
		}
		demandActionFile_create_win.show();
}
//查询
function demandActionFile_query() {
	var record = AOS.selectone(demandAction_grid,true);
	if(AOS.rows(demandAction_grid)==1){
		demandActionFile_grid_store.getProxy().extraParams = {
	    	ad_id : record.data.ad_id
    	};
   		demandActionFile_grid_store.loadPage(1);
	}else{
		demandActionFile_grid_store.getProxy().extraParams = {
	    	ad_id : 0
    	};
   		demandActionFile_grid_store.loadPage(1);
	}
}
//新增
function demandActionFile_create() {
	var record = AOS.selectone(demandAction_grid,true);
		if(AOS.empty(record)){
			AOS.tip('请先需要添加文件的需求数据。');
			return;
		}
		if(AOS.rows(demandAction_grid)>1){
			AOS.tip('请选择一条需求数据。');
			return;
		}
	var filenPath = AOS.getValue('demandActionFile_file');
	if(filenPath.length>62){
			AOS.tip('文件名过长，请修改后重新上传(文件名长度最大50)');
			return;
	}
    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip")
     {
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip格式的');
			return;
    }
    demandActionFile_create_form.getForm().fileUpload = true;
    demandActionFile_create_form.getForm().submit({
    		type : 'POST', 
			url:'do.jhtml?router=demandActionFileService.create&juid=${juid}',
			waitMsg:'文件上传中...',
			params:{
				ad_id: record.data.ad_id
			},
			success: function(form, action) {
					AOS.tip(action.result.msg);
					demandActionFile_create_win.hide(); 
					demandActionFile_grid_store.reload();
	    	},
			 failure: function() {
				 demandActionFile_create_win.hide();
				AOS.tip("文件上传失败！");
			 } 
	 });
}
//修改
function demandActionFile_update() {
	 var path = AOS.selection(demandActionFile_grid, 'fad_path');
	 var title = AOS.selection(demandActionFile_grid, 'fad_name');
	 var fad_id = AOS.selection(demandActionFile_grid, 'fad_id');
		if(AOS.empty(path)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=demandActionFileService.downloadFile&juid=${juid}&path='+path+'&title='+title+'&fad_id='+fad_id);
}
//删除
function demandActionFile_delete(){
	var selection = AOS.selection(demandActionFile_grid, 'fad_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var record = AOS.selectone(demandActionFile_grid, true);
	var rows = AOS.rows(demandActionFile_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'demandActionFileService.delete',
			params:{
				aos_rows: selection,
				create_user_id:record.data.create_user_id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				demandActionFile_grid_store.reload();
			}
		});
	});
}
//上传
function demandActionFile_upload(){
	var selection = AOS.selection(demandAction_grid, 'ad_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择一条项目数据');
		return;
	}
	if(AOS.rows(demandAction_grid)>1){
			AOS.tip('请选择一条需求数据。');
			return;
		}
	if(AOS.select(demandAction_grid)[0].data.state==1){
		AOS.tip('项目数据已启用，无法操作!');
		return;
	}
	if(AOS.select(demandAction_grid)[0].data.state==-1){
		AOS.tip('项目数据已作废，无法操作!');
		return;
	}
	demandActionFile_win_show();
}

//下载
function demandActionFile_down(){
	var selection = AOS.selection(demandActionFile_grid, 'ad_id');
	if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(demandActionFile_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
		return;
	}
	if(AOS.select(demandAction_grid)[0].data.state==-1){
		AOS.tip('项目数据已作废，无法操作!');
		return;
	}
		var file_path = AOS.selection(demandActionFile_grid, 'fad_path');
		var file_title = AOS.selection(demandActionFile_grid, 'fad_name');
		var file_id = AOS.selection(demandActionFile_grid, 'fad_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=demandActionFileService.downloadFile&juid=${juid}&file_path='+file_path+'&file_title='+file_title+'&file_id='+file_id);
	
	
}
