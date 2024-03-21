<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function recruiterlist_win_show(type){
	if(type=="create"){
		AOS.reset(recruiterlist_create_form);
		recruiterList_create_win.show();
	}else{
		AOS.reset(recruiterlist_update_form);
		var record = AOS.selectone(recruiterlist_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		recruiterlist_update_form.loadRecord(record);
		recruiterlist_update_win.show();
	}
}
//双击打开修改界面
function recruiterlist_win_update() {
	recruiterlist_win_show('update');
}
//查询
function recruiterlist_query() {
	var params = AOS.getValue('f_query_recruiter');
    recruiterlist_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	interview_result:params.interview_result,
    	notify_entry_time:params.notify_entry_time,
    	entry_type:params.entry_type,
    	entry_post:params.entry_post
    };
    recruiterlist_grid_store.loadPage(1);
}
//新增
function recruiterlist_create() {
	var contact_date= recruiterlist_create_form.down("datefield[name=contact_date]").getValue();
	var interview_date= recruiterlist_create_form.down("datefield[name=interview_date]").getValue();
	var notify_entry_time= recruiterlist_create_form.down("datefield[name=notify_entry_time]").getValue();
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
		forms : recruiterlist_create_form,
		url : 'recruiterlistService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			recruiterlist_grid_store.reload();
			recruiterlist_create_win.hide();
		}
	});
}
//修改
function recruiterlist_update() {
var contact_date= recruiterlist_update_form.down("datefield[name=contact_date]").getValue();
	var interview_date= recruiterlist_update_form.down("datefield[name=interview_date]").getValue();
	var notify_entry_time= recruiterlist_update_form.down("datefield[name=notify_entry_time]").getValue();
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
		forms : recruiterlist_update_form,
		url : 'recruiterlistService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			
			recruiterlist_grid_store.reload();
			recruiterlist_update_win.hide();
		}
	});
}
//删除
function recruiterlist_delete(){
	var selection = AOS.selection(recruiterlist_grid, 'register_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(recruiterlist_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'recruiterlistService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				recruiterlist_grid_store.reload();
			}
		});
	});
}


//面试结果渲染
 function fn_render_result(value, metaData, record) {
		if (value =="1") {
		return "<span style='color:gray; font-weight:bold'>未通过</span>";
		} else if(value =="2"){
			return "<span style='color:blue; font-weight:bold'>已通知上班</span>";
		}else if(value =="3"){
			return "<span style='color:green; font-weight:bold'>已办理入职</span>";
		}else if(value =="4"){
			return "<span style='color:red; font-weight:bold'>拒绝入职</span>";
		}
		return value;
	}
	
	
//导出
function print_list(){
//
				var selection = AOS.selection(recruiterlist_grid,'register_id');
				var listIds = AOS.selection(recruiterlist_grid,'register_id');
				if(selection.length == 0){
					AOS.tip("导出前请选择数据。");
					return;
				}
				var record = AOS.select(recruiterlist_grid);
				AOS.file('do.jhtml?router=recruiterResultService.exportExcel&juid=${juid}&selection='+selection);
			
}	
	