<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="过程模板" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="templet_win_show('create')" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="templet_win_show('update')" />
	<aos:dockeditem text="启用" icon="go.gif"    onclick="templet_enable" />
	<aos:dockeditem text="停用" icon="stop.gif"    onclick="templet_disable" />
	<aos:dockeditem text="复制模板" icon="copy.png"    onclick="templet_copy" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="templet_delete" />
</aos:docked>

<aos:window 
	id="templet_add_win" 
	title="模板复制">
	<aos:formpanel 
		id="templet_add_form"
	 	width="400"
	  	layout="anchor" 
	  	labelWidth="70"
	>
	<aos:hiddenfield name="templet_id" fieldLabel="模板id" />	
	<aos:textfield name="templet_name" fieldLabel="模板名称" allowBlank="false" maxLength="150"/>
	<aos:textfield name="templet_comment" fieldLabel="说明" allowBlank="false" maxLength="10"/>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templet_add_save" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templet_add_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
//显示新增或修改窗口
function templet_win_show(type){
	if(type=="create"){
		AOS.reset(templet_create_form);
		templet_create_win.show();
	}else{
		var rows = AOS.rows(templet_grid);
		if(rows!=1){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		var templetGrid =  AOS.select(templet_grid);
		var state = templetGrid[0].data.state;
		if(state == 2){
			AOS.tip('改模板已启用，暂时不能进行修改!');
		return;
		}
		AOS.reset(templet_update_form);
		var record = AOS.selectone(templet_grid, true);
		templet_update_form.loadRecord(record);
		templet_update_win.show();
	}
}

		
//修改
function templet_update() {
	AOS.ajax({
		forms : templet_update_form,
		url : 'templetMainService.update',
		ok : function(data) {
			AOS.tip(data.appmsg);
			templet_grid_store.reload();
			templet_update_win.hide();
		}
	});
}
//删除
function templet_delete(){
	var selection = AOS.selection(templet_grid, 'templet_id');
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var grid = AOS.select(templet_grid);
	var state = grid[0].data.state;
	if(state>1){
		AOS.tip('当前状态下不能进行删除操作!。');
		return;
	}
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(templet_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'templetMainService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				templet_grid_store.reload();
				templetProcess_grid_store.reload();
				templetFiletype_grid_store.reload();
			}
		});
	});
}

//启用
function templet_enable(){
var selection = AOS.selection(templet_grid, 'templet_id');
if(AOS.empty(selection)){
	AOS.tip('请选择需要启用的数据。');
	return;
}
var grid = AOS.select(templet_grid);
var state = grid[0].data.state;
if(state!=1){
	AOS.tip('当前状态下不能进行启用操作!。');
	return;
}
var selection_state = AOS.selection(templet_grid, 'state');
var rows = AOS.rows(templet_grid);
var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
AOS.confirm(msg, function(btn){
	if(btn === 'cancel'){
		//AOS.tip('启用操作被取消。');
		return;
	}
	AOS.ajax({
		url : 'templetMainService.enable',
		params:{
			aos_rows: selection
		},
		ok : function(data) {
			AOS.tip(data.appmsg);
			templet_grid_store.reload();
		}
	});
});

}


//停用
function templet_disable(){
var selection = AOS.selection(templet_grid, 'templet_id');
if(AOS.empty(selection)){
	AOS.tip('请选择需要停用的数据。');
	return;
}
var grid = AOS.select(templet_grid);
var state = grid[0].data.state;
if(state!=2){
	AOS.tip('当前状态下不能进行停用操作!。');
	return;
}
var selection_state = AOS.selection(templet_grid, 'state');
var rows = AOS.rows(templet_grid);
var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
AOS.confirm(msg, function(btn){
	if(btn === 'cancel'){
		//AOS.tip('停用操作被取消。');
		return;
	}
	AOS.ajax({
		url : 'templetMainService.disable',
		params:{
			aos_rows: selection
		},
		ok : function(data) {
			AOS.tip(data.appmsg);
			templet_grid_store.reload();
		}
	});
});

}

//复制模板
function templet_copy(){
var rows = AOS.rows(templet_grid);
if(rows != 1){
	AOS.tip('请选择一条需要复制的数据。');
	return;
}
var grid = AOS.select(templet_grid);
var msg =  AOS.merge('确认要复制选中的数据吗？', rows);
AOS.confirm(msg, function(btn){
	if(btn === 'cancel'){
		//AOS.tip('复制模板操作被取消。');
		return;
	}
	AOS.reset(templet_add_form);
	templet_add_win.show();
});

}
//模板复制保存
function templet_add_save(){
	AOS.ajax({
		forms : templet_add_form,
		url : 'templetMainService.create',
		ok : function(data) {
		 	var grid = AOS.select(templet_grid);
			var new_templet_id = data.appmsg;
			var records = templetProcess_grid.getStore().data.items;
			var jsonArray = [];
			Ext.each(records, function (records) {
			        jsonArray.push(records.data);
			    });
			 AOS.ajax({
					params : {
						aos_rows : Ext.encode(jsonArray),
						new_templet_id : new_templet_id
							},
					url : 'templetMainService.saveProcessGrid',
						ok : function(data) {
							var old_templet_id = grid[0].data.templet_id;
							 AOS.ajax({
									params : {
										old_templet_id : old_templet_id,
										new_templet_id :new_templet_id
											},
									url : 'templetMainService.saveFiletypeGrid',
										ok : function(data) {
											templet_grid_store.reload();
											templet_add_win.hide();
											AOS.tip('复制成功!')
											}
									});
							}
					});
			
		}
	});
	
}

</script>