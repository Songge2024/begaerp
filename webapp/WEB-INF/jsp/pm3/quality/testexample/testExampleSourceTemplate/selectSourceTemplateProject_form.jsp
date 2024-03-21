<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	
	<aos:docked forceBoder="0 0 1 0" height="25">
		<aos:dockeditem xtype="tbtext" text="选择测试用例导入模板：" />
	</aos:docked>
	<%-- <aos:docked forceBoder="0 0 1 0" height="35.5"> --%>
		<aos:dockeditem xtype="tbtext" text="选择模板项目：" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:triggerfield  id="export_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger"  onTrigger1Click="export_proj_tree_show" columnWidth="0.4" />
		<aos:hiddenfield id="export_id_proj_name" name="id_proj_name"/>
		<aos:combobox fieldLabel="测试版本号" name="test_version_id"
			allowBlank="false" columnWidth="0.5" queryMode="local" 
			id="export_test_version_id" editable="false"
			url="testExampleService.exportTestVersionId" onchange="export_test_change"/>
			<!-- margin="0 -280 0 90" -->
		<aos:combobox fieldLabel="优先级" name="priority"
			columnWidth="0.585" allowBlank="true" editable="true"
			forceSelection="false" onchange="export_priority_change">
			<aos:option value="P0" display="P0"/>
			<aos:option value="P1" display="P1" />
			<aos:option value="P2" display="P2" />
			<aos:option value="P3" display="P3"/>
		</aos:combobox>
		<aos:dockeditem xtype="button" text="导入>>" columnWidth="0.5" 
				onclick="export_test_module" icon="up.png" margin="0 0 0 103"/>
	<%-- </aos:docked> --%>
		<aos:window id="export_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="export_proj_name" onenterkey="export_proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="export_proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="exportProj_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="export_find_select" />
		</aos:window>
	<script type="text/javascript">
		//项目风险跟踪自动选择默认项目
		window.onload = function(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			var params = {proj_id : proj_id};
			export_test_version_id_store.getProxy().extraParams = params;
			export_test_version_id_store.load();
			if(proj_id !=null && proj_id!=''){
				AOS.setValue('export_id_proj_name',proj_id);
			 	AOS.setValue('export_tree_proj_name',proj_name);
			 	export_module_tree_refresh();
			 	//export_module();
			}
			begin();
		}
		
		function export_proj_name_query(){
			var proj_name = AOS.getValue('export_proj_name');
			exportProj_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		//单击选择项目
		function export_find_select(export_id_proj_name, records) {
		  	var record = AOS.selectone(exportProj_org_find);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('export_id_proj_name',record.raw.id);
			  	AOS.setValue('export_tree_proj_name',record.raw.text);
			  	//export_module();
			  	export_org_find.hide();
				export_module_tree_refresh();
				export_combobox_refresh();
			}else{
				AOS.tip("请选择项目!");
				return;
			}
	  	}
		
		//单机项目选择刷新下拉框
		function export_combobox_refresh(){
			var proj_id = export_id_proj_name.getValue();
			var params = {proj_id : proj_id};
			export_test_version_id_store.getProxy().extraParams = params;
			export_test_version_id_store.load();
		}
		
		//弹出选择上级模块窗口
		function export_proj_tree_show() {
			export_org_find.show();
		}
		
		//导入测试用例
		function export_test_module(){
			var selection = AOS.selection(export_example_template,'standard_id');
			var rows = AOS.rows(export_example_template);
			var import_module = AOS.selectone(import_module_tree);
			var export_module = AOS.selectone(export_module_tree);
			var params = AOS.getValue('import_form_template'); 
			var param = AOS.getValue('export_form_template');
			var record = AOS.select(export_example_template);
			if(import_module.data.id == 0 || AOS.empty(params.test_version_id) || AOS.empty(params.demand_id)){
				AOS.tip("被导入的项目模块、测试版本号和关联需求不能为空。");
				return;
			}
			
			if(export_id_proj_name.getValue() == import_id_proj_name.getValue() && import_module.data.id == export_module.data.id &&
				param.test_version_id == params.test_version_id){
				AOS.tip("相同项目模块下，同测试版本号不能进行导入。");
				return;
			}
			
			if(import_id_proj_name.getValue() == import_module.data.id){
				AOS.tip("不能选取根节点导入。");
				return;
			}
			
			if(AOS.empty(record)){
				AOS.tip("请先选择要导入的测试用例。");
				return;
			}
			var demand_id = params.demand_id;
			var test_version_id = params.test_version_id;
			var proj_id = import_id_proj_name.getValue();
			var stand_id = import_module.data.id;
			AOS.ajax({
				url:'testExampleService.importExampleModule',
				params:{
					aos_rows : selection,
					standard_id : selection,
					stand_id : stand_id,
					proj_id : proj_id,
					test_version_id : test_version_id,
					demand_id : demand_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					export_example_template.store.reload();
					import_example_template.store.reload();
				}
			});
		}
		
		//被导入模板测试版本号变更事件
		function export_test_change(){
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
			if(proj_id == stand_id){
				params.stand_id = null;
				if(b_stand_id == 0){
					params.b_stand_id = b_proj_id;
					export_example_template_store.getProxy().extraParams = params;
					export_example_template_store.loadPage(1);
				}else{
					export_example_template_store.getProxy().extraParams = params;
					export_example_template_store.loadPage(1);
				}
			}else{
				if(b_stand_id == 0){
					params.b_stand_id = b_proj_id;
					export_example_template_store.getProxy().extraParams = params;
					export_example_template_store.loadPage(1);
				}else{
					export_example_template_store.getProxy().extraParams = params;
					export_example_template_store.loadPage(1);
				}
			}
		}
		
		function export_priority_change(){
			on_export_tree();
		}
	</script>