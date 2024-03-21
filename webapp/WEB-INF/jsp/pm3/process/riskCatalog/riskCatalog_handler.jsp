<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function riskCatalog_win_show(type){
	if(type=="create"){
		AOS.reset(riskCatalog_create_form);
		riskCatalog_create_win.show();
	}else{
		AOS.reset(riskCatalog_update_form);
		var rows = AOS.rows(riskCatalog_grid);
		if(rows!=1){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		var state = AOS.select(riskCatalog_grid)[0].data.state;
		if(state == 1){
			AOS.tip('改风险目录已启用，暂时不能进行修改!');
			return;
		}
		var record = AOS.selectone(riskCatalog_grid, true);
		riskCatalog_update_form.loadRecord(record);
		riskCatalog_update_win.show();
	}
}
//查询
function riskCatalog_query() {
	var params = AOS.getValue('query_form');
    riskCatalog_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    riskCatalog_grid_store.loadPage(1);
}
//新增
function riskCatalog_create() {
	AOS.ajax({
		forms : riskCatalog_create_form,
		url : 'riskCatalogService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			riskCatalog_grid_store.reload();
			riskCatalog_create_win.hide();
		}
	});
}
//修改
function riskCatalog_update() {
	AOS.ajax({
		forms : riskCatalog_update_form,
		url : 'riskCatalogService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			riskCatalog_grid_store.reload();
			riskCatalog_update_win.hide();
		}
	});
}
//删除
function riskCatalog_delete(){
	var selection = AOS.selection(riskCatalog_grid, 'risk_cata_id');
	var records = riskCatalog_grid.getSelectionModel().getSelection();
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据');
		return;
	}
	for (var i in records ){
	
		var state = records[i].data.state;
		if(state == 1){
			AOS.tip('存在风险目录已启用的数据，请重新进行选择!');
			return;
		}
	}
	var rows = AOS.rows(riskCatalog_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条风险目录记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
	//		AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'riskCatalogService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				riskCatalog_grid_store.reload();
			}
		});
	});
}