<%@ page contentType="text/html; charset=utf-8"%>
//面试结果渲染
 function fn_render_result(value, metaData, record) {
		if (value =="1") {
		return "<span style='color:red; font-weight:bold'>已登记</span>";
		} else if(value =="2"){
			return "<span style='color:blue; font-weight:bold'>已通知</span>";
		}else if(value =="3"){
			return "<span style='color:green; font-weight:bold'>已面试</span>";
		}else if(value =="4"){
			return "<span style='color:green; font-weight:bold'>已入职</span>";
		}else if(value =="5"){
			return "<span style='color:gray; font-weight:bold'>已拒绝</span>";
		}
		return value;
	}
	//通知结果
  	function fn_contact_result(value, metaData, record){
  	if (value =="1") {
		return "<span style='color:green; font-weight:bold'>来</span>";
		} else if(value =="2"){
			return "<span style='color:gray; font-weight:bold'>不来</span>";
		}
		return value;
  	}
	//面试结论渲染
	 function fn_render_interview(value, metaData, record) {
		if (value =="1") {
		return "<span style='color:green; font-weight:bold'>录用</span>";
		} else if(value =="2"){
			return "<span style='color:gray; font-weight:bold'>不录用</span>";
		}
		return value;
	}
	//双击修改
	function interviewedit_show(){
	     var recorda = AOS.selectone(interviewRecords_grid, true);
		interviewRecords_update_form.loadRecord(recorda);
		interviewRecords_update_win.show();
	}
	//双击修改
	function recruitwin_show(){
	var record = AOS.selectone(recruitmentManagement_grid, true);
	if(record.data.state=="1"){
		recruitmentManagement_update_form.loadRecord(record);
		recruitmentManagement_update_win.show();
	//AOS.hides(recruitmentManagement_update_form, 'entry_date,entry_type,entry_post,experience,train_situation,result_remark');
	}else if(record.data.state=="2"){
	     if(AOS.empty(record)){
	     AOS.tip("请选择一条需要通知的人员信息！");
	     return;
	     }
		notice_create_form.loadRecord(record);
		notice_create_win.show();
	}else if(record.data.state=="3"){
	     var recorda = AOS.selectone(interviewRecords_grid, true);
	     if(AOS.empty(recorda)){
	     AOS.tip("请选择一条需要修改的面试记录！");
	     return;
	     }
		interviewRecords_update_form.loadRecord(recorda);
		interviewRecords_update_win.show();
	
	}else if(record.data.state=="4"){
		entryRegistration_update_form.loadRecord(record);
		entryRegistration_update_win.show();
		//AOS.shows(recruitmentManagement_update_form, 'entry_date,entry_type,entry_post,experience,train_situation,result_remark');
	}else if(record.data.state=="5"){
	      AOS.tip("改人员已拒绝入职！");
	     return;
		}
	
	}
	
