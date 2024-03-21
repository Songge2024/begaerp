<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<script type="text/javascript">
	//新增检查项
	function checkMain_add(){
		var proj_id = AOS.getValue('id_proj_name');
		if(proj_id==undefined){
			AOS.tip('请先选择一个项目!');
			return ;
		}
		 var record=AOS.selectone(t_module);
	  if (AOS.empty(record)||record.data.root==true){
	  AOS.tip("请选择一条里程碑记录");
	  return;
	  }
		AOS.reset(checkMain_create_two_form);
		AOS.setValue('checkMain_create_two_form.proj_id',proj_id);
		AOS.setValue('checkMain_create_two_form.milest_code',record.data.id);
		AOS.setValue('checkMain_create_two_form.milest_name',record.data.text);
		checkMain_create_two_win.show();
	}
	
	//新增
	function checkMain_create() {
		selarr=[];
		cache_select=false;
		selarr.push(0);
		var check_cata_name =AOS.get('check_cata_two_name').value;
		var check_cata_id = AOS.get('check_cata_two_combobox').value;
		var comment =AOS.getValue('checkMain_create_two_form').comment;
		var milest_code=AOS.getValue('checkMain_create_two_form.milest_code');
		var plan_check_time = AOS.getValue('checkMain_create_two_form.plan_check_time');
		var proj_id = id_proj_name.getValue();
		if(AOS.empty(check_cata_name)){
			AOS.tip("请先选择检查项目录!");
			return;
		}
		if(AOS.empty(plan_check_time)){
			AOS.tip("请选择计划检查时间!");
			return;
		}
		AOS.ajax({
			url : 'checkMainService.create',
			params:{
				check_cata_id:check_cata_id,
				check_name:check_cata_name,
				comment:comment,
				proj_id:proj_id,
				milest_code:AOS.selectone(t_module).data.id,
				plan_check_time :plan_check_time
			},
			ok : function(data) {
				AOS.ajax({
					url : 'checkDetailService.copy',
					params:{
						check_cata_id:check_cata_id,
						check_name:check_cata_name,
						proj_id:proj_id
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						checkMain_create_two_win.hide();
					}
				});
			}
		});
	}
	
	//删除检查项
	function checkMain_delete(){
		var selection = AOS.selection(checkedGrid, 'check_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据。');
			return ;
		}
		var select = AOS.selectone(checkedGrid);
		var msg =  AOS.merge('确认要删除选中的检查项记录吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'checkMainService.delete',
				params:{
					aos_rows: select.raw.check_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
				}
			});
		});
	}
	
	//提交检查项
	function checkMain_submit(){
		var selection = AOS.selection(checkedGrid, 'check_id');
		if(AOS.empty(selection)){
			AOS.tip('请先选择一个检查项进行提交!');
			return ;
		}
		var select = AOS.selectone(checkedGrid);
		var msg =  AOS.merge('提交以后不得修改任何数据,确认要提交选中的检查项记录吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'checkMainService.submit',
				params:{
					aos_rows: select.raw.check_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					
				}
			});
		});
	}

	//查询检查项
	function query_checkedGrid(){
		var proj_id=id_proj_name.getValue();
	}
	
	//开始时间change事件
	function on_plan_wastage_begin_change(){
  		var field=this;
		var plan_begin_date=field.up("form").down("datefield[name=plan_begin_date]");
		var plan_end_date=field.up("form").down("datefield[name=plan_end_date]");
		var plan_wastage=field.up("form").down("numberfield[name=plan_wastage]");
		var plan_wastage_value=datedifference(Ext.Date.format(plan_begin_date.getValue(), "Y-m-d"),Ext.Date.format(plan_end_date.getValue(), "Y-m-d"));
		var begin_value=Ext.Date.format(plan_begin_date.getValue(), "Y-m-d");
		var end_value=Ext.Date.format(plan_end_date.getValue(), "Y-m-d");
		if(begin_value>end_value){
			plan_wastage.setValue("");
		}else{
			plan_wastage.setValue(plan_wastage_value+1);
		}
	}
	
	//结束时间 change事件
	function on_plan_wastage_end_change(){
		var field=this;
		var plan_begin_date=field.up("form").down("datefield[name=plan_begin_date]");
		var plan_end_date=field.up("form").down("datefield[name=plan_end_date]");
		var plan_wastage=field.up("form").down("numberfield[name=plan_wastage]");
		var plan_wastage_value=datedifference(Ext.Date.format(plan_begin_date.getValue(), "Y-m-d"),Ext.Date.format(plan_end_date.getValue(), "Y-m-d"));
		var begin_value=plan_begin_date.getValue();
		var end_value=plan_end_date.getValue();
		if(begin_value>end_value){
			plan_wastage.setValue("");
		}else{
			plan_wastage.setValue(plan_wastage_value+1);
		}
	}
	
	//两个时间相差天数
    function datedifference(sDate1, sDate2) {    //sDate1和sDate2是2006-12-18格式  
        var dateSpan,
            tempDate,
            iDays;
        sDate1 = Date.parse(sDate1);
        sDate2 = Date.parse(sDate2);
        dateSpan = sDate2 - sDate1;
        dateSpan = Math.abs(dateSpan);
        iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
        return iDays
    }
	
	//计划天数 change事件
	function on_plan_wastage_change(){
	 	var field=this;
		var plan_begin_date=field.up("form").down("datefield[name=plan_begin_date]");
		var plan_end_date=field.up("form").down("datefield[name=plan_end_date]");
		var plan_wastage=field.up("form").down("numberfield[name=plan_wastage]");
		var plan_begin_date_value=AOS.empty(plan_begin_date.getValue())? new Date():plan_begin_date.getValue();
		var plan_wastage_value=plan_wastage.getValue();
		var plan_end_date_value=Ext.Date.add(plan_begin_date_value, Ext.Date.DAY,plan_wastage_value);
		plan_end_date.setValue(new Date(Ext.Date.format(plan_end_date_value, "Y-m-d")));
		var plan_wastage_value=(parseInt(plan_wastage_value));
		var plan_end_date_value=Ext.Date.add(plan_begin_date_value, Ext.Date.DAY,plan_wastage_value);
		plan_end_date.setValue(new Date(Ext.Date.format(plan_end_date_value, "Y-m-d")));
	}
	
	//显示新增或修改窗口
	function projMilestone_win_show(type){
		if(type=="create"){
			AOS.reset(projMilestone_create_form);
			projMilestone_create_win.setTitle("新增里程碑信息");
			var record = AOS.selectone(t_module);
			if(AOS.empty(id_proj_name.getValue())){
				AOS.tip('请选择一个项目名称！');
				return;
			}
			if(record.data.root==true){
				
			}else{
				AOS.tip('只能新增二级目录！');
				return;
			}
			var proj_name=tree_proj_name.getValue();
			var proj_id=id_proj_name.getValue();
			AOS.setValue('projMilestone_create_form.proj_name',proj_name); 
			AOS.setValue('projMilestone_create_form.proj_id',proj_id); 
			AOS.setValue('projMilestone_create_form.parent_id',record.raw.id); 
			AOS.setValue('projMilestone_create_form.parent_name',record.raw.text); 
			var recordTree = AOS.selectone(t_module);
			AOS.ajax({
			url : 'projMilestoneService.queryMilestonData',
			params:{
				milest_code:recordTree.raw.id,
				plan_end_date:Ext.Date.format(e_date.getValue(), "Y-m-d"),
				proj_id:id_proj_name.getValue()
			},
			ok : function(data) {
				projMilestone_create_form.down("datefield[name=plan_begin_date]").setMinValue(data.plan_begin_date);
				projMilestone_create_form.down("datefield[name=plan_end_date]").setMinValue(data.plan_begin_date);
				projMilestone_create_form.down("datefield[name=plan_begin_date]").setMaxValue('');
				projMilestone_create_form.down("datefield[name=plan_end_date]").setMaxValue('');
				
				var plan_begin_date=Ext.Date.format(new Date(), "Y-m-")+"01";
				var plan_end_date=Ext.util.Format.date(new Date(new Date(new Date().getUTCFullYear(), new Date().getMonth() + 1, 1) - 86400000), "Y-m-d");
				var plan_wastage_value=datedifference(plan_begin_date,plan_end_date);
				
				projMilestone_create_form.down("datefield[name=plan_begin_date]").setValue(plan_begin_date);
				projMilestone_create_form.down("datefield[name=plan_end_date]").setValue(plan_end_date);   
				projMilestone_create_form.down("numberfield[name=plan_wastage]").setValue(plan_wastage_value+1);
				projMilestone_create_form.down("numberfield[name=sort_no]").setValue(data.sort_no);
				}
			});
	 		projMilestone_create_win.show();
		}else if(type=="update"){
			AOS.reset(projMilestone_update_form);
			var record = AOS.selectone(t_module, true);
				if(AOS.empty(record)){
					AOS.tip('请选择一条需要修改的数据。');
					return;
				}
				AOS.ajax({
					url : 'projMilestoneService.queryEditMilestonData',
					params:{
						milest_code:record.raw.id,
						proj_id:id_proj_name.getValue()
					},
					ok : function(data) {
						if(record.data.root==true){
							AOS.tip('不能修改根节点的数据。');
							return;
						}else{
							if(data.state==2){
							AOS.tip('不能修改已结束的里程碑数据。');
							return;
							}else{
								projMilestone_update_form.down("hiddenfield[name=state]").setValue(data.state);
							}
							projMilestone_update_form.down("numberfield[name=plan_wastage]").setValue(data.plan_wastage);
							projMilestone_update_form.down("datefield[name=plan_begin_date]").setValue(data.plan_begin_date);
							projMilestone_update_form.down("datefield[name=plan_end_date]").setValue(data.plan_end_date);  
						  	projMilestone_update_form.down("hiddenfield[name=milest_id]").setValue(data.milest_id);
						 	projMilestone_update_form.down("hiddenfield[name=parent_id]").setValue(data.parent_id);
						 	//projMilestone_update_form.down("textfield[name=parent_name]").setValue(data.parent_name);   
						 
							projMilestone_update_form.down("hiddenfield[name=milest_code]").setValue(record.data.id);
							projMilestone_update_form.down("textfield[name=milest_name]").setValue(data.milest_name);
							projMilestone_update_form.down("hiddenfield[name=proj_id]").setValue(id_proj_name.getValue());    
							projMilestone_update_form.down("textfield[name=proj_name]").setValue(tree_proj_name.getValue());    
						 
							projMilestone_update_form.down("hiddenfield[name=is_leaf]").setValue(data.is_leaf);
							projMilestone_update_form.down("textfield[name=sort_no]").setValue(data.sort_no);
							projMilestone_update_form.down("hiddenfield[name=create_user_id]").setValue(data.create_user_id);
							projMilestone_update_form.down("hiddenfield[name=create_time]").setValue(data.create_time);
							projMilestone_update_form.down("hiddenfield[name=update_user_id]").setValue(data.update_user_id);
							projMilestone_update_form.down("hiddenfield[name=update_time]").setValue(data.update_time);
							projMilestone_update_form.down("hiddenfield[name=type]").setValue(data.type);
							projMilestone_update_form.down("htmleditor[name=comment]").setValue(data.comment);
								
							projMilestone_update_form.down("datefield[name=real_begin_date]").setValue(data.real_begin_date);
							projMilestone_update_form.down("datefield[name=real_end_date]").setValue(data.real_end_date);  
							 
							projMilestone_update_form.down("numberfield[name=plan_jobamount]").setValue(data.plan_jobamount);
							projMilestone_update_form.down("numberfield[name=real_jobamount]").setValue(data.real_jobamount);  
							 
							projMilestone_update_form.down("numberfield[name=earned_value]").setValue(data.earned_value);	
							projMilestone_update_win.show();	
							//AOS.edits(projMilestone_update_form,'plan_begin_date,plan_end_date,sort_no,milest_name,plan_jobamount,comment');
							//AOS.hides(projMilestone_update_form, 'real_begin_date,real_end_date,real_jobamount,earned_value');		
					    }
					}
				});
			
		
		}else{
			AOS.reset(projMilestone_over_form);
			var record = AOS.selectone(t_module, true);
			if(AOS.empty(record)){
				AOS.tip('请选择一条需要结束的数据。');
				return;
			}
			AOS.ajax({
				url : 'projMilestoneService.queryEditMilestonData',
				params:{
					milest_code:record.raw.id,
					proj_id:id_proj_name.getValue()
				},
				ok : function(data) {
					if(data.state==2){
						AOS.tip('该里程碑数据已结束。');
						return;
					}
					projMilestone_over_win.show();
					projMilestone_over_form.down("numberfield[name=plan_wastage]").setValue(data.plan_wastage);
					projMilestone_over_form.down("datefield[name=plan_begin_date]").setValue(data.plan_begin_date);
					projMilestone_over_form.down("datefield[name=plan_end_date]").setValue(data.plan_end_date);  
					 
					projMilestone_over_form.down("hiddenfield[name=milest_id]").setValue(data.milest_id);
					projMilestone_over_form.down("hiddenfield[name=parent_id]").setValue(data.parent_id);
					//projMilestone_over_form.down("textfield[name=parent_name]").setValue(data.parent_name);   
					
					projMilestone_over_form.down("hiddenfield[name=milest_code]").setValue(record.data.id);
					projMilestone_over_form.down("textfield[name=milest_name]").setValue(data.milest_name);
					projMilestone_over_form.down("hiddenfield[name=proj_id]").setValue(id_proj_name.getValue());    
					projMilestone_over_form.down("textfield[name=proj_name]").setValue(tree_proj_name.getValue());    
					
					projMilestone_over_form.down("hiddenfield[name=is_leaf]").setValue(data.is_leaf);
					projMilestone_over_form.down("textfield[name=sort_no]").setValue(data.sort_no);
					projMilestone_over_form.down("hiddenfield[name=create_user_id]").setValue(data.create_user_id);
					projMilestone_over_form.down("hiddenfield[name=create_time]").setValue(data.create_time);
					projMilestone_over_form.down("hiddenfield[name=update_user_id]").setValue(data.update_user_id);
					projMilestone_over_form.down("hiddenfield[name=update_time]").setValue(data.update_time);
					projMilestone_over_form.down("hiddenfield[name=state]").setValue(data.state);
					projMilestone_over_form.down("hiddenfield[name=type]").setValue(data.type);
					projMilestone_over_form.down("htmleditor[name=comment]").setValue(data.comment);
						
					projMilestone_over_form.down("datefield[name=real_begin_date]").setValue(data.real_begin_date);
					projMilestone_over_form.down("datefield[name=real_end_date]").setValue(data.real_end_date);  
					
					projMilestone_over_form.down("numberfield[name=plan_jobamount]").setValue(data.plan_jobamount);
					projMilestone_over_form.down("numberfield[name=real_jobamount]").setValue(data.real_jobamount);  
					
					projMilestone_over_form.down("numberfield[name=earned_value]").setValue(data.earned_value);		
					AOS.reads(projMilestone_over_form,'plan_begin_date,plan_end_date,sort_no,milest_name,plan_jobamount,comment');
				}
			});
				
		}
	}
	
	//计算ev
	function countEv(){
		var real_jobamount=projMilestone_over_form.down("numberfield[name=real_jobamount]").getValue();
		var plan_jobamount=projMilestone_over_form.down("numberfield[name=plan_jobamount]").getValue();
		var ev=plan_jobamount/real_jobamount;
		if(ev=="Infinity"){
			projMilestone_over_form.down("numberfield[name=earned_value]").setValue(0);
		}else{
			projMilestone_over_form.down("numberfield[name=earned_value]").setValue(ev);
		}
	}
	
	//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
	
	//默认选择默认项目
	window.onload = function(){
		var proj_id = '${proj_id}';
		var proj_name = '${proj_name}';
		if(proj_id !=null && proj_id!=''){
			AOS.setValue('id_proj_name',proj_id);
			AOS.setValue('tree_proj_name',proj_name);
		}
		var params = {
			proj_id:'${proj_id}'
		};
		var record = AOS.selectone(t_module);
		if(!AOS.empty(record)){
			params.milest_code = record.raw.id;
			params.root=record.data.root;
		}
		t_module_refresh('root');
	}
     
	//根据选择项目名称刷新树和grid
	function tree_grid_query() {
		var params = {
				proj_id:id_proj_name.getValue()
		};
		var record = AOS.selectone(t_module);
		if(!AOS.empty(record)){
			params.milest_code = record.raw.id;
			params.root=record.data.root;
		}
		//checkedGrid_store.getProxy().extraParams = params;
		//checkedGrid_store.loadPage(1);
		t_module_refresh('root');
	}
	
	//点击树查询
	function projMilestone_grid_query() {
		var params = {
			proj_id:id_proj_name.getValue()	
		};
		var record = AOS.selectone(t_module);
		if(!AOS.empty(record)){
			params.milest_code = record.raw.id;
			params.root=record.data.root;
		}
		AOS.ajax({
			url : 'projMilestoneService.queryEditMilestonData',
			params:{
				milest_code:record.raw.id,
				proj_id:id_proj_name.getValue()
			},
			ok : function(data) {
				if(record.data.root==true){
					return;
				}else{
					projMilestone_formfields_form.down("textfield[name=proj_name]").setValue(tree_proj_name.getValue());    
					projMilestone_formfields_form.down("textfield[name=milest_name]").setValue(data.milest_name);
					
					projMilestone_formfields_form.down("datefield[name=plan_begin_date]").setValue(data.plan_begin_date);
					projMilestone_formfields_form.down("datefield[name=plan_end_date]").setValue(data.plan_end_date);  
					
					projMilestone_formfields_form.down("datefield[name=real_begin_date]").setValue(data.real_begin_date);
					projMilestone_formfields_form.down("datefield[name=real_end_date]").setValue(data.real_end_date);  
					
					projMilestone_formfields_form.down("numberfield[name=plan_jobamount]").setValue(data.plan_jobamount);
					projMilestone_formfields_form.down("numberfield[name=real_jobamount]").setValue(data.real_jobamount);  
					
					projMilestone_formfields_form.down("numberfield[name=plan_wastage]").setValue(data.plan_wastage);
					projMilestone_formfields_form.down("numberfield[name=earned_value]").setValue(data.earned_value);
					
					projMilestone_formfields_form.down("hiddenfield[name=state]").setValue(data.state);	
			    }
			}
		});
	}
		
	//自动选中根节点
	AOS.job(function(){
		t_module.getSelectionModel().select(t_module.getRootNode());
		projMilestone_grid_query();
	},10);
	
	//查询
	function projMilestone_query() {
		var params = AOS.getValue('query_form');
	    projMilestone_grid_store.getProxy().extraParams = {
	    	//name:params.keyWords,
	    	//ahtor:params.keyWords,
	    	//press:params.keyWords
	    };
	    projMilestone_grid_store.loadPage(1);
	}

	//新增
	function projMilestone_create() {
		var recordTree = AOS.selectone(t_module);
		var proj_name=tree_proj_name.getValue();
		var proj_id=id_proj_name.getValue();
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var plan_begin_date=projMilestone_create_form.down("datefield[name=plan_begin_date]").getValue();
		var plan_end_date=projMilestone_create_form.down("datefield[name=plan_end_date]").getValue();
		var real_begin_date=projMilestone_create_form.down("datefield[name=real_begin_date]").getValue();
		var real_end_date=projMilestone_create_form.down("datefield[name=real_end_date]").getValue();
		if(plan_begin_date>plan_end_date){
			AOS.tip("计划开始时间不能大于计划结束时间");
			return;
		}
		if(!AOS.empty(real_begin_date)&&(AOS.empty(real_end_date))){ 
			AOS.tip("请输入实际结束时间");
			return;
		}
		if(AOS.empty(real_begin_date)&&(!AOS.empty(real_end_date))){
			AOS.tip("请输入实际开始时间");
			return;
		}
		if(real_begin_date>real_end_date){
			AOS.tip("实际开始时间不能大于实际结束时间");
			return;
		}
		AOS.ajax({
			forms : projMilestone_create_form,
			url : 'projMilestoneService.saveProjMilestone',
			params:{
				id:recordTree.raw.id
			},
			ok : function(data) {
				if(data.appcode!=0){
					AOS.tip("新增成功");
					projMilestone_create_win.hide();
					t_module_refresh('root');
					var token=data.token;
					//alert(token);
					var title="里程碑启用"; 
					var count="{\"proj_id\":\""+id_proj_name.getValue()+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}启用-"
					+proj_name+"-"+data.milest_name+"\","+"\"createTime\":\""+createTime+"\"}";
					mesVO= {
						"title"  : title, 
						"content": count,
						"extras": {proj_id,proj_name,createTime,sedTime},
						"mesGroup": "CHANNEL"
					}
					AOS.weekSend(token,mesVO);
				}else{
					AOS.tip(data.appmsg);
					return;
				}
			}
		});
	}

	//结束
	function projMilestone_over() {
		var recordTree = AOS.selectone(t_module);
		var real_begin_date=projMilestone_over_form.down("datefield[name=real_begin_date]").getValue();
		var real_end_date=projMilestone_over_form.down("datefield[name=real_end_date]").getValue();
		if(real_begin_date>real_end_date){
			AOS.tip("实际开始时间不能大于实际结束时间");
			return;
		}
		AOS.ajax({
			forms : projMilestone_over_form,
			url : 'projMilestoneService.updateOver',
			params:{
				id:recordTree.raw.id
			},
			ok : function(data) {
				if(data.appmsg=="结束成功"){
					AOS.tip(data.appmsg);
					t_module_refresh('parent_id');
					projMilestone_over_win.hide();
					if(AOS.getValue('projMilestone_over_form.parent_id') == '0'){
						t_module.getRootNode().set('text',AOS.getValue('projMilestone_over_form.milest_name'));
					}
				}else{
					AOS.tip(data.appmsg);
					return;
				}
			}
		});
	}
	
	//修改
	function projMilestone_update() {
		var recordTree = AOS.selectone(t_module);
		var plan_begin_date=projMilestone_update_form.down("datefield[name=plan_begin_date]").getValue();
		var plan_end_date=projMilestone_update_form.down("datefield[name=plan_end_date]").getValue();
		var real_begin_date=projMilestone_update_form.down("datefield[name=real_begin_date]").getValue();
		var real_end_date=projMilestone_update_form.down("datefield[name=real_end_date]").getValue();
		if(plan_begin_date>plan_end_date){
			AOS.tip("计划开始时间不能大于计划结束时间");
			return;
		}
		if(!AOS.empty(real_begin_date)&&(AOS.empty(real_end_date))){
			AOS.tip("请输入实际结束时间");
			return;
		}
		if(AOS.empty(real_begin_date)&&(!AOS.empty(real_end_date))){
			AOS.tip("请输入实际开始时间");
			return;
		}
		if(real_begin_date>real_end_date){
			AOS.tip("实际开始时间不能大于实际结束时间");
			return;
		}
		AOS.ajax({
			forms : projMilestone_update_form,
			url : 'projMilestoneService.update',
			params:{
				id:recordTree.raw.id
			},
			ok : function(data) {
				if(data.appmsg=="修改成功"){
					AOS.tip(data.appmsg);
					t_module_refresh('parent_id');
					projMilestone_update_win.hide();
					if(AOS.getValue('projMilestone_update_form.parent_id') == '0'){
						t_module.getRootNode().set('text',AOS.getValue('projMilestone_update_form.milest_name'));
					}
				}else{
					AOS.tip(data.appmsg);
					return;
				}
			}
		});
	}
	
	//停用
	function projMilestone_grid_upstate(){
		//var selection = AOS.selection(t_module, 'milest_code');
		var selection = AOS.selectone(t_module).data.id;
		var node=AOS.selectone(t_module).data.root;
		//var rows = AOS.rows(projMilestone_grid);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要停用的数据！');
			return;
		}
		if(node==true){
			AOS.tip('无法停用根节点！');
			return;
		}
		//var rows = AOS.rows(projMilestone_grid);
		var msg =  AOS.merge('确认要停用选中的数据吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'projMilestoneService.updateStopState',
				params:{
					aos_rows: selection,
					state:"0"
				},
				ok : function(data) {
					if(data.appcode=="0"){
						AOS.tip(data.appmsg);	
					}else if(data.appcode=="1"){
						AOS.tip(data.appmsg);	
					}else{
						AOS.tip("停用成功");	
					}
					//checkedGrid_store.reload();
					t_module_refresh('root');
				}
			});
		});
	}
	
	function projMilestone_grid_submit(){
		var selection =AOS.selectone(t_module).data.id;
		//var rows = AOS.rows(projMilestone_grid);
		var node=AOS.selectone(t_module).data.root;
		if(AOS.empty(selection)){
			AOS.tip('请选择需要启用的数据！');
			return;
		}
		if(node==true){
			AOS.tip('无法启用根节点！');
			return;
		}
		//var rows = AOS.rows(projMilestone_grid);
		var msg =  AOS.merge('确认要启用选中的数据吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'projMilestoneService.updateState',
				params:{
					aos_rows: selection,
					state:"1"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);	
					//projMilestone_grid_store.reload();
					t_module_refresh('root');
				}
			});
		});
	 }
	
	//删除
	function projMilestone_delete(){
		//var selection = AOS.selection(t_module, 'milest_id');
		var refreshnode = AOS.selectone(t_module);
		var node=AOS.selectone(t_module).data.root;
		var selection = AOS.selectone(t_module).data.id;
		if(AOS.empty(refreshnode)){
			AOS.tip('删除前请先选中数据。');
			return;
		}
		if(node==true){
			AOS.tip('无法删除根节点数据!');
			return;
		}
		if(AOS.empty(refreshnode.data.root==true)){
			AOS.tip('无法删除根节点，请重新选择');
			return;
		}
		//var rows = AOS.rows(refreshnode.data.id);
		var msg =  AOS.merge('确认要删除选中的数据吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'projMilestoneService.delete',
				params:{
					aos_rows: selection,
					proj_id:id_proj_name.getValue(),
					state:"-1"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					t_module_refresh('root');
				}
			});
		});
	}
	
	//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
	function t_module_refresh(flag){
		var refreshnode = AOS.selectone(t_module);
		var proj_id=id_proj_name.getValue();
		if (!refreshnode) {
			refreshnode = t_module.getRootNode();
		}
		if (refreshnode.isLeaf() || (flag=='parent_id' && !refreshnode.isRoot())) {
			refreshnode = refreshnode.parentNode;
		}
		//参数标记为刷新根节点
		if(flag == 'root'){
			refreshnode = t_module.getRootNode();
		}
		t_module_store.load({
			node : refreshnode,
			params:{
				proj_id:proj_id
			},
			callback : function() {
				//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
				refreshnode.collapse();
				refreshnode.expand();
				t_module.getSelectionModel().select(refreshnode);
			}
		});
	}
		
	//弹出选择上级模块窗口
  	function proj_tree_show() {
  		w_org_find.show();
  	}
			  
	/*		  //自动加载默认项目
	window.onload = function(){
	   var proj_id = '${proj_id}';
	   var proj_name = '${proj_name}';
   	   if(proj_id !=null && proj_id!=''){
		AOS.setValue('id_proj_name',proj_id);
		AOS.setValue('tree_proj_name',proj_name);
		t_module_refresh('root');
       }
    } */
      
	//单击选择项目
	function t_org_find_select() {
		var record = AOS.selectone(t_org_find);
		if(record.raw.a=="1"){
			AOS.setValue('id_proj_name',record.raw.id);
			AOS.setValue('tree_proj_name',record.raw.text);
			var params = {proj_id:record.raw.id};
			var records = AOS.selectone(t_module);
			if(!AOS.empty(record)){
				params.milest_code = records.raw.id;
				params.root=records.data.root;
			}
			t_module_refresh('root');
			AOS.reset(projMilestone_formfields_form);
			w_org_find.hide();
		}else{
			AOS.tip("请选择项目!");
			return;
			//w_org_find.hide();
		}
	}
      
	//刷新上级模块树
	function t_org_find_refresh() {
		var proj_id = id_proj_name.getValue();
		var refreshnode = t_org_find.getRootNode();
		t_org_find_store.load({
			params:{
				proj_id : proj_id
			},
			callback : function() {
				//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
				refreshnode.collapse();
				refreshnode.expand();
			}
		});
	}
</script>