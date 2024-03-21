<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="../../public/public_method.jsp"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
//过滤项目id  如果需要过滤，请在主页面设置 pageContext.setAttribute("win_proj_id", "1");
		if(AOSUtils.isEmpty(pageContext.getAttribute("win_proj_id"))){
		    pageContext.setAttribute("win_proj_id", "");
		};
%>
<aos:html title="需求跟踪" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

	<aos:onready>
	<aos:viewport layout="fit">
	<aos:panel border="false">
			<aos:docked forceBoder="1 0 1 0">
			<aos:dockeditem xtype="tbtext" text="选择项目:" />
			<aos:dockeditem xtype="tbseparator" />
			<%-- <aos:combobox  id="query_form" dicField="proj_name" emptyText="选择项目"  margin="0 5 0 0"
				onchange="demandAction_change_query"	selectAll="true" width="180" allowBlank="false" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
					/> --%>
			<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="250" />
			<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			<aos:combobox fieldLabel="所属模块" name="dm_name" id="dm_first_code" columnWidth="0.3" labelWidth="60" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true" url="demandActionService.listModuleDivideComboBox" onchange="demandAction_change_query"/>
			<aos:textfield fieldLabel="需求名称" name="ad_name" id="ad_name_query" columnWidth="0.3" labelWidth="60" onenterkey="demandAction_change_query" width="300"/>
			<aos:dockeditem text="查询" icon="search.png" onclick="demandAction_change_query" />
			<aos:dockeditem text="重置"   icon="refresh.png" onclick="demandAction_change_reset"/>
			</aos:docked>
			<aos:gridpanel id="demandAction_grid" url="demandActionService.listMutiModelDemandState">
			<aos:column id="id_demand" header="需求" type="group" >
		    <aos:selmodel type="checkbox" mode="multi" />
		    <aos:column type="rowno" header="序号" align="center" width="40"/>
			<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
			<aos:column header="需求id" dataIndex="ad_id" hidden="true" />
			<aos:column header="需求code" dataIndex="ad_code" hidden="true" />
			<aos:column header="需求名称" dataIndex="ad_name" celltip="true" width="530"/>
			<aos:column header="所属模块"   dataIndex="dm_name" celltip="true" width="110"/>
			<aos:column header="需求类型" dataIndex="ad_type" rendererField="ad_type_id" />
			</aos:column>
				<aos:column id="id_design" header="设计" type="group">
			<aos:column header="项目id" dataIndex="proj_id"   hidden="true" />
			<aos:column header="任务id" dataIndex="task_id"   hidden="true" />
			<aos:column header="需求id" dataIndex="sj_demand_id"   hidden="true" />
			<aos:column header="任务类型" dataIndex="sj_task_type" hidden="true"  rendererField="task_type"/>
			<aos:column header="任务名称" dataIndex="task_name"  hidden="true" /> 
			<aos:column header="工作量(天)" dataIndex="sj_ts"  fixedWidth="90" align="center"/>
			<aos:column header="完成情况" dataIndex="sj_completion"  fixedWidth="90" align="center"/>
			<aos:column header="操作" dataIndex="sj_operation"  rendererFn="fn_button_render_sj" fixedWidth="60"/>
			</aos:column>
			<aos:column id="id_code" header="编码" type="group">
			<aos:column header="项目id" dataIndex="proj_id"   hidden="true" />
			<aos:column header="任务id" dataIndex="task_id"   hidden="true" />
			<aos:column header="需求id" dataIndex="bm_demand_id"   hidden="true" />
			<aos:column header="任务类型" dataIndex="bm_task_type" hidden="true" rendererField="task_type"/>
			<aos:column header="任务名称" dataIndex="task_name"  hidden="true" /> 
			<aos:column header="工作量(天)" dataIndex="bm_ts"   fixedWidth="90" align="center"/>
			<aos:column header="完成情况" dataIndex="bm_completion"  fixedWidth="90"/>
			<aos:column header="操作" dataIndex="bm_operation"  rendererFn="fn_button_render_bm" fixedWidth="60"/>
			</aos:column>
			<aos:column id="id_test" header="测试" type="group"  >
			<aos:column header="任务id" dataIndex="task_id"   hidden="true" />
			<aos:column header="需求id" dataIndex="cs_demand_id"   hidden="true" />
			<aos:column header="任务类型" dataIndex="cs_task_type" hidden="true" rendererField="task_type"/>
			<aos:column header="任务名称" dataIndex="task_name"  hidden="true" /> 
			<aos:column header="工作量(天)" dataIndex="cs_ts" fixedWidth="90" align="center" />
			<aos:column header="完成情况" dataIndex="cs_completion"  fixedWidth="90" align="center"/>
			<aos:column header="操作" dataIndex="cs_operation" fixedWidth="60" rendererFn="fn_button_render_cs" />
			</aos:column>
			<aos:column id="id_others" header="其他" type="group"  >
			<aos:column header="任务id" dataIndex="task_id"   hidden="true" />
			<aos:column header="需求id" dataIndex="qt_demand_id"   hidden="true" />
			<aos:column header="任务类型" dataIndex="qt_task_type" hidden="true" rendererField="task_type"/>
			<aos:column header="任务名称" dataIndex="task_name"  hidden="true" /> 
			<aos:column header="工作量(天)" dataIndex="qt_ts" fixedWidth="90" align="center" />
			<aos:column header="完成情况" dataIndex="qt_completion"  fixedWidth="90" align="center"/>
			<aos:column header="操作" dataIndex="qt_operation" fixedWidth="60" rendererFn="fn_button_render_qt" />
			</aos:column>
			</aos:gridpanel>
		</aos:panel>
	</aos:viewport>
	<aos:window id="demand_detail_win"  title="需求详情页面" >
