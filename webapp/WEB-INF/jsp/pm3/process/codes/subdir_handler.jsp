<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function subdir_win_show(type){
	if(type=="create"){
		var rows = AOS.rows(rootdir_grid);
		if(rows!=1){
			AOS.tip('新增前请先选择一个裁剪对象!');
			return;
			}
		AOS.reset(subdir_create_form);
		subdir_create_win.show();
	}else{
		AOS.reset(subdir_update_form);
		var record = AOS.selectone(subdir_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		subdir_update_form.loadRecord(record);
		subdir_update_win.show();
	}
}
//查询
function subdir_query() {
	var record = AOS.selectone(rootdir_grid, true);
	var rootdir_id;
	if(AOS.rows(rootdir_grid)==1){
		rootdir_id = record.data.rootdir_id;
	}else{
		rootdir_id = -1;
	}
    subdir_grid_store.getProxy().extraParams = {
    	rootdir_id:rootdir_id
    };
    subdir_grid_store.loadPage(1);
    
    filetype_query();
}
//新增
function subdir_create() {
	var select = AOS.select(rootdir_grid,'rootdir_id');
	var rootdir_id = select[0].data.rootdir_id;
	AOS.ajax({
		forms : subdir_create_form,
		params:{
				rootdir_id : rootdir_id,
		},
		url : 'subdirService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			subdir_grid_store.reload();
			subdir_create_win.hide();
		}
	});
}
//修改
function subdir_update() {
	AOS.ajax({
		forms : subdir_update_form,
		url : 'subdirService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			subdir_grid_store.reload();
			subdir_update_win.hide();
		}
	});
}
//删除
function subdir_delete(state){
	var selection = AOS.selection(subdir_grid,'subdir_id');
	if(AOS.empty(selection)){
		if(state==1){
			AOS.tip('请选择需要启用的数据。');
		return;
		}
		if(state==0){
			AOS.tip('请选择需要停用的数据。');
		return;
		}
		if(state==-1){
			AOS.tip('请选择需要删除的数据。');
		return;
		}
	}
	var rows = AOS.rows(subdir_grid);
	if(state==1){
		var grid =AOS.select(subdir_grid);
		var substate = grid[0].data.state;
		if(substate==0){
				var grid =AOS.select(rootdir_grid);
				var rootstate = grid[0].data.state;
				if(rootstate==1){
					var msg =  AOS.merge('确认要启用选中的{0}条数据吗？ <br>如确认执行,会将右边的文件文档一并执行,请小主三思而定夺!', rows);
				}else{
					AOS.tip('请先启用过程阶段的文件!');
					return;
				}
		}else{
				AOS.tip('此文件已经启用!');
				return;
			 }
	}
	if(state==0){
		var grid =AOS.select(subdir_grid);
		var substate = grid[0].data.state;
			if(substate==1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？ <br>如确认执行,会将右边的输出文档一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经停用!');
				return;
			}
	}
	if(state==-1){
		var grid =AOS.select(subdir_grid);
		var substate = grid[0].data.state;
			if(substate==0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？ <br>如确认执行,会将右边的输出文档一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经启用,不得删除!');
				return;
			}
	}
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'subdirService.delete',
			params:{
				aos_rows: selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				subdir_grid_store.reload();
				filetype_grid_store.reload();
			}
		});
	});
}
//单击
function subdir_grid_click() {
	filetype_query();

}