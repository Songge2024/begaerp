<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function filetype_win_show(type){
	if(type=="create"){
		var rootdirRows = AOS.rows(rootdir_grid);	
		var subdirRows = AOS.rows(subdir_grid);
		if(subdirRows==1){
		AOS.reset(filetype_create_form);
		filetype_create_win.show();
		}else{
			AOS.tip('新增前先选择一个标准过程!');
			return;
			}
	}else{
		AOS.reset(filetype_update_form);
		var record = AOS.selectone(filetype_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		filetype_update_form.loadRecord(record);
		filetype_update_win.show();
	}
}
//查询
function filetype_query() {
    var params = AOS.getValue('query_form');
	var record = AOS.selectone(rootdir_grid, true);
	var record1 = AOS.selectone(subdir_grid, true);
	var rootdir_id;
	var subdir_id;
	if(AOS.rows(rootdir_grid)==1){
		rootdir_id = record.data.rootdir_id;
	}else{
		rootdir_id = -1;
	}
	if(AOS.rows(subdir_grid)==1){
		subdir_id = record1.data.subdir_id;
		 filetype_grid_store.getProxy().extraParams = {
    	rootdir_id:rootdir_id,
    	subdir_id:subdir_id
    };
	}else{
		filetype_grid_store.getProxy().extraParams = {
    	rootdir_id:rootdir_id
   		};
	}
    filetype_grid_store.loadPage(1);
}
//新增
function filetype_create() {
	var select = AOS.select(rootdir_grid,'rootdir_id');
	var selectSubdir = AOS.select(subdir_grid,'subdir_id');
	var rootdir_id = select[0].data.rootdir_id;
	var subdir_id = selectSubdir[0].data.subdir_id;
	AOS.ajax({
		forms : filetype_create_form,
		params:{
				rootdir_id : rootdir_id,
				subdir_id : subdir_id
		},
		url : 'filetypeService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			filetype_grid_store.reload();
			filetype_create_win.hide();
		}
	});
}
//修改
function filetype_update() {
	AOS.ajax({
		forms : filetype_update_form,
		url : 'filetypeService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			filetype_grid_store.reload();
			filetype_update_win.hide();
		}
	});
}
//删除
function filetype_delete(state){
	var selection = AOS.selection(filetype_grid,'filetype_id');
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
	var rows = AOS.rows(filetype_grid);
	if(state==1){
		var grid =AOS.select(filetype_grid);
		var filestate = grid[0].data.state;
		if(filestate==0){
			var grid =AOS.select(subdir_grid);
			var substate = grid[0].data.state;
			if(substate==1){
				var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('请先启用过程的文件!');
				return;
			}
		}else{
				AOS.tip('此文件已经启用!');
				return;
			 }
	}
	if(state==0){
		var grid =AOS.select(filetype_grid);
		var filestate = grid[0].data.state;
			if(filestate==1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('此文件已经停用!');
				return;
			}
	}
	if(state==-1){
		var grid =AOS.select(filetype_grid);
		var filestate = grid[0].data.state;
			if(filestate==0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
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
			url : 'filetypeService.delete',
			params:{
				aos_rows: selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				filetype_grid_store.reload();
			}
		});
	});
}
//保存
function filetype_save(){
	if (AOS.mrows(filetype_grid) == 0) {
				AOS.tip('数据没变化，提交操作取消。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows : AOS.mrs(filetype_grid)
				},
				url : 'FiletypeService.saveFiletypeGrid',
				ok : function(data) {
					AOS.tip(data.appmsg);
					templetFiletype_grid_store.reload();
				}
			});
}