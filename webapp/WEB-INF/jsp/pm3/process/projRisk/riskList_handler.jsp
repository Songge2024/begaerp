<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function riskList_win_show(type){
	if(type=="create"){
		AOS.reset(riskList_create_form);
		var proj_id= id_proj_name.getValue();
		if(proj_id==undefined){
			AOS.tip("请先选择一个项目!");
			return ;
		}
		AOS.setValue('riskList_create_form.proj_id',proj_id);
		riskList_create_win.setTitle('新增项目风险信息');
		riskList_create_win.show();
	}else{
		AOS.reset(riskList_create_form);
		var record = AOS.selectone(riskList_grid, true);
		var rows = AOS.rows(riskList_grid);
		if(rows!=1){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		riskList_create_win.setTitle('修改项目风险信息');
		riskList_create_form.loadRecord(record);
		riskList_create_win.show();
	}
}
function proj_name_query(){
	var proj_name = AOS.getValue('proj_name');
	t_org_find_store.load({
		params:{
			proj_name : proj_name
		}
	})
}
//查询
function riskList_query() {
	var params = AOS.getValue('query_form');
    riskList_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    riskList_grid_store.loadPage(1);
}
//新增
function riskList_create() {

	var createForm = AOS.getValue('riskList_create_form');
	var risk_id = createForm.risk_id;
	if(risk_id==''){
	AOS.ajax({
		forms : riskList_create_form,
		url : 'riskListService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			riskList_grid_store.reload();
			riskList_create_win.hide();
		}
	});
	}else{
	AOS.ajax({
		forms : riskList_create_form,
		url : 'riskListService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			riskList_grid_store.reload();
			riskList_create_win.hide();
		}
	});
	}
}
//修改
function riskList_update() {
	AOS.ajax({
		forms : riskList_create_form,
		url : 'riskListService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			riskList_grid_store.reload();
			riskList_create_win.hide();
		}
	});
}
//删除
function riskList_delete(){
	var selection = AOS.selection(riskList_grid, 'risk_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(riskList_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条项目风险记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
		//	AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'riskListService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				riskList_grid_store.reload();
			}
		});
	});
}