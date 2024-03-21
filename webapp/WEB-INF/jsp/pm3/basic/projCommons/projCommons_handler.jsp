<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<script type="text/javascript">
	//人员信息姓名过滤
	function query_username(){
		var name = AOS.getValue('comm_username');
		var record_role = AOS.selectone(public_projRoleTypes_gridpanel,true);
		if(AOS.empty(record_role)){
			public_user_gridpanel_store.getProxy().extraParams = {
		    	name:name,
		    	proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id
		    };
		}else{
			public_user_gridpanel_store.getProxy().extraParams = {
		    	name:name,
		    	trp_code:record_role.data.trp_code,
		    	proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id
		    };
		}
		public_user_gridpanel_store.loadPage(1);
	}

//显示新增或修改窗口
function projCommons_win_show(type){
	projCommons_create_win.type=type;
	if(type=="create"){
		AOS.reset(projCommons_create_form);
		projCommons_create_win.setTitle("新增项目信息");
		AOS.edits(projCommons_create_form,'proj_code,type_code,proj_name,project_for_short,begin_date,period,plan_completion_time,for_ct_name,rt_desc,client_name,client_out_name,client_address,client_out_phone');
		AOS.enableCmps('projCommons_create_save');
		projCommons_create_win.show();
	}else{
		AOS.reset(projCommons_create_form);
		var record = AOS.selectone(projCommons_grid, true);
	
		if(AOS.empty(record)){
			AOS.tip('请选择一条需要修改的数据。');
			return;
		}
		if(record.data.state==1||record.data.state==2){
	AOS.reads(projCommons_create_form,'proj_code,type_code,proj_name,project_for_short,begin_date');
    	}else{
			AOS.edits(projCommons_create_form,'proj_code,type_code,proj_name,project_for_short,begin_date,period,plan_completion_time,for_ct_name,rt_desc,client_name,client_out_name,client_address,client_out_phone');
			AOS.enableCmps('projCommons_create_save');
		}
		projCommons_create_form.loadRecord(record);
		projCommons_create_win.setTitle("修改项目信息");
		
		var proj_ids = record.raw.pm_user_id;
		if(!AOS.empty(proj_ids)){
			var projIds = proj_ids.split(",");
			for(var i=0;i<projIds.length;i++){
				projIds[i]=Number(projIds[i]);
			}
			AOS.setValue('projCommons_create_form.pm_user_id',projIds);
		}
		
		var proj_ids = record.raw.pm2_user_id;
		if(!AOS.empty(proj_ids)){
			var projIds = proj_ids.split(",");
			for(var i=0;i<projIds.length;i++){
				projIds[i]=Number(projIds[i]);
			}
			AOS.setValue('projCommons_create_form.pm2_user_id',projIds);
		}
		AOS.setValue('projCommons_create_form.plan_completion_time',record.data.plan_completion_time);
		projCommons_create_win.show();
	}
}

//查询
function projCommons_query() {
	var params = AOS.getValue('query_form');
    projCommons_grid_store.getProxy().extraParams = {
    	//name:params.keyWords,
    	//ahtor:params.keyWords,
    	//press:params.keyWords
    };
    projCommons_grid_store.loadPage(1);
}

//查询
function projCommons_name_query() {
	var proj_name = AOS.getValue('proj_name');
    projCommons_grid_store.getProxy().extraParams = {
    	proj_name : proj_name};
    projCommons_grid_store.loadPage(1);
}

//全部导出
function exportAll(){
	var start = 0;
	var limit = 50;
	var proj_name = AOS.getValue('proj_name');
	if(proj_name === undefined){
		proj_name = "";
	}
	AOS.file('do.jhtml?router=projCommonsService.exportALLExcel&juid=${juid}&&proj_name='+proj_name
			+'&start='+start
			+'&limit='+limit
		);	
}

