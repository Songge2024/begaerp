<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<aos:html title="任务情况统计" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="task_query" labelWidth="70" header="false" region="north" border="false" anchor= "100%">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield name="account_number_name" fieldLabel="成员姓名" columnWidth="0.33" onenterkey="task_work_query"/>
			<aos:hiddenfield name="user_id" fieldLabel="人员ID" />
			<aos:hiddenfield name="subordinate_departments_id" fieldLabel="负责人部门ID"/>
			<aos:triggerfield id="search_principal_org" fieldLabel="负责人部门" 
				name="subordinate_departments" allowBlank="false" editable="false" 
				trigger1Cls="x-form-search-trigger" onTrigger1Click="fn_org" columnWidth="0.33" value='${principal_org_name}'/>
			<aos:datetimefield fieldLabel="任务更新时间"  name="update_task_time" columnWidth="0.33" labelWidth="100" format="Y-m-d"/>
			<aos:dockeditem xtype="button" text="查询" icon="query.png" onclick="task_work_query" margin="0 5 0 10" />
			<aos:dockeditem xtype="button" text="重置"   icon="refresh.png" onclick="AOS.reset(task_query);"   margin="0 5 0 5" />
		</aos:formpanel>
		
		<aos:window id="w_stand_find"  title="负责人部门" height="-60" layout="fit"  width="320" autoScroll="true"  >
			<aos:treepanel 
				id="idTree2" 
				flex="1" 
				singleClick="false" 
				cascade="false" 
				rootVisible="false"
 				url="taskWorkCompleteService.getTreeData" 
 				margin="5" 
 				border="true" 
			/> 
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="org_box_save" text="确认" icon="ok.png" />
				<aos:dockeditem onclick="#w_stand_find.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:gridpanel 
			id="task_work_grid" 
			url="taskWorkCompleteService.page"
			onrender="task_work_query_onerad"
			autoScroll="true" 
			hidePagebar="true" 
			forceFit="false" 
			region="center"
		>
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="任务完成情况" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem xtype="button" text="全部导出" onclick="exportAll" icon="icon70.png" />
			</aos:docked>
			<aos:column type="rowno" width="40"/>
			<aos:selmodel type="checkbox" mode="multi"/>
			<aos:column header="成员id" dataIndex="handler_user_id"  width="240" align="center" hidden="true"/>
			<aos:column header="成员姓名" dataIndex="account_number_name" width="200" align="left" celltip="true" />
			<aos:column header="所属部门" dataIndex="subordinate_departments" width="120" align="left" />	
			<aos:column header="未接收任务数" dataIndex="yfb_num" width="200" align="right"/>	
			<aos:column header="当前进行任务数" dataIndex="yjs_num" width="200" align="right" />								
			<aos:column header="待关闭数" dataIndex="ywc_num" width="200" align="right" />	
			<aos:column header="更新状态"   dataIndex="ygx_num" width="200" align="center" rendererFn="task_ygx_num"/>								
		</aos:gridpanel>
	</aos:viewport>
	<script type="text/javascript">
		//弹出选择上级模块窗口
		function fn_org() {
			w_stand_find.show();
		}
		
		//复选框保存
		function org_box_save() {
			var checked_id = AOS.selection(idTree2, 'id');
			var checked_name = AOS.selection(idTree2, 'text');
			if(AOS.empty(checked_id)){
				AOS.info("请选择要查询的部门或科室！");
				return;
			}
			var id=checked_id.split(",");
	    	var name=checked_name.split(",");
	    	var id_=[];
	    	var name_=[];
	    	Ext.each(id,function(item){
	    		if(!AOS.empty(item)){
	    			id_.push(Number(item));
	    		};
	    	});
	    	Ext.each(name,function(item){
	    		if(!AOS.empty(item)){
	    			name_.push(item);
	    		};
	    	});
	    	AOS.setValue('task_query.subordinate_departments',name_);
	    	AOS.setValue('task_query.subordinate_departments_id',id_);
	    	w_stand_find.hide();
		}
		
		//全部导出
		function exportAll(){
			var params = AOS.getValue('task_query');
			var start = 0;
			var limit = 50;
			var account_number_name = params.account_number_name;
			if( account_number_name=== undefined){
				account_number_name = "";
			}
			var subordinate_departments_id = params.subordinate_departments_id;
			if( subordinate_departments_id === undefined){
				subordinate_departments_id = "";
			}
			var update_task_time = params.update_task_time;
			if( update_task_time=== undefined){
				update_task_time = "";
			}
			AOS.file('do.jhtml?router=taskWorkCompleteService.exportALLExcel&juid=${juid}&&account_number_name='+account_number_name
					+'&subordinate_departments_id='+subordinate_departments_id
					+'&update_task_time='+update_task_time
					+'&start='+start
					+'&limit='+limit
				);	
		}
		
		//查询按钮
		function task_work_query() {
			var params = AOS.getValue('task_query');
			var state=AOS.get('search_principal_org').getValue();
			task_work_grid_store.getProxy().extraParams =params;
			task_work_grid_store.loadPage(1);
		}
			
		//个人工作量汇总表
		function task_work_query_onerad() {
			AOS.setValue('task_query.update_task_time', '${update_task_time}');
			AOS.setValue('task_query.subordinate_departments', '${principal_org_name}');
			AOS.setValue('task_query.subordinate_departments_id', '${principal_org_id}');
			var params = AOS.getValue('task_query');
			task_work_grid_store.getProxy().extraParams =params;
			task_work_grid_store.loadPage(1);
		}
		
		//缺陷状态渲染
		function task_ygx_num(value, metaData, record){
			if(value =='0'){
				return "<span style='color:#EEC900; font-weight:bold'>未更新</span>"; 
			}else if(value == '1'){
				return "<span style='color:green; font-weight:bold'>已更新</span>"; 
			}else{
				return value;
			}
		}		
	</script>
</aos:onready>
