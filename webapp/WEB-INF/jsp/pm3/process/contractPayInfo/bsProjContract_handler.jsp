<%@ page contentType="text/html; charset=utf-8"%>
//查询合同明细
function tree_grid_query() {
		proj_id = id_proj_name.getValue();
		AOS.ajax({
		params : {
		proj_id:proj_id
		},
		url : 'bsProjContractService.contract',
		ok : function(data) {
			AOS.tip(data.appmsg);
			bsProjContract_grid_store.loadPage(1);
		}
	});
}
//单击
function bsProjContract_grid_click() {
	var select = AOS.select(bsProjContract_grid, 'ct_id');
	var ct_id = select[0].data.ct_id;
	contractPayInfo_grid_store.reload({
			params:{
					ct_id : ct_id
				}});
}
//显示新增或修改窗口
function bsProjContract_win_show(type){
	if(type=="create"){
		AOS.reset(bsProjContract_create_form);
		bsProjContract_create_win.show();
	}else{
		AOS.reset(bsProjContract_update_form);
		var record = AOS.selectone(bsProjContract_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		bsProjContract_update_form.loadRecord(record);
		bsProjContract_update_win.show();
	}
}
//查询
function bsProjContract_query() {
	proj_id = id_proj_name.getValue();
    bsProjContract_grid_store.getProxy().extraParams = {
    	proj_id:proj_id
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    bsProjContract_grid_store.loadPage(1);
}
//新增
function bsProjContract_create() {
	AOS.ajax({
		forms : bsProjContract_create_form,
		url : 'bsProjContractService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			bsProjContract_grid_store.reload();
			bsProjContract_create_win.hide();
		}
	});
}
//修改
function bsProjContract_update() {
	AOS.ajax({
		forms : bsProjContract_update_form,
		url : 'bsProjContractService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			bsProjContract_grid_store.reload();
			bsProjContract_update_win.hide();
		}
	});
}
//删除
function bsProjContract_delete(){
	var selection = AOS.selection(bsProjContract_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(bsProjContract_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条bs_proj_contract记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'bsProjContractService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				bsProjContract_grid_store.reload();
			}
		});
	});
}