//新增
function projCommons_create() {
		AOS.ajax({
		forms : projCommons_create_form,
		url : projCommons_create_win.type=="update" ? 'projCommonsService.update':'projCommonsService.create',
		ok : function(data) {
			AOS.tip(data.appmsg);
			projCommons_grid_store.reload();
			projCommons_create_win.hide();
		}
	});
}
//修改
function projCommons_update() {
	projCommons_win_show('update');
}
//删除，启用，停用，验收,关闭
function projCommons_delete(state){
	var selection = AOS.selection(projCommons_grid, 'proj_id');
	var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var str='';
 if(state=="3"){
		 if(AOS.empty(selection)){
				AOS.tip('请选择需要关闭的数据。');
				return;
		 }
	if(AOS.selectone(projCommons_grid, true).data.state != 2){
				AOS.tip('当前项目状态无法关闭!');
				return;
			}
		 	str="关闭";
			}
	else if(state=="0"){
 if(AOS.empty(selection)){
		AOS.tip('请选择需要停用的数据。');
		return;
 }
 if(AOS.selectone(projCommons_grid, true).data.state == 2){
		AOS.tip('当前项目状态无法停用!');
		return;
	}
 	str="停用";
	}else if(state=="1"){
 if(AOS.empty(selection)){
		AOS.tip('请选择需要启用的数据。');
		return;
 }
 if(AOS.selectone(projCommons_grid, true).data.state == 2){
		AOS.tip('当前项目状态无法启用!');
		return;
	}
  str="启用";
	}else if(state=="2"){
	if(AOS.empty(selection)){
		AOS.tip('请选择需要验收的数据。');
		return;
	}
	var state1 = AOS.selectone(projCommons_grid, true).data.state;
	if( state1== 2){
		AOS.tip('请勿重复验收。');
		return;
	}
	if(state1 == -1 || state1 == 0 ){
		AOS.tip('当前项目状态无法进行验收，请先启用!');
		return;
	}
	str="验收";
	}else{
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	if(AOS.selectone(projCommons_grid, true).data.state==1 
		|| AOS.selectone(projCommons_grid, true).data.state == 2){
		AOS.tip('当前项目状态无法删除!');
		return;
	}
	str="删除";
	}
	var rows = AOS.rows(projCommons_grid);
	var msg =  AOS.merge('确认要'+str+'选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projCommonsService.delete',
			params:{
				aos_rows: selection,
				state : state
				
			},
			ok : function(data) {
				AOS.tip("操作成功");
				projCommons_grid_store.reload();
				var  token=data.appmsg;
				var proj_id=AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id;
				var proj_name=AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_name;
				var title="项目基本信息"; 
				
				if(str=="启用"){
					var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}启用-"
					+proj_name+"\","+"\"createTime\":\""+createTime+"\"}";
				mesVO=   {
						"title"  : title, 
						 "content": count,
						 "extras": {proj_id,proj_name,createTime,sedTime},
						 "mesGroup": "CHANNEL"
							}
			AOS.weekSend(token,mesVO);
				}else if(str=="验收"){
					var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}验收-"
					+proj_name+"\","+"\"createTime\":\""+createTime+"\"}";
					mesVO=   {
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
//grid 点击
function projTeams_grid_click(me, record){
	var selection = AOS.selection(projCommons_grid, 'proj_id');
	if(AOS.empty(selection)){
		disGridTab();
<!-- 		AOS.tip('请先选中数据。'); -->
		return;
	}
	if(AOS.rows(projCommons_grid)>1){
		disGridTab();
<!-- 		AOS.tip('请选择一条数据。'); -->
		return;
	}
	enGridTab();
	AOS.reset(projTeams_tab_projCommons_form);
	var record = AOS.selectone(projCommons_grid, true);
	
	projTeams_tab_projCommons_form.loadRecord(record);
	projContract_tab_projCommons_form.loadRecord(record);
	public_projRoleTypes_gridpanel_store.loadPage(1);
	var proj_id = AOS.selectone(projCommons_grid, "proj_id").data.proj_id;
	   task_grid_column_handler_user_id_store.getProxy().extraParams = {
			proj_id:proj_id
	};
	params = {proj_id: proj_id}
	contractStage_grid_store.getProxy().extraParams = params;
	contractStage_grid_store.loadPage(1);
	projTeams_query(selection);
	projClientContacts_query(selection);
	
	params = {ct_id: ''}
	projContractformpanel_grid_store.getProxy().extraParams = params;
	projContractformpanel_grid_store.loadPage(1);
	contractFile_grid_store.getProxy().extraParams = params;
	contractFile_grid_store.loadPage(1);
	
}
//禁用GridTab
function disGridTab(){
	AOS.disableCmps('projTeams_tab_org');
	AOS.disableCmps('projContract_tab_org');
<!-- 	AOS.disableCmps('projClientContacts_tab_org'); -->
}
//启用GridTab
function enGridTab(){
	AOS.enableCmps('projTeams_tab_org');
	AOS.enableCmps('projContract_tab_org');
<!-- 	AOS.enableCmps('projClientContacts_tab_org'); -->
}

//checkbox选框
function func_change(){
	var flag_m=AOS.get('id_change').getValue().userRoleName;
		if(flag_m==1){
			 projTeams_grid_store.getProxy().extraParams = {
					proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id
			    };
			 projTeams_grid_store.loadPage(1);
		}else{
			var record_role = AOS.selectone(public_projRoleTypes_gridpanel,true);
		if(AOS.empty(record_role)){
			AOS.tip('请选择一条角色信息!');
			return;
		}
		
	}
}
//查询角色grid
function projRoleTypes_query() {
	public_projRoleTypes_gridpanel_store.getProxy().extraParams = {
    	proj_id : AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id

    };
	public_projRoleTypes_gridpanel_store.loadPage(1);
}
//查询人员grid
function public_user_gridpanel_query() {
	var record_role = AOS.selectone(public_projRoleTypes_gridpanel,true);
	if(AOS.empty(record_role)){
		return;
	}
	if(AOS.empty(AOS.selectone(projCommons_grid,true))){
		return;
	}
	public_user_gridpanel_store.getProxy().extraParams = {
    	proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id,
    	trp_code:record_role.data.trp_code
    };
	 projTeams_grid_store.getProxy().extraParams = {
		proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id,
    	trp_code:record_role.data.trp_code
    };
    public_user_gridpanel_store.loadPage(1);
    projTeams_grid_store.loadPage(1);
    
}
function refresh_team(){
	 projTeams_grid_store.getProxy().extraParams = {
			proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id
	    };
		public_user_gridpanel_store.getProxy().extraParams = {
	    	proj_id:''
	    };
		public_projRoleTypes_gridpanel_store.getProxy().extraParams = {
	    	proj_id:AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id
	    };
		public_projRoleTypes_gridpanel_store.loadPage(1);
		 public_user_gridpanel_store.loadPage(1);
	    projTeams_grid_store.loadPage(1);
}
//项目角色设置保存
function role_user_save(){
	var record_role = AOS.selectone(public_projRoleTypes_gridpanel, true);
		if(AOS.empty(record_role)){
			AOS.tip('请选择项目角色信息记录。');
			return;
		}
	var record = AOS.selectone(public_user_gridpanel, true);
	if(AOS.empty(record)){
		AOS.tip('请选择要添加的人员信息记录。');
		return;
	}
	var trp_code = record_role.data.trp_code;
	var trp_name = record_role.data.trp_name;
	var aos_role_id = record_role.data.aos_role_id;
	var team_user_ids = AOS.selection(public_user_gridpanel, 'id');
	var proj_id = AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id;
	var proj_name = AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_name;
	var name=record.data.name;
	var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	AOS.ajax({
		params:{
				trp_code:trp_code,
				aos_role_id:aos_role_id,
				team_user_id:team_user_ids,
				proj_id:proj_id
			},
		url : 'projTeamsService.create',
		ok : function(data) {
			AOS.tip("新增成功");
			projTeams_grid_store.reload();
			public_user_gridpanel_store.reload();
			var  token=data.appmsg;
				var title="项目组员变更"; 
				var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}添加"
				+name+"-为"+proj_name+"-"+trp_name+"\","+"\"createTime\":\""+createTime+"\"}";
				mesVO=   {
						"title"  : title, 
						 "content": count,
						 "extras": {proj_id,proj_name,createTime,sedTime},
						 "mesGroup": "CHANNEL"
							}
			AOS.weekSend(token,mesVO);
		}
	});
}
//项目角色设置删除
function role_user_delete(){
	var selection = AOS.selection(projTeams_grid, 'team_id');
	var record_role = AOS.selectone(public_projRoleTypes_gridpanel, true);
	if(AOS.empty(record_role)){
		AOS.tip('请选择项目角色信息记录。');
		return;
	}
	if(AOS.empty(selection)){
		AOS.tip('请选择需要删除的数据。');
		return;
	}
	var rows = AOS.rows(projTeams_grid);
	var record = AOS.selectone(projTeams_grid, true);
	var proj_id = AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_id;
	var proj_name = AOS.selectone(Ext.getCmp('projCommons_grid')).data.proj_name;
	var name=record.data.team_user_name;
	var trp_name=record.data.trp_name;
	var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
	var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projTeamsService.delete',
			params:{
				aos_rows: selection
			},
			ok : function(data) {
				AOS.tip("撤销成功");
				public_user_gridpanel_store.reload();
				projTeams_grid_store.reload();
				var  token=data.appmsg;
				var title="项目组员变更"; 
				var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}撤销"
				+name+"-为"+proj_name+"-"+trp_name+"\","+"\"createTime\":\""+createTime+"\"}";
				mesVO={
						"title"  : title, 
						 "content": count,
						 "extras": {proj_id,proj_name,createTime,sedTime},
						 "mesGroup": "CHANNEL"
					}
			AOS.weekSend(token,mesVO);
			}
		});
	});
}
//contract_grid弹窗显示
function contract_grid_show(){
	contract_win.show();
	g_contract_query1();
	g_contract_query();
}

