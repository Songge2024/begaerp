<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<% 
	String currentDayStr=AOSUtils.getDateStr(); 
%>
<aos:hiddenfield fieldLabel="分组编码" name="group_id" />
<aos:fieldset columnWidth="1" collapsible="false" >
	<aos:fieldset columnWidth="0.4" collapsible="false" margin="5 5 5 5"  >
		<aos:hiddenfield fieldLabel="临时task_id" name="temp_task_id"/>
		<aos:combobox fieldLabel="关联项目" name="proj_id"  id="id_proj_id"  json="[]" columnWidth="0.9" allowBlank="false" margin="5 0 0 0" readOnly = "true"/>
		<%-- <aos:textfield fieldLabel="分组编码" name="group_id" /> --%>
		<aos:hiddenfield fieldLabel="所属分组" name="group_name" readOnly="true" columnWidth="0.9"/>
		<%-- <aos:textfield fieldLabel="所属全部分组" name="group_name_all" readOnly="true" columnWidth="0.9"/> --%>
		
		<aos:hiddenfield  id="group_name_all_id" name="group_name_all_id" readOnly="true" columnWidth="0.9"/>
		<aos:triggerfield fieldLabel="所属全部分组" id="group_name_all" name="group_name_all" editable="false" 
					trigger1Cls="x-form-search-trigger" onTrigger1Click="group_tree_show" columnWidth="0.9" />
		
		<aos:datetimefield id="task_plan_begin_time" fieldLabel="计划开始时间" name="plan_begin_time"  onchange="on_task_plan_wastage_change" format="Y-m-d H:i:s" columnWidth="0.9" allowBlank="false"  msgTarget="qtip"/>
		<aos:datetimefield id="task_plan_end_time" fieldLabel="计划结束时间"  name="plan_end_time"   onchange="on_task_plan_wastage_change" format="Y-m-d H:i:s"  columnWidth="0.9" allowBlank="false" msgTarget="qtip"/>
<%-- 		<aos:combobox id="task_handler_user_id" fieldLabel="指派给" name="handler_user_id" json="[]" editable="true" queryMode="local" typeAhead="true"  --%>
<%-- 			selectOnFocus="true" multiSelect="true" columnWidth="0.9" allowBlank="false" msgTarget="qtip"/> --%>
		<aos:hiddenfield name="handler_user_id" id="task_handler_user_id"/>
		<aos:triggerfield fieldLabel="指派给" name="handler_user_name" editable="false"  allowBlank="false"
			 trigger1Cls="x-form-search-trigger"  onTrigger1Click="w_account_find_show" columnWidth="0.9" />
		
		<!--onchange="task_handler_user_id_change" -->
		<aos:textfield fieldLabel="任务名称" name="task_name" msgTarget="qtip" columnWidth="0.9" allowBlank="false" maxLength="100"/>
	</aos:fieldset>
	
	<aos:fieldset columnWidth="0.4" collapsible="false" margin="5 5 5 5" >
	<aos:hiddenfield  id="module_id" name="module_id" readOnly="true" columnWidth="0.9"/>
		<aos:combobox   name="demand_id" fieldLabel="关联需求" columnWidth="0.9" json="[]" margin="5 0 0 0"/>
		<aos:triggerfield fieldLabel="模块名称" id="module_name" name="module_text" editable="false" 
					trigger1Cls="x-form-search-trigger" onTrigger1Click="stand_tree_show" columnWidth="0.9" />
		<aos:numberfield fieldLabel="计划消耗天数" name="plan_wastage"  columnWidth="0.9" editable="true" step="0.5" decimalPrecision="1" value="1" minValue="0" maxValue="999" />
		<aos:combobox id="id_task_type"   fieldLabel="任务类型" name="task_type" columnWidth="0.9" dicField="task_type" allowBlank="false" />
		<aos:combobox fieldLabel="优先级" name="task_level" columnWidth="0.9" dicField="task_level"  allowBlank="false"/>
		<aos:combobox fieldLabel="抄送" name="cc_user_ids" columnWidth="0.9" json="[]"  multiSelect="true" hidden="true"/>
	</aos:fieldset>
	<aos:fieldset columnWidth="0.8" collapsible="false" id="finish_percent" margin="5 5 5 5" hidden="true">
		<aos:numberfield margin="5 0 0 0" columnWidth="0.5" name="percent" fieldLabel="完成比例(%)" step="5"  value="0" minValue="0" maxValue="100" msgTarget="qtip"/>
		<aos:datetimefield margin="5 0 0 0" columnWidth="0.5" name="real_begin_time" fieldLabel="实际开始时间" editable="true" format="Y-m-d H:i:s" />
	</aos:fieldset>
	<aos:fieldset columnWidth="0.8" collapsible="false" id="finish_wastage" margin="5 5 5 5" hidden="false">
		<aos:datetimefield margin="5 0 0 0" columnWidth="0.33" name="real_end_time" fieldLabel="实际完成时间" />
		<aos:numberfield margin="5 0 0 0" columnWidth="0.33" name="real_wastage" minValue="0.0" fieldLabel="工作量核算天数" step="0.5" value="0"/>
		<aos:numberfield margin="5 0 0 0" columnWidth="0.33" name="task_extra_time" minValue="0.0" fieldLabel="额外完成时间" step="0.5" value="0"/>
	</aos:fieldset>
