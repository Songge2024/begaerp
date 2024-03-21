<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="person_week_report" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="person_query"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield name="account_number_name" fieldLabel="成员姓名" columnWidth="0.2" onenterkey="person_work_query"/>
			<aos:hiddenfield name="user_id" fieldLabel="人员ID" value='${id}' />
			<aos:combobox fieldLabel="日期" id="id_main_time" name="main_time"
				columnWidth="0.15" margin="0 10 0 10" onselect="fn_change" value="0">
				<aos:option value="0" display="上月" />
				<aos:option value="1" display="本周" />
				<aos:option value="2" display="本月" />
				<aos:option value="3" display="本年" />
				<aos:option value="4" display="当天" />
			</aos:combobox>
			<%-- <aos:combobox id="search_principal_org" fieldLabel="负责人部门"  name="subordinate_departments" 
					editable="false" columnWidth="0.33" queryMode="local" width="100" onselect="fn_org" value='${principal_org}'>
					<aos:option value="-1" display="图元科技" />
					<aos:option value="1278" display="研发部" />
					<aos:option value="8998" display="质量管理部" />
					<aos:option value="9091" display="工程部" />
					<aos:option value="9117" display="QA" />
					<aos:option value="10541" display="售后服务部" />
					<aos:option value="17251" display="其他" />
			</aos:combobox> --%>
			<aos:hiddenfield name="subordinate_departments_id" fieldLabel="负责人部门ID"/>
			<aos:triggerfield id="search_principal_org" fieldLabel="负责人部门" 
				name="subordinate_departments" allowBlank="false" editable="false" 
				trigger1Cls="x-form-search-trigger" onTrigger1Click="fn_org" columnWidth="0.33" value='${principal_org_name}'/>
			<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
				format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
			<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d "
				columnWidth="0.14" editable="false" margin="0 0 0 0" />
				
			<aos:dockeditem xtype="button" text="查询" onclick="person_work_query"
				icon="query.png" margin="0 5 0 10" />
			<aos:dockeditem xtype="button" text="重置"
				onclick="AOS.reset(person_query);" icon="refresh.png"  margin="0 5 0 5" />
		</aos:formpanel>
		
		<aos:window id="w_stand_find"  title="负责人部门" height="-60" layout="fit"  width="320" autoScroll="true"  >
			<aos:treepanel 
				id="idTree2" 
				flex="1" 
				singleClick="false" 
				cascade="false" 
				rootVisible="false"
 				url="personWorkloadStatisticsService.getTreeData" 
 				margin="5" 
 				border="true" 
			/> 
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="org_box_save" text="确认" icon="ok.png" />
				<aos:dockeditem onclick="#w_stand_find.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<!-- 列表窗口 -->
		<aos:gridpanel id="person_work_grid"  autoScroll="true" hidePagebar="true"  url="personWorkloadStatisticsService.personWorkloadReportListPage"
					forceFit="false" onrender="person_work_query_onerad"  onitemdblclick="show_person_detail" features="summary" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="个人工作量汇总" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem xtype="button" text="全部导出" onclick="exportAll" icon="icon70.png" />
			</aos:docked>
			<aos:column type="rowno" width="40"/>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column header="成员id" dataIndex="handler_user_id"  width="240" align="center" hidden="true"/>
			<aos:column header="成员姓名" dataIndex="account_number_name" width="100" align="left"  celltip="true" summaryRenderer="function(){return '共 ' + summary.user_count + ' 人'}"/>
			<aos:column header="入职时间" dataIndex="entry_time" width="140" align="center" type="date" format="Y-m-d" />	
			<aos:column header="所属部门" dataIndex="subordinate_departments" width="120" align="left" />	
			<aos:column header="总计划工作量" dataIndex="total_planned_workload" width="120" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_ttotal_planned_workload + '人天'}"/>
			<aos:column header="总实际工作量" dataIndex="total_real_workload" width="120" align="right" rendererFn="fn_gzldw"  summaryRenderer="function(){return summary.sums_total_real_workload + '人天'}"/>
			<aos:column header="工作饱和率" dataIndex="working_saturation_rate" width="100" align="right" rendererFn="fn_gzbhl" />
			<aos:column header="任务数量" type="group">
				<aos:column header="计划工作量" dataIndex="task_plan_wastage" width="140" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_task_plan_wastage + '人天'}"/>
				<aos:column header="实际工作量" dataIndex="task_real_wastage" width="140" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_task_real_wastage + '人天'}"/>
				<aos:column header="已关闭工作量" dataIndex="task_ygb_real_wastage" width="150" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_task_ygb_real_wastage + '人天'}"/>
			</aos:column>
			<aos:column header="缺陷数量" type="group">
				<aos:column header="关闭工作量" dataIndex="bug_gb_real_wastage" width="140" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage+'人天'}"/>
			</aos:column>
			<aos:column header="会议数量" type="group">
				<aos:column header="总工作量" dataIndex="meeting_real_wastage" width="140" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_meeting_real_wastage+'人天'}"/>
				<aos:column header="已确认工作量" dataIndex="meeting_yzj_real_wastage"	width="140" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_meeting_yzj_real_wastage+'人天'}"/>
			</aos:column>
			<aos:column header="详情" rendererFn="person_detail"  align="center" width="130"/>
	    </aos:gridpanel>
		
		<!-- 工作详情窗口 -->
		<aos:window id="person_particulars" title="个人工作详情窗口" width="1200" height="550" autoScroll="true">
					<aos:tabpanel id="person_tabs2" plain="true">
						<aos:tab title="总任务详情" onshow="person_task_grid_query" id="per_task_gird">
							<aos:gridpanel id="person_task_grid"  forceFit="false" hidePagebar="true"  border="true" url="personWorkloadStatisticsService.taskPage" 
									onrender="person_task_grid_query" features="summary">
								<aos:column type="rowno" align="center" />
								<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
								<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
								<aos:column header="所属项目" dataIndex="proj_name" width="120" align="left" celltip="true"/>
								<aos:column header="任务名称" dataIndex="task_name" width="350" align="left" summaryRenderer="function(){return '共 ' +summary.sums_task_total+'条任务'}"/>
								<aos:column header="指派人" dataIndex="assign_user_name" width="55" align="center"/>
								<aos:column header="处理人" dataIndex="handler_user_name" width="55" align="center"/>
								<aos:column header="状态" dataIndex="state" width="55" rendererFn="render_state" />
								<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_query_plan_wastage+'人天'}"/>
								<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_query_real_wastage+'人天'}"/>
								<aos:column header="计划工作量" dataIndex="plan_wastage" width="95" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_plan_wastage+'人天'}"/>
								<aos:column header="实际工作量" dataIndex="real_wastage" width="95" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_real_wastage+'人天'}"/>
								<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
								<aos:column header="计划开始时间" dataIndex="plan_begin_time"
									type="date" width="120" format="Y-m-d h:m" align="center"/>
								<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
								<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
								<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
								
								<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="80"/>
								<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总缺陷详情" onshow="person_bug_grid_query" id="per_bug_grid">
							<aos:gridpanel id="person_bug_grid" url="personWorkloadStatisticsService.bugPage" hidePagebar="true" forceFit="false"  border="true" 
									onrender="person_bug_grid_query" features="summary">
								<aos:column type="rowno" align="center" />
								<aos:column header="处理人" dataIndex="deal_man" width="80" align="center"  hidden="true"/>
								<aos:column header="当前处理人" dataIndex="deal_man_name" width="80" summaryRenderer="function(){return '共 ' +summary.sums_bug_count+'个bug'}"/>
