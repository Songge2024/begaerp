<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目管理配置" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north" height ="34"  bodyBorder="0 0 0 0">
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="选择项目:" />
					<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" 
						trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="220" />
					<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			</aos:docked>
		</aos:panel>
		<aos:panel  region="west" headerBorder="0 0 0 1" width="460" bodyBorder="0 1 0 1">
			<%@ include file="projVersion_grid.jsp" %>
		</aos:panel>
		
		<aos:panel  region="center" headerBorder="0 0 0 1"  bodyBorder="0 0 0 0" >
			<%@ include file="projTestVersion_grid.jsp" %>
		</aos:panel>
		<aos:panel region="east" headerBorder="0 0 0 1"  width="480" bodyBorder="0 0 0 1">
			<%@ include file="projCodeVersion_grid.jsp" %>
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
    <%@ include file="projVersion_create_win.jsp" %>
	<%@ include file="projVersion_update_win.jsp" %>
	<%@ include file="projVersion_handler.jsp" %>
	<%@ include file="projCodeVersion_create_win.jsp" %>
	<%@ include file="projCodeVersion_update_win.jsp" %>
	<%@ include file="projCodeVersion_handler.jsp" %>
	<%@ include file="projTestVersion_create_win.jsp" %>
	<%@ include file="projTestVersion_update_win.jsp" %>
	<%@ include file="projTestVersion_handler.jsp" %>
	
	<script type="text/javascript">
		//项目配置管理自动选择默认项目
		window.onload = function(){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			if(proj_id !=null && proj_id!=''){
				AOS.setValue('id_proj_name',proj_id);
				AOS.setValue('tree_proj_name',proj_name);
				tree_grid_refresh();
			}
		}
		
		//弹出选择上级模块窗口
		function proj_tree_show() {
			w_org_find.show();
		}
		
		//项目配置管理单击选择项目
		function t_org_find_select(){
			var record = AOS.selectone(t_org_find);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('id_proj_name',record.raw.id);
			  	AOS.setValue('tree_proj_name',record.raw.text);
				tree_grid_refresh();
				w_org_find.hide();
		 	 }else{
				AOS.tip("请选择项目!");
				return;
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
		
		//根据选择项目名称刷新树和grid
		function tree_grid_refresh() {
			projVersion_query();
			//projCodeVersion_query2();
		}
		
		//查询
		function projVersion_query() {
			var proj_id = id_proj_name.getValue();
			if(AOS.empty(proj_id)){ 
				return; 
			}
			var params = { proj_id : proj_id };
		    projVersion_grid_store.getProxy().extraParams = params;
		    projVersion_grid_store.loadPage(1);
		}
	</script>
</aos:onready>