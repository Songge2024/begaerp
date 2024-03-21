<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="合同信息" />
	<aos:dockeditem xtype="tbseparator" />
		<aos:combobox  id="id_proj_name" dicField="proj_name" emptyText="项目名称" onselect="bsProjContract_query" margin="0 5 0 0"
					selectAll="true" width="180" allowBlank="false" url="bsProjContractService.listComboBoxCascadeData&length=9"
					/>
</aos:docked>