<aos:gridpanel autoScroll="true"  forceFit="false"   id="demandAction_detail_grid" width="1030" height="400"  url="demandActionService.listDetailDemandData" 
				border="true" >
		    <aos:selmodel type="checkbox" mode="multi" />
		    <aos:column type="rowno" header="序号" align="center"/>
		    <aos:column header="分组编码" dataIndex="group_id"  hidden="true"/>
		    <aos:column header="状态名称" dataIndex="state_name"  hidden="true"/>
		    <aos:column header="类型名称" dataIndex="task_type_name"  hidden="true"/>
		    <aos:column header="等级名称" dataIndex="task_level_name"  hidden="true"/>
			<aos:column header="编码" dataIndex="task_id" hidden="true"/>
			<aos:column header="编码" dataIndex="task_code"  hidden="true"/>
			<aos:column header="任务名称" dataIndex="task_name" fixedWidth="140"/>
			<aos:column header="状态" dataIndex="state"  fixedWidth="60" rendererFn="render_state"/>
			<aos:column header="类型" dataIndex="task_type" align="center" fixedWidth="60" rendererField="task_type"/>
			<aos:column header="计划开始时间" dataIndex="plan_begin_time" fixedWidth="140" />
			<aos:column header="计划完成时间" dataIndex="plan_end_time" fixedWidth="140"/>
			<aos:column header="计划天数" dataIndex="plan_wastage"  align="center" fixedWidth="80"/>
			<aos:column header="实际天数" dataIndex="real_wastage"   align="center" fixedWidth="80"  rendererFn="fn_real_wastage"  />
			<aos:column header="实际开始时间" dataIndex="real_begin_time" fixedWidth="140"/>
			<aos:column header="实际完成时间" dataIndex="real_end_time" fixedWidth="140" />
			<aos:column header="指派人" dataIndex="assign_user_id"  hidden="true"/>
			<aos:column header="处理人" dataIndex="handler_user_id"  hidden="true"/>
			<aos:column header="等级" dataIndex="task_level"  rendererField="task_level" align="center" />
			<aos:column header="项目" dataIndex="proj_id"   hidden="true"/>
			<aos:column header="模块" dataIndex="module_id"  hidden="true" />
			<aos:column header="需求" dataIndex="demand_id" hidden="true"/>
			<aos:column header="指派人" dataIndex="assign_user_name"  align="center"/>
			<aos:column header="处置人" dataIndex="handler_user_name"  align="center"/>
				</aos:gridpanel>
					<aos:docked dock="bottom" ui="footer" >
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem text="导出" icon="icon70.png" onclick="fn_export_excel();" />
			<aos:dockeditem onclick="#demand_detail_win.hide();"  text="关闭" icon="close.png" />
		</aos:docked>
				</aos:window>
				
			<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" layout="fit" autoScroll="true">
				<aos:docked forceBoder="0 0 0 0" >
					<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
					<aos:triggerfield  id="proj_name1" onenterkey="proj_name_query1" trigger1Cls="x-form-search-trigger"
							onTrigger1Click="proj_name_query1" width="150" />
				</aos:docked>
				<aos:treepanel id="t_org_find" singleClick="false" width="320" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
			</aos:window>
	<script type="text/javascript">
	
	//实际天数状态列渲染
	function fn_real_wastage(value, metaData, record){
		console.log(record);
		var plan_wastage=record.data.plan_wastage;
		if (value > plan_wastage) {
			  metaData.style = 'color:#CC0000';
		}
		if (value < plan_wastage) {
			  metaData.style = 'color:green';
		}
		
		return value;
    }
	
	function proj_name_query1(){
		var proj_name = AOS.getValue('proj_name1');
		t_org_find_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	
	//按钮列转换
	function fn_button_render_sj(value, metaData, record) {
//		return '<input type="button" value="设计详情" metaData.style = "color:blue" class="cbtn"  onclick="show_DesignDetail();" />';
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn"  onclick="show_DesignDetail();" />';
	}
	//按钮列转换
	function fn_button_render_bm(value, metaData, record) {
//		return '<input type="button" value="编码详情" metaData.style = "color:blue" class="cbtn"  onclick="show_CodeDetail();" />';
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn"  onclick="show_CodeDetail();" />';
	}
	//按钮列转换
	function fn_button_render_cs(value, metaData, record) {
//		return '<input type="button" value="测试详情" metaData.style = "color:blue" class="cbtn" onclick="show_TestDetail();"   />';
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" onclick="show_TestDetail();"   />';
	}
	//按钮列转换
	function fn_button_render_qt(value, metaData, record) {
// 		return '<input type="button" value="其他详情" metaData.style = "color:blue" class="cbtn" onclick="show_OtherDetail();"   />';
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" onclick="show_OtherDetail();"   />';
	}
	
	function demandAction_change_query(){
		 var params = {
					proj_id: id_proj_name.getValue(),
					sj_task_type:'1020',
					bm_task_type:'1030',
					cs_task_type:'1040',
					qt_task_type:'1090',
					ad_name: ad_name_query.getValue(),
					dm_first_code: dm_first_code.getValue()
			};
			demandAction_grid_store.getProxy().extraParams = params;
		    demandAction_grid_store.loadPage(1);
	 }
	
	function demandAction_change_reset() {
		dm_first_code.setValue('');
		ad_name_query.setValue('');
	}
	//状态颜色
	 function render_state(value){
	 	if(value=='1002')return '<span style="color:green;">已发布</span>'
	 	if(value=='1003')return '<span style="color:blue;">已接收</span>'
	 	if(value=='1004')return '<span style="color:red;">已完成</span>'
	 	if(value=='1005')return '<span style="color:gray;">已关闭</span>'
	 	return "草稿";
	 }
	//默认选中第一个项目
		window.onload = function combobox_select(){
			var value = id_proj_name.getValue();
			//AOS.get('query_form').setValue(value);
			demandAction_change_query();
		}
		//导出excel
		function fn_export_excel(){
			//juid需要再这个页面的初始化方法中赋值,这里才引用得到
			var record=AOS.selectone(demandAction_grid);
			var proj_id=id_proj_name.getValue();
			var detailCount= AOS.get('demandAction_detail_grid').store.totalCount;
			if(detailCount==0){
			AOS.tip("当前没有可以打印的数据");
				return;
			}else{
				var task_type=AOS.get('demandAction_detail_grid').store.data.items[0].data.task_type
				var demand_id=record.data.ad_id
			}
			AOS.file('do.jhtml?router=demandActionService.exportDemandExcel&juid=${juid}&task_type='+task_type+'&proj_id='+proj_id+'&demand_id='+demand_id);
		}
		//需求跟踪自动加载默认项目
		window.onload = function(){
		  var proj_id = '${proj_id}';
		  var proj_name = '${proj_name}';
    	  if(proj_id !=null && proj_id!=''){
    		AOS.setValue('id_proj_name',proj_id);
    		AOS.setValue('tree_proj_name',proj_name);
    		demandAction_change_query();
			}
    	  AOS.get('dm_first_code').getStore().getProxy().extraParams = {
			proj_id : id_proj_name.getValue()
		  };
    	  AOS.get('dm_first_code').getStore().load({
		  });
	}
		//需求跟踪单击选择项目
		function t_org_find_select() {
		  	var record = AOS.selectone(t_org_find);
		  	if(record.raw.a=="1"){
		  	AOS.setValue('id_proj_name',record.raw.id);
		  	AOS.setValue('tree_proj_name',record.raw.text);
		  	demandAction_change_query();
			w_org_find.hide();
			AOS.get('dm_first_code').getStore().getProxy().extraParams = {
				proj_id : id_proj_name.getValue()
			  };
	    	  AOS.get('dm_first_code').getStore().load({
			  });
		}else{
			AOS.tip("请选择项目!");
			return;
			//w_org_find.hide();
		}
		  }

		//弹出选择上级模块窗口
		  function proj_tree_show() {
		  	w_org_find.show();
		  }
</script>
</aos:onready>
<script type="text/javascript">
function show_DesignDetail(){
	var record = AOS.selectone(AOS.get('demandAction_grid'));
	var params = {
			proj_id: AOS.get('id_proj_name').getValue(),
			task_type:'1020',
			module_id:record.data.dm_code,
			demand_id:record.data.ad_id
	};
	AOS.get('demand_detail_win').show();
	AOS.get('demand_detail_win').setTitle("设计详细信息");
	AOS.get('demandAction_detail_grid').getStore().getProxy().extraParams = params;
	AOS.get('demandAction_detail_grid').getStore().loadPage(1);
}
function show_CodeDetail(){
	var record = AOS.selectone(AOS.get('demandAction_grid'));
	var params = {
			proj_id: AOS.get('id_proj_name').getValue(),
			task_type:'1030',
			module_id:record.data.dm_code,
			demand_id:record.data.ad_id
	};
	AOS.get('demand_detail_win').show();
	AOS.get('demand_detail_win').setTitle("编码详细信息");
	AOS.get('demandAction_detail_grid').getStore().getProxy().extraParams = params;
	AOS.get('demandAction_detail_grid').getStore().loadPage(1);
}
function show_TestDetail(){
	var record = AOS.selectone(AOS.get('demandAction_grid'));
	var params = {
			proj_id:AOS.get('id_proj_name').getValue(),
			task_type:'1040',
			module_id:record.data.dm_code,
			demand_id:record.data.ad_id
	};
	AOS.get('demand_detail_win').show();
	AOS.get('demand_detail_win').setTitle("测试详细信息");
	AOS.get('demandAction_detail_grid').getStore().getProxy().extraParams = params;
	AOS.get('demandAction_detail_grid').getStore().loadPage(1);
}
function show_OtherDetail(){
	var record = AOS.selectone(AOS.get('demandAction_grid'));
	var params = {
			proj_id: AOS.get('id_proj_name').getValue(),
			task_type:'1090',
			module_id:record.data.dm_code,
			demand_id:record.data.ad_id
	};
	AOS.get('demand_detail_win').show();
	AOS.get('demand_detail_win').setTitle("其他详细信息");
	AOS.get('demandAction_detail_grid').getStore().getProxy().extraParams = params;
	AOS.get('demandAction_detail_grid').getStore().loadPage(1);
}


</script>