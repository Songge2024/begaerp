<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projWorkloadUserMonth_win_show(type){
	if(type=="create"){
		AOS.reset(projWorkloadUserMonth_create_form);
		projWorkloadUserMonth_create_win.show();
	}else{
		AOS.reset(projWorkloadUserMonth_update_form);
		var record = AOS.selectone(projWorkloadUserMonth_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		projWorkloadUserMonth_update_form.loadRecord(record);
		projWorkloadUserMonth_update_win.show();
	}
}
//新增
function projWorkloadUserMonth_create() {
	AOS.ajax({
		forms : projWorkloadUserMonth_create_form,
		url : 'projWorkloadUserMonthService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWorkloadUserMonth_grid_store.reload();
			projWorkloadUserMonth_create_win.hide();
		}
	});
}
//修改
function projWorkloadUserMonth_update() {
	AOS.ajax({
		forms : projWorkloadUserMonth_update_form,
		url : 'projWorkloadUserMonthService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWorkloadUserMonth_grid_store.reload();
			projWorkloadUserMonth_update_win.hide();
		}
	});
}
//删除
function projWorkloadUserMonth_delete(){
	var selection = AOS.selection(projWorkloadUserMonth_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(projWorkloadUserMonth_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条st_proj_workload_user_month记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'projWorkloadUserMonthService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projWorkloadUserMonth_grid_store.reload();
			}
		});
	});
}