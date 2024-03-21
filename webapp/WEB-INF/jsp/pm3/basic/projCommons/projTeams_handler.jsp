<%@ page contentType="text/html; charset=utf-8"%>
//监听单元格编辑事件人员考核
		  function fn_check_user(me) {
		            var record= AOS.selectone(projTeams_grid,true);
					AOS.ajax({
						params : {
								id : record.data.team_user_id,
								check_user_id:  me.getValue()
						},
						url : 'userService.updateCheckUser',
						ok : function(data) {
							AOS.tip(data.appmsg);
							projTeams_grid_store.reload();
							 me.fireEvent('blur');
						}
					});
				}
//显示新增或修改窗口
function projTeams_win_show(type){
	AOS.reads(projTeams_create_form, 'proj_id');
	projTeams_create_win.type=type;
<!-- 	projTeams_create_form.down('combobox[name=proj_id]').hide(); -->
	if(type=="create"){
		var record = AOS.selectone(Ext.getCmp('projCommons_grid'));
		if(AOS.empty(record)){
			AOS.tip('请先选择项目数据。');
			return;
		}
		if(AOS.rows(projCommons_grid)>1){
			disGridTab();
			AOS.tip('请选择一条项目数据。');
			return;
		}
		AOS.reset(projTeams_create_form);
		projTeams_create_win.setTitle("新增团队信息");
		projTeams_create_win.show();
		AOS.setValue('projTeams_create_form.proj_id', record.data.proj_id); 
		projTeams_create_form.down('combobox[name=team_user_id]').setReadOnly(false);
	}else{
		AOS.reset(projTeams_create_form);
		var record = AOS.selectone(projTeams_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		projTeams_create_win.show();
		projTeams_create_form.loadRecord(record);
		projTeams_create_win.setTitle("修改团队信息");
		AOS.setValue('projTeams_create_form.proj_id', record.data.proj_id); 
		projTeams_create_form.down('combobox[name=team_user_id]').setReadOnly(true);
	}
	var record_projCommons_grid = AOS.selectone(Ext.getCmp('projCommons_grid'));
	projTeams_create_form.loadRecord(record_projCommons_grid);
}

//监听单元格编辑事件
  function fn_task_user(me) {
            var recode= AOS.selectone(projTeams_grid,true);
			AOS.ajax({
				params : {
					team_id : recode.data.team_id,
					 develop_task_user:  me.getValue()
				},
				url : 'projCommonsService.saveCellEditGrid',
				ok : function(data) {
					AOS.tip(data.appmsg);
					projTeams_grid_store.reload();
					 me.fireEvent('blur');
					
				}
			});
		}
	


//查询
function projTeams_query(proj_id) {
    projTeams_grid_store.getProxy().extraParams = {
    	proj_id:proj_id
    };
    projTeams_grid_store.loadPage(1);
   
}
//新增
function projTeams_create() {
	AOS.ajax({
		forms : projTeams_create_form,
		url : projTeams_create_win.type=="update" ? 'projTeamsService.update':'projTeamsService.create',
		ok : function(data) {
			AOS.tip("新增成功");
			projTeams_grid_store.reload();
			projTeams_create_win.hide();
			}
	});
}
//修改
function projTeams_update() {
	projTeams_win_show('update');
}
//删除
function projTeams_delete(){
	var selection = AOS.selection(projTeams_grid, 'team_id');
	if(AOS.empty(selection)){
		AOS.tip('b、请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(projTeams_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projTeamsService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTeams_grid_store.reload();
			}
		});
	});
}