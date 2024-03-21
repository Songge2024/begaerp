<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目汇报" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="west" width="320" collapsible="true" title="项目选择">
			<%@ include file="week_grid_tree.jsp"%>
		</aos:panel>
		<aos:panel region="center" headerBorder="0 0 0 1" width="200"
			bodyBorder="0 0 0 1" layout="border" border="true">
			<aos:panel region="north" border="true" width="200" anchor="100%"
				bodyBorder="0 1 0 0">
				<%@ include file="projectReport_form.jsp"%>
			</aos:panel>
			<aos:panel region="center" border="true" width="200"
				bodyBorder="0 1 0 0">
				<%@ include file="projectReport.jsp"%>
			</aos:panel>
		</aos:panel>
		

	</aos:viewport>
	
<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30"  width="320" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="pproj_name" onenterkey="pproj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="pproj_name_query" width="150" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
</aos:window>

<script type="text/javascript">
function pproj_name_query(){
	var proj_name = AOS.getValue('pproj_name');
	t_org_find_store.load({
		params:{
			proj_name : proj_name
		}
	})
}
</script>

</aos:onready>