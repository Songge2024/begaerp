<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="过程信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="templetProcess_win_show" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="templetProcess_update_win_show" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="templetProcess_delete" />
	
</aos:docked>
<script type="text/javascript">
//新增及修改保存
function templetProcess_createSave() {
	var createForm = AOS.getValue('templetProcess_create_form');
	var temp_proc_id = createForm.temp_proc_id;
	var subdir_id = createForm.subdir_id;

		var select = AOS.select(templet_grid);
		var templet_id = select[0].data.templet_id;
		var flow_state = createForm.flow_state;
		var url = '';
		if(subdir_id==''){
			url ='templetProcessService.createAll';
		}else{
			url ='templetProcessService.create'
		}
			AOS.ajax({
			forms : templetProcess_create_form,
			params:{
				templet_id: templet_id,
				flow_state : flow_state
				},
			url : url,
			ok : function(data) {
				AOS.tip(data.appmsg);
				templet_module_store.reload();
				templetProcess_create_win.hide();
				}
				});
		
		}
//修改保存	
function templetProcess_updateSave() {
			AOS.ajax({
			forms : templetProcess_update_form,
			url : 'templetProcessService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				templet_module_store.reload();
				templetProcess_update_win.hide();
			}
				});
		}
	


//删除
function templetProcess_delete(){
	var selection = AOS.selection(templet_module, 'id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var templetGrid =  AOS.select(templet_grid);
	var state = templetGrid[0].data.state
	if(state == 2){
		AOS.tip('改模板已启用，暂时不能进行删除!');
		return;
	}
	var rows = AOS.rows(templet_module);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows-1);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
		//	AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'templetProcessService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				templet_module_store.reload();
				templetFiletype_grid_store.reload();
			}
		});
	});
}
//保存
function process_save(){
	if (AOS.mrows(templetProcess_grid) == 0) {
				AOS.tip('数据没变化，保存操作取消。');
				return;}
			AOS.ajax({
				params : {
					aos_rows : AOS.mrs(templetProcess_grid)
				},
				url : 'templetProcessService.saveProcessGrid',
				ok : function(data) {
					AOS.tip(data.appmsg);
					templetProcess_grid_store.reload();
				}
			});
}

</script>