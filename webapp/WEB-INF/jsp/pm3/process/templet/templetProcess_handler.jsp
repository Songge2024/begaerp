<%@ page contentType="text/html; charset=utf-8"%>

<%!int templet_id=-1; %>
//显示新增或修改窗口
function templetProcess_win_show(type){
		var rows = AOS.rows(templet_grid);
		if(rows!=1){
			AOS.tip('请先选择一条过程模板数据!');
			return;
			}
		var templetGrid =  AOS.select(templet_grid);
		var state = templetGrid[0].data.state;
		if(state == 2){
			AOS.tip('改模板已启用，暂时不能进行新增!');
		return;
		}
		AOS.reset(templetProcess_create_form);
			subdir_id_store.load();
			templetProcess_create_win.setTitle("新增过程信息");
			templetProcess_create_win.show();
	}
	

//查询
function templetProcess_query() {
	//var params = AOS.getValue('query_form');
    templetProcess_grid_store.getProxy().extraParams = {
    templet_id : -1
    };
    templetProcess_grid_store.loadPage(1);
}