</aos:fieldset>
<aos:fieldset  title="任务描述"  collapsible="false" margin="5 0 5 0" height="270">
	<aos:tabpanel columnWidth="1">
		<aos:tab title="任务描述" closable="false" id="task_desc_create" disabled="false" layout="anchor" columnWidth="1">
			<aos:panel margin="5"  padding="5" contentEl="task_desc_div" width='1300' border="40"/>
		</aos:tab>
		<aos:tab title="相关附件" closable="false" id="temp_task_tab_file" disabled="false" layout="anchor" columnWidth="1">
			<aos:gridpanel id="temp_taskFileUpload_grid" columnWidth="1" url="taskFileUploadTempService.page" onrender="taskFiletype_query" split="true"
				height="220" width='1500' region="center" forceFit="true" columnLines="true" bodyBorder="0 0 1 0">
				<aos:menu>
					<aos:menuitem text="上传" onclick="show_excel_win" icon="add.png" />
					<aos:menuitem text="删除" onclick="file_grid_del" icon="del.png" />
					<aos:menuitem xtype="menuseparator" />
					<aos:menuitem text="刷新" onclick="#temp_taskFileUpload_grid_store.reload();" icon="refresh.png" />
				</aos:menu>
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="文件列表" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="上传" icon="add.png" onclick="show_excel_win" />
					<aos:dockeditem text="删除" icon="del.png" onclick="file_grid_del" />
				</aos:docked>
				
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<aos:column header="文件ID" dataIndex="create_file_id" width="150" hidden="true"/>
				<aos:column header="文件类型" dataIndex="task_file_type" rendererField="task_file_type" width="150" align="center"/>
				<aos:column header="上传文件标题" dataIndex="file_title" width="400" />
				<aos:column header="上传人" dataIndex="create_user_name" width="120"/>
				<aos:column header="上传文件大小" dataIndex="file_size" width="100" align="right"/>
				<aos:column header="任务ID" dataIndex="task_id" width="200" hidden="true"/>
				<aos:column header="任务名称" dataIndex="task_name" width="300" />
				<aos:column header="项目id" dataIndex="proj_id" width="100"  hidden="true"/>
				<aos:column header="项目名称" dataIndex="proj_name" width="200"  hidden="true"/>
				<aos:column header="上传时间" dataIndex="create_time" width="150"  align="center"/>
				<aos:column header="文件编码" dataIndex="file_code" width="150" hidden="true"/>
				<aos:column header="排序号" dataIndex="sortno" width="100" hidden="true" />
				<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
				<aos:column header="创建人" dataIndex="create_user_id" width="120" hidden="true"/>
				<aos:column header="上传文件路径" dataIndex="file_path" width="100" hidden="true"/>
				<aos:column header="上传文件URL" dataIndex="file_url" width="100"  hidden="true" />
				<aos:column header="上传文件备注" dataIndex="file_remark" width="100" hidden="true" />
				
				<!-- 上传窗口-->
				<aos:window id="temp_excel_win" title="上传文件">
					<aos:formpanel id="temp_excel_win_form" width="450" layout="anchor" labelWidth="60">
						<aos:combobox id="id_create_taskFileType" fieldLabel="文件类型" dicField="task_file_type" allowBlank="false" />
						<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="60" allowBlank="false"/>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="excel_win_save" text="上传" icon="ok.png" />
						<aos:dockeditem onclick="#temp_excel_win.hide();" text="关闭" icon="close.png" />
					</aos:docked>
				</aos:window>
			</aos:gridpanel>
			
			<aos:gridpanel id="create_taskFileUpload_grid" columnWidth="1" split="true" url="taskFileUploadService.createPage" onrender="taskFiletype_create_query"
				height="220" width='1500' region="center" forceFit="true" columnLines="true" bodyBorder="0 0 1 0">
				<aos:menu>
					<aos:menuitem text="上传" onclick="create_show_excel_win" icon="add.png" />
					<aos:menuitem text="删除" onclick="create_file_grid_del" icon="del.png" />
					<aos:menuitem text="下载" onclick="create_g_acount_down" icon="down.png" />
					<aos:menuitem xtype="menuseparator" />
					<aos:menuitem text="刷新" onclick="#create_taskFileUpload_grid_store.reload();" icon="refresh.png" />
				</aos:menu>
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="文件列表" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="上传" icon="add.png" onclick="create_show_excel_win" />
					<aos:dockeditem text="删除" icon="del.png" onclick="create_file_grid_del" />
					<aos:dockeditem text="下载" icon="down.png"  onclick="create_g_acount_down" />
				</aos:docked>
				
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<aos:column header="文件类型" dataIndex="task_file_type" rendererField="task_file_type" width="150" align="center"/>
				<aos:column header="上传文件标题" dataIndex="file_title" width="400" />
				<aos:column header="上传人" dataIndex="create_user_name" width="120"/>
				<aos:column header="上传文件大小" dataIndex="file_size" width="100" align="right"/>
				<aos:column header="任务ID" dataIndex="task_id" width="200" hidden="true"/>
				<aos:column header="任务名称" dataIndex="task_name" width="300" />
				<aos:column header="项目id" dataIndex="proj_id" width="100"  hidden="true"/>
				<aos:column header="项目名称" dataIndex="proj_name" width="200"  hidden="true"/>
				<aos:column header="上传时间" dataIndex="create_time" width="150"  align="center"/>
				<aos:column header="文件ID" dataIndex="file_id" width="150" hidden="true"/>
				<aos:column header="文件编码" dataIndex="file_code" width="150" hidden="true"/>
				<aos:column header="排序号" dataIndex="sortno" width="100" hidden="true" />
				<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
				<aos:column header="创建人" dataIndex="create_user_id" width="120" hidden="true"/>
				<aos:column header="上传文件路径" dataIndex="file_path" width="100" hidden="true"/>
				<aos:column header="上传文件URL" dataIndex="file_url" width="100"  hidden="true" />
				<aos:column header="上传文件备注" dataIndex="file_remark" width="100" hidden="true" />
				
				<!-- 上传窗口-->
				<aos:window id="create_excel_win" title="上传文件">
					<aos:formpanel id="create_excel_win_form" width="450" layout="anchor" labelWidth="60">
						<aos:combobox id="id_taskFileType" fieldLabel="文件类型" dicField="task_file_type" allowBlank="false" />
						<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="60" allowBlank="false"/>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="create_excel_win_save" text="上传" icon="ok.png" />
						<aos:dockeditem onclick="#create_excel_win.hide();" text="关闭" icon="close.png" />
					</aos:docked>
				</aos:window>
			</aos:gridpanel>
		</aos:tab>
	</aos:tabpanel>
