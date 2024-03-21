<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function testExample_win_show(type){
	if(type=="create"){
		AOS.reset(testExample_create_form);
		testExample_create_win.show();
	}else{
		AOS.reset(testExample_update_form);
		var record = AOS.selectone(testExample_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		testExample_update_form.loadRecord(record);
		testExample_update_win.show();
	}
}
//查询
function testExample_query() {
	var params = AOS.getValue('query_form');
    testExample_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    testExample_grid_store.loadPage(1);
}
//新增
function testExample_create() {
	AOS.ajax({
		forms : testExample_create_form,
		url : 'testExampleService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			testExample_grid_store.reload();
			testExample_create_win.hide();
		}
	});
}
//修改
function testExample_update() {
	AOS.ajax({
		forms : testExample_update_form,
		url : 'testExampleService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			testExample_grid_store.reload();
			testExample_update_win.hide();
		}
	});
}
//删除
function testExample_delete(){
	var selection = AOS.selection(testExample_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(testExample_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条qa_test_example记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'testExampleService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				testExample_grid_store.reload();
			}
		});
	});
}