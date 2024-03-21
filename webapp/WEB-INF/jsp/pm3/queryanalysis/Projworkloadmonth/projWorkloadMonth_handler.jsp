<%@ page contentType="text/html; charset=utf-8"%>
var groupCollapses;
//列表行点击
AOS.get('projWorkloadMonth_grid').view.on('groupclick',function(view,node,group,groupthis ){
view.features[0].collapseAll();
groupCollapses=group;
});
//列表行选择
AOS.get('projWorkloadMonth_grid').on('beforeselect',function(obj, record, index, e){
		var newIndex=record.index;
		var groups=obj.getStore().getGroups();
		for(var i=0; i < groups.length-1;i++){
			var gxc_=groups[i];
			var gc=	gxc_.name;
			if(groupCollapses== gc){
			    break;
            }else{
				newIndex+=(gxc_.children.length-1);
			  }
			}
			record=obj.getStore().getAt(newIndex);
			var sm = this.getSelectionModel(); 
			sm.select(record,false,true);
			return false;
}); 
//显示新增或修改窗口
function projWorkloadMonth_win_show(type){
	if(type=="create"){
		AOS.reset(projWorkloadMonth_create_form);
		projWorkloadMonth_create_win.show();
	}else{
		AOS.reset(projWorkloadMonth_update_form);
		var record = AOS.selectone(projWorkloadMonth_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		projWorkloadMonth_update_form.loadRecord(record);
		projWorkloadMonth_update_win.show();
	}
}

//数据渲染时
function _g_grid_onload(){
}

//查询明细
function projWorkloadUserMonth_click() {
	var recode=AOS.selectone(projWorkloadMonth_grid,true);
	console.log(recode);
    projWorkloadUserMonth_grid_store.getProxy().extraParams = {
    	month:recode.data.month,
    	proj_id:recode.data.proj_id
    };
    projWorkloadUserMonth_grid_store.loadPage(1);
}
//查询
function projWorkloadMonth_query() {
	var params = AOS.getValue('query_form');
    projWorkloadMonth_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    projWorkloadMonth_grid_store.loadPage(1);
}
//新增
function projWorkloadMonth_create() {
	AOS.ajax({
		forms : projWorkloadMonth_create_form,
		url : 'projWorkloadMonthService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWorkloadMonth_grid_store.reload();
			projWorkloadMonth_create_win.hide();
		}
	});
}
//修改
function projWorkloadMonth_update() {
	AOS.ajax({
		forms : projWorkloadMonth_update_form,
		url : 'projWorkloadMonthService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projWorkloadMonth_grid_store.reload();
			projWorkloadMonth_update_win.hide();
		}
	});
}

//删除
function projWorkloadMonth_delete(){
	var selection = AOS.selection(projWorkloadMonth_grid, 'id');
console.log(selection);
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(projWorkloadMonth_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条st_proj_workload_month记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'projWorkloadMonthService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projWorkloadMonth_grid_store.reload();
			}
		});
	});
}