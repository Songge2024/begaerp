<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function projVersion_win_show(type){
	if(type=="create"){
		AOS.reset(projVersion_create_form);
		var proj_id = id_proj_name.getValue();
		if(proj_id == null || proj_id == ''){
			AOS.tip('请先选择项目再新增！');
			return;
		}
		AOS.setValue('projVersion_create_form.proj_id',proj_id);
		projVersion_create_win.show();
	}else{
		AOS.reset(projVersion_update_form);
		var record = AOS.selectone(projVersion_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		if(record.data.state == '1'){
			AOS.tip('已启用的版本号无法修改');
			return;
		}
		projVersion_update_form.loadRecord(record);
		projVersion_update_win.show();
	}
}

//新增
function projVersion_create() {
	AOS.ajax({
		forms : projVersion_create_form,
		url : 'projVersionService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projVersion_grid_store.reload();
			projVersion_create_win.hide();
		}
	});
}
//修改
function projVersion_update() {
	AOS.ajax({
		forms : projVersion_update_form,
		url : 'projVersionService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projVersion_grid_store.reload();
			projVersion_update_win.hide();
		}
	});
}
//删除/启用/停用
function projVersion_delete(state){
	var selection = AOS.selection(projVersion_grid, 'version_id');
	if(AOS.empty(selection)){
		if(state == 1){
			AOS.tip('请选择需要启用的数据。');
			return;
		}
		if(state == 0){
			AOS.tip('请选择需要停用的数据。');
			return;
		}
		if(state == -1){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
	}
	var rows = AOS.rows(projVersion_grid);
	if(state == 1){
		var grid = AOS.select(projVersion_grid);
		var versionstate = grid[0].data.state;
			if(versionstate == 0){
			var msg =  AOS.merge('确认要启用选中的{0}条数据吗？ <br>如确认执行,会将右边的版本号一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经启用!');
				return;
			}
	}
	if(state == 0){
		var grid = AOS.select(projVersion_grid);
		var versionstate = grid[0].data.state;
			if(versionstate == 1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？ <br>如确认执行,会将右边的版本号一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经停用!');
				return;
			}
	}
	if(state == -1){
		var grid = AOS.select(projVersion_grid);
		var versionstate = grid[0].data.state;
			if(versionstate == 0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？ <br>如确认执行,会将右边的版本号一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经启用,不得删除!');
				return;
			}
	}
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'projVersionService.delete',
			params:{
				aos_rows : selection,
				version_id : selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projVersion_grid_store.reload();
				projTestVersion_grid_store.reload();
				projCodeVersion_grid_store.reload();
			}
		});
	});
}