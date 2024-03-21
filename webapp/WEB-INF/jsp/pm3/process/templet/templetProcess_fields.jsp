<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="temp_proc_id" fieldLabel="模板明细ID" />
	<aos:combobox  	 name="rootdir_id"
					 fieldLabel="过程阶段名称"
					 id="rootdir_id" 
					 url="templetProcessService.listComboBoxRootDirId" 
					 allowBlank="false"
					 onselect="rootdir_onselect" 
					 editable="true" 
					 queryMode="local"
					 typeAhead="true" 
					 forceSelection="true" 
					 selectOnFocus="true"  />
	<aos:hiddenfield name="rootdir_name" id="rootdir_name"  fieldLabel="过程阶段名称"  />	
	<aos:combobox  	name="subdir_id" 
				   	fieldLabel="活动名称"  
				   	id="subdir_id" 
				   	emptyText="不选默认加载该过程阶段下所有活动"
				  	url="templetProcessService.listComboBoxSubDirId"  
				  	onselect="proc_onselect" 
				  	queryMode="local"
					editable="true" 
					typeAhead="true"
					forceSelection="true"
					selectOnFocus="true"  />
	<aos:hiddenfield name="temp_proc_name" id="temp_proc_name" fieldLabel="过程名称"  />	
	<aos:numberfield name="sort_no" fieldLabel="排序号"  emptyText="不填默认排序" minValue="0" maxValue="2147483647"/>
	<aos:radioboxgroup fieldLabel="是否必须流程" columns="[50,50]" >
		<aos:radiobox name="flow_state" checked="true" boxLabel="是" inputValue="1" />
		<aos:radiobox name="flow_state" boxLabel="否" inputValue="0" />
	</aos:radioboxgroup>
	
	<script type="text/javascript">

	//子目录下拉框触发事件
	function proc_onselect(obj){
		AOS.setValue('temp_proc_name',obj.rawValue);
	}
	//跟目录下拉框触发事件
	function rootdir_onselect(obj){
		AOS.setValue('rootdir_name',obj.rawValue);
		var rootdir_id = obj.getValue();
			subdir_id_store.getProxy().extraParams = {
				rootdir_id : rootdir_id
			};
			subdir_id_store.load();
	}

	</script>