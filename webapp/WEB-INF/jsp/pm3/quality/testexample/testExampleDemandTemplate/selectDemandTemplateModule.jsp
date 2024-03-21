<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:treepanel id="import_module_tree" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
		border="true" onitemclick="on_import_tree" bodyBorder="1 1 1 1">
	</aos:treepanel>
	
	<script type="text/javascript">
	//刷新菜单树   刷新父节点；root：刷新根节点
	function import_module_tree_refresh() {
			var proj_id = import_id_proj_name.getValue();
			import_module_tree_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					import_module_tree.getSelectionModel().select(import_module_tree.getRootNode());
				}
			});
		}
	
	//单击树节点
	function on_import_tree(){
		var params = AOS.getValue('import_form_template');
		var proj_id = import_id_proj_name.value;
		var record = AOS.selectone(import_module_tree);
		var stand_id = record.data.id;
		params.proj_id = proj_id;
		params.stand_id = stand_id;
		var import_test_version_id = params.test_version_id;
		if(AOS.empty(import_test_version_id)){
			AOS.tip("请先选择测试用例版本号。");
			return;
		}
		if(proj_id == stand_id){
			params.stand_id = null;
			import_example_template_store.getProxy().extraParams = params;
			import_example_template_store.loadPage(1);
			on_export_tree();
		}else{
			import_example_template_store.getProxy().extraParams = params;
			import_example_template_store.loadPage(1);
			on_export_tree();
		}
	}
	</script>