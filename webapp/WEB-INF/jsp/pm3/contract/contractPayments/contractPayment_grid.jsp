<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="contractPayment_grid" 
	url="contractPaymentService.page" 
	forceFit="true"
 	region="center"
  	hidePagebar="true"
  	columnLines="true"
  	features="summary"
  	onitemclick="paymentGrid_click"
  >
	
	<aos:menu>
		<aos:menuitem text="新增" onclick="contractPayment_win_show('create');" icon="add.png" />
		<aos:menuitem text="修改" onclick="contractPayment_win_show('update');" icon="edit.png" />
		<aos:menuitem text="作废" onclick="contractPayment_delete" icon="del.png" />
		<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#contractPayment_grid_store.reload();" icon="refresh.png" />
	</aos:menu>
	<aos:docked id="dock_state" >
		<aos:dockeditem xtype="tbtext" text="合同回款信息" />
		<aos:dockeditem xtype="tbseparator" />
		<aos:dockeditem text="新增" icon="add.png"  		onclick="contractPayment_win_show('create');" />
		<aos:dockeditem text="修改" icon="edit.png" 		onclick="contractPayment_win_show('update');" />
		<aos:dockeditem text="作废" icon="del.png"    onclick="contractPayment_delete" />
		<aos:dockeditem xtype="tbtext" text="状态" />
		<aos:combobox name="state" value="1" id="state" onchange="fn_state">
							<aos:option value="1" display="正常" />
							<aos:option value="0" display="已作废" />
		</aos:combobox>
		<aos:dockeditem text="确认合同完成" icon="ok.png"    onclick="contractPayment_complete" />
	</aos:docked>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="contractPayment_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">
//单击
function contractPayment_complete(){
	var ct_id = AOS.getValue('id_contract_name');
	if(AOS.empty(ct_id)){
		AOS.tip('请先选择一个合同!');
		return;
	}
	var state = AOS.getValue('id_contract_state');
	if(state == 3){
		AOS.tip('当前合同状态已完成，不必重复完成!');
		return ;
	}else if(state == 1){
		AOS.tip('当前合同状态未启用，合同不能完成!');
		return ;
	}else if(state == 4){
		AOS.tip('当前合同状态已暂停，合同不能完成!');
		return ;
	}else if(state == 2){
		var gridArry = contractStage_grid.store.data.items;
		var rece_amount =0;
		var pay_amount = 0;
		for(var i =0; i<(gridArry.length);i++){
		 rece_amount = rece_amount+gridArry[i].data.rece_amount;
	 	 pay_amount = pay_amount+gridArry[i].data.pay_amount;
		}
		if(rece_amount-pay_amount==0){
			AOS.ajax({
				url : 'contractService.complete',
				params:{
					ct_id: ct_id,
					state: 3,
				},
				ok : function(data) {
					AOS.get('id_contract_state').setValue("3");
					AOS.tip(data.appmsg);
					contractPayment_grid_store.reload();
					contractStage_grid_store.reload();
					contractPaymentDetail_grid_store.reload();;
				}
			})
		}else{
			AOS.tip('合同款未支付完成，合同不能完成!');
			return ;
		}
	
	}
}
function paymentGrid_click(){
	
	var ct_pay_id = AOS.select(contractPayment_grid)[0].data.ct_pay_id;
	if (AOS.rows(contractStage_grid) != 1){
	contractPaymentDetail_grid_store.reload({
   		params : {
   			ct_pay_id : ct_pay_id
   		}
   	});
	}else{
	var ct_stage_id = AOS.select(contractStage_grid)[0].data.ct_stage_id;
	contractPaymentDetail_grid_store.reload({
   		params : {
   			//ct_stage_id : ct_stage_id,
   			ct_pay_id : ct_pay_id
   		}
   	});
	}
}


function fn_state(obj){
	var ct_id = AOS.getValue('id_contract_name');
	if(AOS.empty(ct_id)){
		AOS.tip('请先选择一个合同!');
		return;
	}
	var state = obj.getValue();
	contractPayment_grid_store.reload({
		params : {
			ct_id : ct_id,
			state : state
		}
	});
	contractPaymentDetail_grid_store.reload({
		params : {
			ct_id : ct_id,
			state : state
		}
	})
}
</script>