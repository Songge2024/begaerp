<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function contractPaymentDetail_win_show(type){
	if(type=="create"){
		AOS.reset(contractPaymentDetail_create_form);
		contractPaymentDetail_create_win.show();
	}else{
		AOS.reset(contractPaymentDetail_update_form);
		var record = AOS.selectone(contractPaymentDetail_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		contractPaymentDetail_update_form.loadRecord(record);
		contractPaymentDetail_update_win.show();
	}
}
//查询
function contractPaymentDetail_query() {
	var params = AOS.getValue('query_form');
    contractPaymentDetail_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    contractPaymentDetail_grid_store.loadPage(1);
}
//新增
function contractPaymentDetail_create() {
	AOS.ajax({
		forms : contractPaymentDetail_create_form,
		url : 'contractPaymentDetailService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			contractPaymentDetail_grid_store.reload();
			contractPaymentDetail_create_win.hide();
		}
	});
}
//修改
function contractPaymentDetail_update() {
	AOS.ajax({
		forms : contractPaymentDetail_update_form,
		url : 'contractPaymentDetailService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			contractPaymentDetail_grid_store.reload();
			contractPaymentDetail_update_win.hide();
		}
	});
}
//删除
function contractPaymentDetail_delete(){
	var selection = AOS.selection(contractPaymentDetail_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(contractPaymentDetail_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条bs_contract_payment_detail记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'contractPaymentDetailService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				contractPaymentDetail_grid_store.reload();
			}
		});
	});
}