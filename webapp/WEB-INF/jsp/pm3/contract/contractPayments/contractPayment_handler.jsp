<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function contractPayment_win_show(type){
	if(type=="create"){
		var ct_id = AOS.getValue('id_contract_name');
		if(ct_id == undefined){
			AOS.tip('请先选择一个合同!');
			return ;
		}
		if(contractStage_grid.store.data.items.length==0){
		  	AOS.tip('该合同不存在支付阶段信息,请先进行维护!');
			return ;
		}
		 if(AOS.rows(contractStage_grid) > 1){
		  	AOS.tip('请先选择一条需要新增回款信息的记录(或者不选)!');
			return ;
		} 
		 var state = AOS.getValue('id_contract_state');
		if(state == 3){
			AOS.tip('当前合同状态已完成，不能新增回款信息!');
			return ;
		} 
		var selectStageGrid = AOS.select(contractStage_grid);
		AOS.reset(contractPayment_create_form);
		AOS.setValue('contractPayment_create_form.ct_id',ct_id);
		if(AOS.getValue('state')==0){
		
		}else{
		AOS.ajax({
				url : 'contractPaymentService.queryOtherMoney',
						params:{
						ct_id:ct_id
						},
				ok : function(data) {
				 if(data.appmsg =='当前实收金额已达到合同总金额'){
		     	AOS.tip(data.appmsg);
				 return;
						}else{
			   contractPayment_create_form.down("numberfield[name=pay_money]").setValue(data.syje);
			   	contractPayment_create_win.show();
						}
				}
			});
		}
	
		
	}else{
		AOS.reset(contractPayment_create_form);
		var state = AOS.getValue('id_contract_state');
		if(state == 3){
			AOS.tip('当前合同状态已完成，不能修改回款信息!');
			return ;
		} 
		var record = AOS.selectone(contractPayment_grid, true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		
		contractPayment_create_form.loadRecord(record);
		contractPayment_create_win.setTitle("修改回款信息");
		contractPayment_create_win.show();
	}
}
//查询
function contractPayment_query() {
	var params = AOS.getValue('query_form');
    contractPayment_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    contractPayment_grid_store.loadPage(1);
}
//保存
function contractPayment_create() {//新增保存
		var ct_pay_id = AOS.getValue('contractPayment_create_form.ct_pay_id');
		 if(ct_pay_id==""){
 		if(AOS.rows(contractStage_grid) == 1){
		 var selectStageGrid = AOS.select(contractStage_grid);
		 var ct_stage_id = selectStageGrid[0].data.ct_stage_id;
		 var rece_amount = parseFloat(selectStageGrid[0].data.rece_amount).toFixed(2);
		 var pay_amount = parseFloat(selectStageGrid[0].data.pay_amount).toFixed(2);
		 var pay_money = parseFloat(AOS.getValue('contractPayment_create_form.pay_money')).toFixed(2);
		 if((rece_amount-pay_amount-pay_money).toFixed(2)<0){
		 AOS.tip('实收金额不能大于所选阶段应收金额,请重新输入!');
		 return ;
		 	}
		} else{
			var gridArry = contractStage_grid.store.data.items;
			var rece_amount =0.00;
			var pay_amount = 0.00;
			for(var i =0; i<(gridArry.length);i++){
			 rece_amount = rece_amount+gridArry[i].data.rece_amount;
		 	 pay_amount = pay_amount+gridArry[i].data.pay_amount;
			}
			var pay_money = parseFloat(AOS.getValue('contractPayment_create_form.pay_money')).toFixed(2);
			var finall_money=  rece_amount-pay_amount-pay_money;
			if(parseFloat(finall_money.toFixed(2))<0.00){
			 AOS.tip('实收金额不能大于应收金额,请重新输入!');
		 	return ;
		 	}
			var ct_stage_id = -1;
		} 
	AOS.ajax({
		forms : contractPayment_create_form,
		params : {ct_stage_id : ct_stage_id },
		url : 'contractPaymentService.create',
		ok : function(data) {
			//如果金额等于合同总额就变为执行完成，整个界面刷新
			//var state=AOS.getValue('id_contract_state');
			//if(state==2&&data.ssje==data.htje){
			//	AOS.get('id_contract_state').setValue("3"); 
		//	}else if(state==3&&data.ssje!=data.htje){
			//	AOS.get('id_contract_state').setValue("2"); 
		//	}
			AOS.tip(data.appmsg);
			var ct_id = AOS.getValue('contractPayment_create_form.ct_id');
			AOS.ajax({
			params:{ct_id : ct_id},
	        url: 'contractPaymentService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(contract_form,data);
	           }
	        });
			contractPayment_grid_store.reload();
			contractPayment_create_win.hide();
			contractStage_grid_store.reload();
			contractPaymentDetail_grid_store.reload();
		}
	});
	}else{//修改保存
		var pay_money =AOS.select(contractPayment_grid)[0].data.pay_money;
		var update_money= AOS.getValue('contractPayment_create_form.pay_money');
		if(pay_money-update_money == 0){
		var update_state = 0;
		}else{
		update_state = 1;
		}
		AOS.ajax({
		forms : contractPayment_create_form,
		params : {update_state : update_state},
		url : 'contractPaymentService.update',
		ok : function(data) {
		
		//如果金额等于合同总额就变为执行完成，整个界面刷新
			// var state=AOS.getValue('id_contract_state');
			//if(state==2&&data.ssje==data.htje){
			//	AOS.get('id_contract_state').setValue("3"); 
			//}else if(state==3&&data.ssje!=data.htje){
				//AOS.get('id_contract_state').setValue("2"); 
		//	} 
			AOS.tip(data.appmsg);
			var ct_id = AOS.getValue('contractPayment_create_form.ct_id');
			AOS.ajax({
			params:{ct_id : ct_id},
	        url: 'contractPaymentService.loadFormInfo',
	        ok: function (data) {
	           AOS.setValues(contract_form,data);
	           }
	        });
			contractPayment_grid_store.reload();
			contractStage_grid_store.reload();
			contractPaymentDetail_grid_store.reload();
			contractPayment_create_win.hide();
		}
	});
	}
}

