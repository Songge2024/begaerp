<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function checkProjType_win_show(type){
	if(type=="create"){
		AOS.reset(checkProjType_create_form);
		checkProjType_create_win.show();
	}else{
		AOS.reset(checkProjType_update_form);
		var record = AOS.selectone(checkProjType_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		checkProjType_update_form.loadRecord(record);
		checkProjType_update_win.show();
	}
}
//查询
function checkProjType_query() {
	var params = AOS.getValue('query_form');
    checkProjType_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    checkProjType_grid_store.loadPage(1);
}
//新增
function checkProjType_create() {
	AOS.ajax({
		forms : checkProjType_create_form,
		url : 'checkProjTypeService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkProjType_grid_store.reload();
			checkProjType_create_win.hide();
		}
	});
}
//修改
function checkProjType_update() {
	AOS.ajax({
		forms : checkProjType_update_form,
		url : 'checkProjTypeService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkProjType_grid_store.reload();
			checkProjType_update_win.hide();
		}
	});
}
//删除
function checkProjType_delete(){
	var selection = AOS.selection(checkProjType_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(checkProjType_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条pr_check_proj_type记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'checkProjTypeService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				checkProjType_grid_store.reload();
			}
		});
	});
}