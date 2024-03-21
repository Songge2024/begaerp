<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function topContacts_win_show(type){
	if(type=="create"){
		AOS.reset(topContacts_create_form);
		topContacts_create_win.show();
	}else{
		AOS.reset(topContacts_update_form);
		var record = AOS.selectone(topContacts_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		topContacts_update_form.loadRecord(record);
		topContacts_update_win.show();
	}
}
//查询
function topContacts_query() {
	var params = AOS.getValue('query_form');
    topContacts_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    topContacts_grid_store.loadPage(1);
}
//新增
function topContacts_create() {
	AOS.ajax({
		forms : topContacts_create_form,
		url : 'topContactsService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			topContacts_grid_store.reload();
			topContacts_create_win.hide();
		}
	});
}
//修改
function topContacts_update() {
	AOS.ajax({
		forms : topContacts_update_form,
		url : 'topContactsService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			topContacts_grid_store.reload();
			topContacts_update_win.hide();
		}
	});
}
//删除
function topContacts_delete(){
	var selection = AOS.selection(topContacts_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(topContacts_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条qa_top_contacts记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'topContactsService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				topContacts_grid_store.reload();
			}
		});
	});
}