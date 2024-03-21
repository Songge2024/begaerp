<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
	//显示新增或修改窗口
	function projTestVersion_win_show(type){
		if(type == "create"){
			AOS.reset(projTestVersion_create_form);
			var rows = AOS.rows(projVersion_grid);
			if(rows != 1 ){
				AOS.tip("新增前请先选择一个项目版本号。");
			}
			//获取项目版本号ID
			var select = AOS.select(projVersion_grid,'version_id');
			var version_id = select[0].data.version_id;
			var proj_id = id_proj_name.getValue();
			AOS.setValue('projTestVersion_create_form.version_id',version_id);
			AOS.setValue('projTestVersion_create_form.proj_id',proj_id);
			projTestVersion_create_win.show();
		}else{
			AOS.reset(projTestVersion_update_form);
			var record = AOS.selectone(projTestVersion_grid, true);
			if(AOS.empty(record)){
				AOS.tip('请选择要修改的记录。');
				return;
			}
			if(record.data.state == '1'){
				AOS.tip('已启用的版本号无法进行修改。');
				return;
			}
			projTestVersion_update_form.loadRecord(record);
			projTestVersion_update_win.show();
		}
	}
	
	//新增
	function projTestVersion_create() {
		AOS.ajax({
			forms : projTestVersion_create_form,
			url : 'projTestVersionService.create',
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTestVersion_grid_store.reload();
				projTestVersion_create_win.hide();
			}
		});
	}
	//修改
	function projTestVersion_update() {
		AOS.ajax({
			forms : projTestVersion_update_form,
			url : 'projTestVersionService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTestVersion_grid_store.reload();
				projTestVersion_update_win.hide();
			}
		});
	}
	//查询
	function projTestVersion_query(){
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(proj_id)){ 
			return; 
		}
	    var record = AOS.selectone(projVersion_grid, true);
		var version_id;
		if(AOS.rows(projVersion_grid)==1){
			version_id = record.data.version_id;
		}else{
			version_id = -1;
		}
	    projTestVersion_grid_store.getProxy().extraParams = {
	    	version_id :version_id,
	    };
	    projTestVersion_grid_store.loadPage(1);
	    projCodeVersion_query();
	}
	//启用/停用/删除
	function projTestVersion_delete(state){
		var selection = AOS.selection(projTestVersion_grid,'test_version_id');
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
		var rows = AOS.rows(projTestVersion_grid);
		if(state == 1){
			var grid = AOS.select(projTestVersion_grid);
			var testState = grid[0].data.state;
			if(testState == 0){
				var grid = AOS.select(projVersion_grid);
				var Versionstate = grid[0].data.state;
				if(Versionstate == 1){
					var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
				}else{
					AOS.tip('请先启用项目版本号的数据!');
					return;
				}
			}else{
				AOS.tip('此数据已经启用!');
				return;
			}
		}
		if(state == 0){
			var grid =AOS.select(projTestVersion_grid);
			var testState = grid[0].data.state;
			if(testState == 1){
				var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			}else{
				AOS.tip('此文件已经停用!');
				return;
			}
		}
		if(state == -1){
			var grid =AOS.select(projTestVersion_grid);
			var testState = grid[0].data.state;
			if(testState == 0){
				var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
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
				url : 'projTestVersionService.delete',
				params:{
					aos_rows: selection,
					test_version_id:selection,
					state :state
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					projTestVersion_grid_store.reload();
					projCodeVersion_grid_store.reload();
				}
			});
		});
	}
</script>