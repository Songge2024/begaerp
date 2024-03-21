<%@ page contentType="text/html; charset=utf-8"%>
<script type="text/javascript">

//显示新增或修改窗口
	function demandAction_win_show(type){
		demandAction_create_win.type=type;
		var record = AOS.selectone(demandAction_t_module,true);
		AOS.reads(demandAction_create_form,'proj_id');
		if(!AOS.empty(record)){
	<!-- 		if(record.raw.id==1){ -->
	<!-- 			AOS.tip('请选择一条功能模块数据。'); -->
	<!-- 		return; -->
	<!-- 		} -->
		}else{
			AOS.tip('请选择项目！');
			return;
		}
		if(AOS.empty(id_proj_name.getValue())){
			AOS.tip('请选择一个项目数据。');
			return;
		}
		//新增
		if(type=="create"){
			AOS.reset(demandAction_create_form);
			demandAction_create_win.setTitle("新增需求信息");
			AOS.setValue('demandAction_create_form.dm_code', record.raw.id);
			if(record.raw.id!=0){
				AOS.setValue('demandAction_create_form.dm_code_name', record.raw.text);
			}
			AOS.setValue('demandAction_create_form.proj_id', Number(id_proj_name.getValue())); 
			//获取前台当前时间
			var time = new Date();
			AOS.setValue("demandAction_create_form.ad_raise_date",time);
			
			//带图片富文本框嵌入
			demand_desc_editor=UM.getEditor('demand_desc_editor',{
							autoHeightEnabled:false,
							autoFloatEnabled:true
						});
						
			content_desc_editor=UM.getEditor('content_desc_editor',{
							autoHeightEnabled:false,
							autoFloatEnabled:true
						});
			demand_desc_editor.setContent("");
			content_desc_editor.setContent("");
			
		}else {
		if(!AOS.empty(AOS.select(demandAction_grid)[0])){
			if(AOS.select(demandAction_grid)[0].data.state==1){
				find_task();
				return;
			}
		}
		//修改
			AOS.reset(demandAction_create_form);
			var record = AOS.selectone(demandAction_grid, true);
			var records = AOS.select(demandAction_grid, true);
			if(AOS.empty(record) || records.length>1){
				AOS.tip('请选择一条需要修改的数据。');
				return;
			}
			demandAction_create_form.loadRecord(record);
			demandAction_create_win.setTitle("修改需求信息");
			//带图片富文本框嵌入
			demand_desc_editor=UM.getEditor('demand_desc_editor',{
							autoHeightEnabled:false,
							autoFloatEnabled:true
						});
						
			content_desc_editor=UM.getEditor('content_desc_editor',{
							autoHeightEnabled:false,
							autoFloatEnabled:true
						});
			demand_desc_editor.setContent(record.data.ad_source_remark||"");
			content_desc_editor.setContent(record.data.ad_content||"");
		}
		demandAction_create_win.show();
		demandAction_create_win.maximize();
	}

//查询
	function demandAction_query() {
		var query_form = AOS.getValue('query_form');
		var combobox_state = AOS.getValue('combobox_state');
		var demandAction_proj_id = AOS.getValue('id_proj_name');
		params = {ad_name:query_form, proj_id:demandAction_proj_id,state :combobox_state};
	    demandAction_grid_store.getProxy().extraParams = params;
	    demandAction_grid_store.loadPage(1);
	}
	
