<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目检查单" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel  region="north" bodyBorder="0 1 0 1" width="330">
			<%@ include file="proj_combo.jsp"%>
		</aos:panel>
		
		<aos:panel  region="west" bodyBorder="0 1 0 1" width="250" collapsible="true">
			<%@ include file="checkMain_grid.jsp"%>
		</aos:panel>			
		<aos:panel region="center" border="false" layout="border">
			<aos:layout type="vbox" align="stretch" />
			<aos:panel flex ="2">
				<%@ include file="checkDetail_grid.jsp"%>
			</aos:panel>
			<aos:panel flex ="1">
				<aos:formpanel id="f_result" layout="column" labelWidth="150"  >
					<%@ include file="checkMain_result_form.jsp"%>
				</aos:formpanel>
			</aos:panel>
		</aos:panel>
	</aos:viewport>

	<%@ include file="checkMain_create_win.jsp"%>
	<%@ include file="checkMain_update_win.jsp"%>
	<%@ include file="checkMain_handler.jsp"%>
	<%@ include file="checkDetail_create_win.jsp"%>
	<%@ include file="checkDetail_update_win.jsp"%>
	<%@ include file="checkDetail_handler.jsp"%>

	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30"  width="330" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="t_org_find" singleClick="false" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	
<script>
	//qa检查单默认加载默认项目
	window.onload = function(){
		var proj_id = '${proj_id}';
		var proj_name = '${proj_name}';
		if(proj_id !=null && proj_id!=''){
			AOS.setValue('id_proj_name',proj_id);
			AOS.setValue('tree_proj_name',proj_name);
			grid_refresh();
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
				AOS.reset(checkMain_result_form);
			}
		});
	}
	
	//qa检查单点击选择项目
	function t_org_find_select() {
	  	var record = AOS.selectone(t_org_find);
		if(record.raw.a=="1"){
		  	AOS.setValue('id_proj_name',record.raw.id);
		  	AOS.setValue('tree_proj_name',record.raw.text);
		  	grid_refresh();
			w_org_find.hide();
		}else{
			AOS.tip("请选择项目!");
			return;
		}
	}
	
	//弹出选择上级模块窗口
	function proj_tree_show() {
		w_org_find.show();
	}	
</script>
	
</aos:onready>

	