<%@ page contentType="text/html; charset=utf-8"%>
<%
	//设置type_code_columnWidth
	pageContext.setAttribute("proj_id_columnWidth", ".33");
%>

<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="../../public/public_method.jsp"%>
<%@page import="aos.system.common.model.UserModel"%>

<aos:html title="re_demand_action" base="http" lib="ext,ueditor">
<aos:body>
	<div id="demand_desc_div">
		<script type="text/plain" id="demand_desc_editor"
			style="text-align: left; margin-top: 5px; margin-right: 5px; width: 86%; min-height: 200px; height: 200px"></script>
	</div>
	<div id="content_desc_div">
		<script type="text/plain" id="content_desc_editor"
			style="text-align: left; margin-top: 5px; margin-right: 5px; width: 86%; min-height: 200px; height: 200px"></script>
	</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:treepanel id="demandAction_t_module" region="west"
			bodyBorder="0 1 0 0" width="280" rootVisible="false"
			singleClick="false" url="projTypesService.getModuleDivideTreeData"
			nodeParam="dm_parent_code" rootId="0" onitemclick="g_module_query">
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="选择项目:" />
				<%-- <aos:combobox id="demandAction_id_proj_name" dicField="proj_name"
					emptyText="请选择项目" onselect="tree_grid_query" selectAll="true"
					width="200" allowBlank="false"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" /> --%>
				<aos:triggerfield id="tree_proj_name" name="tree_proj_name"
					editable="false" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="proj_tree_show1" width="200" />
				<aos:hiddenfield id="id_proj_name" name="id_proj_name" />
			</aos:docked>
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="功能模块树" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增需求" onclick="demandAction_win_show('create');"
					icon="add.png" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="demandAction_t_module_refresh"
					icon="refresh.png" />
			</aos:menu>
		</aos:treepanel>
		<aos:panel flex="4" border='true' layout="border" region="center">
			<%@ include file="demandAction_grid.jsp"%>
			<%@ include file="../demandActionFile/demandActionFile_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	<aos:window id="w_org_find1" x="0" y="30" title="项目树[单击选择]" height="-30" width="280" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="150" />
			</aos:docked>
			<aos:treepanel id="t_org_find1" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_tree_find_select" />
	</aos:window>
	<%@ include file="demandAction_win.jsp"%>
	<%@ include file="demandAction_handler.jsp"%>
	<%@ include file="demandLook_win.jsp"%>
	<%@ include file="demandTaskCreate_win.jsp"%>
	<%@ include file="demandTaskAdd_win.jsp"%>
	<%@ include file="demand_find_task_win.jsp"%>
	<%@ include file="../demandActionFile/demandActionFile_handler.jsp"%>
	<%@ include file="../demandActionFile/demandActionFile_win.jsp"%>
	
	<script type="text/javascript">
	function proj_name_query(){
		var proj_name = AOS.getValue('proj_name');
		t_org_find1_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	</script>
	
</aos:onready>

<script type="text/javascript">
	function w_detail_show() {
		var record = AOS.selectone(AOS.get('demandAction_grid'), true);
		if (AOS.empty(record)) {
			AOS.tip('请选择要查看的记录。');
			return;
		}
		AOS.get('demand_look_form').loadRecord(record);
		AOS.get('demand_look_win').show();
		AOS.get('demand_look_win').maximize();
	}
</script>