<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked>
<aos:dockeditem xtype="tbtext" text="选择项目:"/>
<%-- <aos:combobox id="id_proj_name" 
			  dicField="proj_name" 
			  emptyText="项目名称"
			  selectAll="true" 
			  width="500" 
			  allowBlank="false" 
			  url="projCommonsService.listComboBoxUerid" 
			  onchange="grid_refresh"/> --%>
			  <aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="180" />
			 <aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			  </aos:docked>
			 

