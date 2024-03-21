<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function rootdir_win_show(type){
	if(type=="create"){
		AOS.reset(rootdir_create_form);
		rootdir_create_win.show();
	}else{
		AOS.reset(rootdir_update_form);
		var record = AOS.selectone(rootdir_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		rootdir_update_form.loadRecord(record);
		rootdir_update_win.show();
	}
}
//查询
function rootdir_query() {
	var params = AOS.getValue('query_form');
    rootdir_grid_store.getProxy().extraParams = {
    };
    rootdir_grid_store.loadPage(1);
    
    subdir_query();
}
//单击
function rootdir_grid_click() {
	var select = AOS.select(rootdir_grid, 'rootdir_id');
	var rootdir_id = select[0].data.rootdir_id;
	subdir_query();
	filetype_query(); 		
}
//新增
function rootdir_create() {
	rootdir_grid_store.reload();
		AOS.ajax({
			forms : rootdir_create_form,
			url : 'rootdirService.create',
			ok : function(data) {
				AOS.tip(data.appmsg);
				rootdir_grid_store.reload();
				rootdir_create_win.hide();
			}
		});
}
//修改
function rootdir_update() {
	AOS.ajax({
		forms : rootdir_update_form,
		url : 'rootdirService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			rootdir_grid_store.reload();
			rootdir_update_win.hide();
		}
	});
}
//删除
function rootdir_delete(state){
	var selection = AOS.selection(rootdir_grid, 'rootdir_id');
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
	var rows = AOS.rows(rootdir_grid);
	if(state==1){
		var grid =AOS.select(rootdir_grid);
		var rootstate = grid[0].data.state;
			if(rootstate==0){
			var msg =  AOS.merge('确认要启用选中的{0}条数据吗？ <br>如确认执行,会将右边的过程文档及文件文档一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经启用!');
				return;
			}
	}
	if(state==0){
		var grid =AOS.select(rootdir_grid);
		var rootstate = grid[0].data.state;
			if(rootstate==1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？ <br>如确认执行,会将右边的过程文档及文件文档一并执行,请小主三思而定夺!', rows);
			}else{
				AOS.tip('此文件已经停用!');
				return;
			}
		
	}
	if(state==-1){
		var grid =AOS.select(rootdir_grid);
		var rootstate = grid[0].data.state;
			if(rootstate==0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？ <br>如确认执行,会将右边的过程文档及文件文档一并执行,请小主三思而定夺!', rows);
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
			url : 'rootdirService.delete',
			params:{
				aos_rows: selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				rootdir_grid_store.reload();
				subdir_grid_store.reload();
				filetype_grid_store.reload();
			}
		});
	});
}