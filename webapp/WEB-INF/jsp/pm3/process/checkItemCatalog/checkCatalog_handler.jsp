<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">

//显示新增或修改窗口
function checkCatalog_win_show(type){
	if(type=="create"){
		AOS.reset(checkCatalog_create_form);
		var rows = AOS.rows(checkProjType_grid);
		if(rows != 1 ){
			AOS.tip("请先选择项目类型。");
			return;
		}
		//获取项目类型ID
		var select =  AOS.select(checkProjType_grid,'type_code');
		var type_code = select[0].data.type_code;
		AOS.setValue('checkCatalog_create_form.type_code',type_code);
		checkCatalog_create_win.show();
	}else{
		AOS.reset(checkCatalog_update_form);
		var record = AOS.selectone(checkCatalog_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		if(record.data.state == '1'){
			AOS.tip('已启用的检查项无法进行修改。');
			return;
		}
		checkCatalog_update_form.loadRecord(record);
		checkCatalog_update_win.show();
	}
}
//单击项目类型查询
function checkCatalog_query() {
	var record = AOS.selectone(checkProjType_grid, true);
	var type_code;
	if(AOS.rows(checkProjType_grid)==1){
		type_code = record.data.type_code;
	}else{
		type_code = -1;
	}
    checkCatalog_grid_store.getProxy().extraParams = {
    	type_code : type_code,
    };
    checkCatalog_grid_store.loadPage(1);
    checkItem_query();
}
//新增
function checkCatalog_create() {
	AOS.ajax({
		forms : checkCatalog_create_form,
		url : 'checkCatalogService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkCatalog_grid_store.reload();
			checkCatalog_create_win.hide();
		}
	});
}
//修改
function checkCatalog_update(type) {
	AOS.ajax({
		forms : checkCatalog_update_form,
		url : 'checkCatalogService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkCatalog_grid_store.reload();
			checkCatalog_update_win.hide();
		}
	});
}
 //删除/启用/停用
function checkCatalog_delete(state){
	var selection = AOS.selection(checkCatalog_grid, 'check_cata_id');
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
	var rows = AOS.rows(checkCatalog_grid);
	if(state == 1){
		var grid = AOS.select(checkCatalog_grid);
		var cataState = grid[0].data.state;
		if(cataState == 0){
			var grid = AOS.select(checkProjType_grid);
			var typeState = grid[0].data.state;
			if(typeState == 1){
				var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('请先启用项目类型的数据!');
				return;
			}
		}else{
			AOS.tip('此数据已经启用!');
			return;
		}
	}
	if(state == 0){
		var grid =AOS.select(checkCatalog_grid);
		var cataState = grid[0].data.state;
		if(cataState == 1){
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
		}else{
			AOS.tip('此文件已经停用!');
			return;
		}
	}
	if(state == -1){
		var grid =AOS.select(checkCatalog_grid);
		var cataState = grid[0].data.state;
		if(cataState == 0){
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
		}else{
			AOS.tip('此文件已经启用,不得删除!');
			return;
		}
	}
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'checkCatalogService.delete',
			params:{
				aos_rows : selection,
				check_cata_id : selection,
				state : state
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				checkCatalog_grid_store.reload();
				checkItem_grid_store.reload();
			}
		});
	});
}
</script>