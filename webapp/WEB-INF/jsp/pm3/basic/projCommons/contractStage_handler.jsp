<%@ page contentType="text/html; charset=utf-8"%>
//合同状态渲染
		function fn_ct_state(value, metaData, record){
			if(value == 2){
				return "<span style='color:green; font-weight:bold'>执行中</span>"; 
			}else if(value == 1){
				return "<span style='color:blue; font-weight:bold'>未启用</span>"; 
			}else if(value == 0){
				return "<span style='color:red; font-weight:bold'>已作废</span>"; 
			}else if(value == 3){
				return "<span style='color:green; font-weight:bold'>执行完成</span>"; 
			}else if(value == 4){
				return "<span style='color:red; font-weight:bold'>暂停</span>"; 
			}
		}
//显示新增或修改窗口
function contractStage_win_show(type){
contractStage_create_win.type=type;
	if(type=="create"){
		var record = AOS.selectone(Ext.getCmp('projContract_grid'));
		if(AOS.empty(record)){
<!-- 			AOS.tip('请先选择合同数据。'); -->
			return;
		}
		if(AOS.rows(projContract_grid)>1){
<!-- 			AOS.tip('请选择一条合同数据。'); -->
			return;
		}
		AOS.reset(contractStage_create_form);
		contractStage_create_win.setTitle("新增合同明细信息");
		contractStage_create_win.show();
		var record_projContract_grid = AOS.selectone(Ext.getCmp('projContract_grid'));
		contractStage_create_form.loadRecord(record_projContract_grid);
	}else{
		AOS.reset(contractStage_create_form);
		var record = AOS.selectone(contractStage_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		contractStage_create_form.loadRecord(record);
		contractStage_create_win.setTitle("修改合同明细信息");
		contractStage_create_win.show();
	}
}
//查询
function contractStage_query(ct_id) {
	var params = AOS.getValue('query_form');
    contractStage_grid_store.getProxy().extraParams = {
    	ct_id : ct_id
    };
    contractStage_grid_store.loadPage(1);
}
//新增
function contractStage_create() {
	AOS.ajax({
		forms : contractStage_create_form,
		url : contractStage_create_win.type=="update" ? 'contractStageService.update':'contractStageService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			contractStage_grid_store.reload();
			contractStage_create_win.hide();
		}
	});
}
//修改
function contractStage_update() {
	contractStage_win_show('update');
}
//删除
function contractStage_delete(){
	var selection = AOS.selection(contractStage_grid, 'stage_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(contractStage_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'contractStageService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				contractStage_grid_store.reload();
			}
		});
	});
}