</aos:fieldset>
<%-- <aos:fieldset columnWidth="1" collapsible="false"  title="任务描述">
    <aos:panel columnWidth="1" margin="5"  padding="5" contentEl="task_desc_div"/>
</aos:fieldset> --%>
<aos:fieldset columnWidth="1" collapsible="false"  title="备注">
	<aos:panel columnWidth="0.8" margin="5"   padding="5" contentEl="task_remark_div"/>
</aos:fieldset>

<%-- 通过这个弹窗表单演示再查询一次DB加载数据的方法 --%>
<aos:window id="w_user" title="部门人员详情（双击）" width="1000" height="500" layout="border" onshow="w_user_onshow">
	<aos:gridpanel hidePagebar="true" id="g_aosuser" url="taskService.taskHandlerUserPage" onitemdblclick="add_contract_grid" width="450" onrender="g_user_query" region="west" >
			<aos:docked forceBoder="0 0 1 0">
		    	<aos:triggerfield emptyText="姓名" id="id_name" onenterkey="g_user_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_user_query" width="180" />
	        	<aos:combobox id="search_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
					url="filesManageService.listPrincipalOrg" emptyText="部门查询" onselect="fn_org"/>
	        </aos:docked> 
			<aos:selmodel type="row" mode="multi" />
			<aos:column type="rowno" width="30"/>
			<aos:column header="姓名" dataIndex="user_name" width="80"/>
			<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
			<aos:column header="所属组织" dataIndex="org_name" width="120" />
			<aos:column header="所属角色" dataIndex="role_name"  width="120" />
			<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
			<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80"  hidden="true"/>
			<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80" hidden="true" />
	</aos:gridpanel>
	<aos:gridpanel id="g_aosuser_corp"   hidePagebar="true" url="taskService.taskHandlerUsersPage" onitemdblclick="del_contract_grid" onrender="g_user_query_corp"  width="450" region="center" >
			<aos:docked forceBoder="0 0 1 0"   >
				<aos:checkbox boxLabel="常用联系人" id="id_top" onchange="g_aosuser_corp_query"  checked="false" value="false"/>
		    </aos:docked>
			<aos:selmodel type="row" mode="multi" />
			<aos:column type="rowno" width="30"/>
			<aos:column header="姓名" dataIndex="user_name" width="80"/>
			<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
			<aos:column header="所属组织" dataIndex="org_name" width="120" />
			<aos:column header="所属角色" dataIndex="role_name"  width="120" />
			<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
			<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80" hidden="true"/>
			<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="1000"  hidden="true"/>
	</aos:gridpanel>
	<aos:gridpanel id="top_grid" hidePagebar="true" width="450" url="taskService.topContactsPage" onitemdblclick="top_contract_grid" region="west" onrender="top_grid_query">
			<aos:docked forceBoder="0 0 1 0">
				<aos:triggerfield emptyText="常用联系人姓名查询" onenterkey="top_user_query" id="top_user_name" trigger1Cls="x-form-search-trigger" onTrigger1Click="top_user_query" width="180" />
	        	<aos:combobox id="top_principal_org" name="subordinate_departments" editable="false" width="150" queryMode="local" 
					url="filesManageService.listPrincipalOrg" emptyText="常用联系人部门查询" onselect="top_org"/>
	        </aos:docked> 
			<aos:selmodel type="row" mode="multi" />
			<aos:column type="rowno" width="30"/>
			<aos:column header="姓名" dataIndex="user_name" width="80"/>
			<aos:column header="id" dataIndex="id" width="80" hidden="true"/>
			<aos:column header="所属组织" dataIndex="org_name" width="120" />
			<aos:column header="所属角色" dataIndex="role_name"  width="120" />
			<aos:column header="性别" dataIndex="sex" rendererFn="fn_sex" width="40" />
			<aos:column header="用户状态" dataIndex="status" rendererFn="fn_status" width="80"  hidden="true"/>
			<aos:column header="用户类型" dataIndex="type" rendererFn="fn_type" width="80" hidden="true" />
	</aos:gridpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="personnel_save()" text="保存数据" icon="ok.png" />
		<aos:dockeditem onclick="#w_user.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

