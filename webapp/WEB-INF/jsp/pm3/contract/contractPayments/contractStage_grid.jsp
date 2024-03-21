<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractStage_grid" 
	url="contractStageService.page" 
	forceFit="true"
 	region="center"
  	hidePagebar="true"
  	columnLines="true"
  	features="summary"
  	onitemclick="stageGrid_click"
  >
  <aos:docked>
  <aos:dockeditem xtype="tbtext" text="合同支付阶段信息" />
  <aos:dockeditem xtype="tbseparator" />
  </aos:docked>
  <aos:selmodel type="checkbox" mode="single" />
	<aos:column type="rowno" />
	<%@ include file="contractStage_columns.jsp"%>

</aos:gridpanel>

<script type="text/javascript">
//查询
function contractStage_query() {
	var params = AOS.getValue('query_form');
    contractStage_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    contractStage_grid_store.loadPage(1);
}
//单击
function stageGrid_click(){
	var ct_stage_id = AOS.select(contractStage_grid)[0].data.ct_stage_id;
	if(AOS.rows(contractPayment_grid) == 1){
	//var ct_pay_id = AOS.select(contractPayment_grid)[0].data.ct_pay_id;
	contractPaymentDetail_grid_store.reload({
   		params : {
   			ct_stage_id : ct_stage_id
   		//	ct_pay_id : ct_pay_id
   		}
   	});
	}else{
		var ct_stage_id = AOS.select(contractStage_grid)[0].data.ct_stage_id;
		contractPaymentDetail_grid_store.reload({
	   		params : {
	   			ct_stage_id : ct_stage_id
	   		}
	   	});
	}
}

</script>