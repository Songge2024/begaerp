<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="templetProcess_update_win" 
	title="修改"
>
	<aos:formpanel 
		id="templetProcess_update_form"
	 	width="500"
	  	layout="anchor" 
	  	labelWidth="100"
	  	msgTarget="qtip"
	>
	<aos:hiddenfield name="temp_proc_id" fieldLabel="模板明细ID" />
	<aos:hiddenfield  name="rootdir_id" fieldLabel="过程阶段名称" id="u_rootdir_id" />
	<aos:textfield name="rootdir_name" id="u_rootdir_name"  fieldLabel="过程阶段名称" readOnly = "true"  />	
	<aos:hiddenfield  name="subdir_id" fieldLabel="活动名称"  id="u_subdir_id"  />
	<aos:textfield name="temp_proc_name" id="u_temp_proc_name" fieldLabel="过程名称"  readOnly = "true" />	
	<aos:numberfield name="sort_no" fieldLabel="排序号"  emptyText="不填默认排序" minValue="0" maxValue="2147483647"/>
	<aos:radioboxgroup fieldLabel="是否必须流程" columns="[50,50]" >
		<aos:radiobox name="flow_state" checked="true" boxLabel="是" inputValue="1" />
		<aos:radiobox name="flow_state" boxLabel="否" inputValue="0" />
	</aos:radioboxgroup>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="templetProcess_updateSave" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#templetProcess_update_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>
<script type="text/javascript">
function templetProcess_update_win_show(){
	var rows = AOS.rows(templet_module);
	if(rows-1!=1){
		AOS.tip('请选择一条需要修改的数据。');
		return;
	}
	var templetGrid =  AOS.select(templet_grid);
	var state = templetGrid[0].data.state;
	if(state == 2){
		AOS.tip('改模板已启用，暂时不能进行新增!');
	return;
	}
	AOS.reset(templetProcess_update_form);
	var rootdir_id = AOS.select(templet_module)[1].raw.parentId;
	var subdir_id = AOS.select(templet_module)[1].raw.a;
	var temp_proc_id = AOS.select(templet_module)[1].raw.id;
	var record = AOS.select(templet_module)[1];
	record.data.rootdir_id = rootdir_id;
	record.data.subdir_id = subdir_id;
	record.data.temp_proc_id = temp_proc_id;


	//var record = Ext.data.Record({
	// rootdir_id: rootdir_id,
	// subdir_id: subdir_id,
	// temp_proc_id:temp_proc_id}); 

//	AOS.setValue('rootdir_id',rootdir_id);
//	AOS.setValue('subdir_id',subdir_id);
//	rootdir_id_store.load();
//	subdir_id_store.load();
	AOS.ajax({
	url : 'templetProcessService.listTemplet',
	params:{
		temp_proc_id: temp_proc_id
	},
	ok : function(data) {
		//AOS.tip(data);
	//	templetProcess_update_form.loadRecord(data);
		AOS.setValues(templetProcess_update_form,data);
		templetProcess_update_win.setTitle("修改过程信息");
		templetProcess_update_win.show();
	}	
	});
	
	//templetProcess_update_form.loadRecord(record);
	//AOS.setValue('templetProcess_update_form.rootdir_id','24142');
	//AOS.setValue('templetProcess_update_form.subdir_id',subdir_id);
	//AOS.setValue('templetProcess_update_form.sort_no',421321);
	
	
	
}

/* //根目录下拉框触发事件
function proc_onselect(obj){
	AOS.setValue('u_temp_proc_name',obj.rawValue);
}
//子目录下拉框触发事件
function rootdir_onselect(obj){
	AOS.setValue('u_rootdir_name',obj.rawValue);
	var rootdir_id = obj.getValue();
		u_subdir_id_store.getProxy().extraParams = {
			rootdir_id : rootdir_id
		};
		u_subdir_id_store.load();
}
 */
</script>