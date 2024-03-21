<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目里程碑" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:treepanel id="t_module" region="west" bodyBorder="0 1 0 0" 
			width="350" rootText="里程碑计划" singleClick="false"
			url="projMilestoneService.getTreeData" nodeParam="parent_id"
			rootId="1" onitemclick="projMilestone_grid_query">
			<aos:docked>
			<aos:dockeditem xtype="tbtext" text="选择项目:" /> 
			 	<%-- <aos:combobox id="id_proj_name" dicField="proj_name"
					emptyText="项目名称" onselect="tree_grid_query" selectAll="true"
					width="250" allowBlank="false"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" /> --%>
					<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="250" />
					<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			</aos:docked>
			<aos:docked>
				<aos:dockeditem xtype="tbtext" text="项目里程碑树" />
			<aos:dockeditem xtype="tbseparator" />
			<aos:dockeditem tooltip="新增" icon="add.png"
				onclick="projMilestone_win_show('create');" />
			<aos:dockeditem tooltip="修改" icon="edit.png"
				onclick="projMilestone_win_show('update');" />
			<aos:dockeditem tooltip="结束" onclick="projMilestone_win_show('over');"  
				icon="stop.gif" />
			<aos:dockeditem tooltip="删除" icon="del.png" onclick="projMilestone_delete"  hidden="true"/>
			<aos:dockeditem tooltip="停用" onclick="projMilestone_grid_upstate"  hidden="true"
				icon="stop.gif" />
			<aos:dockeditem tooltip="启用" onclick="projMilestone_grid_submit"  hidden="true"
				icon="go.gif" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增"
					onclick="projMilestone_win_show('create')" icon="add.png" />
						<aos:menuitem text="修改" icon="edit.png"
				onclick="projMilestone_win_show('update');" />
				<aos:menuitem text="结束" onclick="projMilestone_win_show('over');"  
				icon="stop.gif" />
			<aos:menuitem text="删除" icon="del.png" onclick="projMilestone_delete"  hidden="true"/>
			<aos:menuitem text="停用" onclick="projMilestone_grid_upstate"  hidden="true"
				icon="stop.gif" />
			<aos:menuitem text="启用" onclick="projMilestone_grid_submit"  hidden="true"
				icon="go.gif" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="t_module_refresh"
					icon="refresh.png" />
			</aos:menu>
		</aos:treepanel>
			<aos:panel region="center">
			
				<aos:panel  region="north">
				<aos:docked forceBoder="0 0 1 1">
				<aos:dockeditem xtype="tbtext"  text="项目总体信息" />
				</aos:docked>
	<aos:formpanel id="projMilestone_formfields_form" layout="column" labelWidth="120" bodyBorder="0 0 0 1"
						header="false" border="false">
					<%@ include file="projMilestone_formfields.jsp"%>
				</aos:formpanel>
				</aos:panel>
				
				
				</aos:panel>
	
	</aos:viewport>
	

	<%@ include file="checkMain_create_win.jsp"%>
		<%@ include file="projMilestone_handler.jsp"%>
	<%@ include file="projMilestone_win.jsp"%>
	<script>
	// id_proj_name.on("expand",function(){
		//id_proj_name.getPicker().setWidth(500).setAutoScroll(true);
//	});  
	</script>
</aos:onready>
<script type="text/javascript">
//单元格的颜色转换
	function fn_render(value, metaData, record) {
		if (value == '0') {
			return "<span style='color:red; font-weight:bold'>未提交</span>";
		} else {
			return "<span style='color:blue; font-weight:bold'>已提交</span>";
		}
		return value;
	}
	</script>