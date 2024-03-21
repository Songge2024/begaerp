<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projSituationCount_win_show(type){
	if(type=="create"){
		AOS.reset(projSituationCount_create_form);
		projSituationCount_create_win.show();
	}else{
		AOS.reset(projSituationCount_update_form);
		var record = AOS.selectone(projSituationCount_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		projSituationCount_update_form.loadRecord(record);
		projSituationCount_update_win.show();
	}
}
//导出明细excel
	function fn_export_excel_detail(){
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		AOS.file('do.jhtml?router=projSituationCountService.exportExcel&juid=${juid}');
	}
//列增加百分比渲染
function fn_percent(value,meat,recode){
if(value>0){
    return Math.round(value*100)+"%";
    }else
    return value;
}
//查询
function projSituationCount_query() {
	var params = AOS.getValue('query_form');
    projSituationCount_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    projSituationCount_grid_store.loadPage(1);
}
//新增
function projSituationCount_create() {
	AOS.ajax({
		forms : projSituationCount_create_form,
		url : 'projSituationCountService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projSituationCount_grid_store.reload();
			projSituationCount_create_win.hide();
		}
	});
}
//修改
function projSituationCount_update() {
	AOS.ajax({
		forms : projSituationCount_update_form,
		url : 'projSituationCountService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projSituationCount_grid_store.reload();
			projSituationCount_update_win.hide();
		}
	});
}
//删除
function projSituationCount_delete(){
	var selection = AOS.selection(projSituationCount_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(projSituationCount_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条bs_proj_situation_count记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'projSituationCountService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projSituationCount_grid_store.reload();
			}
		});
	});
}