<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractStage1_grid" 
	url="contractStageService.page" 
	forceFit="true"
	border='true'
 	split="true"
 	height="345"
 	columnWidth='1'
  	bodyBorder="1 0 1 0"
  	hidePagebar="true"
  	onitemclick="fn3"
  >
  	<!-- onrender="projContract_query"  -->
	<%@ include file="contractStage_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="contractStage_columns.jsp"%>
</aos:gridpanel>

<script type="text/javascript">

//查询
function contractStage_query(proj_id) {
	var params = AOS.getValue('query_form');
    contractStage_grid1_store.getProxy().extraParams = {
    	proj_id : proj_id
    };
    contractStage_grid1_store.loadPage(1);
}

function fn3(){
	var select = AOS.select(contractStage1_grid);
	var stage_id = select[0].data.stage_id;
	var ct_id = select[0].data.ct_id;
	var proj_id = select[0].data.proj_id;
	var params = {stage_id : stage_id};
	contractPayInfo_grid_store.getProxy().extraParams = params;
	contractPayInfo_grid_store.loadPage(1);
	
}
</script>