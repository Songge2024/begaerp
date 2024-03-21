<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	
	<aos:docked forceBoder="0 0 1 0" height="25">
		<aos:dockeditem xtype="tbtext" text="选择测试用例导入模板：" />
	</aos:docked>
	<%-- <aos:docked forceBoder="0 0 1 0" height="35.5"> --%>
		<aos:dockeditem xtype="tbtext" text="选择模板项目：" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:triggerfield  id="import_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="import_proj_tree_show" columnWidth=".4" />
		<aos:hiddenfield id="import_id_proj_name" name="id_proj_name"/>
		<aos:combobox fieldLabel="测试版本号" name="test_version_id"
			allowBlank="false" columnWidth="0.5" queryMode="local" 
			id="import_test_version_id" editable="false"
			url="testExampleService.exportTestVersionId" onchange="import_test_change"/>
			<!-- margin="0 -280 0 90" -->
		<aos:combobox fieldLabel="优先级" name="priority" 
			columnWidth="0.3" allowBlank="true" editable="true"
			forceSelection="false" onchange="import_priority_change">
			<aos:option value="P0" display="P0"/>
			<aos:option value="P1" display="P1" />
			<aos:option value="P2" display="P2" />
			<aos:option value="P3" display="P3"/>
		</aos:combobox>
		<aos:combobox fieldLabel="需求" name="demand_id" editable="false"
			allowBlank="false" columnWidth="0.5"  id="import_demand_id"
			url="testExampleService.demandSite" />
		<aos:dockeditem xtype="button" text="<<移除" columnWidth="0.2"
				onclick="delete_import_testExample" icon="del.png" margin="0 0 0 20"/>
	<%-- </aos:docked> --%>
		<aos:window id="import_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
			<aos:treepanel id="importProj_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="import_find_select" />
		</aos:window>
	<script type="text/javascript">
		//项目风险跟踪自动选择默认项目
		function begin(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			var params = {proj_id : proj_id};
			//测试用例版本号下拉框
			import_test_version_id_store.getProxy().extraParams = params;
			import_test_version_id_store.load();
			//需求下拉框
			import_demand_id_store.getProxy().extraParams = params;
			import_demand_id_store.load();
			if(proj_id !=null && proj_id!=''){
				AOS.setValue('import_id_proj_name',proj_id);
			 	AOS.setValue('import_tree_proj_name',proj_name);
			 	import_module_tree_refresh();
			 	//import_module();
			}
		}
		//单击选择项目
		function import_find_select() {
		  	var record = AOS.selectone(importProj_org_find);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('import_id_proj_name',record.raw.id);
			  	AOS.setValue('import_tree_proj_name',record.raw.text);
			  	//import_module();
			  	import_org_find.hide();
				import_module_tree_refresh();
				import_combobox_refresh();
				import_demand_refresh();
			}else{
				AOS.tip("请选择项目!");
				return;
			}
	  	}
		
		//测试版本号下拉框刷新
		function import_combobox_refresh(){ 
			var proj_id = import_id_proj_name.getValue();
			var params = {proj_id : proj_id};
			import_test_version_id_store.getProxy().extraParams = params;
			import_test_version_id_store.load();
		}
		
		//需求下拉框刷新
		function import_demand_refresh(){
			var proj_id= import_id_proj_name.getValue();
			var params = {proj_id : proj_id};
			import_demand_id_store.getProxy().extraParams = params;
			import_demand_id_store.load();
		}
		
		//弹出选择上级模块窗口
		function import_proj_tree_show() {
			import_org_find.show();
		}
		
		//移除测试用例
		function delete_import_testExample(){
			var record = AOS.select(import_example_template);
			var selection = AOS.selection(import_example_template,'standard_id');
			var execute_code = AOS.selection(import_example_template,'execute_code');
			var standard_code = AOS.selection(import_example_template,'standard_code');
			if(AOS.empty(record)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			for(var i=0;i<record.length;i++){
				if(record[i].data.return_state == 1){
					AOS.tip('已回归测试的用例不能删除。');
					return;
				}
			}
			var rows = AOS.rows(import_example_template);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'testExampleService.delete',
					params:{
						aos_rows: selection,
						execute_code:execute_code,
						standard_code:standard_code
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						export_example_template.store.reload();
						import_example_template_store.reload();
					}
				});
			});
		}
		
		//被导入模板测试版本号变更事件
		function import_test_change(){
			var params = AOS.getValue('import_form_template');
			var proj_id = import_id_proj_name.value;
			var record = AOS.selectone(import_module_tree);
			var stand_id = record.data.id;
			params.proj_id = proj_id;
			params.stand_id = stand_id;
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
		
		//被导入模板优先级变更事件
		function import_priority_change(){
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