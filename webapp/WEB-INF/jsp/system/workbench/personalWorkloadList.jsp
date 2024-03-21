<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="aos.framework.web.router.HttpModel"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	int userid = userModel.getId();
	String userName = userModel.getName();
	String orgName = userModel.getAosOrgPO().getName();
%>
<aos:html title="我的工作量" base="http" lib="ext">
<script type="text/javascript" src="monthPick.jsp"></script>
<aos:body>
	<div id="div_tips" class="x-hidden"
		style="line-height: 25px; margin-right: 10px; text-align: center;">
		<h1>${user_name}（${org_name}） 个人工作量统计</h1>
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
			<aos:gridpanel id="proj_work_grid" url="workloadReportService.queryPersonWorkloadReportList"
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
						align="right" rendererFn="fn_task_yfb_render" summaryRenderer="function(){return summary.sums_task_yfb_count}"/>
					<aos:column header="已接收" dataIndex="task_yjs_count" width="70"
						align="right" rendererFn="fn_task_yjs_render" summaryRenderer="function(){return summary.sums_task_yjs_count}"/>
					<aos:column header="已完成" dataIndex="task_ywc_count" width="70"
						align="right" rendererFn="fn_task_ywc_render" summaryRenderer="function(){return summary.sums_task_ywc_count}"/>
					<aos:column header="已关闭" dataIndex="task_ygb_count" width="70"
						align="right" rendererFn="fn_task_ygb_render" summaryRenderer="function(){return summary.sums_task_ygb_count}"/>
					<aos:column header="已暂停" dataIndex="task_yzt_count" width="70"
						align="right" rendererFn="fn_task_yzt_render" summaryRenderer="function(){return summary.sums_task_yzt_count}"/>
					<aos:column header="任务总数" dataIndex="task_total_count" width="80"
						align="right" rendererFn="fn_task_total_render" summaryRenderer="function(){return summary.sums_task_total_count}"/>
					<aos:column header="计划工作量" dataIndex="task_plan_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_plan_wastage + '人天'}"/>
					<aos:column header="实际工作量" dataIndex="task_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_real_wastage + '人天'}" />
					<aos:column header="已关闭工作量" dataIndex="task_ygb_real_wastage" width="100"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_ygb_real_wastage + '人天'}" />
				</aos:column>
				<aos:column header="我的缺陷" type="group">
					<aos:column header="未解决" dataIndex="bug_wjj_count" width="80"
						align="right" rendererFn="fn_bug_wjj_render" summaryRenderer="function(){return summary.sums_bug_wjj_count}"/>
					<aos:column header="已解决" dataIndex="bug_yjj_count" width="80"
						align="right" rendererFn="fn_bug_yjj_render" summaryRenderer="function(){return summary.sums_bug_yjj_count}"/>
					<aos:column header="延期处理" dataIndex="bug_yqcl_count" width="100"
						align="right" rendererFn="fn_bug_yqcl_render" summaryRenderer="function(){return summary.sums_bug_yqcl_count}"/>
					<aos:column header="已关闭" dataIndex="bug_gb_count" width="80"
						align="right" rendererFn="fn_bug_gb_render" summaryRenderer="function(){return summary.sums_bug_gb_count}"/>
					<aos:column header="拒绝" dataIndex="bug_jj_count" width="80"
						align="right" rendererFn="fn_bug_jj_render" summaryRenderer="function(){return summary.sums_bug_jj_count}"/>
					<aos:column header="重新打开" dataIndex="bug_cxdk_count" width="100"
						align="right" rendererFn="fn_bug_cxdk_render" summaryRenderer="function(){return summary.sums_bug_cxdk_count}"/>
					<aos:column header="无法复现" dataIndex="bug_wffx_count" width="100"
						align="right" rendererFn="fn_bug_wffx_render" summaryRenderer="function(){return summary.sums_bug_wffx_count}"/>
					<aos:column header="缺陷总数" dataIndex="bug_total_count" width="80"
						align="right" rendererFn="fn_bug_total_render" summaryRenderer="function(){return summary.sums_bug_total_count}"/>
					<%-- <aos:column header="实际工作量" dataIndex="bug_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" /> --%>
					<aos:column header="关闭工作量" dataIndex="bug_gb_real_wastage" width="90"
						align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage+'人天'}"/>
				</aos:column>
				<aos:column header="我参加的会议" type="group">
