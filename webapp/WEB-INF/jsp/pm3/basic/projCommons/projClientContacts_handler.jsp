<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projClientContacts_win_show(type){
	AOS.reads(projClientContacts_create_form, 'proj_id');
	projClientContacts_create_win.type=type;
	if(type=="create"){
		var record = AOS.selectone(Ext.getCmp('projCommons_grid'));
		if(AOS.empty(record)){
			AOS.tip('请先选择项目数据。');
			return;
		}
		if(AOS.rows(projCommons_grid)>1){
			disGridTab();
			AOS.tip('请选择一条项目数据。');
			return;
		}
		AOS.reset(projClientContacts_create_form);
		AOS.setValue('projClientContacts_create_form.proj_id', record.data.proj_id); 
		projClientContacts_create_win.setTitle("新增项目联系人信息");
		projClientContacts_create_win.show();
	}else{
		AOS.reset(projClientContacts_create_form);
		var record = AOS.selectone(projClientContacts_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		projClientContacts_create_form.loadRecord(record);
		projClientContacts_create_win.setTitle("修改项目联系人信息");
		projClientContacts_create_win.show();
	}
	var record_projCommons_grid = AOS.selectone(Ext.getCmp('projCommons_grid'));
	projClientContacts_create_form.loadRecord(record_projCommons_grid);
}
//查询
function projClientContacts_query(proj_id) {
    projClientContacts_grid_store.getProxy().extraParams = {
    	proj_id:proj_id
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    projClientContacts_grid_store.loadPage(1);
}
//新增
function projClientContacts_create() {
	AOS.ajax({
		forms : projClientContacts_create_form,
		url : projClientContacts_create_win.type=="update" ? 'projClientContactsService.update':'projClientContactsService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projClientContacts_grid_store.reload();
			projClientContacts_create_win.hide();
		}
	});
}
//修改
function projClientContacts_update() {
	projClientContacts_win_show('update');
}
//删除
function projClientContacts_delete(){
	var selection = AOS.selection(projClientContacts_grid, 'cont_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(projClientContacts_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projClientContactsService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projClientContacts_grid_store.reload();
			}
		});
	});
}