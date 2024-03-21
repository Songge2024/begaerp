<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="aos.framework.web.router.HttpModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
// 	String juid = request.getAttribute("juid").toString();
// 	UserModel userModel = AOSCxt.getUserModel(juid);
// 	request.setAttribute("user", userModel);
// 	int userid = userModel.getId();
// 	String userName = userModel.getName();
// 	String orgName = userModel.getAosOrgPO().getName();
%>
<aos:html title="我的工作量" base="http" lib="ext">
<script type="text/javascript" src="monthPick.jsp"></script>
<aos:body>
	<div id="div_tips" class="x-hidden"
		style="line-height: 25px; margin-right: 10px; text-align: center;">
<%-- 		<h1>${user_name}（${org_name}） 个人工作量统计</h1> --%>
	</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:layout type="vbox" align="stretch" />
		<aos:panel>
			<aos:panel height="60" contentEl="div_tips" border="false">
		</aos:panel>
		</aos:panel>
		
		<aos:panel layout="fit">
			<aos:formpanel id="f_query" layout="column" labelWidth="70" header="false"  border="false">
				<aos:docked forceBoder="0 0 1 0">
					<aos:dockeditem xtype="tbtext" text="查询条件" />
				</aos:docked>
				<aos:textfield name="proj_name" fieldLabel="项目名称" columnWidth="0.25" />
				<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
					format="Y-m-d" columnWidth="0.18" editable="false" margin="0 0 0 0" />
				<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d"
					columnWidth="0.18" editable="false" margin="0 0 0 0" />
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem xtype="button" text="查询" onclick="proj_work_query"
					icon="query.png" />
				<aos:dockeditem xtype="button" text="重置"
					onclick="AOS.reset(f_query);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
			</aos:formpanel>
		</aos:panel>

		<aos:panel flex="1" layout="fit">
			<aos:gridpanel id="proj_work_grid"
				url="workloadReportService.queryPersonWorkloadReportList"
				hidePagebar="true" onrender="proj_work_query_onerad" features="summary" title="我的项目-工作量详情">
				
				<aos:column type="rowno" />
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
					align="left" locked="true" summaryRenderer="function(){return '总共 ' + summary.proj_count + ' 个项目'}" />
				<aos:column header="项目id" dataIndex="proj_id" hidden="true"
					fixedWidth="100" align="center" />
				<aos:column header="计划工作总量" dataIndex="total_plan_wastage"
					width="110" align="right" rendererFn="fn_jhgzl" locked="true" summaryRenderer="function(){return summary.sums_total_plan_wastage + '人天'}" />
				<aos:column header="实际工作总量" dataIndex="total_real_wastage"
					width="110" align="right" rendererFn="fn_jhgzl" locked="true" summaryRenderer="function(){return summary.sums_total_real_wastage + '人天'}" />
<%-- 				<aos:column header="需求数量" type="group"> --%>
<%-- 					<aos:column header="原始需求" dataIndex="demand_ys_count" width="80" --%>
<%-- 						align="right" rendererFn="fn_demand_bgcolor_render" /> --%>
<%-- 					<aos:column header="变更需求" dataIndex="demand_bg_count" width="80" --%>
<%-- 						align="right" rendererFn="fn_demand_bgcolor_render" /> --%>
<%-- 					<aos:column header="需求总数" dataIndex="demand_total_count" width="80" --%>
<%-- 						align="right" rendererFn="fn_demand_bgcolor_render" /> --%>
<%-- 				</aos:column> --%>
				<aos:column header="我的任务" type="group">
					<aos:column header="已发布" dataIndex="task_yfb_count" width="70"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_yfb_count}"/>
					<aos:column header="已接收" dataIndex="task_yjs_count" width="70"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_yjs_count}"/>
					<aos:column header="已完成" dataIndex="task_ywc_count" width="70"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_ywc_count}"/>
					<aos:column header="已关闭" dataIndex="task_ygb_count" width="70"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_ygb_count}"/>
					<aos:column header="已暂停" dataIndex="task_yzt_count" width="70"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_yzt_count}"/>
					<aos:column header="任务总数" dataIndex="task_total_count" width="80"
						align="right" rendererFn="fn_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_total_count}"/>
					<aos:column header="计划工作量" dataIndex="task_plan_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_plan_wastage + '人天'}"/>
					<aos:column header="实际工作量" dataIndex="task_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_real_wastage + '人天'}" />
					<aos:column header="已关闭工作量" dataIndex="task_ygb_real_wastage" width="100"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_ygb_real_wastage + '人天'}" />
				</aos:column>
				<aos:column header="我的缺陷" type="group">
					<aos:column header="未解决" dataIndex="bug_wjj_count" width="80"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_wjj_count}"/>
					<aos:column header="已解决" dataIndex="bug_yjj_count" width="80"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_yjj_count}"/>
					<aos:column header="延期处理" dataIndex="bug_yqcl_count" width="100"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_yqcl_count}"/>
					<aos:column header="已关闭" dataIndex="bug_gb_count" width="80"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_gb_count}"/>
					<aos:column header="拒绝" dataIndex="bug_jj_count" width="80"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_jj_count}"/>
					<aos:column header="重新打开" dataIndex="bug_cxdk_count" width="100"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_cxdk_count}"/>
					<aos:column header="无法复现" dataIndex="bug_wffx_count" width="100"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_wffx_count}"/>
					<aos:column header="缺陷总数" dataIndex="bug_total_count" width="80"
						align="right" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_total_count}"/>
					<%-- <aos:column header="实际工作量" dataIndex="bug_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" /> --%>
					<aos:column header="关闭工作量" dataIndex="bug_gb_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage+'人天'}"/>
				</aos:column>
				<aos:column header="我参加的会议" type="group">
