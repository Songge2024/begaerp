<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projContract_win_show(type){
AOS.reads(projContract_create_form, 'proj_id');
	projContract_create_win.type=type;
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
		AOS.reset(projContract_create_form);
		AOS.setValue('projContract_create_form.proj_id', record.data.proj_id); 
		projContract_create_win.setTitle("新增项目合同信息");
		projContract_create_win.show();
	}else{
		AOS.reset(projContract_create_form);
		var record = AOS.selectone(projContract_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		projContract_create_form.loadRecord(record);
		projContract_create_win.setTitle("修改项目合同信息");
		projContract_create_win.show();
	}
	var record_projCommons_grid = AOS.selectone(Ext.getCmp('projCommons_grid'));
	projContract_create_form.loadRecord(record_projCommons_grid);
}
//新增
function projContract_create() {
	AOS.ajax({
		forms : projContract_create_form,
		url : projContract_create_win.type=="update" ? 'projContractService.update':'projContractService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projContract_grid_store.reload();
			projContract_create_win.hide();
		}
	});
}
//修改
function projContract_update() {
	projContract_win_show('update');
}
//删除
function projContract_delete(){
	var selection = AOS.selection(projContract_grid, 'ct_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(projContract_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projContractService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projContract_grid_store.reload();
			}
		});
	});
}
//点击事件
function projContract_grid_click(me, record){
	var selection = AOS.selection(projContract_grid, 'ct_id');
	if(AOS.empty(selection)){
		return;
	}
	contractStage_query(selection);
	projContract_formpanel.loadRecord(AOS.selectone(projContract_grid, true));
}
//项目合同开始时间change事件
function cp_bengin_date_onselect(v){
	if(AOS.empty(v.rawValue)){
			return;
		}
	projContract_create_form.down('datefield[name=cp_end_date]').setMinValue(v.rawValue);
}