<%-- 					<aos:column header="草稿" dataIndex="meeting_cg_count" width="80" --%>
<%-- 						align="right" rendererFn="fn_meeting_bgcolor_render" /> --%>
					<aos:column header="已发起" dataIndex="meeting_yfq_count" width="80"
						align="right" rendererFn="fn_meeting_yfq_render" summaryRenderer="function(){return summary.sums_meeting_yfq_count}"/>
					<aos:column header="已总结" dataIndex="meeting_yzj_count" width="80"
						align="right" rendererFn="fn_meeting_yzj_render" summaryRenderer="function(){return summary.sums_meeting_yzj_count}"/>
					<aos:column header="会议总数" dataIndex="meeting_total_count" width="80" 
						align="right" rendererFn="fn_meeting_total_render" summaryRenderer="function(){return summary.sums_meeting_total_count}"/>
					<aos:column header="总工作量" dataIndex="meeting_real_wastage"
						width="90" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_real_wastage+'人天'}"/>
					<aos:column header="已确认工作量" dataIndex="meeting_yzj_real_wastage"
						width="120" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_yzj_real_wastage+'人天'}"/>
				</aos:column>
				<%-- <aos:column header="详情" fixedWidth="120" rendererFn="proj_"
					align="center" /> --%>
			</aos:gridpanel>
			
			</aos:panel>
			<aos:window id="task_yfb_count_win" title="已发布任务详情" onshow="task_yfb_click">
						<aos:gridpanel id="task_yfb_count_grid" width="1400" height="600"
							url="workloadReportService.taskYfbPage" forceFit="false" onrender="task_yfb_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />						
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_yfb_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_yjs_count_win" title="已接收任务详情" onshow="task_yjs_click">
						<aos:gridpanel id="task_yjs_count_grid" width="1400" height="600"
							url="workloadReportService.taskYjsPage" forceFit="false" onrender="task_yjs_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_yjs_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_ywc_count_win" title="已完成任务详情" onshow="task_ywc_click">
						<aos:gridpanel id="task_ywc_count_grid" width="1400" height="600"
							url="workloadReportService.taskYwcPage" forceFit="false" onrender="task_ywc_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_ywc_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_ygb_count_win" title="已关闭任务详情" onshow="task_ygb_click">
						<aos:gridpanel id="task_ygb_count_grid" width="1400" height="600"
							url="workloadReportService.taskYgbPage" forceFit="false" onrender="task_ygb_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_ygb_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_yzt_count_win" title="已暂停任务详情" onshow="task_yzt_click">
						<aos:gridpanel id="task_yzt_count_grid" width="1400" height="600"
							url="workloadReportService.taskYztPage" forceFit="false" onrender="task_yzt_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_yzt_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_total_count_win" title="总任务详情" onshow="task_total_click">
						<aos:gridpanel id="task_total_count_grid" width="1400" height="600"
							url="workloadReportService.taskTotalPage" forceFit="false" onrender="task_total_count_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" width="200" hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" width="200" align="left" hidden="true"/>
							<aos:column header="任务编码" dataIndex="task_code" width="90" align="center" />
							<aos:column header="任务名称" dataIndex="task_name" width="200" align="left"/>
							<aos:column header="指派人" dataIndex="assign_user_name" width="80" align="center"/>
							<aos:column header="处理人" dataIndex="handler_user_name" width="80" align="center"/>
							<aos:column header="状态" dataIndex="state" width="90" rendererFn="render_state" />
							<aos:column header="本月内计划工作量" dataIndex="query_plan_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="本月内实际工作量" dataIndex="query_real_wastage" width="120" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="计划工作量" dataIndex="plan_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="实际工作量" dataIndex="real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
							<aos:column header="完成比例" dataIndex="percent" width="100" align="right"/>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date" width="120" format="Y-m-d h:m"/>
							<aos:column header="实际开始时间" dataIndex="real_begin_time" width="120" format="Y-m-d h:m" align="center"/>
							<aos:column header="实际结束时间" dataIndex="real_end_time" width="120" format="Y-m-d h:m" align="center"/>
							
							<aos:column header="任务类型" dataIndex="task_type" rendererField="task_type" width="100"/>
							<aos:column header="任务等级" dataIndex="task_level" width="100" rendererField="task_level" align="center"/>
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_total_count_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_wjj_win" title="未解决缺陷详情" onshow="bug_wjj_click">
						<aos:gridpanel id="bug_wjj_grid" width="900" height="400"
							url="workloadReportService.bugWjjPage" onrender="bug_wjj_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_wjj_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_yjj_win" title="已解决缺陷详情" onshow="bug_yjj_click">
						<aos:gridpanel id="bug_yjj_grid" width="900" height="400"
							url="workloadReportService.bugYjjPage" onrender="bug_yjj_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_yjj_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_yqcl_win" title="延期处理缺陷详情" onshow="bug_yqcl_click">
						<aos:gridpanel id="bug_yqcl_grid" width="900" height="400"
							url="workloadReportService.bugYqclPage" onrender="bug_yqcl_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_yqcl_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_gb_win" title="已关闭缺陷详情" onshow="bug_gb_click">
						<aos:gridpanel id="bug_gb_grid" width="900" height="400"
							url="workloadReportService.bugGbPage" onrender="bug_gb_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_gb_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_jj_win" title="延期处理缺陷详情" onshow="bug_jj_click">
						<aos:gridpanel id="bug_jj_grid" width="900" height="400"
							url="workloadReportService.bugJjPage" onrender="bug_jj_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_jj_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_cxdk_win" title="重新打开缺陷详情" onshow="bug_cxdk_click">
						<aos:gridpanel id="bug_cxdk_grid" width="900" height="400"
							url="workloadReportService.bugCxdkPage" onrender="bug_cxdk_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_cxdk_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_wffx_win" title="无法复现缺陷详情" onshow="bug_wffx_click">
						<aos:gridpanel id="bug_wffx_grid" width="900" height="400"
							url="workloadReportService.bugWffxPage" onrender="bug_wffx_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_wffx_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_total_win" title="无法复现缺陷详情" onshow="bug_total_click">
						<aos:gridpanel id="bug_total_grid" width="900" height="400"
							url="workloadReportService.bugTotalPage" onrender="bug_total_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
								align="left" />
							<aos:column header="当前状态" dataIndex="state"
								rendererFn="fn_bug_state" fixedWidth="100" />
							<aos:column header="严重程度" dataIndex="severity"
								rendererField="bug_severity" fixedWidth="100" />
							<aos:column header="优先级" dataIndex="priority"
								rendererField="bug_priority" fixedWidth="100" />
							<aos:column header="模块" dataIndex="dm_name" fixedWidth="120" />
							<aos:column header="类型" dataIndex="bug_type"
								rendererField="bug_type" fixedWidth="100" />
							<aos:column header="缺陷位置" dataIndex="bug_addr"
								rendererField="bug_addr" fixedWidth="100" />
							<aos:column header="出现频率" dataIndex="rate"
								rendererField="bug_rate" fixedWidth="100" />
							<aos:column header="来源方" dataIndex="source"
								rendererField="bug_source" fixedWidth="100" hidden="true" />
							<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
							<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
							<aos:column header="创建人" dataIndex="create_name" fixedWidth="100" />
							<aos:column header="创建时间" dataIndex="create_time"
								fixedWidth="150" />
							<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
							<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="150" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#bug_total_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="meeting_yfq_win" title="已发布会议详情" onshow="meeting_yfq_click">
						<aos:gridpanel id="meeting_yfq_grid" width="900" height="400"
							url="workloadReportService.meetingYfqPage" onrender="meeting_yfq_query"
							 hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="会议主题" dataIndex="theme" fixedWidth="280"
								align="left" />
							<aos:column header="会议方式" dataIndex="review_type"
								fixedWidth="280" rendererFn="fnReview" align="left" />
							<aos:column header="会议类型" dataIndex="meeting_type"
								fixedWidth="280" rendererFn="fnMeeting" align="left" />
							<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="280"
								align="left" />
							<aos:column header="结束时间" dataIndex="end_date" fixedWidth="280"
								align="left" />
							<aos:column header="用时" dataIndex="workload" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（内部）" dataIndex="attende_mans"
								fixedWidth="280" align="left" />
							<aos:column header="参与人（外部）" dataIndex="attende_mans_out"
								fixedWidth="280" align="left" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#meeting_yfq_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="meeting_yzj_win" title="已总结会议详情" onshow="meeting_yzj_click">
						<aos:gridpanel id="meeting_yzj_grid" width="900" height="400"
							url="workloadReportService.meetingYzjPage" onrender="meeting_yzj_query"
							 hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="会议主题" dataIndex="theme" fixedWidth="280"
								align="left" />
							<aos:column header="会议方式" dataIndex="review_type"
								fixedWidth="280" rendererFn="fnReview" align="left" />
							<aos:column header="会议类型" dataIndex="meeting_type"
								fixedWidth="280" rendererFn="fnMeeting" align="left" />
							<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="280"
								align="left" />
							<aos:column header="结束时间" dataIndex="end_date" fixedWidth="280"
								align="left" />
							<aos:column header="用时" dataIndex="workload" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（内部）" dataIndex="attende_mans"
								fixedWidth="280" align="left" />
							<aos:column header="参与人（外部）" dataIndex="attende_mans_out"
								fixedWidth="280" align="left" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#meeting_yzj_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="meeting_total_win" title="会议总详情" onshow="meeting_total_click">
						<aos:gridpanel id="meeting_total_grid" width="900" height="400"
							url="workloadReportService.meetingTotalPage" onrender="meeting_total_query"
							 hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="会议主题" dataIndex="theme" fixedWidth="280"
								align="left" />
							<aos:column header="会议方式" dataIndex="review_type"
								fixedWidth="280" rendererFn="fnReview" align="left" />
							<aos:column header="会议类型" dataIndex="meeting_type"
								fixedWidth="280" rendererFn="fnMeeting" align="left" />
							<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="280"
								align="left" />
							<aos:column header="结束时间" dataIndex="end_date" fixedWidth="280"
								align="left" />
							<aos:column header="用时" dataIndex="workload" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（内部）" dataIndex="attende_mans"
								fixedWidth="280" align="left" />
							<aos:column header="参与人（外部）" dataIndex="attende_mans_out"
								fixedWidth="280" align="left" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#meeting_total_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>

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
		
		function task_yfb_count_query(){
			task_yfb_count_grid_store.loadPage(1);
		} 
		
		function task_yjs_count_query(){
			task_yjs_count_grid_store.loadPage(1);
		} 
		
		function task_ywc_count_query(){
			task_ywc_count_grid_store.loadPage(1);
		} 
		
		function task_ygb_count_query(){
			task_ygb_count_grid_store.loadPage(1);
		} 
		
		function task_yzt_count_query(){
			task_yzt_count_grid_store.loadPage(1);
		} 
		
		function task_total_count_query(){
			task_total_count_grid_store.loadPage(1);
		}
		
		function bug_wjj_query(){
			bug_wjj_grid_store.loadPage(1);
		}
		
		function bug_yjj_query(){
			bug_yjj_grid_store.loadPage(1);
		}
		
		function bug_yqcl_query(){
			bug_yqcl_grid_store.loadPage(1);
		}
		
		function bug_gb_query(){
			bug_gb_grid_store.loadPage(1);
		}
		
		function bug_jj_query(){
			bug_jj_grid_store.loadPage(1);
		}
		
		function bug_cxdk_query(){
			bug_cxdk_grid_store.loadPage(1);
		}
		
		function bug_wffx_query(){
			bug_wffx_grid_store.loadPage(1);
		}
		
		function bug_total_query(){
			bug_total_grid_store.loadPage(1);
		}
		
		function meeting_yfq_query(){
			meeting_yfq_grid_store.loadPage(1);
		}
		
		function meeting_yzj_query(){
			meeting_yzj_grid_store.loadPage(1);
		}
		
		function meeting_total_query(){
			meeting_total_grid_store.loadPage(1);
		}
		
		//单元格样式
		function fn_demand_bgcolor_render(value, metaData, record) {
						//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #F0FFF0;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//单元格样式
		function fn_task_yfb_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
			
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			//alert(columnIndex);
			if (columnIndex == 0 ) {
				AOS.get('task_yfb_count_win').show();
			} 
		});
		
		//单元格样式
		function fn_task_yjs_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 1 ) {
				AOS.get('task_yjs_count_win').show();
			} 
		}); 
		
		//单元格样式
		function fn_task_ywc_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 2 ) {
				AOS.get('task_ywc_count_win').show();
			} 
		}); 
		
		//单元格样式
		function fn_task_ygb_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 3 ) {
				AOS.get('task_ygb_count_win').show();
			} 
		});
		
		//单元格样式
		function fn_task_yzt_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 4 ) {
				AOS.get('task_yzt_count_win').show();
			} 
		});
		
		//单元格样式
		function fn_task_total_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 5 ) {
				AOS.get('task_total_count_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_wjj_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 9 ) {
				AOS.get('bug_wjj_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_yjj_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 10 ) {
				AOS.get('bug_yjj_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_yqcl_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 11 ) {
				AOS.get('bug_yqcl_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_gb_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 12 ) {
				AOS.get('bug_gb_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_jj_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 13 ) {
				AOS.get('bug_jj_win').show();
			}
		});
		
		//单元格样式
		function fn_bug_cxdk_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 14 ) {
				AOS.get('bug_cxdk_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_wffx_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 15 ) {
				AOS.get('bug_wffx_win').show();
			} 
		});
		
		//单元格样式
		function fn_bug_total_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 16 ) {
				AOS.get('bug_total_win').show();
			} 
		});
		
		//单元格样式
		function fn_meeting_yfq_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 18 ) {
				AOS.get('meeting_yfq_win').show();
			} 
		});
		
		//单元格样式
		function fn_meeting_yzj_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 19 ) {
				AOS.get('meeting_yzj_win').show();
			} 
		});
		
		//单元格样式
		function fn_meeting_total_render(value, metaData, record) {
			//metaData.tdAttr = 'data-qtip="'+value+'"';
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
			if(value != 0){
				return '<a href="javascript:void(0);">' + value + '</a>';
			}
			return value;
		}
		proj_work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 20 ) {
				AOS.get('meeting_total_win').show();
			} 
		});
		
		function proj_work_query_onerad() {
			AOS.setValue('f_query.plan_begin_time', '${plan_begin_time}');
			AOS.setValue('f_query.plan_end_time', '${plan_end_time}');
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
		
		function task_yfb_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_yfb_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function task_yjs_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_yjs_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function task_ywc_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_ywc_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function task_ygb_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_ygb_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function task_yzt_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_yzt_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function task_total_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_total_count_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_wjj_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_wjj_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_yjj_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_yjj_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_yqcl_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_yqcl_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_gb_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_gb_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_jj_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_jj_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_cxdk_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_cxdk_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_wffx_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_wffx_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function bug_total_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_total_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function meeting_yfq_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			meeting_yfq_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function meeting_yzj_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			meeting_yzj_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		function meeting_total_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			meeting_total_grid_store.reload({
				params:{
					proj_id : proj_id,
					handler_user_id:handler_user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
					}
			});
		}
		
		//查询
		function proj_work_query() {
			/* var params = AOS.getValue('f_query');
			proj_work_grid_store.getProxy().extraParams = params;
			proj_work_grid_store.loadPage(1); */
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
		//完成百分比
		function render_percent(value){
			if(value)return value+"%";
			return "0%";
		}
		//拖延状体颜色
		function fn_state(value){
			if(value=='01')return '<span style="color:green">正常</span>'
			if(value=='02')return '<span style="color:red;">延期</span>'
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
		//完成百分比
		function render_percent(value){
			if(value)return value+"%";
			return "0%";
		}
		
		//缺陷当前状态
		function fn_bug_state(value, metaData, record){
			if(value =='1000'){
				return "<span >未解决</span>"; 
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
		
		//会议方式
		function fnReview(value, metaData, record){
			if(value =='1'){
				return "<span style='background-color:#E8C1E0; font-weight:bold'>会议现场</span>";
			}else if(value =='2'){
				return "<span style='background-color:#11EE96; font-weight:bold'>远程会议</span>";
			}else if(value =='3'){
				return "<span style='background-color:#E8C1E0; font-weight:bold'>其他</span>";
			}else{
				return null;
			}
		}
		
		//会议类型
		function fnMeeting(value, metaData, record){
			if(value =='1'){
				return "<span style='background-color:#E8C1E0; font-weight:bold'>项目周例会	</span>";
			}else if(value =='2'){
				return "<span style='background-color:#11EE96; font-weight:bold'>评审会议</span>";
			}else if(value =='3'){
				return "<span style='background-color:#E8C1E0; font-weight:bold'>专题会议</span>";
			}else if(value =='4'){
				return "<span style='background-color:#F3F350; font-weight:bold'>其他</span>";
			}else{
				return null;
			}
		}
		//完成百分比
		function render_percent(value){
			if(value)return value+"%";
			return "0%";
		}
		//拖延状体颜色
		function fn_state(value){
			if(value=='01')return '<span style="color:green">正常</span>'
			if(value=='02')return '<span style="color:red;">延期</span>'
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
		//完成百分比
		function render_percent(value){
			if(value)return value+"%";
			return "0%";
		}

	</script>
</aos:onready>