//显示按钮新增或修改窗口
function recruitmentManagement_win_show(type){
//登记
	if(type=="1"){
		AOS.reset(recruitmentManagement_create_form);
		//AOS.hides(recruitmentManagement_create_form, 'entry_date,entry_type,entry_post,experience,train_situation,result_remark');
		recruitmentManagement_create_form.down("hiddenfield[name=state]").setValue("1");
		recruitmentManagement_create_win.show();
	}else if(type=="2"){
		AOS.reset(notice_create_form);
			var rows = AOS.rows(recruitmentManagement_grid);
		if(rows==0){
			AOS.tip('请选择<b>已登记</b>的人员信息记录。');
				return;
		} 
		var record = AOS.selectone(recruitmentManagement_grid, true);
		 if (rows>1){
			AOS.tip('请选择<b>一条</b>人员信息记录。');
				return;
		}
		if (rows==1 && record.data.state!="1"){
			AOS.tip('请选择<b>一条已登记</b>的人员信息记录。');
				return;
		}
		notice_create_form.loadRecord(record);
		notice_create_win.show();
		notice_create_form.down("datefield[name=contact_date]").setValue('${time}');
		notice_create_form.down("textfield[name=contact_user_name]").setValue('${name}');
		notice_create_form.down("hiddenfield[name=contact_user_id]").setValue('${userid}');
	}else if(type=="3"){
	//面试
			var rows = AOS.rows(recruitmentManagement_grid);
		if(rows==0){
			AOS.tip('请选择人员信息记录。');
				return;
		} 
		var record = AOS.selectone(recruitmentManagement_grid, true);
		 if (rows>1){
			AOS.tip('请选择<b>一条</b>的人员信息记录。');
				return;
		}
		//alert(record.data.contact_result);
		if (rows==1){
		interviewRecords_create_form.loadRecord(record);
		interviewRecords_create_win.show();
		var notify_interview_date=interviewRecords_create_form.down("datefield[name=notify_interview_date]").getValue();
		notify_interview_date=Ext.Date.format(notify_interview_date,"Y-m-d");
		if(notify_interview_date>'${time}'){
			interviewRecords_create_form.down("datefield[name=interview_date]").setValue(notify_interview_date);
		}else{
			interviewRecords_create_form.down("datefield[name=interview_date]").setValue('${time}');
		}
		}else{
		AOS.tip('请选择<b>一条</b>人员信息记录。');
				return;
		}
	}else if(type=="4"){
		var rows = AOS.rows(recruitmentManagement_grid);
		if(rows==0){
			AOS.tip('请选择<b>已面试</b>的人员信息记录。');
				return;
		} 
		var record = AOS.selectone(recruitmentManagement_grid, true);
		 if (rows>1){
			AOS.tip('请选择<b>一条已面试</b>的人员信息记录。');
				return;
		}
		if (rows==1 && record.data.state!="2"&&record.data.interview_result=="2"){
			AOS.tip('请选择<b>一条已面试并录用</b>的人员信息记录。');
				return;
		}
		entryRegistration_create_form.loadRecord(record);
		entryRegistration_create_win.show();
				//实际面试时间
		var interview_date=	record.data.interview_date;
		if(interview_date>'${time}'){
			entryRegistration_create_form.down("datefield[name=entry_date]").setValue(interview_date);
		}else{
			entryRegistration_create_form.down("datefield[name=entry_date]").setValue('${time}');
		}
		//AOS.shows(recruitmentManagement_update_form, 'entry_date,entry_type,entry_post,experience,train_situation,result_remark');
	}else if(type=="5"){
		var rows = AOS.rows(recruitmentManagement_grid);
		if(rows==0){
			AOS.tip('请选择人员信息记录。');
				return;
		} 
		var record = AOS.selectone(recruitmentManagement_grid, true);
		 if (rows>1){
			AOS.tip('请选择<b>一条</b>人员信息记录。');
				return;
		}
		if (rows==1 && record.data.state!="2"&&record.data.interview_result=="2"){
			AOS.tip('请选择<b>一条已面试通过</b>的人员信息记录。');
				return;
		}
			var msg =  AOS.merge('确认该人员已拒绝入职吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			AOS.ajax({
				url : 'recruitmentManagementService.update',
				params:{
					register_id: record.data.register_id,
					state:"5"
				},
				ok : function(data) {
					AOS.tip("操作成功");	
					recruitmentManagement_grid_store.reload();
				}
				});
			});
		//entryRegistration_create_form.loadRecord(record);
		//entryRegistration_create_win.show();
		//AOS.shows(recruitmentManagement_update_form, 'entry_date,entry_type,entry_post,experience,train_situation,result_remark');
	}
}
//单击查询面试记录
		function interview_show(){
		var params = AOS.getValue('f_query_recruitManage');
	var selection = AOS.selection(recruitmentManagement_grid, 'register_id');
	interviewRecords_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	interview_date:params.interview_date,
    	notify_entry_time:params.notify_entry_time,
    	interview_result:params.interview_result,
    	register_id:selection,
    	entry_type:params.entry_type,
    	entry_post:params.entry_post
    };
    interviewRecords_grid_store.loadPage(1);
		}
		//查询面试记录信息
