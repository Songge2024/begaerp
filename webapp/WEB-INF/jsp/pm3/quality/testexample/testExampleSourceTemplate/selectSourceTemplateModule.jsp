<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:treepanel id="export_module_tree" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
		border="true" onitemclick="on_export_tree" bodyBorder="1 1 1 1">
	</aos:treepanel>
	
	<script type="text/javascript">
	//刷新菜单树   刷新父节点；root：刷新根节点
	function export_module_tree_refresh() {
			var proj_id = export_id_proj_name.getValue();
			export_module_tree_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					export_module_tree.getSelectionModel().select(export_module_tree.getRootNode());
				}
			});
		}
	
	//单击树节点
	function on_export_tree(){
		var params = AOS.getValue('export_form_template');
		var param = AOS.getValue('import_form_template');
		var proj_id = export_id_proj_name.getValue();
		var b_proj_id = import_id_proj_name.getValue();
		
		var a_test_version_id = params.test_version_id;
		var b_test_version_id = param.test_version_id;
		
		var record = AOS.selectone(export_module_tree);
		var stand_id = record.data.id;
		var records = AOS.selectone(import_module_tree);
		var b_stand_id = records.data.id;
		
		params.proj_id = proj_id;
		params.stand_id = stand_id;
		params.b_proj_id = b_proj_id;
		params.b_test_version_id = b_test_version_id;
		params.b_stand_id = b_stand_id;
		var query_test_version_id = params.test_version_id;
		if(AOS.empty(query_test_version_id)){
			AOS.tip("请先选择测试用例版本号。");
			return;
		}
		if(proj_id == stand_id || stand_id == 0){
			params.stand_id = null;
			if(b_stand_id == 0 || b_stand_id == b_proj_id){
				params.b_stand_id = null;
				
				export_example_template_store.getProxy().extraParams = params;
				export_example_template_store.loadPage(1);
			}else{
				
				export_example_template_store.getProxy().extraParams = params;
				export_example_template_store.loadPage(1);
			}
		}else{
			if(b_stand_id == 0 || b_stand_id == b_proj_id){
				params.b_stand_id = null;
				
				export_example_template_store.getProxy().extraParams = params;
				export_example_template_store.loadPage(1);
			}else{
				
				export_example_template_store.getProxy().extraParams = params;
				export_example_template_store.loadPage(1);
			}
		}
	}
	</script>