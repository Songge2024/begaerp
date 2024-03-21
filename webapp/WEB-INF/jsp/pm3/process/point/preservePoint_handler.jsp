<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">
//显示新增或修改窗口
function preservePoint_win_show(type){
	if(type=="create"){
		AOS.reset(preservePoint_create_form);
		preservePoint_create_win.show();
	}else{
		AOS.reset(preservePoint_update_form);
		var record = AOS.selectone(preservePoint_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		preservePoint_update_form.loadRecord(record);
		preservePoint_update_win.show();
	}
}
//查询
function preservePoint_query() {
    preservePoint_grid_store.getProxy().extraParams = {
    
    };
    preservePoint_grid_store.loadPage(1);
}
//新增
function preservePoint_create() {
	AOS.ajax({
		forms : preservePoint_create_form,
		url : 'preservePointService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			preservePoint_grid_store.reload();
			preservePoint_create_win.hide();
		}
	});
}
//修改
function preservePoint_update() {
	AOS.ajax({
		forms : preservePoint_update_form,
		url : 'preservePointService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			preservePoint_grid_store.reload();
			preservePoint_update_win.hide();
		}
	});
}
//删除
function preservePoint_delete(){
	var selection = AOS.selection(preservePoint_grid, 'id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(preservePoint_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条扣分标准记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'preservePointService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				preservePoint_grid_store.reload();
			}
		});
	});
}
</script>