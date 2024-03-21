<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function bugManage_win_show(type){
	if(type=="create"){
		AOS.reset(bugManage_create_form);
		bugManage_create_win.show();
	}else{
		AOS.reset(bugManage_update_form);
		var record = AOS.selectone(bugManage_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		bugManage_update_form.loadRecord(record);
		bugManage_update_win.show();
	}
}
//查询
function bugManage_query() {
	var params = AOS.getValue('query_form');
    bugManage_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    bugManage_grid_store.loadPage(1);
}
//新增
function bugManage_create() {
	AOS.ajax({
		forms : bugManage_create_form,
		url : 'bugManageService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			bugManage_grid_store.reload();
			bugManage_create_win.hide();
		}
	});
}
//修改
function bugManage_update() {
	AOS.ajax({
		forms : bugManage_update_form,
		url : 'bugManageService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			bugManage_grid_store.reload();
			bugManage_update_win.hide();
		}
	});
}
//删除
function bugManage_delete(){
	var selection = AOS.selection(bugManage_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(bugManage_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条qa_bug_manage记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'bugManageService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				bugManage_grid_store.reload();
			}
		});
	});
}