function interviewRecords_query() {
	//var params = AOS.getValue('query_form');
    //interviewRecords_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
   // };
    interviewRecords_grid_store.loadPage(1);
}
//查询
function recruitmentManagement_query() {
	var params = AOS.getValue('f_query_recruitManage');
	if(AOS.empty(params.notify_interview_date_begin)&&!AOS.empty(params.notify_interview_date_end)){
	AOS.tip("请选择约定面试开始日期");
	return;
	}
	if(!AOS.empty(params.notify_interview_date_begin)&&AOS.empty(params.notify_interview_date_end)){
	AOS.tip("请选择约定面试结束日期");
	return;
	}
	if(params.notify_interview_date_begin>params.notify_interview_date_end){
	AOS.tip("约定面试开始日期不能大于结束日期");
	return;
	}
	if(AOS.empty(params.entry_date_begin)&&!AOS.empty(params.entry_date_end)){
	AOS.tip("请选择实际入职开始日期");
	return;
	}
	if(!AOS.empty(params.entry_date_begin)&&AOS.empty(params.entry_date_end)){
	AOS.tip("请选择实际入职结束日期");
	return;
	}
	if(params.entry_date_begin>params.entry_date_end){
	AOS.tip("实际入职开始日期不能大于结束日期");
	return;
	}
    recruitmentManagement_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    	name:params.name,
    	link_phone:params.link_phone,
    	notify_interview_date_begin:params.notify_interview_date_begin,
    	notify_interview_date_end:params.notify_interview_date_end,
    	interview_result:params.interview_result,
    	state:params.state,
    	entry_date_begin:params.entry_date_begin,
    	entry_date_end:params.entry_date_end,
    	entry_type:params.entry_type,
    	entry_post:params.entry_post
    };
    recruitmentManagement_grid_store.loadPage(1);
     interviewRecords_grid_store.getProxy().extraParams = {
    	name:params.name,
    	link_phone:params.link_phone,
    	notify_interview_date_begin:params.notify_interview_date_begin,
    	notify_interview_date_end:params.notify_interview_date_end,
    	interview_result:params.interview_result,
    	state:params.state,
    	entry_date_begin:params.entry_date_begin,
    	entry_date_end:params.entry_date_end,
    	entry_type:params.entry_type,
    	entry_post:params.entry_post
   };
    interviewRecords_grid_store.loadPage(1);
}
//新增登记
function recruitmentManagement_create() {
	AOS.ajax({
		forms : recruitmentManagement_create_form,
		url : 'recruitmentManagementService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			recruitmentManagement_grid_store.reload();
			recruitmentManagement_create_win.hide();
		}
	});
}
//修改登记/通知
function recruitmentManagement_update() {
	AOS.ajax({
		forms : recruitmentManagement_update_form,
		url : 'recruitmentManagementService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			recruitmentManagement_grid_store.reload();
			recruitmentManagement_update_win.hide();
		}
	});
}
//通知
function notice_update() {
	AOS.reset(recruitmentManagement_create_form);
	AOS.ajax({
		forms : notice_create_form,
		url : 'recruitmentManagementService.update',
		params:{
			state:2
		},
		ok : function(data) {
			AOS.tip("操作成功");
			recruitmentManagement_grid_store.reload();
			notice_create_win.hide();
		}
	});
}
//新增面试
function interviewRecords_create(v) {
	var interview_date= interviewRecords_create_form.down("datefield[name=interview_date]").getValue();
	AOS.ajax({
		forms : interviewRecords_create_form,
		url : 'interviewRecordsService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			interviewRecords_grid_store.reload();
			recruitmentManagement_grid_store.reload();
			interviewRecords_create_win.hide();
		}
	});
}
//修改面试
function interviewRecords_update() {
var interview_date= interviewRecords_update_form.down("datefield[name=interview_date]").getValue();
	AOS.ajax({
		forms : interviewRecords_update_form,
		url : 'interviewRecordsService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			interviewRecords_grid_store.reload();
			recruitmentManagement_grid_store.reload();
			interviewRecords_update_win.hide();
		}
	});
}
//新增入职
function entryRegistration_create() {
	AOS.ajax({
		forms : entryRegistration_create_form,
		url : 'recruitmentManagementService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			recruitmentManagement_grid_store.reload();
			entryRegistration_create_win.hide();
		}
	});
}
//修改入职
function entryRegistration_update() {
	AOS.ajax({
		  forms : entryRegistration_update_form,
			url : 'recruitmentManagementService.update',
		  params:{
				state:3
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				recruitmentManagement_grid_store.reload();
				entryRegistration_update_win.hide();
			}
	});
}

//导出
function print_list(){
//
				var selection = AOS.selection(recruitmentManagement_grid,'register_id');
				var listIds = AOS.selection(recruitmentManagement_grid,'register_id');
				if(selection.length == 0){
					AOS.tip("导出前请选择数据。");
					return;
				}
				var record = AOS.select(recruitmentManagement_grid);
				AOS.file('do.jhtml?router=recruitmentManagementService.exportExcel&juid=${juid}&selection='+selection);
			
}
//删除
function recruitmentManagement_delete(){
	var selection = AOS.selection(recruitmentManagement_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(recruitmentManagement_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条bs_recruitment_management记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'recruitmentManagementService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				recruitmentManagement_grid_store.reload();
			}
		});
	});
}