//删除
function contractPayment_delete(){
	var selection = AOS.selection(contractPayment_grid, 'ct_pay_id');
		var state = AOS.getValue('id_contract_state');
		AOS.reset(contractPayment_create_form);
		if(state == 3){
			AOS.tip('当前合同状态已完成，不能作废回款信息!');
			return ;
		} 
	if(AOS.empty(selection)){
		AOS.tip('请选择需要作废的数据。');
		return;
	}
	var rows = AOS.rows(contractPayment_grid);
	var msg =  AOS.merge('确认要作废选中的{0}条数据吗？', rows);
	var record = AOS.selectone(contractPayment_grid, true);
	var pay_money = AOS.getValue('contractPayment_create_form.pay_money');
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			//AOS.tip('作废操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'contractPaymentService.delete',
			params:{
				aos_rows: selection,
				ct_id:record.data.ct_id,
				pay_money:(-1)*pay_money
				
			},
			ok : function(data) {
			//如果金额等于合同总额就变为执行完成，整个界面刷新
			// var state=AOS.getValue('id_contract_state');
			//if(state==2&&data.ssje==data.htje){
			//	AOS.get('id_contract_state').setValue("3"); 
			//}else if(state==3&&data.ssje!=data.htje){
			//	AOS.get('id_contract_state').setValue("2"); 
			//} 
				var ct_id = AOS.getValue('contract_form.ct_id');
				AOS.ajax({
				params:{ct_id : ct_id},
		        url: 'contractPaymentService.loadFormInfo',
		        ok: function (data) {
		           AOS.setValues(contract_form,data);
		           }
		        });
				AOS.tip(data.appmsg);
				contractPayment_grid_store.reload();
				contractStage_grid_store.reload();
				contractPaymentDetail_grid_store.reload();
			}
		});
	});
}