<aos:window id="w_stand_find" title="模块树[双击选择]" height="-60" layout="fit" autoScroll="true">
	<aos:treepanel id="t_stand_find" singleClick="false" width="320" bodyBorder="0 0 0 0" url="projTypesService.getModuleDivideTreeData" rootVisible="false" onitemdblclick="t_org_find_select" />
</aos:window>

<aos:window id="w_group_find" title="WBS模块树[双击选择]" height="-60" layout="fit" autoScroll="true">
	<aos:treepanel id="t_group_find" singleClick="false" width="320" bodyBorder="0 0 0 0" url="taskGroupService.treeData" rootVisible="true" rootText="WBS" onitemdblclick="t_org_group_select" />
</aos:window>
<script>

//设置实际消耗天数的只读属性

/* //弹出选择上级模块窗口
function task_handler_user_id_change() {
	
	console.log("111111111111");
	var me = AOS.get('task_handler_user_id'),
	picker=me.getPicker(),
	values = me.getRawValue().split(","),
	last_select_value=values[values.length-1];
	
	me.suspendEvents(true);
	if(null!=last_select_value||""!=last_select_value|| undefined !=last_select_value){
		me.doQuery(last_select_value, false, true);
	}
	me.resumeEvents();
	return false;
}  */


//弹出选择上级模块窗口
function stand_tree_show() {
	var proj_id = AOS.get('id_proj_id').getValue();
	 t_stand_find_store.load({
		 params:{
			 proj_id:proj_id
		 }
	 });
	w_stand_find.show();
}