<%-- 					<aos:column header="草稿" dataIndex="meeting_cg_count" width="80" --%>
<%-- 						align="right" rendererFn="fn_meeting_bgcolor_render" /> --%>
					<aos:column header="已发起" dataIndex="meeting_yfq_count" width="80"
						align="right" rendererFn="fn_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_yfq_count}"/>
					<aos:column header="已总结" dataIndex="meeting_yzj_count" width="80"
						align="right" rendererFn="fn_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_yzj_count}"/>
					<aos:column header="会议总数" dataIndex="meeting_total_count"
						width="80" align="right" rendererFn="fn_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_total_count}"/>
					<aos:column header="总工作量" dataIndex="meeting_real_wastage"
						width="90" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_real_wastage+'人天'}"/>
					<aos:column header="已确认工作量" dataIndex="meeting_yzj_real_wastage"
						width="120" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_yzj_real_wastage+'人天'}"/>
				</aos:column>
				<%-- <aos:column header="详情" fixedWidth="120" rendererFn="proj_"
					align="center" /> --%>
			</aos:gridpanel>
			</aos:panel>

	</aos:viewport>
	<script type="text/javascript">
		//人天
		function fn_jhgzl(value, metaData, record){
			//metaData.style = 'background: #F0FFFF;height:25px;margin-top:1px;margin-right:1px;';
		    if(value==0){
	            return value;
	         }else{
		        return "<b>"+value+"</b><span style='font-size:5px; color:green;'>人天</span>";
		
		  }
		}
		
		function fn_sums_jhgzl(value){
			//metaData.style = 'background: #F0FFFF;height:25px;margin-top:1px;margin-right:1px;';
		    if(value==0){
	            return value;
	         }else{
		        return "<b>"+value+"</b><span style='font-size:5px; color:green;'>人天</span>";
		
		  }
		}
		
		//单元格样式
		function fn_demand_bgcolor_render(value, metaData, record) {
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #F0FFF0;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//单元格样式
		function fn_task_bgcolor_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//单元格样式
		function fn_bug_bgcolor_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//单元格样式
		function fn_meeting_bgcolor_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		function proj_work_query_onerad() {
// 			AOS.setValue('f_query.plan_begin_time', '${plan_begin_time}');
// 			AOS.setValue('f_query.plan_end_time', '${plan_end_time}');
			var params = AOS.getValue('f_query');
			
			AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'workloadReportService.queryPersonWorkloadReportSummary',
				ok : function(data) {
					summary = data;
					proj_work_grid_store.getProxy().extraParams = params;
					proj_work_grid_store.loadPage(1);
				}
			});
		}
		
		//查询
		function proj_work_query() {
			var params = AOS.getValue('f_query');
			proj_work_grid_store.getProxy().extraParams = params;
			proj_work_grid_store.loadPage(1);
		}
	</script>
</aos:onready>