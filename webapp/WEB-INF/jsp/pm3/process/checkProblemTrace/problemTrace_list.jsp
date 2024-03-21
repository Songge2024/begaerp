<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_problem_trace" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel  region="north" bodyBorder="0 1 0 1" width="330" >
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="选择项目:"/>
				<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" 
					trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="180" />
				<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			</aos:docked>
		</aos:panel>
		<aos:panel region="west" bodyBorder="0 1 0 1" width="250" collapsible="true">
			<aos:treepanel id="checkMain_grid" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
				url="checkMainService.getCheckMainListTreeData" onitemclick="checkMainTree_query" cascade="true" rootExpanded="true">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="QA检查单类型" />
					<aos:dockeditem xtype="tbseparator" />
				</aos:docked>
			</aos:treepanel>
		</aos:panel>
		<aos:panel region="center" border="false" layout="border">
			<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
				<aos:formpanel id="fn_problem_trace" layout="column" labelWidth="150" header="false" border="false" >
					<aos:combobox fieldLabel="问题来源" dicField="problem_sources"
						multiSelect="false" name="problem_sources" columnWidth="0.33" />
					<aos:combobox fieldLabel="过程及产品" dicField="process_product"
						multiSelect="false" name="process_product" columnWidth="0.33" />
					<aos:combobox fieldLabel="问题状态" dicField="problem_state"
						multiSelect="true" name="problem_state" columnWidth="0.33" />
					<aos:combobox id="search_principal_org" fieldLabel="负责人部门" name="principal_org" 
						editable="false" columnWidth="0.33" queryMode="local" width="100"
						url="problemTraceService.listPrincipalOrg" emptyText="负责人部门查询"/>
					<aos:combobox fieldLabel="问题等级" dicField="problem_level"
						multiSelect="false" name="problem_level" columnWidth="0.33" />
					<aos:combobox id="search_deal_man" fieldLabel="处理人" name="deal_man" 
						editable="true" columnWidth="0.33" queryMode="local" width="100"
						typeAhead="true" forceSelection="true" selectOnFocus="true"
						url="problemTraceService.listDealMan" emptyText="处理人查询" />
						
					<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查询" onclick="problemTrace_query"
							icon="query.png" />
						<aos:dockeditem xtype="button" text="重置"
							onclick="AOS.reset(fn_problem_trace);" icon="refresh.png" />
						<aos:dockeditem xtype="tbfill" />
					</aos:docked>
				</aos:formpanel>
			</aos:panel>
			<%@ include file="problemTrace_grid.jsp"%>
		</aos:panel>
		
	</aos:viewport>
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	<%@ include file="problemTrace_handler.jsp"%>
	
	<script type="text/javascript">
		//qa问题查询默认加载默认项目
		window.onload = function(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			if(proj_id !=null && proj_id!=''){
				AOS.setValue('id_proj_name',proj_id);
				AOS.setValue('tree_proj_name',proj_name);
				grid_refresh();
				all_proj_id= '${proj_id}';
				search_deal_man_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				search_deal_man_store.load();
				list_principal_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				list_principal_store.load();
				list_deal_man_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				list_deal_man_store.load();
				changeTimer();
				proj_manager();
			}
		}
		
		function proj_name_query(){
			var proj_name = AOS.getValue('proj_name');
			t_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		//弹出选择项目选择窗口
		function proj_tree_show() {
			w_org_find.show();
		}
		
		//单击选择项目
		function t_org_find_select(){
			var record = AOS.selectone(t_org_find);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('id_proj_name',record.raw.id);
			  	AOS.setValue('tree_proj_name',record.raw.text);
				grid_refresh();
				changeTimer();
				proj_manager();
				all_proj_id=record.raw.id;
				search_deal_man_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				search_deal_man_store.load();
				list_principal_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				list_principal_store.load();
				list_deal_man_store.getProxy().extraParams = {
					proj_id : all_proj_id
				}
				list_deal_man_store.load();
				w_org_find.hide();
		 	 }else{
				AOS.tip("请选择项目!");
				return;
			}
		}
		
		function grid_refresh(){
			var proj_id = id_proj_name.getValue();
			if(AOS.empty(proj_id)){
				return;
			}
			checkMain_grid_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					checkMain_grid.getSelectionModel().select(checkMain_grid.getRootNode());
				}
			});
			var params = {proj_id : proj_id};
			problemTrace_grid_store.getProxy().extraParams = params;
			problemTrace_grid_store.loadPage(1);
			problemTrace_grid_store.load({
				params:{
					proj_id : proj_id
				}
			});
			AOS.reset(fn_problem_trace);
		}
		//单击树结构
		function checkMainTree_query(){
			var record = AOS.selectone(checkMain_grid);
			var proj_id = AOS.getValue('id_proj_name');
			var params = AOS.getValue('fn_problem_trace');
			if(AOS.empty(proj_id)){ 
				return; 
			}
			if(!AOS.empty(record)){
				if(record.raw.a == undefined && record.raw.b == undefined){
					params.proj_id = proj_id;
				}else if(record.raw.a == undefined && record.raw.b != undefined){
					params.proj_id = proj_id;
					params.check_cata_id = record.raw.b;
				}else{
					params.proj_id = proj_id;
			 		params.check_id = record.raw.id;
				}
			}
			problemTrace_grid_store.getProxy().extraParams = params;
			problemTrace_grid_store.loadPage(1);
		}
		//查询
		function problemTrace_query() {
			checkMainTree_query();
		}
		//查询当前项目下为解决的问题
		function changeTimer(){
			var proj_id = AOS.getValue('id_proj_name');
			AOS.ajax({
				params : {proj_id : proj_id},
				url : 'problemTraceService.changeTimer',
				ok : function(data){
					
				}
			});
		}
		
	</script>
</aos:onready>