<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="process_id" fieldLabel="过程ID" />
	<aos:hiddenfield name="proj_id" fieldLabel="项目id" />
	<aos:hiddenfield name="subdir_id" fieldLabel="项目id" />
	<aos:combobox  	name="filetype_id" 
					fieldLabel="输出文档名称" 
					id="filetype_id"
					queryMode="local"
					editable="true" 
					typeAhead="true"
					forceSelection="true"
					selectOnFocus="true" 
					url="templetFiletypeService.listComboBoxFiletypeId" 
					allowBlank="false" 
					onselect="filetype_onselect" />
	<aos:hiddenfield name="proc_filetype_name" id="proc_filetype_name"  fieldLabel="输出文档名称"   />	
	<%-- <aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="true" /> --%>
	<aos:radioboxgroup fieldLabel="是否必须流程  " columns="[50,50]" >
		<aos:radiobox name="file_state"  checked="true" boxLabel="是" inputValue="1" />
		<aos:radiobox name="file_state"  boxLabel="否" inputValue="0" />
	</aos:radioboxgroup>
