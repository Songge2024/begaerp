<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="检查单汇总查询" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel tabPosition="top" id="id_tabpanel" region="center">
			<aos:tab id="count_query" title="统计查询" layout="border" autoScroll="false">
				<aos:panel  region="north" bodyBorder="0 1 0 1" width="330">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="选择项目:"/>
						<aos:triggerfield  id="tree_proj_name_count" name="tree_proj_name" editable="false" 
							trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_count_show" width="180" />
						<aos:hiddenfield id="id_proj_name_count" name="id_proj_name"/>
					</aos:docked>
				</aos:panel>
				<aos:panel region="west" bodyBorder="0 1 0 1" width="250" collapsible="true">
					<aos:treepanel id="checkMain_grid_count" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
						url="checkMainService.getCheckMainListTreeData" onitemclick="checkMainTree_count_query" cascade="true" rootExpanded="true">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="QA检查单类型" />
							<aos:dockeditem xtype="tbseparator" />
						</aos:docked>
					</aos:treepanel>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="fn_count" layout="column" labelWidth="150" header="false" border="false" >
							<aos:datefield  name="check_begin_time" fieldLabel="检查开始时间" columnWidth="0.5"  editable="false" />
							<aos:datefield  name="check_end_time" fieldLabel="检查结束时间" columnWidth="0.5"  editable="false" />
							<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
								<aos:dockeditem xtype="tbfill" />
								<aos:dockeditem xtype="button" text="查询" onclick="fn_select_count"
									icon="query.png" />
								<aos:dockeditem xtype="button" text="重置"
									onclick="AOS.reset(fn_count);" icon="refresh.png" />
								<aos:dockeditem xtype="tbfill" />
							</aos:docked>
						</aos:formpanel>
					</aos:panel>
					<%@ include file="checkMainCount_grid.jsp"%>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="problem_query" title="问题统计" layout="border" autoScroll="false">
				<aos:panel  region="north" bodyBorder="0 1 0 1" width="330">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="选择项目:"/>
						<aos:triggerfield  id="tree_proj_name_problem" name="tree_proj_name" editable="false" 
							trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_problem_show" width="180" />
						<aos:hiddenfield id="id_proj_name_problem" name="id_proj_name"/>
					</aos:docked>
				</aos:panel>
				<aos:panel region="west" bodyBorder="0 1 0 1" width="250" collapsible="true">
					<aos:treepanel id="checkMain_grid_problem" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
						url="checkMainService.getCheckMainProblemTreeData" onitemclick="checkMainTree_problem_query"  cascade="true" rootExpanded="true">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="QA检查单类型" />
							<aos:dockeditem xtype="tbseparator" />
						</aos:docked>
					</aos:treepanel>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="fn_problem" layout="column" labelWidth="150" header="false" border="false" >
							<aos:datefield  name="check_begin_time" fieldLabel="检查开始时间" columnWidth="0.5"  editable="false" />
							<aos:datefield  name="check_end_time" fieldLabel="检查结束时间" columnWidth="0.5"  editable="false" />
							<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
								<aos:dockeditem xtype="tbfill" />
								<aos:dockeditem xtype="button" text="查询" onclick="fn_select_problem"
									icon="query.png" />
								<aos:dockeditem xtype="button" text="重置"
									onclick="AOS.reset(fn_problem);" icon="refresh.png" />
								<aos:dockeditem xtype="tbfill" />
							</aos:docked>
						</aos:formpanel>
					</aos:panel>
					<%@ include file="checkMainCountProblem_grid.jsp"%>
				</aos:panel>
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>
	  
	<aos:window id="w_org_find_count" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="proj_name_count" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="t_org_find_count" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="count_find_select" />
	</aos:window>
	<aos:window id="w_org_find_problem" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="proj_name_count_problem" onenterkey="proj_name_problem_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_name_problem_query" width="180" />
		</aos:docked>
		<aos:treepanel id="t_org_find_count_problem" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="problem_find_select" />
	</aos:window>
	<%@ include file="checkDetail_grid_win.jsp"%>
	
	
	<script type="text/javascript">
		window.onload = function(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			if(proj_id !=null && proj_id!=''){
				AOS.setValue('id_proj_name_count',proj_id);
				AOS.setValue('tree_proj_name_count',proj_name);
				AOS.setValue('id_proj_name_problem',proj_id);
				AOS.setValue('tree_proj_name_problem',proj_name);
				count_grid_refresh();
				problem_grid_refresh();
			}
		}
		
		function proj_name_query(){
			var proj_name = AOS.getValue('proj_name_count');
			t_org_find_count_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		function proj_name_problem_query(){
			var proj_name = AOS.getValue('proj_name_count_problem');
			t_org_find_count_problem_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		function count_grid_refresh(){
			var proj_id = id_proj_name_count.getValue();
			if(AOS.empty(proj_id)){
				return;
			}
			checkMain_grid_count_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					checkMain_grid_count.getSelectionModel().select(checkMain_grid_count.getRootNode());
				}
			});
			AOS.reset(fn_count);
		}
		function problem_grid_refresh(){
			var proj_id = id_proj_name_problem.getValue();
			checkMain_grid_problem_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					checkMain_grid_problem.getSelectionModel().select(checkMain_grid_problem.getRootNode());
				}
			});
			AOS.reset(fn_problem);
		}
		
		//弹出选择项目选择窗口
		function proj_tree_count_show() {
			w_org_find_count.show();
		}
		//
		function proj_tree_problem_show(){
			w_org_find_problem.show();
		}
		
		//单击选择项目
		function count_find_select(){
			var record = AOS.selectone(t_org_find_count);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('id_proj_name_count',record.raw.id);
			  	AOS.setValue('tree_proj_name_count',record.raw.text);
			  	count_grid_refresh();
				w_org_find_count.hide();
		 	 }else{
				AOS.tip("请选择项目!");
				return;
			}
		}
		//单击选择项目
		function problem_find_select(){
			var record = AOS.selectone(t_org_find_count_problem);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('id_proj_name_problem',record.raw.id);
			  	AOS.setValue('tree_proj_name_problem',record.raw.text);
			  	problem_grid_refresh();
				w_org_find_problem.hide();
		 	 }else{
				AOS.tip("请选择项目!");
				return;
			}
		}
		
		
		//单击树结构
		function checkMainTree_count_query(){
			var record = AOS.selectone(checkMain_grid_count);
			var proj_id = AOS.getValue('id_proj_name_count');
			var params = AOS.getValue('fn_count');
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
			AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				url : 'checkMainService.countNum',
				params : params,
				ok : function(data){ 
					summary = data; 
					checkMainCount_grid_store.getProxy().extraParams = params;
					checkMainCount_grid_store.loadPage(1);
			 	}
			});
		}
		
		
		
		//单击树节点
		function checkMainTree_problem_query(){
			var record = AOS.selectone(checkMain_grid_problem);
			var proj_id = AOS.getValue('id_proj_name_problem');
			var params = AOS.getValue('fn_problem');
			if(AOS.empty(proj_id)){ 
				return; 
			}
			if(!AOS.empty(record)){
				if(record.raw.b == undefined){
					params.proj_id = proj_id;
				}else{
					params.proj_id = proj_id;
					params.check_cata_id = record.raw.b;
				}
				AOS.ajax({
					wait : false, //防止出现2个遮罩层。(ajax和表格load)
					url : 'checkMainService.problemNum',
					params : params,
					ok : function(data){
						summary = data; 
						checkMainCountProblem_grid_store.getProxy().extraParams = params;
						checkMainCountProblem_grid_store.loadPage(1);
				 	}
				}); 
			}
		}
		
		//查询
		function fn_select_count(){
			checkMainTree_count_query();
		}
		//查询
		function fn_select_problem(){
			checkMainTree_problem_query();
		}
		
		//点击
		function fn_check_detail(value, metaData, record){
			if(value != 0) {
				return '<a href="javascript:void(0);">' + record.data.check_code + '</a>';
			}
			return value;
		}
		checkMainCount_grid.on("cellclick", function(grid, rowIndex, columnIndex, e){
			var record = AOS.selectone(checkMainCount_grid, true);
			if(AOS.empty(record) || record.length>1){
				AOS.tip('只能勾选一列查看缺陷详情。');
				return;
			}
			if (columnIndex == 2 ) {
				checkDetail_grid_win.show();
				var params = {check_id : record.data.check_id};
				new_checkdetail_grid_store.getProxy().extraParams = params;
				new_checkdetail_grid_store.loadPage(1);
			}
		});
	</script>
</aos:onready>
	