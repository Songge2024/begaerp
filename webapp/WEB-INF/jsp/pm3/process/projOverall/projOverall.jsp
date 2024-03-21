<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="用户管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<aos:treepanel id="t_overall" region="west" bodyBorder="0 1 0 0" width="350" rootText="WBS"
			singleClick="false" url="projOverallService.getTreeData" nodeParam="proj_id" rootId="${rootPO.id}"
			onitemclick="g_overall_query" rootIcon="home.png" rootAttribute="a:'${rootPO.cascade_id}'">
			<aos:docked forceBoder="0 1 1 0">
				<aos:dockeditem xtype="tbtext" text="选择项目:"/>
				<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" 
					trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="180" />
				<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
				<aos:checkbox boxLabel="级联显示" id="id_cascade" onchange="g_overall_query" checked="false" />
			</aos:docked>
		</aos:treepanel>
		<aos:gridpanel id="g_overall" url="projOverallService.page" region="center" bodyBorder="1 0 1 0" onrender="g_overall_query">
			<aos:docked forceBoder="0 0 1 0">
			  	<aos:dockeditem text="统一保存" onclick="g_overall_save" icon="save.png" />
			  	<aos:dockeditem text="全部导出" onclick="exportAll" icon="icon70.png" />
			</aos:docked>
			<aos:plugins>
				<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
			</aos:plugins>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="项目id" dataIndex="proj_id" fixedWidth="120" hidden="true" />
			<aos:column header="项目id" dataIndex="group_id" fixedWidth="120" hidden="true" />
			<aos:column header="节点id" dataIndex="parent_id" fixedWidth="120" hidden="true" />
			<aos:column header="节点语义ID" dataIndex="cascade_id" fixedWidth="150" hidden="true" />
			<aos:column header="项目WBS" dataIndex="group_name" fixedWidth="300" align="center"/>
			<aos:column header="计划开始时间" dataIndex="plan_begin_time" fixedWidth="250" align="center" format="Y-m-d"  type="date">
				<aos:datefield format="Y-m-d" />
			</aos:column>
			<aos:column header="计划结束时间" dataIndex="plan_end_time" fixedWidth="250" align="center" format="Y-m-d" type="date">
				<aos:datefield format="Y-m-d" />
			</aos:column>
			<aos:column header="完成百分比" dataIndex="percent" fixedWidth="240" align="center" rendererFn="render_percent"/>
			<aos:column header="备注" dataIndex="remark" fixedWidth="305" celltip="true" >
				<aos:textfield />
			</aos:column>
		</aos:gridpanel>
	</aos:viewport>
	
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	<script type="text/javascript">
	
		//完成百分比
		function render_percent(value){
			if(value)return value+"%";
			return "0%";
		}
	
		//自动加载默认项目
		window.onload = function(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			if(proj_id !=null && proj_id!=''){
				all_proj_id= '${proj_id}';
				AOS.setValue('id_proj_name',proj_id);
				AOS.setValue('tree_proj_name',proj_name);
				t_overall_refresh();
				solve_refresh();
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
		
		//自动选中根节点
		AOS.job(function(){
			t_overall.getSelectionModel().select(t_overall.getRootNode());
			g_overall_query();
		},10);
	
		//弹出选择项目选择窗口
		function proj_tree_show() {
			w_org_find.show();
		}
		//单击选择项目
		function t_org_find_select() {
			var record = AOS.selectone(t_org_find);
			if(record.raw.a=="1"){
			AOS.setValue('id_proj_name',record.raw.id);
			AOS.setValue('tree_proj_name',record.raw.text);
			t_overall_refresh();
			solve_refresh();
			w_org_find.hide();
			}else{
				AOS.tip("请选择项目!");
				return;
			}
		}
		
		function t_overall_refresh(){
			var refreshnode = t_overall.getRootNode();
			var proj_id = id_proj_name.getValue();
			if(AOS.empty(proj_id)){
				return;
			}
			t_overall_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					refreshnode.collapse();
					refreshnode.expand();
					t_overall.getSelectionModel().select(refreshnode);
				}
			});
			g_overall_query();
		}
		
		function solve_refresh() {
			var params = { 
					proj_id : id_proj_name.getValue(),
					cascade : id_cascade.getValue()
			};
			g_overall_store.getProxy().extraParams = params;
			g_overall_store.loadPage(1);
		}
		
		//查询
		function g_overall_query(){
			var params = {
				proj_id : id_proj_name.getValue(),
				cascade: id_cascade.getValue()
			};
			var record = AOS.selectone(t_overall);
			if(!AOS.empty(record)){
				params.group_id = record.raw.id;
				params.parent_id = record.raw.id;
				params.cascade_id = record.raw.a;
			}
			g_overall_store.getProxy().extraParams = params;
			g_overall_store.loadPage(1);
		}
		
		//统一保存
		function g_overall_save(){
			var record = AOS.selectone(t_overall);
			if (AOS.mrows(g_overall) == 0) {
				AOS.tip('数据没变化，提交操作取消。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows:AOS.mrs(g_overall)
				},
				url : 'projOverallService.saveGrid',
				ok : function(data){
					AOS.ajax({
						url : 'taskGroupService.update',
						params : {
							group_id : record.raw.id
						},
						ok : function(data){
							AOS.tip(data.appmsg);
							g_overall_store.reload();
							t_overall_refresh();
							solve_refresh();
						}
					});
				}
			});
		}
		
		//全部导出
		function exportAll(){
			var record = AOS.selectone(t_overall);
			var proj_id = AOS.getValue("id_proj_name");
			if(!AOS.empty(record)){
				group_id = record.raw.id;
				parent_id = record.raw.id;
				cascade_id = record.raw.a;
			}
			var start = 0;
			var limit = 50;
			var group_id = record.raw.id;
			var parent_id = record.raw.id;
			var cascade = AOS.getValue("id_cascade");
			var cascade_id = record.raw.a;
			if(cascade === undefined){
				id_cascade="";
			}
			AOS.file('do.jhtml?router=projOverallService.exportALLExcel&juid=${juid}&proj_id='+proj_id
					+'&group_id='+group_id
					+'&parent_id='+parent_id
					+'&cascade_id='+cascade_id
					+'&cascade='+cascade
					+'&start='+start
					+'&limit='+limit
				);
		}
		
	</script>
</aos:onready>