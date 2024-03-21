<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%

%>

<aos:docked>
		<%-- <aos:combobox id="pm_proj_id"   dicField="proj_name" emptyText="请选择项目" selectAll="true" 
		        width="300" allowBlank="false"
				url="projCommonsService.listComboBoxUerid" onselect="tree_query" />  --%>
				<aos:dockeditem xtype="tbtext" text="项目选择" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="240" />
				<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
</aos:docked>
<aos:treepanel id="public_module_divide_tree" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
				border="true" onitemclick="on_public_tree">
</aos:treepanel>

<script type="text/javascript">	
		
	//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
	function public_module_divide_tree_refresh() {
		var proj_id = id_proj_name.getValue();
		public_module_divide_tree_store.load({
			params:{
				proj_id : proj_id
			},
			callback : function() {
				//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
				/* refreshnode.collapse();
				refreshnode.expand(); */
				public_module_divide_tree.getSelectionModel().select(public_module_divide_tree.getRootNode());
			}
		});
		
	}
		
	
</script>