<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="过程文档上传下载管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="column">
		<aos:panel columnWidth='0.27'  height='-0'  border='true'>
			<%@ include file="codes/processList_tree.jsp"%>
		</aos:panel>
		<aos:panel columnWidth='0.3' height='-0' border='true'>
			<%@ include file="codes/processFiletype_grid.jsp"%>
		</aos:panel>
		<aos:panel columnWidth='0.43' height='-0' border='true'>
			<%@ include file="codes/processFileUpload_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="290" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="150" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>

	<script type="text/javascript">
	function proj_name_query(){
		var proj_name = AOS.getValue('proj_name');
		t_org_find_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	</script>

</aos:onready>