//contract_grid加载win
function g_contract_query(){
		contract_grid_store.loadPage(1);
}
//contract_grid 保存
function personnel_save(){
	var data = AOS.get('contract_grid1').store.data.items;
	var sum_ct_id="";
	var sum_ct_name="";
	for(var i= 0 ;i< data.length;i++){  
        var ct_id = data[i].data.ct_id;  
        var ct_name = data[i].data.ct_name;
        if(i==0){
        sum_ct_id = ct_id;
        sum_ct_name = ct_name;
        }else{  
        sum_ct_id = sum_ct_id +"," + ct_id;
        sum_ct_name = sum_ct_name +"," +ct_name;
        }
    }  
	AOS.get('ct_id').setValue(sum_ct_id);
	AOS.get('ct_name').setValue(sum_ct_name);
	contract_win.hide();
}
//添加选中的单条grid
function add_contract_grid(me, record){
	var data = AOS.get('contract_grid1').store.data.items;
	for(var i= 0 ;i< data.length;i++){  
        if(record.data.ct_id==data[i].data.ct_id){
        		AOS.tip("数据重复，无法选中！");
        		return;
        	} 
        }
	var grid1 = AOS.get('contract_grid1').store;
	grid1.add(record);
}
//删除某条数据
function del_contract_grid(me,record){
	var grid1 = AOS.get('contract_grid1').store;
	grid1.remove(record);
}
//合同链接grid加载
function g_contract_query1(){
	var proj_id = AOS.selection(projCommons_grid,'proj_id');
	if(proj_id==""){
		proj_id = "null,";
	}
	proj_id = proj_id.substr(0, proj_id.length - 1);  
	params = {proj_id: proj_id}
	contract_grid1_store.getProxy().extraParams = params;
	contract_grid1_store.loadPage(1);
}

//金额渲染
function fn_money(value, metaData, data) {
	if(value>=10000){
		return Ext.util.Format.number(value/10000,'0,000.00')+'  (万)';
	} 
		return Ext.util.Format.number(value,'0,000.00')+'元';
}
//刷新支付阶段grid 文档下载grid
function onclickpayContact(){
	var ct_id = AOS.selection(contractStage_grid,'ct_id');
	ct_id = ct_id.substr(0, ct_id.length - 1);
	params = {ct_id: ct_id}
	projContractformpanel_grid_store.getProxy().extraParams = params;
	projContractformpanel_grid_store.loadPage(1);
	contractFile_grid_store.getProxy().extraParams = params;
	contractFile_grid_store.loadPage(1);
}
//跳转合同管理新增
function contractStage_grid_add(){
		window.location.href="do.jhtml?router=contractService.init&juid=<%=request.getAttribute("juid")%>";
	}
</script>