<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="输出文档" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="templetFiletype_win_show('create')" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="templetFiletype_win_show('update')" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="templetFiletype_delete" />
	<aos:dockeditem text="保存" icon="save.png"    onclick="filetype_save" />
</aos:docked>
<script type="text/javascript">
//新增及修改保存
function templetFiletype_create() {
	var params = AOS.getValue('templetFiletype_create_form');
	var temp_filetype_id = params.temp_filetype_id;
	if(temp_filetype_id==''){
	var select = AOS.select(templet_grid);
	//var selectProcess = AOS.selectone(templet_module);
	var templet_id = select[0].data.templet_id;
	var temp_proc_id =AOS.select(templet_module)[1].raw.id;
	var subdir_id =AOS.select(templet_module)[1].raw.a;
	AOS.ajax({
		forms : templetFiletype_create_form,
		params:{
				templet_id : templet_id,
				temp_proc_id : temp_proc_id,
				subdir_id	: subdir_id
				},
		url : 'templetFiletypeService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			templetFiletype_grid_store.reload();
			templetFiletype_create_win.hide();
		}
	});
	}else{
		AOS.ajax({
			forms : templetFiletype_create_form,
			url : 'templetFiletypeService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				templetFiletype_grid_store.reload();
				templetFiletype_create_win.hide();
			}
		});
	}
}
//删除
function templetFiletype_delete(){
	var selection = AOS.selection(templetFiletype_grid, 'temp_filetype_id');
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
	var rows = AOS.rows(templetFiletype_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'templetFiletypeService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				templetFiletype_grid_store.reload();
			}
		});
	});
}

//保存
function filetype_save(){
	if (AOS.mrows(templetFiletype_grid) == 0) {
				AOS.tip('数据没变化，提交操作取消。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows : AOS.mrs(templetFiletype_grid)
				},
				url : 'templetFiletypeService.saveFiletypeGrid',
				ok : function(data) {
					AOS.tip(data.appmsg);
					templetFiletype_grid_store.reload();
				}
			});
}
</script>