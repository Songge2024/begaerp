<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:docked >
	<aos:dockeditem xtype="tbtext" text="合同基本信息"/>
	<aos:dockeditem xtype="tbseparator"/>
		<aos:dockeditem xtype="tbtext" text="合同状态" />
		<aos:combobox  id="id_contract_state" emptyText="合同状态"  
		width="200" 
		allowBlank="false" 
		dicField="re_cp_type"
		onselect="contractState_onselect" 
		queryMode="local"
		editable="true" 
		value="2"
		dicFilter="!1"
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true" />
		<aos:dockeditem xtype="tbseparator"/>
		<aos:dockeditem xtype="tbtext" text="合同列表" />
		<aos:combobox  id="id_contract_name" emptyText="合同名称"  
		selectAll="true" 
		width="300" 
		allowBlank="false" 
		url="contractPaymentService.listComboBoxContractCata"  
		onselect="contract_onselect" 
		queryMode="local"
		editable="true" 
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true" />

	
	</aos:docked>
	<aos:formpanel 
		id="contract_form"
		width="120"
	  	layout="column" 
	  	labelWidth="100">
	<%@ include file="contract_fields.jsp"%>
	</aos:formpanel>
	
<script type="text/javascript">
//合同状态
function contractState_onselect(obj){
	var state= obj.getValue();
	id_contract_name_store.getProxy().extraParams = {
		state : state
	};
	id_contract_name_store.load();
	AOS.reset(contract_form);
	contractPaymentDetail_grid_store.removeAll();
	contractPayment_grid_store.removeAll();
	contractStage_grid_store.removeAll();
}
//项目选择
function contract_onselect(obj){
	var ct_id = obj.getValue();
	AOS.ajax({
			params:{ct_id : ct_id},
	        url: 'contractPaymentService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(contract_form,data);
	           }
	        });
	var params ={ct_id : ct_id};
	contractStage_grid_store.getProxy().extraParams = params;
	contractStage_grid_store.loadPage(1);
	contractPayment_grid_store.getProxy().extraParams = params;
	contractPayment_grid_store.loadPage(1);
	contractPaymentDetail_grid_store.getProxy().extraParams = params;
	contractPaymentDetail_grid_store.loadPage(1);
	AOS.setValue('state','1');
}



</script>