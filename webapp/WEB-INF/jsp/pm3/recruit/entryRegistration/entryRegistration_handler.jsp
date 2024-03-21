<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function entryRegistration_win_show(type){
	if(type=="create"){
		AOS.reset(entryRegistration_create_form);
			var selection = AOS.selection(recruiterInformation_grid, 'register_id');
		if(AOS.empty(selection)){
		AOS.tip('请选择招聘人员信息。');
			return;
		}
		var rows = AOS.rows(recruiterInformation_grid);
		if(rows>1){
		AOS.tip('请选择一条招聘人员信息。');
			return;
		}
		var record = AOS.selectone(recruiterInformation_grid, true);
		entryRegistration_create_form.loadRecord(record);
		AOS.setValue('entryRegistration_create_form.result_id',record.data.register_id);
		entryRegistration_create_win.show();
	}else{
		AOS.reset(entryRegistration_update_form);
		var record = AOS.selectone(entryRegistration_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		entryRegistration_update_form.loadRecord(record);
		entryRegistration_update_win.show();
	}
}
//查询
function entryRegistration_query() {
	var params = AOS.getValue('query_form');
    entryRegistration_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    entryRegistration_grid_store.loadPage(1);
}
//新增
function entryRegistration_create() {
	AOS.ajax({
		forms : entryRegistration_create_form,
		url : 'entryRegistrationService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			entryRegistration_grid_store.reload();
			entryRegistration_create_win.hide();
		}
	});
}
//修改
function entryRegistration_update() {
	AOS.ajax({
		forms : entryRegistration_update_form,
		url : 'entryRegistrationService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			entryRegistration_grid_store.reload();
			entryRegistration_update_win.hide();
		}
	});
}
//删除
function entryRegistration_delete(){
	var selection = AOS.selection(entryRegistration_grid, 'entry_id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(entryRegistration_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
		//	AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'entryRegistrationService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				entryRegistration_grid_store.reload();
			}
		});
	});
}
//查询登记信息
function recruiterInformation_query() {
	var params = AOS.getValue('f_query_enterRegistration');
    recruiterInformation_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time
    };
    recruiterInformation_grid_store.loadPage(1);
    entryRegistration_grid_store.getProxy().extraParams = {
    name:params.name,
    link_phone:params.link_phone,
    interview_date:params.interview_date,
    notify_entry_time:params.notify_entry_time,
    interview_result:params.interview_result,
    real_interviewer_time:params.real_interviewer_time
   };
    entryRegistration_grid_store.loadPage(1);
}

	//单击查询事件
		function recruiterInformation_itemquery(){
		var params = AOS.getValue('f_query_enterRegistration');
		var selection = AOS.selection(recruiterInformation_grid, 'register_id');
		entryRegistration_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time,
    	interview_result:params.interview_result,
    	register_id:selection,
    	real_interviewer_time:params.real_interviewer_time
    };
    entryRegistration_grid_store.loadPage(1);
		
	}
