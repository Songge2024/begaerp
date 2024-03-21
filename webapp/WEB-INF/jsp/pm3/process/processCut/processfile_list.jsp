<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目过程裁剪" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north"  height ="180"  bodyBorder="1 0 1 0">
			<%@ include file="processProject_form.jsp"%>
		</aos:panel>
		<aos:panel  region="west" headerBorder="0 0 0 1" width="600" bodyBorder="0 0 0 1">
			<%@ include file="processTemplet_grid.jsp"%>
		</aos:panel>
		<aos:panel  region="center" headerBorder="0 0 0 1" width="200"  bodyBorder="0 0 0 1" >
			<%@ include file="processFiletype_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]"  width="314" height="-30" layout="fit" autoScroll="true" >
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
</aos:window>
	
	
	<%@ include file="processFiletype_handler.jsp"%>
	<%@ include file="processFiletype_add_win.jsp"%>
	<%@ include file="processTemplet_add_win.jsp"%>
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
<script type="text/javascript">
//默认加载项目
window.onload = function combobox_select(){
	var record = AOS.get('t_org_find');
	var arr = record.store.tree.root.childNodes;
	if(arr.length > 0){
		var proj_id = arr[0].raw.id;
		var porj_name = arr[0].raw.text;
		AOS.get('id_proj_name').setValue(proj_id);
		AOS.get('tree_proj_name').setValue(porj_name);
		proj_onselect();
	}
}
</script>