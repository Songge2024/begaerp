<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="projContract1_grid" 
	url="contractPayInfoService.pay" 
	forceFit="true"
 	border='true'
 	columnWidth='0.2'
 	height="450"
  	bodyBorder="1 1 1 1" 
  	hidePagebar="true"
  	onitemclick="fn1"          
  >
 <!--  onrender="projContract_query"  -->
	<%@ include file="projContract_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="projContract_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">
//查询
function projContract_query(proj_id) {
    projContract1_grid_store.getProxy().extraParams = {
    	proj_id:proj_id
    };
    projContract1_grid_store.loadPage(1);
}


function fn1(){
	var select = AOS.select(projContract1_grid);
	var ct_id = select[0].data.ct_id;
	var proj_id = select[0].data.proj_id;
	var params = {proj_id : proj_id,ct_id : ct_id};
	contractStage1_grid_store.getProxy().extraParams = params;
	contractStage1_grid_store.loadPage(1);
	
}
</script>