//新增
	function demandAction_create() {
	var form=AOS.getValue('demandAction_create_form');
	//提出时间
	var ad_raise_date=form.ad_raise_date;
	//要求完成时间
	var ad_claim_finish_date=form.ad_claim_finish_date;
	//计划完成时间
	var ad_plan_finish_date=form.ad_plan_finish_date;
	//实际完成时间
	var ad_actual_finish_date=form.ad_actual_finish_date;
	if(!(Ext.isEmpty(ad_plan_finish_date)) && !(Ext.isEmpty(ad_actual_finish_date))){
		if((ad_raise_date>ad_claim_finish_date)||(ad_raise_date>ad_plan_finish_date)){
			AOS.tip('提出时间不能大于要求完成时间、计划完成时间');
			return;
		}
		if(ad_actual_finish_date!=""){
			if(ad_plan_finish_date>ad_actual_finish_date){
				AOS.tip('计划时间不能大于实际完成时间');
				return;
			} 
		}
	 }
	if(Ext.isEmpty(content_desc_editor.getContent())){
	AOS.tip('需求内容不能为空');
	return;
	}
		AOS.ajax({
			forms : demandAction_create_form,
			url : demandAction_create_win.type=="update" ? 'demandActionService.update':'demandActionService.create',
			params:{
					ad_source_remark : demand_desc_editor.getContent(),
					ad_content : content_desc_editor.getContent()
					},
			ok : function(data) {
			    if(data.appcode == -1){
			    	AOS.tip(data.appmsg);
			    }
			    else{
					AOS.tip(data.appmsg);
					demandAction_grid_store.reload();
					demandAction_create_win.hide();
				}
			},
			failure : function(data){
				AOS.tip(data.appmsg);
			}
		});
	}
	
	//修改
	function demandAction_update() {
		demandAction_win_show('update');
	}
	
	//停用(0)  启用(1)  完成(2)
	function demandAction_delete(state){
		var selection = AOS.selection(demandAction_grid, 'ad_id');
		var str='';
		if(state=="0"){
			if(AOS.empty(selection)){
				AOS.tip('请选择需要停用的数据。');
				return;
			}
			if(!AOS.empty(AOS.select(demandAction_grid)[0])){
				if(AOS.select(demandAction_grid)[0].data.state==0){
					AOS.tip('项目数据已是停用状态，无法进行该操作!');
					return;
				}
			}
	 		str="停用";
		}else if(state=="1"){
			if(AOS.empty(selection)){
				AOS.tip('请选择需要启用的数据。');
				return;
			}
			if(!AOS.empty(AOS.select(demandAction_grid)[0])){
				if(AOS.select(demandAction_grid)[0].data.state==1){
					AOS.tip('项目数据已启用，无法进行该操作!');
					return;
				}
				if( AOS.empty(AOS.select(demandAction_grid)[0].data.ad_plan_finish_date)){
					AOS.tip('计划完成时间为空，请先修改!');
					return;
				}
// 				if( AOS.empty(AOS.select(demandAction_grid)[0].data.ad_workload)){
// 					AOS.tip('工作量估算为空，请先修改!');
// 					return;
// 				}
// 				if(AOS.select(demandAction_grid)[0].data.ad_workload<=0){
// 					AOS.tip('工作量估算不能小于0，请先修改!');
// 					return;
// 				}
			}
			str="启用";
		}else if(state=="2"){
			if(AOS.empty(selection)){
					AOS.tip('请选择需要完成的数据。');
					return;
			 }
			if(!AOS.empty(AOS.select(demandAction_grid)[0])){
				if(AOS.select(demandAction_grid)[0].data.state==2){
					AOS.tip('项目数据已完成，无法进行该操作!');
					return;
				}
				if( AOS.empty(AOS.select(demandAction_grid)[0].data.ad_plan_finish_date)){
					AOS.tip('计划完成时间为空，请先修改!');
					return;
				}
				if( AOS.empty(AOS.select(demandAction_grid)[0].data.ad_workload)){
					AOS.tip('工作量估算为空，请先修改!');
					return;
				}
				if(AOS.select(demandAction_grid)[0].data.ad_workload<=0){
					AOS.tip('工作量估算不能小于0，请先修改!');
					return;
				}
			}
			str="完成";
		}else if(state="9999"){
			if(AOS.empty(selection)){
				AOS.tip('请选择需要作废的数据。');
				return;
			}
			if(!AOS.empty(AOS.select(demandAction_grid)[0])){
				if(AOS.select(demandAction_grid)[0].data.state==1){
					AOS.tip('项目数据已启用，无法进行该操作!');
					return;
				}
				if(AOS.select(demandAction_grid)[0].data.state==9999){
					AOS.tip('项目数据已作废，无法进行该操作!');
					return;
				}
			}
			str="作废";
		}
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var rows = AOS.rows(demandAction_grid);
		var msg =  AOS.merge('确认要'+str+'选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'demandActionService.delete',
				params:{
					aos_rows: selection,
					state : state
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					demandAction_grid_store.reload();
					if(str=="启用"){
					var  token=data.appmsg;
					var count="{\"proj_id\":\""+AOS.select(demandAction_grid)[0].data.proj_id+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}提交"
						+task_plan_num+"项目周报\","+"\"createTime\":\""+createTime+"\"}";
					var title="项目周报"; 
					mesVO= {
							"title"  : title, 
							 "content": count,
							 "extras": {proj_id,proj_name,createTime,sedTime},
							  "mesGroup": "CHANNEL"
						}
					AOS.weekSend(token,mesVO);
					}
				}
			});
		});
	}

	//需求类型变动
	function demandAction_fields_ad_type_change(v){
		if(v.value==2){
			demandAction_change_fields.show();
		}else{
			demandAction_change_fields.hide();
		}
	}
	
	//需求类型变动
	function demandLook_fields_ad_type_change(v){
		if(v.value==2){
			demandLook_change_fields.show();
		}else{
			demandLook_change_fields.hide();
		}
	}

	//根据选择项目名称刷新树和grid
	function tree_grid_query(){
		var params = {
				proj_id:id_proj_name.getValue()
		};
		demandAction_t_module_refresh();
		var record = AOS.selectone(demandAction_t_module,true);
		demandAction_query();
		var proj_id=id_proj_name.getValue();
		//判断按钮启用权限
		AOS.ajax({
			url : 'projCommonsService.queryProrole',
			params:{
				proj_id:proj_id
			},
			ok : function(data) {
				var is_proj_manager = false; //是否项目经理
				var is_proj_development = false; //是否开发经理
				for(var i=0;i < data.length;i++){
					if(data[i].name == '项目经理'){
						is_proj_manager = true;
					} 
					if(data[i].name == '开发经理'){
						is_proj_development = true;
					} 
				}
				if(is_proj_manager || is_proj_development){
					AOS.get('enable').setVisible(true);
					AOS.get('disable').setVisible(true);
					AOS.get('complete').setVisible(true);
					AOS.get('men_enable').setVisible(true);
					AOS.get('men_disable').setVisible(true);
					AOS.get('men_make_task').setVisible(true);
					AOS.get('make_task').setVisible(true);
					AOS.get('men_complete').setVisible(true);
				}else{
					AOS.get('enable').setVisible(true);
					AOS.get('disable').setVisible(true);
					AOS.get('complete').setVisible(true);
					AOS.get('men_enable').setVisible(true);
					AOS.get('men_disable').setVisible(true);
					AOS.get('men_make_task').setVisible(true);
					AOS.get('make_task').setVisible(true);
					AOS.get('men_complete').setVisible(true);
				}
			}
		});
	}
	
	//模块查询
	function g_module_query(){
		var params = {
				proj_id:id_proj_name.getValue()
		};
		var record = AOS.selectone(demandAction_t_module,true);
		var a = record.raw.a;
		if(!AOS.empty(record)){
			if(record.raw.a=="true"){
				params = {proj_id:record.raw.id}
				demandAction_grid_store.getProxy().extraParams = params;
	    		demandAction_grid_store.loadPage(1);
			}else if(record.raw.a=="false"){
				params.dm_code = record.raw.id;
				demandAction_grid_store.getProxy().extraParams = params;
	    		demandAction_grid_store.loadPage(1);
			}
		}
	<!-- 	g_module_store.getProxy().extraParams = params; -->
	<!-- 	g_module_store.loadPage(1); -->
	}

	//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
	function demandAction_t_module_refresh(flag){
		var refreshnode = AOS.selectone(demandAction_t_module,true);
		var proj_id=id_proj_name.getValue();
		if (!refreshnode) {
			refreshnode = demandAction_t_module.getRootNode();
		}
		if (refreshnode.isLeaf() || (flag=='dm_parent_code' && !refreshnode.isRoot())) {
			refreshnode = refreshnode.parentNode;
		}
		//参数标记为刷新根节点
		if(flag == 'root'){
			refreshnode = demandAction_t_module.getRootNode();
		}
		demandAction_t_module_store.load({
			params:{
				proj_id:proj_id
			},
			callback : function() {
				//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
				refreshnode.collapse();
				refreshnode.expand();
				demandAction_t_module.getSelectionModel().select(refreshnode);
			}
		});
	}
	
	//默认选中第一个项目
	/*window.onload = function combobox_select(){
		var value = AOS.get('id_proj_name').getValue();
		AOS.get('id_proj_name').setValue(value);
		var proj_id=id_proj_name.getValue();
		tree_grid_query();
	}
	*/

	function on_ad_raise_date(){
		var now = new Date;
		var put_time = AOS.get('put_time').getValue();
		if(put_time>now){
			AOS.tip('提出时间不能超过今天!请重新选择!');
			AOS.get('put_time').setValue(null);
			return;
		}
	}

	//弹出选择上级模块窗口
	 function proj_tree_show() {
	 	w_org_find.show();
	 }
	 
	//上级模块树节点双击事件
	function t_org_find_select() {
		var record = AOS.selectone(t_org_find);
		AOS.setValue('demandAction_create_form.dm_code',record.raw.id);
		AOS.setValue('demandAction_create_form.dm_code_name',record.raw.text);
		w_org_find.hide();
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
	//项目需求维护默认加载默认项目
	window.onload = function(){
		var proj_id = '${proj_id}';
		var proj_name = '${proj_name}';
		if(proj_id !=null && proj_id!=''){
			AOS.setValue('id_proj_name',proj_id);
			AOS.setValue('tree_proj_name',proj_name);
			tree_grid_query();
		}
	}
	//项目弹出数选择事件
	function t_tree_find_select() {
	  	var record = AOS.selectone(t_org_find1);
	  	if(record.raw.a=="1"){
	  	AOS.setValue('id_proj_name',record.raw.id);
	  	AOS.setValue('tree_proj_name',record.raw.text);
	  	tree_grid_query();
		w_org_find1.hide();
		}else{
		AOS.tip("请选择项目!");
		return;
	  //w_org_find.hide();
	  }
	}

	//弹出选择上级模块窗口
	function proj_tree_show1() {
		w_org_find1.show();
	}
	
	//查看列按钮方法转换
	function fn_button_render(value, metaData, record, rowIndex, colIndex, store) {
		return '<input type="button" value="查看" class="cbtn" onclick="w_detail_show();" />';
	}
	//单元格样式
	function fn_task_count(value, metaData, record) {
		if(value != 0){
			return '<a href="javascript:void(0);">' + value + '</a>';
		}
		return value;
		
	}
	demandAction_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
		var record = AOS.selectone(demandAction_grid,true);
		console.log(record);
		var proj_id = record.data.proj_id;
		var demand_id=record.data.ad_id;
		if (columnIndex == 3 ) {
			AOS.get('demand_find_task_win').show();
			demand_find_task_win.maximize();
			demand_count_query(demand_id,proj_id);
		} 
	});
	
	function demand_count_query(demand_id,proj_id){
		var params = {
				demand_id : demand_id,
				proj_id : proj_id
		};
		demand_task_find_grid_store.getProxy().extraParams = params;
		demand_task_find_grid_store.loadPage(1);
	}
	
	//生成任务
	function task_make(){
		//清空form和grid
		demand_task_create_grid.getStore().removeAll();
		demand_group_id.setValue('');
		
		var record = AOS.selectone(demandAction_grid, true);
		var records = AOS.select(demandAction_grid, true);
		if(AOS.empty(record) || records.length>1){
			AOS.tip('请选择一条数据生成任务。');
			return;
		}
		if(record.data.state!=1){
			AOS.tip('该需求非启用状态，不能生成任务。');
				return;
		}
		var proj_id =record.data.proj_id;
		demand_task_create_form.loadRecord(record);
		AOS.get('demand_task_add_form.handler_user_id').getStore().getProxy().extraParams = {
			proj_id : proj_id
		};
		AOS.get('demand_task_add_form.handler_user_id').getStore().load({
			callback : function(records, operation, success) {
			}
		});
		AOS.get('demand_task_add_form.cc_user_ids').getStore().getProxy().extraParams = {
			proj_id : proj_id
		};
		AOS.get('demand_task_add_form.cc_user_ids').getStore().load({
			callback : function(records, operation, success) {
			}
		});
		//需求赋值
		AOS.setValue('demand_task_create_form.demand_id',record.data.ad_id);
		AOS.setValue('demand_task_create_form.demand_name',record.data.ad_name);
		//模块赋值
		AOS.setValue('demand_task_create_form.i_module_id',record.data.dm_code);
		AOS.setValue('demand_task_create_form.i_module_name',record.data.dm_code_name);
		
		//任务模块，因为任务存的是名字，这里带过去也是名字
		//AOS.setValue('demand_task_create_form.module_id',record.data.dm_code_name);
		AOS.setValue('demand_task_create_form.module_id',record.data.dm_code);
		
		//需求内容
		AOS.setValue('demand_task_create_form.ad_content',record.data.ad_content);
		//计划消耗天数
		AOS.setValue('demand_task_create_form.plan_wastage',record.data.ad_workload);
		//grid项目名称
		AOS.setValue('demand_task_create_form.proj_name',demand_task_create_proj_id.getRawValue());
		//grid任务名称
		AOS.setValue('demand_task_create_form.task_name',record.data.ad_name);
		//grid任务详情
		AOS.setValue('demand_task_create_form.task_desc',record.data.ad_content);
		
		
		//工作量
		var ad_workload = record.data.ad_workload;
		//当前时间
		var plan_begin_time_value=new Date();
		if(plan_begin_time_value.getHours()<12){
			//计划开始时间
			AOS.setValue('demand_task_create_form.plan_begin_time',Ext.Date.format(new Date(), "Y-m-d 08:30:00"));
			//计划完成时间
			AOS.setValue('demand_task_create_form.plan_end_time',Ext.Date.format(Ext.Date.add(new Date(),Ext.Date.DAY,ad_workload), "Y-m-d 12:00:00"));
		}
		else{
			//计划开始时间
			AOS.setValue('demand_task_create_form.plan_begin_time',Ext.Date.format(new Date(), "Y-m-d 12:00:00"));
			//计划完成时间
			AOS.setValue('demand_task_create_form.plan_end_time',Ext.Date.format(Ext.Date.add(new Date(),Ext.Date.DAY,ad_workload), "Y-m-d 17:30:00"));
		} 
		
		AOS.get('demand_task_create_form.group_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
		   AOS.get('demand_task_create_form.group_id').getStore().load({
				callback : function(records, operation, success) {
				}
			});
		demand_task_create_win.show();
		//测试
		var form1 = demand_task_create_form.getValues();
		form1.task_level='1010';
		form1.task_type='1020';
		//开发
		var form2 = demand_task_create_form.getValues();
		form2.task_level='1010';
		form2.task_type='1030';
		//设计
		var form3 = demand_task_create_form.getValues();
		form3.task_level='1010';
		form3.task_type='1040';
		demand_task_create_grid_store.insert(0,form3);
		demand_task_create_grid_store.insert(0,form2);
		demand_task_create_grid_store.insert(0,form1);
		
		demand_task_create_win.maximize();
	}
	
	//查看关联任务和缺陷
	function find_task(){
		var record = AOS.selectone(demandAction_grid, true);
		var records = AOS.select(demandAction_grid, true);
		if(AOS.empty(record) || records.length>1){
			AOS.tip('请选择一条数据查看。');
			return;
		}
		var proj_id = record.data.proj_id;
		var demand_id=record.data.ad_id;
		
		var params = new Object();
		params.proj_id = proj_id;
		params.demand_id=demand_id;
		demand_task_find_grid_store.getProxy().extraParams = params;
		demand_task_find_grid_store.loadPage(1);
			
		demand_bug_find_grid_store.getProxy().extraParams = params;
		demand_bug_find_grid_store.loadPage(1);
		demand_find_task_win.show();
		demand_find_task_win.maximize();
	}
	
	//需求导入
	function demand_import_excel(){
		demand_importExcle_win.show();
	}	
	
	//导入保存
	function demand_importExcle_save(){
		var filenPath = AOS.getValue('demand_importExcle_form.excel_file');
		if(filenPath==''){
			AOS.tip("请选择一个文件！");
			return;
		}
		var proj_id = id_proj_name.getValue();
		var params = new Object();
		params.proj_id = proj_id;
		fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
		if (fileExtension != ".xls" && fileExtension != ".xlsx") {
			AOS.tip('请选择excel文件进行导入!');
			return;
		}
		demand_importExcle_form.getForm().fileUpload = true;
		demand_importExcle_form.getForm().submit({
			type : 'POST',
			params : params,
			url:'do.jhtml?router=demandActionService.importFile&juid=${juid}',
			waitMsg:'文件导入中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				demand_importExcle_win.hide(); 
				demandAction_grid_store.reload();
			},
			failure: function(form, action) {
				console.log(action);
// 				demandAction_grid_store.reload();
				demand_importExcle_win.hide();
				AOS.tip("导入的数据中存在重复的需求名称！");
			}
		});
	}
	
	//上传窗口
	function WBS_show_excel_win(){
		WBS_excel_win.show();
	}
	
	//上传保存
	function WBS_excel_win_save(){
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var filenPath = AOS.getValue('WBS_excel_win_form.WBS_excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
			return;
	    }
	    WBS_excel_win_form.getForm().fileUpload = true;
	    WBS_excel_win_form.getForm().encoding="multipart/form-data";
	    WBS_excel_win_form.getForm().submit({
    		type : 'POST', 
			url:'do.jhtml?router=demandActionUploadTemplateService.importFile&juid=${juid}',
			waitMsg:'文件上传中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				WBS_excel_win.hide(); 
				var token=action.result.msg;
				var count="{\"${user_name}上传"+"\"createTime\":\""+createTime+"\"}";
				var title="WBS文件"; 
				mesVO=   {
					"title"  : title, 
					 "content": count,
					 "extras": {createTime,sedTime},
					 "mesGroup": "CHANNEL",
				}
				AOS.weekSend(token,mesVO);
	    	},
			failure: function() {
				WBS_excel_win.hide();
				AOS.tip("文件上传失败！");
			}
		});
	}
	
	//下载导入模板
	function import_excel_upload(){
		AOS.file('do.jhtml?router=demandActionUploadTemplateService.downloadFile&juid=${juid}');
	}
</script>