<%-- 								<aos:column header="所属部门" dataIndex="subordinate_departments" width="100" align="center" /> --%>
								<aos:column header="所属项目" dataIndex="proj_name" width="120" align="left" celltip="true"/>
								<aos:column header="发现人" dataIndex="find_name" width="55" />
								<aos:column header="发现时间" dataIndex="find_time" width="150" />
								<aos:column header="BUG编号" dataIndex="bug_code" width="130" align="left" />
								<aos:column header="BUG名称" dataIndex="bug_name" width="350" align="left" />
								<aos:column header="当前状态" dataIndex="state" align="center" rendererFn="fn_bug_state" width="90"/>
								<aos:column header="实际消耗时间" dataIndex="bug_real_wastage" width="100" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_bug_real_wastage}"/>
								<aos:column header="关闭实际消耗时间" dataIndex="bug_gb_real_wastage" width="100" align="right" rendererFn="fn_gzldw" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage}"/>
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总会议详情" onshow="person_meeting_grid_query" id="per_meeting_grid">
							<aos:gridpanel id="person_meeting_grid" url="personWorkloadStatisticsService.managePage" hidePagebar="true" forceFit="false"  border="true" 
									onrender="person_meeting_grid_query" features="summary"> 
								<aos:column type="rowno" align="center"/>
								<aos:column header="发起人" dataIndex="initiator" width="80"
									align="left"/>
								<aos:column header="所属项目" dataIndex="proj_name" width="150"
									align="left" summaryRenderer="function(){return '共 ' +summary.sums_manage_total+'条会议'}"/>
								<aos:column header="会议编号" dataIndex="manage_code" width="130" align="center" />
								<aos:column header="会议主题" dataIndex="theme" width="200" align="left" celltip="true"/>
								<aos:column header="开始时间" dataIndex="begin_date" width="180" align="center"/>
								<aos:column header="结束时间" dataIndex="end_date" width="180" align="center"/>
								<aos:column header="用时" dataIndex="workload" width="50" align="right" summaryRenderer="function(){return summary.sums_workload}"/>
								<aos:column header="参与人(内)" dataIndex="attende_mans" width="180" celltip="true"/>
								<aos:column header="参与人(外)" dataIndex="attende_mans_out" width="180" celltip="true"/>
							</aos:gridpanel>
						</aos:tab>
						
					</aos:tabpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="#person_particulars.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
	</aos:viewport>
	<script type="text/javascript">
	
	//全部导出
	function exportAll(){
		var params = AOS.getValue('person_query');
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
		var plan_begin_time = params.plan_begin_time;
		if( plan_begin_time=== undefined){
			plan_begin_time = "";
		}
		var plan_end_time = params.plan_end_time;
		if( plan_end_time=== undefined){
			plan_end_time = "";
		}
		AOS.file('do.jhtml?router=personWorkloadStatisticsService.exportALLExcel&juid=${juid}&&account_number_name='+account_number_name
				+'&subordinate_departments_id='+subordinate_departments_id
				+'&plan_begin_time='+plan_begin_time
				+'&plan_end_time='+plan_end_time
				+'&start='+start
				+'&limit='+limit
			);	
	}
	
	//人天
	function fn_gzldw(value,maction,record){
	    if(value==0){
            return value;
         }else{
	        return value+"<span style=' font-size:5px; color:green;'>人天</span>";
        }
	}
	
	//人天
	function fn_gzbhl(value,maction,record){
	    if(value==0){
            return value;
         }else{
	        return value+"<span style=' font-size:5px; color:green;'>%</span>";
        }
	}
	
	//查询时间段改变
	function fn_change(obj) {
		var val = obj.getValue();
		var date_ = '${plan_begin_time}';
		var date1_ = '${plan_end_time}';
		var today_date_ = '${today_date}';
		var year_begin_date_ = '${year_begin_date}';
		var year_end_date_ = '${year_end_date}';
		var recently_begin_date_ = '${recently_begin_date}';
		var recently_end_date_ = '${recently_end_date}';
		var week_begin_date_ = '${week_begin_date}';
		var week_end_date_ = '${week_end_date}';
		var id = '${id}';
		if(val == "0"){
			AOS.setValue('person_query.plan_begin_time', recently_begin_date_);
			AOS.setValue('person_query.plan_end_time', recently_end_date_);
		}else if (val == "1") {
			AOS.setValue('person_query.plan_begin_time', week_begin_date_);
			AOS.setValue('person_query.plan_end_time', week_end_date_);
		} else if (val == "2") {
			AOS.setValue('person_query.plan_begin_time', date_);
			AOS.setValue('person_query.plan_end_time', date1_);
		} else if (val == "3") {
			AOS.setValue('person_query.plan_begin_time', year_begin_date_);
			AOS.setValue('person_query.plan_end_time', year_end_date_);
		} else if (val == "4") {
			AOS.setValue('person_query.plan_begin_time', today_date_);
			AOS.setValue('person_query.plan_end_time', today_date_);
	
		}
		AOS.setValue('person_query.user_id',id);
		var params = AOS.getValue('person_query');
		AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryPersonWorkloadReportSummary',
			ok : function(data) {
				summary = data;
				person_work_grid_store.getProxy().extraParams =params;
				person_work_grid_store.loadPage(1);
			}
		});
	}
	
	function person_detail(value, metaData, record) {
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" onclick="show_person_detail();" />';
	} 
	
	/* function person_detail(value, metaData, record){
 		if(value != 0) {
			return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" " />';
		}
		return value;
	}
	person_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e){
		var record = AOS.selectone(person_work_grid, true);
		if (columnIndex == 7 ) {
			var account_number_name = record.data.account_number_name;
			AOS.get("person_particulars").show();
			AOS.get("per_task_gird").show();
			AOS.get("per_bug_grid").show();
			AOS.get("per_meeting_grid").show();
		}
	}); */
	
	//查询条件、查询部门
	/* function fn_org(){
		person_work_query();
	} */
	
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
    	AOS.setValue('person_query.subordinate_departments',name_);
    	AOS.setValue('person_query.subordinate_departments_id',id_);
    	w_stand_find.hide();
	}
	
	//根据所属部门查询-项目工作量汇总表
	function person_work_query() {
		var params = AOS.getValue('person_query');
		var state=AOS.get('search_principal_org').getValue();
		AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryPersonWorkloadReportSummary',
			ok : function(data) {
				summary = data;
				person_work_grid_store.getProxy().extraParams =params;
				person_work_grid_store.loadPage(1);
			}
		});
	}
	
	//个人工作量汇总表
	function person_work_query_onerad() {
		AOS.setValue('person_query.plan_begin_time', '${recently_begin_date}');
		AOS.setValue('person_query.plan_end_time', '${recently_end_date}');
		AOS.setValue('person_query.subordinate_departments', '${principal_org_name}');
		AOS.setValue('person_query.subordinate_departments_id', '${principal_org_id}');
		var params = AOS.getValue('person_query');
		AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryPersonWorkloadReportSummary',
			ok : function(data) {
				summary = data;
				person_work_grid_store.getProxy().extraParams =params;
				person_work_grid_store.loadPage(1);
			}
		});
		
	}
	
	 //个人任务信息
    function person_task_grid_query(){
    	var record = AOS.select(person_work_grid,true)[0];
    	var params = new Object();
    	var params = AOS.getValue('person_query');
    	params.handler_user_id = record.data.handler_user_id;
    	AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryTaskWorkloadReportSummary',
			ok : function(data) {
				summary = data;
		    	person_task_grid_store.getProxy().extraParams = params;
		    	person_task_grid_store.loadPage(1);
			}
		});
    }
	 
  	//个人缺陷信息
    function person_bug_grid_query(){
    	var record = AOS.select(person_work_grid,true)[0];
    	var params = new Object();
    	var params = AOS.getValue('person_query');
    	params.handler_user_id = record.data.handler_user_id;
    	AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryBugWorkloadReportSummary',
			ok : function(data) {
				summary = data;
		    	person_bug_grid_store.getProxy().extraParams = params;
		    	person_bug_grid_store.loadPage(1);
			}
		});
    }
  	
  	//个人会议信息
    function person_meeting_grid_query(){
    	var record = AOS.select(person_work_grid,true)[0];
    	var params = new Object();
    	var params = AOS.getValue('person_query');
    	params.handler_user_id = record.data.handler_user_id;
    	AOS.ajax({
			wait : false, //防止出现2个遮罩层。(ajax和表格load)
			params : params,
			url : 'personWorkloadStatisticsService.queryManageWorkloadReportSummary',
			ok : function(data) {
				summary = data;
		    	person_meeting_grid_store.getProxy().extraParams = params;
		    	person_meeting_grid_store.loadPage(1);
			}
		});
    }
	 
  	//完成百分比
	function render_percent(value){
		if(value)return value+"%";
		return "0%";
	}
  
	//状态颜色
	function render_state(value){
		if(value=='1002')return '<span style="color:green;">已发布</span>'
		if(value=='1003')return '<span style="color:blue;">已接收</span>'
		if(value=='1004')return '<span style="color:red;">已完成</span>'
		if(value=='1005')return '<span style="color:gray;">已关闭</span>'
		if(value=='1007')return '<span style="color:#FF00FF;font-weight:bold;">已暂停</span>'
		return "草稿";
	}
	//当前状态
	function fn_bug_state(value, metaData, record){
		if(value =='1000'){
			return "<span style='color:#FF1493; font-weight:bold'>未解决</span>"; 
		}else if(value == '1002'){
			return "<span style='color:blue; font-weight:bold'>延期处理</span>"; 
		}else if(value == '1004'){
			return "<span style='color:red; font-weight:bold'>拒绝</span>"; 
		}else if(value == '1001'){
			return "<span style='color:green; font-weight:bold'>已解决</span>"; 
		}else if(value == '1003'){
			return "<span style='font-weight:bold'>关闭</span>"; 
		}else if(value == '1005'){
			return "<span style='font-weight:bold'>重新打开</span>"; 
		}else if(value == '1006'){
			return "<span style='font-weight:bold'>无法复现</span>"; 
		}
	}
	</script>
</aos:onready>
<script type="text/javascript">
	//项目详情显示窗口
	function show_person_detail(){
		AOS.get("person_particulars").show();
		AOS.get("per_bug_grid").show();
		AOS.get("per_meeting_grid").show();
		AOS.get("per_task_gird").show();
	}
</script>
