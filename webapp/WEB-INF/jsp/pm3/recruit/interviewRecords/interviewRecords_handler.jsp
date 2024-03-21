<%@ page contentType="text/html; charset=utf-8"%>
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
	//双击显示修改窗口
	function interviewRecords_updateWin(){
	interviewRecords_win_show('update');
	}
//显示新增或修改窗口
function interviewRecords_win_show(type){
	if(type=="create"){
		AOS.reset(interviewRecords_create_form);
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
		interviewRecords_create_form.loadRecord(record);
		interviewRecords_create_win.show();
	}else{
		AOS.reset(interviewRecords_update_form);
		var record = AOS.selectone(interviewRecords_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		var rows = AOS.rows(interviewRecords_grid);
		if(rows>1){
		AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		interviewRecords_update_form.loadRecord(record);
		if(record.data.interview_result=="3"){
		AOS.reads(interviewRecords_update_form,'real_interviewer_time,base_situation,interview_score,written_score,interviewer,interview_result,conclusion');
		}else{
			AOS.edits(interviewRecords_update_form,'real_interviewer_time,base_situation,interview_score,written_score,interviewer,interview_result,conclusion');
		}
		interviewRecords_update_win.show();
	}
}
	//单击查询事件
		function recruiterInformation_itemquery(){
		var params = AOS.getValue('f_query_interviewRecords');
	var selection = AOS.selection(recruiterInformation_grid, 'register_id');
	interviewRecords_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time,
    	interview_result:params.interview_result,
    	register_id:selection,
    	real_interviewer_time:params.real_interviewer_time
    };
    interviewRecords_grid_store.loadPage(1);
		}
//查询登记信息
function recruiterInformation_query() {
	var params = AOS.getValue('f_query_interviewRecords');
    recruiterInformation_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time
    };
    recruiterInformation_grid_store.loadPage(1);
      interviewRecords_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time,
    	interview_result:params.interview_result,
    	real_interviewer_time:params.real_interviewer_time
    };
    interviewRecords_grid_store.loadPage(1);
}
//查询面试记录信息
function interviewRecords_query() {
	var params = AOS.getValue('query_form');
    interviewRecords_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    interviewRecords_grid_store.loadPage(1);
}
//新增
function interviewRecords_create() {
	var interview_date= interviewRecords_create_form.down("datefield[name=interview_date]").getValue();
	var real_interviewer_time= interviewRecords_create_form.down("datefield[name=real_interviewer_time]").getValue();
	if(interview_date>real_interviewer_time){
	AOS.tip("实际面试时间不能小于约定面试时间");
	return;
	}
	AOS.ajax({
		forms : interviewRecords_create_form,
		url : 'interviewRecordsService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			interviewRecords_grid_store.reload();
			interviewRecords_create_win.hide();
		}
	});
}
//修改
function interviewRecords_update() {
var interview_date= interviewRecords_update_form.down("datefield[name=interview_date]").getValue();
	var real_interviewer_time= interviewRecords_update_form.down("datefield[name=real_interviewer_time]").getValue();
	if(interview_date>real_interviewer_time){
	AOS.tip("实际面试时间不能小于约定面试时间");
	return;
	}
	AOS.ajax({
		forms : interviewRecords_update_form,
		url : 'interviewRecordsService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			interviewRecords_grid_store.reload();
			interviewRecords_update_win.hide();
		}
	});
}
//删除
function interviewRecords_delete(){
	var selection = AOS.selection(interviewRecords_grid, 'result_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(interviewRecords_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗?', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'interviewRecordsService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				interviewRecords_grid_store.reload();
			}
		});
	});
}