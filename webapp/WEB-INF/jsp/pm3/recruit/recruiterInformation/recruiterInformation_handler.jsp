<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function recruiterInformation_win_show(type){
	if(type=="create"){
		AOS.reset(recruiterInformation_create_form);
		recruiterInformation_create_win.show();
	}else{
		AOS.reset(recruiterInformation_update_form);
		var record = AOS.selectone(recruiterInformation_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		recruiterInformation_update_form.loadRecord(record);
		recruiterInformation_update_win.show();
	}
}
//双击打开修改界面
function recruiterInformation_win_update() {
	recruiterInformation_win_show('update');
}
//查询
function recruiterInformation_query() {
	var params = AOS.getValue('f_query_recruiter');
    recruiterInformation_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time
    };
    recruiterInformation_grid_store.loadPage(1);
}
//新增
function recruiterInformation_create() {
	var contact_date= recruiterInformation_create_form.down("datefield[name=contact_date]").getValue();
	var interview_date= recruiterInformation_create_form.down("datefield[name=interview_date]").getValue();
	var notify_entry_time= recruiterInformation_create_form.down("datefield[name=notify_entry_time]").getValue();
		if(contact_date>interview_date){
		AOS.tip("联系日期不能大于约定面试日期！");
		return;
		}
		if(AOS.empty(notify_entry_time)){
		
		}else{
		if(interview_date>notify_entry_time){
		AOS.tip("约定面试日期不能大于通知入职时间！");
		return;
		}
		if(contact_date>notify_entry_time){
		AOS.tip("联系日期不能大于通知入职时间！");
		return;
		}
		}
		
	AOS.ajax({
		forms : recruiterInformation_create_form,
		url : 'recruiterInformationService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			recruiterInformation_grid_store.reload();
			recruiterInformation_create_win.hide();
		}
	});
}
//修改
function recruiterInformation_update() {
var contact_date= recruiterInformation_update_form.down("datefield[name=contact_date]").getValue();
	var interview_date= recruiterInformation_update_form.down("datefield[name=interview_date]").getValue();
	var notify_entry_time= recruiterInformation_update_form.down("datefield[name=notify_entry_time]").getValue();
		if(contact_date>interview_date){
		AOS.tip("联系日期不能大于约定面试日期！");
		return;
		}
		if(contact_date>interview_date){
		AOS.tip("联系日期不能大于约定面试日期！");
		return;
		}
		if(AOS.empty(notify_entry_time)){
		
		}else{
		if(interview_date>notify_entry_time){
		AOS.tip("约定面试日期不能大于通知入职时间！");
		return;
		}
		if(contact_date>notify_entry_time){
		AOS.tip("联系日期不能大于通知入职时间！");
		return;
		}
		}
	AOS.ajax({
		forms : recruiterInformation_update_form,
		url : 'recruiterInformationService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			
			recruiterInformation_grid_store.reload();
			recruiterInformation_update_win.hide();
		}
	});
}
//删除
function recruiterInformation_delete(){
	var selection = AOS.selection(recruiterInformation_grid, 'register_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(recruiterInformation_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'recruiterInformationService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				recruiterInformation_grid_store.reload();
			}
		});
	});
}