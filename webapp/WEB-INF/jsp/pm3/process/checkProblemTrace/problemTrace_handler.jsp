<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function problemTrace_win_show(type){
	if(type=="create"){
		AOS.reset(problemTrace_create_form);
		problemTrace_create_win.show();
	}else{
		AOS.reset(problemTrace_update_form);
		var record = AOS.selectone(problemTrace_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		problemTrace_update_form.loadRecord(record);
		problemTrace_update_win.show();
	}
}
//新增
function problemTrace_create() {
	AOS.ajax({
		forms : problemTrace_create_form,
		url : 'problemTraceService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			problemTrace_grid_store.reload();
			problemTrace_create_win.hide();
		}
	});
}
//修改
function problemTrace_update() {
	AOS.ajax({
		forms : problemTrace_update_form,
		url : 'problemTraceService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			problemTrace_grid_store.reload();
			problemTrace_update_win.hide();
		}
	});
}
//删除
function problemTrace_delete(){
	var selection = AOS.selection(problemTrace_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(problemTrace_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条pr_problem_trace记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'problemTraceService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				problemTrace_grid_store.reload();
			}
		});
	});
}