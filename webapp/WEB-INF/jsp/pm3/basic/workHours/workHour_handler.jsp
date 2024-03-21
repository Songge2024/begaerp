<%@ page contentType="text/html; charset=utf-8"%>
    //渲染天数
     function fn_hours(value, metaData, record){
           if(AOS.empty(value)){
                return
             }else{
		        return value+"<span  style=' font-size:3px; color:green;'   >天</span>";
		}
    }
    
    //加载表格数据
	function workHour_query() {
	    AOS.setValue('query_form.begin_date','${begin_date}');
		AOS.setValue('query_form.end_date','${end_date}');
	    var params = AOS.getValue('query_form');
	    console.log(params);
	    workHour_grid_store.getProxy().extraParams = params;
		workHour_grid_store.loadPage(1);
		
	
	}
    //导出明细excel
	function fn_export_excel_detail(){
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		var select = AOS.selectone(public_tree,true);
		var proj_id = AOS.empty(select) ? "" : select.raw.id;
		var proj_id_=String(proj_id);
		var begin_date =AOS.getValue('query_form.begin_date');
		var end_date=AOS.getValue('query_form.end_date');
		var  begin_date_ = Ext.Date.format(begin_date, "Y/m/d");
		var  end_date_ = Ext.Date.format(end_date, "Y/m/d");
		AOS.file('do.jhtml?router=workHourService.exportExcel&juid=${juid}&proj_id='+proj_id_+'&begin_date='+begin_date_+'&end_date='+end_date_);
	}
   //过滤
   	function query_button_click() {
	var select = AOS.selectone(public_tree,true);
	var proj_id = AOS.empty(select) ? "" : select.raw.id;
	var proj_id_=String(proj_id);
	var begin_date=AOS.getValue('query_form.begin_date');
	var end_date=AOS.getValue('query_form.end_date');
	workHour_grid_store.getProxy().extraParams = {
		proj_id : proj_id_,
		begin_date:begin_date,
		end_date:end_date
	};
	workHour_grid_store.loadPage(1);
     }
    //时间判断
	function changeweekBdt(){
		  var begin_date=AOS.getValue('query_form.begin_date');
		  var end_date=AOS.getValue('query_form.end_date');
		  if(end_date< begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
			  AOS.setValue('query_form.end_date',null);
    		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
    		  return;
		}
	  }

	//项目树点击方法
	function on_public_tree(view, record, node, item, e) {
		var params = new Object();
		var begin_date=AOS.getValue('query_form.begin_date');
		var end_date=AOS.getValue('query_form.end_date');
		var a = AOS.empty(record) ? "" : record.raw.a;
		var proj_id=record.raw.id;
		var proj_id_=String(proj_id);
		params.proj_id= String(record.data.id);
		params.begin_date=begin_date;
		params.end_date=end_date;
		workHour_grid_store.getProxy().extraParams = params;
		workHour_grid_store.loadPage(1);	
	}
//显示新增或修改窗口
function workHour_win_show(type){
	if(type=="create"){
		AOS.reset(workHour_create_form);
		workHour_create_win.show();
	}else{
		AOS.reset(workHour_update_form);
		var record = AOS.selectone(workHour_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		workHour_update_form.loadRecord(record);
		workHour_update_win.show();
	}
}

//新增
function workHour_create() {
	AOS.ajax({
		forms : workHour_create_form,
		url : 'workHourService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			workHour_grid_store.reload();
			workHour_create_win.hide();
		}
	});
}
//修改
function workHour_update() {
	AOS.ajax({
		forms : workHour_update_form,
		url : 'workHourService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			workHour_grid_store.reload();
			workHour_update_win.hide();
		}
	});
}
//删除
function workHour_delete(){
	var selection = AOS.selection(workHour_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(workHour_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条ta_work_hour记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'workHourService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				workHour_grid_store.reload();
			}
		});
	});
}