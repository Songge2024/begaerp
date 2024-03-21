<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">

//显示新增或修改窗口
function checkMain_win_show(type){
	if(type=="create"){
		AOS.reset(checkMain_create_form);
		checkMain_create_win.show();
	}else{
		AOS.reset(checkMain_update_form);
		var record = AOS.selectone(checkMain_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		checkMain_update_form.loadRecord(record);
		checkMain_update_win.show();
	}
}
//查询
function checkMain_query() {
	var params = AOS.getValue('query_form');
    checkMain_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    checkMain_grid_store.loadPage(1);
}
//新增
function checkMain_create() {
	selarr=[];
	cache_select=false;
	selarr.push(0);
	var check_cata_name =AOS.get('check_cata_name').value;
	var check_cata_id = AOS.get('check_cata_combobox').value;
	var comment =AOS.getValue('checkMain_create_form').comment;
	var plan_check_time =AOS.getValue('checkMain_create_form').plan_check_time;
	var proj_id = id_proj_name.getValue();
	if(AOS.empty(check_cata_name)){
		AOS.tip("请先选择检查项目录!");
		return;
	}
	AOS.ajax({
		//forms : checkMain_create_form,
		url : 'checkMainService.create',
		params : {
			check_cata_id:check_cata_id,
			check_name:check_cata_name,
			comment:comment,
			proj_id:proj_id,
			plan_check_time:plan_check_time
		},
		ok : function(data) {
			AOS.ajax({
				url : 'checkDetailService.copy',
				params:{
					check_cata_id:check_cata_id,
					check_name:check_cata_name,
					proj_id:proj_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					checkMain_grid_store.reload();
					checkMain_create_win.hide();
				}
			});
		}
	});
}
//修改
function checkMain_update() {
	AOS.ajax({
		forms : checkMain_update_form,
		url : 'checkMainService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			checkMain_grid_store.reload();
			checkMain_update_win.hide();
		}
	});
}
</script>