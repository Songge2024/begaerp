<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">


//显示新增或修改窗口
function projCodeVersion_win_show(type){
	if(type=="create"){
		AOS.reset(projCodeVersion_create_form);
		var rows1 = AOS.rows(projVersion_grid);
		var rows2 = AOS.rows(projTestVersion_grid);
		if(rows1 != 1 && rows2 != 1){
			AOS.tip('新增前请先选择一个项目版本号或代码版本号。');
			return;
		}
		//获取项目版本号ID
		var select1 = AOS.select(projVersion_grid,'version_id');
		var version_id = select1[0].data.version_id;
		//获取测试版本号ID
		var select2 = AOS.select(projTestVersion_grid,'test_version_id');
		var test_version_id = select2[0].data.test_version_id;
		
		var proj_id = id_proj_name.getValue();
		AOS.setValue('projCodeVersion_create_form.proj_id',proj_id);
		AOS.setValue('projCodeVersion_create_form.version_id',version_id);
		AOS.setValue('projCodeVersion_create_form.test_version_id',test_version_id);
		projCodeVersion_create_win.show();
	}else{
		AOS.reset(projCodeVersion_update_form);
		var record = AOS.selectone(projCodeVersion_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的数据。');
			return;
		}
		if(record.data.state == '1'){
			AOS.tip('已启用的版本号无法修改');
			return;
		}
		projCodeVersion_update_form.loadRecord(record);
		projCodeVersion_update_win.show();
	}
}
//查询
function projCodeVersion_query() {
	var proj_id = id_proj_name.getValue();
	if(AOS.empty(proj_id)){ 
		return; 
	}
	var record = AOS.selectone(projVersion_grid, true);
	var record1 = AOS.selectone(projTestVersion_grid, true);
	var version_id;
	var test_version_id;
	if(AOS.rows(projVersion_grid)==1){
		version_id = record.data.version_id;
	}else{
		version_id = -1;
	}
	if(AOS.rows(projTestVersion_grid)==1){
		test_version_id = record1.data.test_version_id;
		projCodeVersion_grid_store.getProxy().extraParams = {
			version_id : version_id,
			test_version_id : test_version_id
		};
	}else{
		projCodeVersion_grid_store.getProxy().extraParams = {
			version_id:version_id
	  		};
	}
	projCodeVersion_grid_store.loadPage(1);
}
//初始页面初始 查询
function projCodeVersion_query2() {
	var proj_id = id_proj_name.getValue();
	if(AOS.empty(proj_id)){ 
		return;
	}
     projCodeVersion_grid_store.getProxy().extraParams = {
    	proj_id : proj_id
    };
    projCodeVersion_grid_store.loadPage(1);
}

//新增
function projCodeVersion_create() {
	AOS.ajax({
		forms : projCodeVersion_create_form,
		url : 'projCodeVersionService.create',
		
		ok : function(data) {
			AOS.tip(data.appmsg);
			projCodeVersion_grid_store.reload();
			projCodeVersion_create_win.hide();
		}
	});
}
//修改
function projCodeVersion_update() {
	AOS.ajax({
		forms : projCodeVersion_update_form,
		url : 'projCodeVersionService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projCodeVersion_grid_store.reload();
			projCodeVersion_update_win.hide();
		}
	});
}
//删除
function projCodeVersion_delete(state){
	var selection = AOS.selection(projCodeVersion_grid, 'code_version_id');
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
	var rows = AOS.rows(projCodeVersion_grid);
	if(state == 1){
		var grid = AOS.select(projCodeVersion_grid);
		var codestate = grid[0].data.state;
		if(codestate == 0){
			var grid = AOS.select(projTestVersion_grid);
			var testState = grid[0].data.state;
			if(testState == 1){
				var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('请先启用测试版本号的数据!');
				return;	
			}
		}else{
			AOS.tip('此数据已经启用!');
			return;
		}
	}
	if(state==0){
		var grid =AOS.select(projCodeVersion_grid);
		var codestate = grid[0].data.state;
			if(codestate==1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('此数据已经停用!');
				return;
			}
	}
	if(state==-1){
		var grid =AOS.select(projCodeVersion_grid);
		var codestate = grid[0].data.state;
			if(codestate==0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('此数据已经启用,不得删除!');
				return;
			}
	}
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'projCodeVersionService.delete',
			params:{
				aos_rows: selection,
				code_version_id : selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projCodeVersion_grid_store.reload();
			}
		});
	});
}
</script>
