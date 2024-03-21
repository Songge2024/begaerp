<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function templetFiletype_win_show(type){
	if(type=="create"){
	var templetRows = AOS.rows(templet_grid);
		var processRows = AOS.rows(templet_module);
		var templetGrid =  AOS.select(templet_grid);
		var treeGrid=AOS.select(templet_module);
		//console.log(templetGrid);
		if(templetGrid.length == 0){
		AOS.tip('请先选择一条过程信息数据');
			return;
		}
		var state = templetGrid[0].data.state;
		if(processRows-1==1&&templetRows==1){
		if(state == 2){
			AOS.tip('改模板已启用，暂时不能进行新增!');
			return;
		}
		AOS.reset(templetFiletype_create_form);
		templetFiletype_create_win.setTitle("新增过程文件");
		console.log('错误rootdir_id:'+AOS.select(templet_module)[0].childNodes[0].data.parentId+'subdir_id:'+AOS.select(templet_module)[0].data.children[0].a);
		console.log('测试:'+AOS.select(templet_module)[0].firstChild.raw.a);
		AOS.edit(filetype_id);
		filetype_id_store.getProxy().extraParams = {
		rootdir_id : AOS.select(templet_module)[1].raw.parentId,
		subdir_id : AOS.select(templet_module)[1].raw.a
	};
	filetype_id_store.load();
		templetFiletype_create_win.show();
		}
		else{
			AOS.tip('请先选择一条过程信息数据');
			return;
			}
		
	}else{
		var rows = AOS.rows(templetFiletype_grid);
		if(rows!=1){
			AOS.tip('请选择一条要修改的数据。');
			return;
		}
		var templetGrid =  AOS.select(templet_grid);
		var state = templetGrid[0].data.state;
		if(state == 2){
			AOS.tip('改模板已启用，暂时不能进行修改!');
			return;
		}
		AOS.reset(templetFiletype_create_form);
		var record = AOS.selectone(templetFiletype_grid);
		templetFiletype_create_win.setTitle("修改过程文件");
		templetFiletype_create_form.loadRecord(record);
		AOS.read(filetype_id);
		templetFiletype_create_win.show();
	}
}
//查询
function templetFiletype_query() {
	var params = AOS.getValue('query_form');
    templetFiletype_grid_store.getProxy().extraParams = {
    templet_id:-1,
    temp_proc_id:-1
    };
    templetFiletype_grid_store.loadPage();
}


