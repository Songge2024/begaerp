<%@ page contentType="text/html; charset=utf-8"%>
//显示新增或修改窗口
function contractPayInfo_win_show(type){
	if(type=="create"){
		var select = AOS.select(contractStage1_grid);
		AOS.reset(contractPayInfo_create_form);
		if(AOS.rows(contractStage1_grid)==1){
			var ct_id = select[0].data.ct_id;
			var proj_id = select[0].data.proj_id;
			var stage_id = select[0].data.stage_id;
			var stage_code = select[0].data.stage_code;  
			var stage_name = select[0].data.stage_name;
			var percentage = select[0].data.percentage; 
			AOS.setValue('contractPayInfo_create_form.ct_id',ct_id);
			AOS.setValue('contractPayInfo_create_form.proj_id',proj_id);
			AOS.setValue('contractPayInfo_create_form.stage_id',stage_id);
			AOS.setValue('contractPayInfo_create_form.pay_name',stage_name);
			AOS.setValue('contractPayInfo_create_form.pay_condition',percentage);
			contractPayInfo_create_win.show();
		}else{
			AOS.tip('请选择一条合同款支付阶段')
		}
	}else{
		if(AOS.rows(contractStage1_grid)==1){
			AOS.reset(contractPayInfo_update_form);
			var record = AOS.selectone(contractPayInfo_grid, true);
			if(AOS.empty(record)){
				AOS.tip('请选择要修改的记录。');
				return;
			}
			contractPayInfo_update_form.loadRecord(record);
			contractPayInfo_update_win.show();
		}else{
			AOS.tip('请选择一条合同款支付阶段')
		}
	}
}
//查询
function contractPayInfo_query(stage_id) {
	var params = AOS.getValue('query_form');
	contractPayInfo_grid_store.getProxy().extraParams = {
	    	stage_id:-1
	    	//name:params.keyWords,
	    	//ahtor:params.keyWords,
	    	//press:params.keyWords
	    };
 	contractPayInfo_grid_store.loadPage(1);
}
//新增
function contractPayInfo_create() {
	var select = AOS.select(contractStage1_grid);
	AOS.ajax({
		forms : contractPayInfo_create_form,
		url : 'contractPayInfoService.savePayMoney',
		ok : function(data) {
			AOS.tip(data.appmsg);
			var proj_id = select[0].data.proj_id;
			AOS.reset(projCommons_form);
	 		AOS.ajax({
	 			params:{proj_id : proj_id},
		        url: 'contractPayInfoService.loadFormInfo',
		        ok: function (data) {
		           AOS.setValues(projCommons_form,data);
		           }
		        });
			contractStage1_grid_store.reload();
			contractPayInfo_grid_store.reload();
			projContract1_grid_store.reload();
			contractPayInfo_create_win.close();
		}
	});
}
//修改
function contractPayInfo_update() {
	var select = AOS.select(contractStage1_grid);
	AOS.ajax({
		forms : contractPayInfo_update_form,
		url : 'contractPayInfoService.update',
		ok : function(data) {AOS.tip(data.appmsg);
			var proj_id = select[0].data.proj_id;
			AOS.reset(projCommons_form);
	 		AOS.ajax({
	 			params:{proj_id : proj_id},
		        url: 'contractPayInfoService.loadFormInfo',
		        ok: function (data) {
		           AOS.setValues(projCommons_form,data);
		           }
		        });
		        //获取修改前选中行数
		         var selarr = new Array();
                 var records = contractPayInfo_grid.getSelectionModel().getSelection();
                 selarr.splice(0);
                 for (var i in records) {
                        selarr.push(records[i].index);
                 }
				 //获取修改前选中行数
		         var selarr1 = new Array();
                 var records1 = contractStage1_grid.getSelectionModel().getSelection();
                 selarr1.splice(0);
                 for (var i in records1) {
                        selarr.push(records1[i].index);
                 }
				 //获取修改前选中行数
		         var selarr2 = new Array();
                 var records2 = projContract1_grid.getSelectionModel().getSelection();
                 selarr2.splice(0);
                 for (var i in records2) {
                        selarr.push(records2[i].index);
                 }
                   
                    
			contractStage1_grid_store.reload({
				callback : function(records1, operation, success) {
						  //恢复选择
						for (var i = 0; i < selarr.length; i++) {
                   		 contractStage1_grid.getSelectionModel().select(selarr1[i],true);
                    }
					}
				});
			contractPayInfo_grid_store.reload({
				callback : function(records, operation, success) {
						  //恢复选择
						for (var i = 0; i < selarr.length; i++) {
                   		 contractPayInfo_grid.getSelectionModel().select(selarr[i],true);
                    }
					}
				});
				
				
			projContract1_grid_store.reload({
				callback : function(records2, operation, success) {
						  //恢复选择
						for (var i = 0; i < selarr.length; i++) {
                   		 projContract1_grid.getSelectionModel().select(selarr2[i],true);
                    }
					}
				});

			contractPayInfo_update_win.close();
		}
	});
}
//删除
function contractPayInfo_delete(){
	var select = AOS.select(contractPayInfo_grid);
	var pay_id = select[0].data.pay_id;
	var stage_id = select[0].data.stage_id;
	var proj_id = select[0].data.proj_id;
	var selection = AOS.selection(contractPayInfo_grid, 'pay_id');
	if(AOS.empty(selection)){
		AOS.tip('删除前请先选中数据。');
		return;
	}
	var rows = AOS.rows(contractPayInfo_grid);
	var msg =  AOS.merge('确认要删除选中的{0}条pr_contract_pay_info记录吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			AOS.tip('删除操作被取消。');
			return;
		}
		AOS.ajax({
			url : 'contractPayInfoService.delete',
			params:{
				aos_rows: selection,
			    stage_id :stage_id,
			    pay_id : pay_id
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.ajax({
	 			params:{proj_id : proj_id},
		        url: 'contractPayInfoService.loadFormInfo',
		        ok: function (data) {
		           AOS.setValues(projCommons_form,data);
		           }
		        });
			contractStage1_grid_store.reload();
			contractPayInfo_grid_store.reload();
			projContract1_grid_store.reload();
			}
		});
	});
}