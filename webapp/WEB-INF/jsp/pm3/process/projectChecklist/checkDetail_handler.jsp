<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function checkDetail_win_show(type){
	if(type=="create"){
		AOS.reset(checkDetail_create_form);
		checkDetail_create_win.show();
	}else{
		AOS.reset(checkDetail_update_form);
		var record = AOS.selectone(checkDetail_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		checkDetail_update_form.loadRecord(record);
		checkDetail_update_win.show();
	}
}
//查询
function checkDetail_query() {
	var params = AOS.getValue('query_form');
    checkDetail_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    checkDetail_grid_store.loadPage(1);
}
//新增
function checkDetail_create() {
	AOS.ajax({
		forms : checkDetail_create_form,
		url : 'checkDetailService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkDetail_grid_store.reload();
			checkDetail_create_win.hide();
		}
	});
}
//修改
function checkDetail_update() {
	AOS.ajax({
		forms : checkDetail_update_form,
		url : 'checkDetailService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkDetail_grid_store.reload();
			checkDetail_update_win.hide();
		}
	});
}