//上级模块树节点双击事件
function t_org_find_select() {
	var record = AOS.selectone(t_stand_find);
	if(record.raw.parentId=='0'){
		 AOS.tip("请勿选择项目根节点作为关联模块.");
		 return;
		}
	AOS.setValue('module_name',record.raw.text);
	AOS.setValue('module_id',record.raw.id);
	w_stand_find.hide();
}
//刷新上级模块树
function t_org_find_refresh() {
	
	var proj_id = AOS.get('id_proj_id').getValue();
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

//弹出选择上级模块窗口
function group_tree_show() {
	var proj_id = AOS.get('id_proj_id').getValue();
	 t_group_find_store.load({
		 params:{
			 proj_id:proj_id
		 }
	 });
	 w_group_find.show();
}

//上级模块树节点双击事件
function t_org_group_select() {
	var record = AOS.selectone(t_group_find);
	AOS.setValue('group_name_all',record.raw.text);
	AOS.setValue('group_name_all_id',record.raw.id);
	w_group_find.hide();
}

/**计划天数改变事件响应*/

	/**计划天数改变事件响应*/
 	 function on_task_plan_wastage_change(field){
		console.log("field="+field);
//  		var begin_date=AOS.getValue('task_create_form.plan_begin_time');
//  		var end_date=AOS.getValue('task_create_form.plan_end_time');
		var begin_date=AOS.getValue('task_create_form.plan_begin_time');
 		var end_date=AOS.getValue('task_create_form.plan_end_time');
 		if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
 			  AOS.setValue('task_create_form.plan_begin_time',null);
 			  AOS.tip("结束时间不能小于开始时间,请重新选择!");
 			  return;
 		}
 		
		var plan_begin_time=field.up("form").down("datetimefield[name=plan_begin_time]");
		var plan_end_time=field.up("form").down("datetimefield[name=plan_end_time]");
		var plan_wastage=field.up("form").down("numberfield[name=plan_wastage]");
		
		var plan_begin_time_value=AOS.empty(plan_begin_time.getValue())? new Date():plan_begin_time.getValue();
		var plan_end_time_value=AOS.empty(plan_end_time.getValue())? new Date():plan_end_time.getValue();
		var plan_wastage_value=plan_wastage.getValue();
		var plan_wastage_value=plan_wastage.getValue();  
		
		var plan_begin_time_value_hours = plan_begin_time_value.getHours();
		var plan_end_time_value_hours = plan_end_time_value.getHours();
		
		plan_begin_time_value = Ext.Date.format(plan_begin_time_value, "Y-m-d");
		plan_end_time_value = Ext.Date.format(plan_end_time_value, "Y-m-d");
	 	var day = Ext.Date.getElapsed(new Date(plan_begin_time_value),new Date(plan_end_time_value))/(24*60*60*1000);
	
		if(plan_begin_time_value_hours <=12 && plan_end_time_value_hours <=12 ){
			day = day + 0.5;
		}else if(plan_begin_time_value_hours <=12 && plan_end_time_value_hours >12){
			day = day +1;
		}else if(plan_begin_time_value_hours >12 && plan_end_time_value_hours >12){
	        day = day +0.5;
		}
		if(day<0.5 ){
			day = 0.5;
		}
		plan_wastage.setValue(day);
	}
	
	//弹出选择角色窗口
	function w_account_find_show() {
		w_user.show();
	}
	
	//组件显示的时候调用
    function  w_user_onshow(){
    	var proj_id = AOS.get('id_proj_id').getValue();
    	var id = AOS.getValue('task_view_form.handler_user_id');
    	var params = AOS.getValue('id_name');
   		g_aosuser_corp_store.getProxy().extraParams = {
   			id : id,
   			proj_id : proj_id
		};
		g_aosuser_corp_store.loadPage(1);
  		g_aosuser_store.getProxy().extraParams = {
  			id_name:params,
  			id:id,
  			proj_id : proj_id
		};
		g_aosuser_store.loadPage(1);
		top_grid_store.getProxy().extraParams = {
			 top_name : params,
			 proj_id : proj_id,
			 user_id : id
		 };
		 top_grid_store.loadPage(1);
    }
	
	//添加选中的单条grid
	function add_contract_grid(me, record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid1Records = grid1.data.items;
		var grid2 = AOS.get('g_aosuser').store;
		var flag = true;
		Ext.each(grid1Records, function (grid1Record) {
			if(grid1Record.data.id == record.data.id){
				AOS.tip("该人员已存在，请勿重复添加!");
				flag = false;
				return;
			}
	    });
		if(flag){
			grid1.add(record);
			grid2.remove(record);
		}
	}
  
	//添加选中的常用联系人
	function top_contract_grid(me,record){
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid1Records = grid1.data.items;
		var grid3 = AOS.get('top_grid').store;
		var flag = true;
		Ext.each(grid1Records, function (grid1Record) {
			if(grid1Record.data.id == record.data.id){
				AOS.tip("该人员已存在，请勿重复添加!");
				flag = false;
				return;
			}
	    });
		if(flag){
			grid1.add(record);
			grid3.remove(record);
		}
	}
	
	//删除某条数据
	function del_contract_grid(me,record){
		var id_top = AOS.getValue('id_top');
		var grid1 = AOS.get('g_aosuser_corp').store;
		var grid2 = AOS.get('g_aosuser').store;
		var grid3 = AOS.get('top_grid').store;
		if(id_top == true){
			grid1.remove(record);
			grid3.add(record);
		}else{
			grid1.remove(record);
			grid2.add(record);
		}
	}
	
 	//人员信息表信息
	function g_user_query(){
		var proj_id = AOS.get('id_proj_id').getValue();
		var id_name = AOS.getValue('id_name');
		var search_principal_org = AOS.getValue('search_principal_org');
		g_aosuser_store.getProxy().extraParams = {id_name:id_name,subordinate_departments:search_principal_org,proj_id:proj_id};
		g_aosuser_store.loadPage(1);
	}
 	
	//常用联系人组键
	function g_aosuser_corp_query(){
		var id_top = AOS.getValue('id_top');
		if(id_top == true){
			g_aosuser.hide();
			top_grid.show();
			top_grid_store.reload();
		}else{
			g_aosuser.show();
			top_grid.hide();
		}
	}
	
	//人员信息表信息
	function fn_org(){
		var proj_id = AOS.get('id_proj_id').getValue();
		var id_name = AOS.getValue('id_name');
		var search_principal_org = AOS.getValue('search_principal_org');
		g_aosuser_store.getProxy().extraParams = {id_name:id_name,subordinate_departments:search_principal_org,proj_id:proj_id};
		g_aosuser_store.loadPage(1);
	}
	
	//临时窗口
	function g_user_query_corp(){
		var id = AOS.getValue('task_view_form.handler_user_id');
		g_aosuser_corp_query();
		g_aosuser_corp_store.getProxy().extraParams = {id:id}
		g_aosuser_corp_store.loadPage(1);
   }
	
	//常用联系人表刷新
	function top_grid_query(){
		var top_user_name = AOS.getValue('top_user_name');
		 var top_principal_org = AOS.getValue('top_principal_org');
		 var id = AOS.getValue('task_create_form.handler_user_id');
		 top_grid_store.getProxy().extraParams = {
			 top_name : top_user_name,
			 top_org_name_id : top_principal_org,
			 user_id : id
		 };
		 top_grid_store.loadPage(1);
	}
	
	//常用联系人信息查询
	 function top_user_query(){
		 var proj_id = AOS.get('id_proj_id').getValue();
		 var top_user_name = AOS.getValue('top_user_name');
		 var top_principal_org = AOS.getValue('top_principal_org');
		 var id = AOS.getValue('task_create_form.handler_user_id');
		 top_grid_store.getProxy().extraParams = {
			 top_name : top_user_name,
			 top_org_name_id : top_principal_org,
			 user_id : id,
			 proj_id : proj_id
		 };
		 top_grid_store.loadPage(1);
	 }
	
	//常用联系人部门查询
	function top_org(){
		 var proj_id = AOS.get('id_proj_id').getValue();
		 var top_user_name = AOS.getValue('top_user_name');
		 var top_principal_org = AOS.getValue('top_principal_org');
		 var id = AOS.getValue('task_create_form.handler_user_id');
		 top_grid_store.getProxy().extraParams = {
			 top_name : top_user_name,
			 top_org_name_id : top_principal_org,
			 user_id : id,
			 proj_id : proj_id
		 };
		 top_grid_store.loadPage(1);
	}
	
	//用户名称保存
    function personnel_save(){
    	g_aosuser_corp.getSelectionModel().selectAll();
    	var select=AOS.selection(g_aosuser_corp,'id');
    	var user_name=AOS.selection(g_aosuser_corp,'user_name');
    	console.log(AOS.mr(g_aosuser_corp));
    	var attende_id=select.split(",");
    	var user_name_=user_name.split(",");
    	var attende_id_=[];
    	var user_name_p=[];
    	Ext.each(attende_id,function(item){
    		if(!AOS.empty(item)){
    			attende_id_.push(Number(item));
    		};
    	});
    	Ext.each(user_name_,function(item){
    		if(!AOS.empty(item)){
    			user_name_p.push(item);
    		};
    	});
    	AOS.setValue('task_create_form.handler_user_id',attende_id_);
    	AOS.setValue('task_create_form.handler_user_name',user_name_p);
    	AOS.setValue('task_view_form.handler_user_id',attende_id_);
    	AOS.setValue('task_view_form.handler_user_name',user_name_p);
    	w_user.hide();
    }
	
	//性别值转换
	function fn_sex(value, metaData, record, rowIndex, colIndex,
			store) {
		if(value=='1'){
			value='男'
		}
		if(value=='2'){
			value='女'
		}
		if(value=='3'){
			value='未知'
		}
		return value
	}
	
	//文件类型查询
	function taskFiletype_query() {
		var temp_task_id = AOS.getValue('task_create_form.temp_task_id');
<%-- 		var task_id = '<%=request.getAttribute("task_id") %>'; --%>
	    var proj_id = '<%=request.getAttribute("proj_id") %>';
		if(AOS.empty(temp_task_id)){ 
			return; 
		}
		var params = { 
			proj_id : proj_id,
			temp_task_id : temp_task_id
		};
		temp_taskFileUpload_grid_store.getProxy().extraParams = params;
		temp_taskFileUpload_grid_store.loadPage(1);
	}
	
	//显示上传文件窗口
	function show_excel_win(){
		temp_excel_win.show();
	}
	
	//删除选中的文件
	function file_grid_del(){
		var selection = AOS.selection(temp_taskFileUpload_grid, 'create_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据!');
			return;
		}
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var record = AOS.selectone(temp_taskFileUpload_grid);
		var rows = AOS.rows(temp_taskFileUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'taskFileUploadTempService.delete',
				params:{
					temp_file_id: selection,
					create_user_id:record.data.create_user_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					temp_taskFileUpload_grid_store.reload();
					var token=data.appmsg;
					var proj_id = '';//id_proj_name.getValue();
					var file_type = '';//record.data.file_title;
					var count="{\"proj_id\":\""+proj_id+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}删除"
						+file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
					var title="项目过程文档"; 
					var projid = proj_id;
					mesVO={
						"title"  : title, 
						"content": count,
						"extras": {proj_id,proj_name,createTime,sedTime},
						"mesGroup": "CHANNEL",
					}
					AOS.weekSend(token,mesVO);
				}
			});
		});
	}
	 
	//文件上传
	function excel_win_save(){
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var filenPath = AOS.getValue('temp_excel_win_form.excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
			return;
	    }
		//文件类型
		var task_file_type = id_create_taskFileType.getValue();
		var temp_task_id = AOS.getValue('task_create_form.temp_task_id');
	    var proj_id = '<%=request.getAttribute("proj_id") %>';
	    var params = {
	    		task_file_type : task_file_type,
				temp_task_id : temp_task_id,
				proj_id : proj_id
			};
	    temp_excel_win_form.getForm().fileUpload = true;
	    temp_excel_win_form.getForm().encoding="multipart/form-data";
	    temp_excel_win_form.getForm().submit({
    		type : 'POST', 
			url:'do.jhtml?router=taskFileUploadService.importFile&juid=${juid}',
			waitMsg:'文件上传中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				temp_excel_win.hide(); 
				temp_taskFileUpload_grid_store.reload();
				var token=action.result.msg;
				var task_file_type = id_taskFileType.getRawValue();
				var count="{\"proj_id\":\""+proj_id+"\","+","+"\"content\":\""+"${user_name}上传"
					+task_file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
				var title="任务文件"; 
				var projid = proj_id;
				mesVO=   {
					"title"  : title, 
					 "content": count,
					 "extras": {proj_id,proj_name,createTime,sedTime},
					 "mesGroup": "CHANNEL",
				}
				AOS.weekSend(token,mesVO);
	    	},
			failure: function() {
				temp_excel_win.hide();
				AOS.tip("文件上传失败！");
			},
			params : params
		});
	}
	
	
	//文件类型查询
	function taskFiletype_create_query() {
		var task_id = '<%=request.getAttribute("task_id") %>';
	    var proj_id = '<%=request.getAttribute("proj_id") %>';
		if(AOS.empty(task_id)){ 
			return; 
		}
		var params = { 
			proj_id : proj_id,
			task_id : task_id
		};
		create_taskFileUpload_grid_store.getProxy().extraParams = params;
		create_taskFileUpload_grid_store.loadPage(1);
	}
	
	//显示上传文件窗口
	function create_show_excel_win(){
		create_excel_win.show();
	}
	
	//删除选中的文件
	function create_file_grid_del(){
		var selection = AOS.selection(create_taskFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据!');
			return;
		}
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var record = AOS.selectone(create_taskFileUpload_grid);
		var rows = AOS.rows(create_taskFileUpload_grid);
		var msg =  AOS.merge('确认要删除选中的{0}个信息吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'taskFileUploadService.delete',
				params:{
					file_id: selection,
					create_user_id:record.data.create_user_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					create_taskFileUpload_grid_store.reload();
					var token=data.appmsg;
					var proj_id = '';//id_proj_name.getValue();
					var file_type = '';//record.data.file_title;
					var count="{\"proj_id\":\""+proj_id+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}删除"
						+file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
					var title="项目过程文档"; 
					var projid = proj_id;
					mesVO={
						"title"  : title, 
						"content": count,
						"extras": {proj_id,proj_name,createTime,sedTime},
						"mesGroup": "CHANNEL",
					}
					AOS.weekSend(token,mesVO);
				}
			});
		});
	}
	
	//下载
	function create_g_acount_down(){
		var selection = AOS.selection(create_taskFileUpload_grid, 'file_id');
		console.log(selection);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(create_taskFileUpload_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
			return;
		}
		var file_path = AOS.selection(create_taskFileUpload_grid, 'file_path');
		var file_title = AOS.selection(create_taskFileUpload_grid, 'file_title');
		var file_id = AOS.selection(create_taskFileUpload_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		AOS.file('do.jhtml?router=taskFileUploadService.downloadFile&juid=${juid}&file_path='+file_path+'&file_title='+file_title+'&file_id='+file_id);
	}
	 
	//文件上传
	function create_excel_win_save(){
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var filenPath = AOS.getValue('create_excel_win_form.excel_file');
	    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
	    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip"&&fileExtension != ".txt"&&fileExtension != ".mpp"&&fileExtension != ".jpg"&&fileExtension != ".png")
	     {
			AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip、txt、mpp、jpg、png格式的');
			return;
	    }
		//文件类型
		var task_file_type = id_taskFileType.getValue();
		var task_id = '<%=request.getAttribute("task_id") %>';
	    var proj_id = '<%=request.getAttribute("proj_id") %>';
	    var params = {
	    		task_file_type : task_file_type,
				task_id : task_id,
				proj_id : proj_id
			};
	    create_excel_win_form.getForm().fileUpload = true;
	    create_excel_win_form.getForm().encoding="multipart/form-data";
	    create_excel_win_form.getForm().submit({
    		type : 'POST', 
			url:'do.jhtml?router=taskFileUploadService.importFileCreate&juid=${juid}',
			waitMsg:'文件上传中...',
			success: function(form, action) {
				AOS.tip(action.result.msg);
				create_excel_win.hide(); 
				create_taskFileUpload_grid_store.reload();
				var token=action.result.msg;
				var task_file_type = id_taskFileType.getRawValue();
				var count="{\"proj_id\":\""+proj_id+"\","+","+"\"content\":\""+"${user_name}上传"
					+task_file_type+"文档\","+"\"createTime\":\""+createTime+"\"}";
				var title="任务文件"; 
				var projid = proj_id;
				mesVO=   {
					"title"  : title, 
					 "content": count,
					 "extras": {proj_id,proj_name,createTime,sedTime},
					 "mesGroup": "CHANNEL",
				}
				AOS.weekSend(token,mesVO);
	    	},
			failure: function() {
				create_excel_win.hide();
				AOS.tip("文件上传失败！");
			},
			params : params
		});
	}
</script>
