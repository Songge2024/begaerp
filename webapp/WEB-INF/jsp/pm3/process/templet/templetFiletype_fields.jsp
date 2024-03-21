<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="temp_filetype_id" fieldLabel="模板文件类型ID" />	
	<aos:combobox   name="filetype_id" 
					fieldLabel="输出文档名称" 
					id="filetype_id"
					editable="true"  
					url="templetFiletypeService.listComboBoxFiletypeId"
					allowBlank="false"
					onselect="filetype_onselect"
					queryMode="local"
					typeAhead="true"
					forceSelection="true"
					selectOnFocus="true"  />
	<aos:hiddenfield name="temp_filetype_name" id="temp_filetype_name"  fieldLabel="输出文档名称"   />	
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" emptyText="不填默认排序" allowDecimals="false" center="true" minValue="0" maxValue="2147483647" /> 
	<aos:radioboxgroup fieldLabel="是否必须流程" columns="[50,50]" >
		<aos:radiobox name="flow_state" checked="true" boxLabel="是" inputValue="1" />
		<aos:radiobox name="flow_state" boxLabel="否" inputValue="0" />
	</aos:radioboxgroup>
<script type="text/javascript">
function filetype_onselect(obj){
	AOS.setValue('temp_filetype_name',obj.rawValue);
}
</script>
