<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projWeek_win_show(type){
		projWeek_create_win.type=type;
	if(type=="create"){
		AOS.reset(projWeek_create_form);
		var proj_name=query_form.getRawValue();
		var proj_id=query_form.getValue();
		AOS.setValue('projWeek_create_form.proj_name',proj_name); 
		AOS.setValue('projWeek_create_form.proj_id',proj_id); 
		projWeek_create_win.show();
	}else{
		AOS.reset(projWeek_update_form);
		var record = AOS.selectone(projWeek_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
			if(record.data.state==1){
			AOS.tip('该数据已启用，无法修改！');
			return;
		}
		projWeek_update_form.loadRecord(record);
		projWeek_update_win.show();
	}
}

//查询
function projWeek_query() {
        var params = {
				proj_id:query_form.getValue()
		};
		projWeek_grid_store.getProxy().extraParams = params;
    projWeek_grid_store.loadPage(1);
}
	//默认选中第一个项目
	window.onload = function combobox_select(){
		var value = AOS.get('query_form').store.getAt(0).raw.value;
		AOS.get('query_form').setValue(value);
		projWeek_query();
	}
//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
//新增
function projWeek_create() {
	AOS.ajax({
		forms : projWeek_create_form,
		url : 'projWeekService.create',
			params:{
				proj_id: AOS.get('query_form').getValue()
			},
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWeek_grid_store.reload();
			projWeek_create_win.hide();
		}
	});
}
//修改
function projWeek_update() {
	AOS.ajax({
		forms : projWeek_update_form,
		url : 'projWeekService.update',
			params:{
				proj_id: AOS.get('query_form').getValue()
			},
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWeek_grid_store.reload();
			projWeek_update_win.hide();
		}
	});
}
//停用
		function g_module_upstate(){
			var selection = AOS.selection(projWeek_grid, 'week_id');
			var rows = AOS.rows(projWeek_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要停用的数据！');
				return;
			}
			var rows = AOS.rows(projWeek_grid);
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			AOS.ajax({
				url : 'projWeekService.updateState',
				params:{
					aos_rows: selection,
					state:"0"
				},
				ok : function(data) {
					AOS.tip("已停用");	
					projWeek_grid_store.reload();
				}
				});
			});
		}
			function g_module_submit(){
			var selection = AOS.selection(projWeek_grid, 'week_id');
			var rows = AOS.rows(projWeek_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要启用的数据！');
				return;
			}
			var rows = AOS.rows(projWeek_grid);
			var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			AOS.ajax({
				url : 'projWeekService.updateState',
				params:{
					aos_rows: selection,
					state:"1"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);	
					projWeek_grid_store.reload();
				}
			});
			});
		 }
//删除
function projWeek_delete(){
	var selection = AOS.selection(projWeek_grid, 'week_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(projWeek_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projWeekService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projWeek_grid_store.reload();
			}
		});
	});
}