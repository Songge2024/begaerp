<%@ page contentType="text/html; charset=utf-8"%>
//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
//显示新增或修改窗口
function projRoleTypes_win_show(type){
var record = AOS.selectone(projRoleTypes_grid, true);
	if(type=="create"){
		AOS.reset(projRoleTypes_create_form);
		projRoleTypes_create_win.show();
	}else{
		AOS.reset(projRoleTypes_update_form);
		var selection = AOS.selection(projRoleTypes_grid, 'trp_code');
		AOS.reads(projRoleTypes_update_form,'trp_name');
		var rows = AOS.rows(projRoleTypes_grid);
		if(AOS.empty(selection)||rows>1){
			AOS.tip('请选择一条需要修改的数据');
			return;
		}
		var record = AOS.selectone(projRoleTypes_grid);
		projRoleTypes_update_form.loadRecord(record);
		projRoleTypes_update_win.show();
	}
}
//查询
function projRoleTypes_query() {
	var params = AOS.getValue('query_form');
     var params = {
				trp_name: query_form.getValue()
		};
	projRoleTypes_grid_store.getProxy().extraParams = params;
    projRoleTypes_grid_store.loadPage(1);
}
//新增
function projRoleTypes_create() {
	AOS.ajax({
		forms : projRoleTypes_create_form,
		url : 'projRoleTypesService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projRoleTypes_grid_store.reload();
			projRoleTypes_create_win.hide();
		}
	});
}
//修改
function projRoleTypes_update() {
	AOS.ajax({
		forms : projRoleTypes_update_form,
		url : 'projRoleTypesService.update',
		ok : function(data) {
			AOS.tip("修改成功");
			projRoleTypes_grid_store.reload();
			projRoleTypes_update_win.hide();
		}
	});
}
//停用
function ProjRoleTypes_upstate() {
		var selection = AOS.selection(projRoleTypes_grid, 'trp_code');
			var rows = AOS.rows(projRoleTypes_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要停用的数据！');
				return;
			}
			var rows = AOS.rows(projRoleTypes_grid);
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
	AOS.ajax({
		url : 'projRoleTypesService.updateState',
		params:{
		aos_rows: selection,
		state:"0"
		},
		ok : function(data) {
			AOS.tip("停用成功");
			projRoleTypes_grid_store.reload();
		}
	});
	});
}
//启用
function submitProjRoleTypes() {
var selection = AOS.selection(projRoleTypes_grid, 'trp_code');
			var rows = AOS.rows(projRoleTypes_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要启用的数据！');
				return;
			}
			var rows = AOS.rows(projRoleTypes_grid);
			var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
	AOS.ajax({
		url : 'projRoleTypesService.updateState',
		params:{
		aos_rows: selection,
		state:"1"
		},
		ok : function(data) {
			AOS.tip("启用成功");
			projRoleTypes_grid_store.reload();
		}
	});
	});
}
//删除
function projRoleTypes_delete(){
var selection = AOS.selection(projRoleTypes_grid, 'trp_code');
			var rows = AOS.rows(projRoleTypes_grid);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据！');
				return;
			}
			var rows = AOS.rows(projRoleTypes_grid);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
		AOS.ajax({
			url : 'projRoleTypesService.delProjRoleInfo',
			params:{
			aos_rows: selection,
				state:"-1"
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projRoleTypes_grid_store.reload();
			}
	});
	});
}
//按钮列转换
	function fn_button_render(value, metaData, record) {
		return '<input type="button" value="修改" class="cbtn" onclick="projRoleTypes_update_show();" />';
	}
	
	//按钮列转换
	function fn_button_del(value, metaData, record) {
		return '<input type="button" value="删除" class="cbtn" onclick="fn_del();" />';
	}