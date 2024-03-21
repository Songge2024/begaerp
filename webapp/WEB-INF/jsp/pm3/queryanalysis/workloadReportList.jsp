<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="ta_week_report" base="http" lib="ext">
<script type="text/javascript" src="monthPick.jsp"></script>
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="f_query" layout="column" labelWidth="70"
			title="查询条件" region="north" anchor="100%" border="false" margin="5"
			collapsible="true">
			<aos:textfield name="proj_name" fieldLabel="项目名称" columnWidth="0.2" />
			<aos:hiddenfield name="user_id" fieldLabel="人员ID" value='${id}' />
			<aos:combobox fieldLabel="日期" id="id_main_time" name="main_time"
				columnWidth="0.15" margin="0 10 0 10" onselect="fn_change" value="2">
				<aos:option value="4" display="当天" />
				<aos:option value="1" display="本周" />
				<aos:option value="2" display="本月" />
				<aos:option value="3" display="本年" />
			</aos:combobox>
			<aos:combobox fieldLabel="项目状态" id="id_proj_id_state"
				name="proj_id_state" columnWidth="0.15" margin="0 10 0 10"
				onselect="fn_state" value="0">
				<aos:option value="0" display="全部" />
				<aos:option value="1" display="进行中" />
				<aos:option value="2" display="历史项目" />
			</aos:combobox>
			<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
				format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
			<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d "
				columnWidth="0.14" editable="false" margin="0 0 0 0" />
				
			<aos:dockeditem xtype="button" text="查询" onclick="proj_work_query"
				icon="query.png" margin="0 5 0 10" />
			<aos:dockeditem xtype="button" text="重置"
				onclick="AOS.reset(f_query);" icon="refresh.png"  margin="0 5 0 5" />
<%-- 			<aos:dockeditem xtype="button" text="生成" onclick="add_clickes" --%>
<%-- 				icon="add.png" margin="0 5 0 5" /> --%>
<%-- 			<aos:dockeditem xtype="button" text="撤销" onclick="remove_clickes" --%>
<%-- 				icon="del.png" margin="0 5 0 5" /> --%>
			
		</aos:formpanel>
		
		<aos:tabpanel id="_id_tabsss" region="center" bodyBorder="0 0 0 0"
			margin="0 0 2 0">
			<aos:tab id="week_c" title="月工作检查表" layout="anchor" autoScroll="false">
				<!-- 列表窗口 -->
				<aos:gridpanel id="proj_work_grid" url="workloadReportService.projectWorkloadReportList"
					hidePagebar="true" onitemclick="commons_click" onrender="proj_work_query_onerad" anchor="100% 50%"
					border="true" collapsible="true" forceFit="false" title="项目工作量汇总" margin="0 5 0 5" >
					<aos:column type="rowno" width="40"/>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="项目名称" dataIndex="proj_name" width="240" align="left" locked="true" celltip="true"/>
					<aos:column header="项目id" dataIndex="proj_id" hidden="true" fixedWidth="100" align="center" />
					<aos:column header="计划工作总量" dataIndex="total_plan_wastage" width="100" align="right" rendererFn="fn_jhgzl" locked="true"/>	
					<aos:column header="实际工作总量" dataIndex="total_real_wastage" width="100" align="right" rendererFn="fn_jhgzl" locked="true"/>
					<aos:column header="任务数量" type="group">
						<aos:column header="已发布" dataIndex="task_yfb_count" width="70" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="已接收" dataIndex="task_yjs_count" width="70" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="已完成" dataIndex="task_ywc_count" width="70" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="已关闭" dataIndex="task_ygb_count" width="70" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="已暂停" dataIndex="task_yzt_count" width="70" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="任务总数" dataIndex="task_total_count" width="80" align="right" rendererFn="fn_task_bgcolor_render" />
						<aos:column header="计划工作量" dataIndex="task_plan_wastage" width="90" align="right" rendererFn="fn_jhgzl"/>
						<aos:column header="实际工作量" dataIndex="task_real_wastage" width="90" align="right" rendererFn="fn_jhgzl"/>
						<aos:column header="已关闭工作量" dataIndex="task_ygb_real_wastage" width="100" align="right" rendererFn="fn_jhgzl"/>
					</aos:column>
					<aos:column header="缺陷数量" type="group">
						<aos:column header="未解决" dataIndex="bug_wjj_count" width="80" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="已解决" dataIndex="bug_yjj_count" width="80" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="延期处理" dataIndex="bug_yqcl_count" width="100" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="已关闭" dataIndex="bug_gb_count" width="80" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="拒绝" dataIndex="bug_jj_count" width="80" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="重新打开" dataIndex="bug_cxdk_count" width="100" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="无法复现" dataIndex="bug_wffx_count" width="100" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="缺陷总数" dataIndex="bug_total_count" width="80" align="right" rendererFn="fn_bug_bgcolor_render" />
						<aos:column header="实际工作量" dataIndex="bug_real_wastage" width="90" align="right" rendererFn="fn_jhgzl" hidden="true"/>
						<aos:column header="关闭工作量" dataIndex="bug_gb_real_wastage" width="90"
							align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage+'人天'}"/>
					</aos:column>
					<aos:column header="会议数量" type="group">
						<aos:column header="草稿" dataIndex="meeting_cg_count" width="80" align="right" rendererFn="fn_meeting_bgcolor_render" hidden="true"/>
						<aos:column header="已发起" dataIndex="meeting_yfq_count" width="80" align="right" rendererFn="fn_meeting_bgcolor_render" />
						<aos:column header="已总结" dataIndex="meeting_yzj_count" width="80" align="right" rendererFn="fn_meeting_bgcolor_render" />
						<aos:column header="会议总数" dataIndex="meeting_total_count" width="80" align="right" rendererFn="fn_meeting_bgcolor_render" />
						<aos:column header="总工作量" dataIndex="meeting_real_wastage"
							width="90" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_real_wastage+'人天'}"/>
						<aos:column header="已确认工作量" dataIndex="meeting_yzj_real_wastage"
							width="120" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_yzj_real_wastage+'人天'}"/>
					</aos:column>
<%-- 					<aos:column header="需求数量" type="group" hidden="true"> --%>
<%-- 						<aos:column header="原始需求" dataIndex="demand_ys_count" width="80" align="right" rendererFn="fn_demand_bgcolor_render" hidden="true"/> --%>
<%-- 						<aos:column header="变更需求" dataIndex="demand_bg_count" width="80" align="right" rendererFn="fn_demand_bgcolor_render" hidden="true"/> --%>
<%-- 						<aos:column header="需求总数" dataIndex="demand_total_count" width="80" align="right" rendererFn="fn_demand_bgcolor_render" hidden="true"/> --%>
<%-- 					</aos:column> --%>
					<aos:column header="详情" fixedWidth="120" rendererFn="proj_detail" align="center" />
				</aos:gridpanel>
				
				<!-- 明细窗口 -->
				<aos:gridpanel id="work_grid" url="workloadReportService.personWorkloadReportByProjIdList" 
				   hidePagebar="true" anchor="100% 50%" border="true" title="组员工作量详情" autoScroll="true" margin="5 5 0 5">
					<aos:column type="rowno" width="40"/>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="组员姓名" dataIndex="name" fixedWidth="240"
						align="left" locked="true" celltip="true"/>
						<aos:column header="组员姓名" dataIndex="handler_user_id" fixedWidth="240"
						align="left" hidden="true"/>
					<aos:column header="项目id" dataIndex="proj_id" hidden="true"
						align="center" />
					<aos:column header="计划工作总量" dataIndex="total_plan_wastage"
						width="100" align="right" rendererFn="fn_jhgzl" locked="true" />
					<aos:column header="实际工作总量" dataIndex="total_real_wastage"
						width="100" align="right" rendererFn="fn_jhgzl" locked="true"/>
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
							align="right" rendererFn="fn_detail_task_bgcolor_render"/>
						<aos:column header="已接收" dataIndex="task_yjs_count" width="70"
							align="right" rendererFn="fn_detail_task_bgcolor_render"/>
						<aos:column header="已完成" dataIndex="task_ywc_count" width="70"
							align="right" rendererFn="fn_detail_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_ywc_count}"/>
						<aos:column header="已关闭" dataIndex="task_ygb_count" width="70"
							align="right" rendererFn="fn_detail_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_ygb_count}"/>
						<aos:column header="已暂停" dataIndex="task_yzt_count" width="70"
							align="right" rendererFn="fn_detail_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_yzt_count}"/>
						<aos:column header="任务总数" dataIndex="task_total_count" width="80"
							align="right" rendererFn="fn_detail_task_bgcolor_render" summaryRenderer="function(){return summary.sums_task_total_count}"/>
						<aos:column header="计划工作量" dataIndex="task_plan_wastage" width="90"
							align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_plan_wastage + '人天'}"/>
						<aos:column header="实际工作量" dataIndex="task_real_wastage" width="90"
							align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_real_wastage + '人天'}" />
						<aos:column header="已关闭工作量" dataIndex="task_ygb_real_wastage" width="100"
							align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_task_ygb_real_wastage + '人天'}" />
					</aos:column>
					<aos:column header="我的缺陷" type="group">
						<aos:column header="未解决" dataIndex="bug_wjj_count" width="80"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_wjj_count}"/>
						<aos:column header="已解决" dataIndex="bug_yjj_count" width="80"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_yjj_count}"/>
						<aos:column header="延期处理" dataIndex="bug_yqcl_count" width="100"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_yqcl_count}"/>
						<aos:column header="已关闭" dataIndex="bug_gb_count" width="80"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_gb_count}"/>
						<aos:column header="拒绝" dataIndex="bug_jj_count" width="80"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_jj_count}"/>
						<aos:column header="重新打开" dataIndex="bug_cxdk_count" width="100"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_cxdk_count}"/>
						<aos:column header="无法复现" dataIndex="bug_wffx_count" width="100"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_wffx_count}"/>
						<aos:column header="缺陷总数" dataIndex="bug_total_count" width="80"
							align="right" rendererFn="fn_detail_bug_bgcolor_render" summaryRenderer="function(){return summary.sums_bug_total_count}"/>
						<%-- <aos:column header="实际工作量" dataIndex="bug_real_wastage" width="90"
							align="right" rendererFn="fn_jhgzl" /> --%>
						<aos:column header="关闭工作量" dataIndex="bug_gb_real_wastage" width="90"
							align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_bug_gb_real_wastage+'人天'}"/>
					</aos:column>
					<aos:column header="我参加的会议" type="group">
	<%-- 					<aos:column header="草稿" dataIndex="meeting_cg_count" width="80" --%>
	<%-- 						align="right" rendererFn="fn_detail_meeting_bgcolor_render" /> --%>
						<aos:column header="已发起" dataIndex="meeting_yfq_count" width="80"
							align="right" rendererFn="fn_detail_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_yfq_count}"/>
						<aos:column header="已总结" dataIndex="meeting_yzj_count" width="80"
							align="right" rendererFn="fn_detail_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_yzj_count}"/>
						<aos:column header="会议总数" dataIndex="meeting_total_count" width="80" 
							align="right" rendererFn="fn_detail_meeting_bgcolor_render" summaryRenderer="function(){return summary.sums_meeting_total_count}"/>
						<aos:column header="总工作量" dataIndex="meeting_real_wastage"
							width="90" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_real_wastage+'人天'}"/>
						<aos:column header="已确认工作量" dataIndex="meeting_yzj_real_wastage"
							width="120" align="right" rendererFn="fn_jhgzl" summaryRenderer="function(){return summary.sums_meeting_yzj_real_wastage+'人天'}"/>
					</aos:column>
				</aos:gridpanel>
			</aos:tab>
		</aos:tabpanel>
		
		<!-- 工作详情窗口 -->
		<aos:window id="proj_particulars" width="1200" height="700" title="工作详情窗口">
					<aos:tabpanel id="id_tabs2" plain="true">
						<aos:tab title="总任务详情" onshow="money_grid_query" id="taskgird">
							<aos:gridpanel id="money_grid"
								url="workChecklistService.taskPage" onrender="money_grid_query">
								<aos:column type="rowno" header="序号" />
								<aos:column header="分组编码" dataIndex="group_id" width="200"
									hidden="true" />
								<aos:column header="项目" dataIndex="proj_name" width="280"
									align="left" />
								<aos:column header="编码" dataIndex="task_code" width="140"
									hidden="true" align="center" />
								<aos:column header="状态" dataIndex="state" width="65"
									rendererFn="render_state" />
								<aos:column header="任务名称" dataIndex="task_name" width="200"
									align="left">
									<aos:textareafield allowBlank="false" />
								</aos:column>
								<aos:column header="任务类型" dataIndex="task_type"
									rendererField="task_type" width="80">
								</aos:column>
								<aos:column header="任务等级" dataIndex="task_level" width="80"
									rendererField="task_level" align="left">
									<aos:combobox allowBlank="false" dicField="task_level"
										dicDataType="char" />
								</aos:column>
								<aos:column header="计划开始时间" dataIndex="plan_begin_time"
									type="date" width="150" format="Y-m-d h:m">
									<aos:datetimefield name="plan_begin_time" format="Y-m-d h:m"
										allowBlank="false" />
								</aos:column>
								<aos:column header="计划完成时间" dataIndex="plan_end_time"
									type="date" width="150" format="Y-m-d h:m">
									<aos:datetimefield name="plan_end_time" format="Y-m-d h:m"
										allowBlank="false" />
								</aos:column>
								<aos:column header="指派人" dataIndex="assign_user_id"
									width="120">
								</aos:column>
								<aos:column header="处理人" dataIndex="handler_user_id"
									width="150">
								</aos:column>
								<aos:column header="需求" dataIndex="demand_id" width="180"
									hidden="true" />
								<aos:column header="模块" dataIndex="module_id" width="180"
									hidden="true" />
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总缺陷详情" onshow="file_grid_query" id="buggird">
							<aos:gridpanel id="file_grid" url="workChecklistService.bugPage"
								onrender="file_grid_query" forceFit="false">
								<aos:column type="rowno" header="序号" />
								<aos:column header="项目" dataIndex="proj_name" width="280"
									align="left" />
								<aos:column header="缺陷名称" dataIndex="bug_name" width="280"
									align="left" />
								<aos:column header="当前状态" dataIndex="state" align="center"
									rendererFn="fn_bug_state" width="100">
								</aos:column>
								<aos:column header="严重程度" dataIndex="severity"
									rendererField="bug_severity" width="100" />
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
								<aos:column header="发现人" dataIndex="find_name" fixedWidth="100" />
								<aos:column header="当前处理人" dataIndex="deal_man" fixedWidth="100" />
								<aos:column header="创建人" dataIndex="create_name"
									fixedWidth="100" />
								<aos:column header="创建时间" dataIndex="create_time"
									fixedWidth="150" />
								<aos:column header="关闭人" dataIndex="close_name" fixedWidth="100" />
								<aos:column header="关闭时间" dataIndex="close_time"
									fixedWidth="150" />
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总会议详情" onshow="manage_grid_query">
							<aos:gridpanel id="manage_grid"
								url="workChecklistService.managePage"
								onrender="manage_grid_query">
								<aos:column type="rowno" header="序号" />
								<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
									align="left" />
								<aos:column header="会议主题" dataIndex="theme" fixedWidth="140"
									align="center" />
								<aos:column header="会议方式" dataIndex="review_type"
									fixedWidth="65" rendererFn="fnReview" />
								<aos:column header="会议类型" dataIndex="meeting_type"
									fixedWidth="200" rendererFn="fnMeeting" align="left" />
								<aos:column header="开始时间" dataIndex="begin_date"
									fixedWidth="180" />
								<aos:column header="结束时间" dataIndex="end_date" fixedWidth="180" />
								<aos:column header="用时" dataIndex="workload" fixedWidth="180" />
								<aos:column header="参与人(内)" dataIndex="attende_mans"
									fixedWidth="180" />
								<aos:column header="参与人(外)" dataIndex="attende_mans_out"
									fixedWidth="180" />
							</aos:gridpanel>
						</aos:tab>
						
						<aos:tab title="周报" onshow="week_grid_query">
							<aos:gridpanel id="week_grid" url="weekReportService.pageweek"
								onrender="week_grid_query" forceFit="false">
								<aos:docked forceBoder="0 0 0 0">
									<aos:dockeditem xtype="tbseparator" />
									<aos:dockeditem text="导出" icon="icon70.png"
										onclick="fn_export_excel" margin="0 0 1 1" />
								</aos:docked>
								<aos:selmodel type="checkbox" mode="multi" />
								<aos:column type="rowno" />
								<!-- 隐藏的内容 -->
								<aos:column header="周报ID" dataIndex="week_id" hidden="true" />
								<!-- 显示内容 -->
								<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
								<aos:column header="项目ID" dataIndex="proj_id" hidden="true"
									fixedWidth="80" />
								<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280" />
								<aos:column header="状态" dataIndex="flag" rendererFn="t_flag"
									fixedWidth="100" align="center" />
								<aos:column header="周报" dataIndex="task_plan_num"
									fixedWidth="80" />
								<aos:column header="开始时间" dataIndex="begin_date"
									fixedWidth="140" type="date" format="Y-m-d" width="100"
									align="center" />
								<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140"
									type="date" format="Y-m-d" width="100" align="center" />
								<aos:column header="测试组长" dataIndex="test_leader" hidden="true"
									fixedWidth="100" align="center" />
								<aos:column header="创建人" dataIndex="add_name" fixedWidth="100"
									align="center" />
								<aos:column header="创建时间" dataIndex="create_time"
									fixedWidth="150" align="center" />
							</aos:gridpanel>
						</aos:tab>

					</aos:tabpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="#proj_particulars.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
	
		<aos:window id="task_num_win" title="任务详情" width="1200" height="550" layout="border">
			<aos:gridpanel id="task_num_grid" url="workloadReportService.queryMonthTaskList"
				hidePagebar="true" border="true" anchor="100% 100%" region="center" forceFit="false"  margin="2 2 2 2">
				<aos:docked forceBoder="0 0 1 0">
					<aos:hiddenfield id="id_task_proj_id" name="proj_id" fieldLabel="项目id" />
					<aos:textfield id="id_task_proj_name" name="proj_name" fieldLabel="项目名称" width="350" labelWidth="60" readOnly="true"/>
					<aos:textfield id="id_task_type_name" name="task_type" fieldLabel="任务类型" width="200" labelWidth="60" readOnly="true"/>
					<aos:hiddenfield id="id_task_type" name="task_type" fieldLabel="任务类型" />
					<aos:hiddenfield id="id_handler_user_id" name="handler_user_id" fieldLabel="处理人" width="200" labelWidth="70"/>
					<aos:textfield id="id_handler_user_name" name="id_handler_user_name" fieldLabel="处理人" width="150" labelWidth="50" readOnly="true"/>
					<%-- <aos:dockeditem xtype="tbseparator" /> --%>
					<%-- <aos:dockeditem text="新增" onclick="#AOS.tip('您点击了新增按钮');" icon="add.png" hidden="true"/> --%>
					<%-- <aos:dockeditem text="修改" onclick="#AOS.tip('您点击了修改按钮');" icon="edit.png" hidden="true"/> --%>
					<%-- <aos:dockeditem text="删除" onclick="#AOS.tip('您点击了删除按钮');" icon="del.png" hidden="true"/> --%>
				</aos:docked>
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
				<aos:dockeditem onclick="#task_num_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		
		<aos:window id="meeting_num_win" title="会议详情" width="1200" height="550" layout="border">
			<aos:gridpanel id="meeting_num_grid" url="workloadReportService.queryMonthMeetingList"
				hidePagebar="true" border="true" anchor="100% 100%" region="center" forceFit="false"  margin="2 2 2 2">
				<aos:docked forceBoder="0 0 1 0">
					<aos:hiddenfield id="id_meeting_proj_id" name="proj_id" fieldLabel="项目id" />
					<aos:textfield id="id_meeting_proj_name" name="proj_name" fieldLabel="项目名称" width="350" labelWidth="60" readOnly="true"/>
					<aos:textfield id="id_meeting_type_name" name="meeting_type_name" fieldLabel="会议类型" width="200" labelWidth="60" readOnly="true"/>
					<aos:hiddenfield id="id_meeting_type" name="meeting_type" fieldLabel="会议类型" width="150" labelWidth="60"/>
					<aos:hiddenfield id="id_meeting_handler_user_id" name="handler_user_id" />
					<aos:textfield id="id_meeting_handler_user_name" name="handler_user_name" fieldLabel="处理人" width="150" labelWidth="50" readOnly="true"/>
				</aos:docked>
				<aos:column type="rowno" header="序号" />
				<aos:column header="项目" dataIndex="proj_name" fixedWidth="240" align="left" hidden="true"/>
				<aos:column header="会议主题" dataIndex="theme" fixedWidth="240"  align="left" celltip="true"/>
				<aos:column header="会议方式" dataIndex="review_type" fixedWidth="90" rendererFn="fnReview" align="center" />
				<aos:column header="会议类型" dataIndex="meeting_type" fixedWidth="90" rendererFn="fnMeeting" align="center" />
				<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="140" align="center" />
				<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140" align="center" />
				<aos:column header="用时" dataIndex="workload" fixedWidth="100" align="right" rendererFn="fn_jhgzl"/>
				<aos:column header="参与人（内部）" dataIndex="attende_mans" fixedWidth="280" align="left" celltip="true"/>
				<aos:column header="参与人（外部）" dataIndex="attende_mans_out" fixedWidth="280" align="left" celltip="true"/>
				
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#meeting_num_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="bug_num_win" title="缺陷详情" width="1200" height="550" layout="border">
			<aos:gridpanel id="bug_num_grid" url="workloadReportService.queryMonthBugList"
				hidePagebar="true" border="true" anchor="100% 100%" region="center" forceFit="false"  margin="2 2 2 2">
				<aos:docked forceBoder="0 0 1 0">
					<aos:hiddenfield id="id_bug_proj_id" name="proj_id" fieldLabel="项目id" />
					<aos:textfield id="id_bug_proj_name" name="proj_name" fieldLabel="项目名称" width="350" labelWidth="60" readOnly="true"/>
					<aos:textfield id="id_bug_type_name" name="bug_type" fieldLabel="缺陷类型" width="200" labelWidth="60" readOnly="true"/>
					<aos:hiddenfield id="id_bug_type" name="bug_type" fieldLabel="缺陷类型" />
					<aos:hiddenfield id="id_bug_handler_user_id" name="handler_user_id" fieldLabel="参与人" width="200" labelWidth="70"/>
					<aos:textfield id="id_bug_handler_user_name" name="handler_user_name" fieldLabel="参与人" width="150" labelWidth="50" readOnly="true"/>
					<%-- <aos:dockeditem xtype="tbseparator" /> --%>
					<%-- <aos:dockeditem text="新增" onclick="#AOS.tip('您点击了新增按钮');" icon="add.png" hidden="true"/> --%>
					<%-- <aos:dockeditem text="修改" onclick="#AOS.tip('您点击了修改按钮');" icon="edit.png" hidden="true"/> --%>
					<%-- <aos:dockeditem text="删除" onclick="#AOS.tip('您点击了删除按钮');" icon="del.png" hidden="true"/> --%>
				</aos:docked>
				<aos:column type="rowno" header="序号" />
				<aos:column header="项目" dataIndex="proj_name" width="350" align="left" hidden="true"/>
				<aos:column header="缺陷名称" dataIndex="bug_name" width="350" align="left" celltip="true"/>
				<aos:column header="当前状态" dataIndex="state" rendererFn="fn_bug_state" width="100" />
				<aos:column header="当前处理人" dataIndex="deal_man" width="100" hidden="true"/>
				<aos:column header="当前处理人" dataIndex="deal_name" width="100"/>
				<aos:column header="消耗工作量" dataIndex="real_wastage" width="100" rendererFn="fn_jhgzl" align="right"/>
				<aos:column header="发现人" dataIndex="find_name" width="100" />
				<aos:column header="创建人" dataIndex="create_name" width="100" hidden="true"/>
				<aos:column header="创建时间" dataIndex="create_time" width="150" />
				<aos:column header="严重程度" dataIndex="severity" rendererField="bug_severity" width="80" />
				<aos:column header="优先级" dataIndex="priority" rendererField="bug_priority" width="80" />
				<aos:column header="模块" dataIndex="dm_name" width="120" />
				<aos:column header="类型" dataIndex="bug_type" rendererField="bug_type" width="100" />
				<aos:column header="缺陷位置" dataIndex="bug_addr" rendererField="bug_addr" width="100" />
				<aos:column header="出现频率" dataIndex="rate" rendererField="bug_rate" width="100" />
				<aos:column header="来源方" dataIndex="source" rendererField="bug_source" width="100" hidden="true" />
				<aos:column header="关闭人" dataIndex="close_name" width="100" />
				<aos:column header="关闭时间" dataIndex="close_time" width="150" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#bug_num_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	
	</aos:viewport>
	<script type="text/javascript">
	//人天
	function fn_jhgzl(value,maction,record){
	    if(value==0){
            return value;
         }else{
	        return value+"<span style=' font-size:5px; color:green;'>人天</span>";
	
	  }
	}
	
	//查询条件、项目状态
	function fn_state(){
		proj_work_query();
	}
	
	function proj_detail(value, metaData, record) {
		return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn" onclick="show_proj_detail();" />';
	}
	
	//**********************汇总表样式start**********************//
	//单元格样式
	function fn_demand_bgcolor_render(value, metaData, record) {
		//metaData.tdAttr = 'data-qtip="'+value+'"';
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #FFFFE5;height:25px;margin-top:1px;margin-right:1px;';
		return value;
	}
	
	//单元格样式
	function fn_task_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
		return value;
	}
	
	//单元格样式
	function fn_bug_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
		return value;
	}
	
	//单元格样式
	function fn_meeting_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
		return value;
	}
	//**********************汇总表样式end**********************//
	
	//**********************明细表样式start**********************//
	//单元格样式
	function fn_detail_demand_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #FFFFE5;height:25px;margin-top:1px;margin-right:1px;';
		if(value != 0){
			return '<a href="javascript:void(0);">' + value + '</a>';
		}
		return value;
	}
	
	//单元格样式
	function fn_detail_task_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
		if(value != 0){
			return '<a href="javascript:void(0);">' + value + '</a>';
		}
		return value;
	}
	
	//单元格样式
	function fn_detail_bug_bgcolor_render(value, metaData, record) {
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
		if(value != 0){
			return '<a href="javascript:void(0);">' + value + '</a>';
		}
		return value;
	}
	
	//单元格样式
	function fn_detail_meeting_bgcolor_render(value, metaData, record) {
		//metaData.tdAttr = 'data-qtip="'+value+'"';
		//可以对单元格应用任何你想使用的样式信息
		metaData.style = 'background: #E0FFFF;height:25px;margin-top:1px;margin-right:1px;';
		if(value != 0){
			return '<a href="javascript:void(0);">' + value + '</a>';
		}
		return value;
	}
	//**********************明细表样式end**********************//
	
	//双击组员工作量详情查看
	work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
		console.log('grid:'+grid);
		var dataIndexValue = grid.getGridColumns()[columnIndex].dataIndex;//获取表头header内容 列名
		var record = AOS.selectone(work_grid);
		var value = record.get(dataIndexValue);
		if(value == null || value == 0){
			return;
		}
		var proj_id = record.data.proj_id;
		var handler_user_id = record.data.handler_user_id;
		var handler_user_name = record.data.name;
		var proj_name = AOS.selectone(proj_work_grid).data.proj_name;
		var state = null;
		//我的任务-已发布
		if (dataIndexValue == 'task_yfb_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			state = '1002';
			id_task_type.setValue(state);
			id_task_type_name.setValue("已发布");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, state);
		} 
		//我的任务-已接收
		if (dataIndexValue == 'task_yjs_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			state = '1003';
			id_task_type.setValue(state);
			id_task_type_name.setValue("已接收");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, state);
		} 
		//我的任务-已完成
		if (dataIndexValue == 'task_ywc_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			state = '1004';
			id_task_type.setValue(state);
			id_task_type_name.setValue("已完成");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, state);
		} 
		//我的任务-已关闭
		if (dataIndexValue == 'task_ygb_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			state = '1005';
			id_task_type.setValue(state);
			id_task_type_name.setValue("已关闭");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, state);
		} 
		//我的任务-已暂停
		if (dataIndexValue == 'task_yzt_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			state = '1006';
			id_task_type.setValue(state);
			id_task_type_name.setValue("暂停");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, state);
		} 
		//我的任务-任务总数
		if (dataIndexValue == 'task_total_count' ) {
			task_num_win.show();
			id_task_proj_id.setValue(proj_id);
			id_task_proj_name.setValue(proj_name);
			id_task_type.setValue(null);
			id_task_type_name.setValue("全部");
			id_handler_user_id.setValue(handler_user_id);
			id_handler_user_name.setValue(handler_user_name);
			task_num_query(proj_id, handler_user_id, null);
		} 
		
		
		//我的缺陷-未解决
		if (dataIndexValue == 'bug_wjj_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1000';
			id_task_type.setValue(state);
			id_task_type_name.setValue("未解决");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		} 
		
		//我的缺陷-已解决
		if (dataIndexValue == 'bug_yjj_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1001';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("已解决");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-延期处理
		if (dataIndexValue == 'bug_yqcl_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1002';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("延期处理");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-已关闭
		if (dataIndexValue == 'bug_gb_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1003';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("已关闭");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-拒绝
		if (dataIndexValue == 'bug_jj_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1004';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("拒绝");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-重新打开
		if (dataIndexValue == 'bug_cxdk_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1005';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("重新打开");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-无法复现
		if (dataIndexValue == 'bug_wffx_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = '1006';
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("无法复现");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的缺陷-缺陷总数
		if (dataIndexValue == 'bug_total_count' ) {
			AOS.get('bug_num_win').show();
			id_bug_proj_id.setValue(proj_id);
			id_bug_proj_name.setValue(proj_name);
			state = null;
			id_bug_type.setValue(state);
			id_bug_type_name.setValue("全部");
			id_bug_handler_user_id.setValue(handler_user_id);
			id_bug_handler_user_name.setValue(handler_user_name);
			bug_num_query(proj_id, handler_user_id, state);
		}
		
		//我的会议-已发起
		if (dataIndexValue == 'meeting_yfq_count') {
			AOS.get('meeting_num_win').show();
			id_meeting_proj_id.setValue(proj_id);
			id_meeting_proj_name.setValue(proj_name);
			state = '1';
			id_meeting_type.setValue(state);
			id_meeting_type_name.setValue("已发起");
			id_meeting_handler_user_id.setValue(handler_user_id);
			id_meeting_handler_user_name.setValue(handler_user_name);
			meeting_num_query(proj_id, handler_user_id, state);
		}
		
		//我的会议-已总结
		if (dataIndexValue == 'meeting_yzj_count') {
			AOS.get('meeting_num_win').show();
			id_meeting_proj_id.setValue(proj_id);
			id_meeting_proj_name.setValue(proj_name);
			state = '2';
			id_meeting_type.setValue(state);
			id_meeting_type_name.setValue("已总结");
			id_meeting_handler_user_id.setValue(handler_user_id);
			id_meeting_handler_user_name.setValue(handler_user_name);
			meeting_num_query(proj_id, handler_user_id, state);
		}
		
		//我的会议-会议总数
		if (dataIndexValue == 'meeting_total_count') {
			AOS.get('meeting_num_win').show();
			id_meeting_proj_id.setValue(proj_id);
			id_meeting_proj_name.setValue(proj_name);
			state = null;
			id_meeting_type.setValue(state);
			id_meeting_type_name.setValue("全部");
			id_meeting_handler_user_id.setValue(handler_user_id);
			id_meeting_handler_user_name.setValue(handler_user_name);
			meeting_num_query(proj_id, handler_user_id, state);
		}
		
		
		//需求
	});
	
	
	//组员工作量详情-任务详情查看窗口数据加载
	function task_num_query(proj_id, handler_user_id, state) {
		var params = {
				proj_id : proj_id,
				handler_user_id : handler_user_id,
				state : state,
				plan_begin_time : AOS.getValue('f_query.plan_begin_time'),
				plan_end_time : AOS.getValue('f_query.plan_end_time')
		};
		task_num_grid_store.getProxy().extraParams = params;
		task_num_grid_store.loadPage(1);
	}
	
	//组员工作量详情-缺陷详情查看窗口数据加载
	function bug_num_query(proj_id, handler_user_id, state) {
		var params = {
				proj_id : proj_id,
				handler_user_id : handler_user_id,
				state : state,
				plan_begin_time : AOS.getValue('f_query.plan_begin_time'),
				plan_end_time : AOS.getValue('f_query.plan_end_time')
		};
		bug_num_grid_store.getProxy().extraParams = params;
		bug_num_grid_store.loadPage(1);
	}
	
	//组员工作量详情-会议详情查看窗口数据加载
	function meeting_num_query(proj_id, handler_user_id, state) {
		var params = {
				proj_id : proj_id,
				handler_user_id : handler_user_id,
				state : state,
				plan_begin_time : AOS.getValue('f_query.plan_begin_time'),
				plan_end_time : AOS.getValue('f_query.plan_end_time')
		};
		meeting_num_grid_store.getProxy().extraParams = params;
		meeting_num_grid_store.loadPage(1);
	}
	
// 	function task_nums_query() {
// 		task_nums_grid_store.loadPage(1);
// 	}
// 	function bug_num_query() {
// 		bug_num_grid_store.loadPage(1);
// 	}
// 	function bug_nums_query() {
// 		bug_nums_grid_store.loadPage(1);
// 	}
	
// 	function demand_num_query() {
// 		demand_num_grid_store.loadPage(1);
// 	}
// 	function demand_nums_query() {
// 		demand_nums_grid_store.loadPage(1);
// 	}
// 	function manage_num_query() {
// 		manage_num_grid_store.loadPage(1);
// 	}
// 	function manage_nums_query() {
// 		manage_nums_grid_store.loadPage(1);
// 	}
// 	function work_grid_query() {
// 		//var params = AOS.getValue('f_query');
// 	   //	work_grid_store.getProxy().extraParams = params;
// 	  //	work_grid_store.loadPage(1);
// 	}
	

	//根据项目状态查询-项目工作量汇总表
	function proj_work_query() {
		var params = AOS.getValue('f_query');
		var state=AOS.get('id_proj_id_state').getValue();
		proj_work_grid_store.getProxy().extraParams =params;
		proj_work_grid_store.loadPage(1);
	}
	
	//项目工作量汇总表
	function proj_work_query_onerad() {
		AOS.setValue('f_query.plan_begin_time', '${plan_begin_time}');
		AOS.setValue('f_query.plan_end_time', '${plan_end_time}');
		var params = AOS.getValue('f_query');
		proj_work_grid_store.getProxy().extraParams =params;
		proj_work_grid_store.loadPage(1);
		
	}
	
	//点击汇总表，查询组员详情
	function commons_click() {
		var select = AOS.select(proj_work_grid, 'proj_id');
		var proj_id = select[0].data.proj_id;
		var params = AOS.getValue('f_query');
		params.proj_id=proj_id;
		work_grid_store.getProxy().extraParams =params;
		work_grid_store.loadPage(1);
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
			
		//项目需求信息
		function contract_grid_query(){
			var record = AOS.select(proj_work_grid,true)[0];
			var params = new Object();
			var params = AOS.getValue('f_query');
			params.proj_id = record.data.proj_id;
			contract_grid_store.getProxy().extraParams = params;
			contract_grid_store.loadPage(1);
		}
      //项目任务信息
      function money_grid_query(){
      	var record = AOS.select(proj_work_grid,true)[0];
      	var params = new Object();
      	var params = AOS.getValue('f_query');
      	params.proj_id = record.data.proj_id;
      	money_grid_store.getProxy().extraParams = params;
      	money_grid_store.loadPage(1);
      }
      //项目缺陷信息
      function file_grid_query(){
      	var record = AOS.select(proj_work_grid,true)[0];
      	var params = new Object();
      	var params = AOS.getValue('f_query');
      	params.proj_id = record.data.proj_id;
      	file_grid_store.getProxy().extraParams = params;
      	file_grid_store.loadPage(1);
      }
      //会议信息
      function manage_grid_query(){
      	var record = AOS.select(proj_work_grid,true)[0];
      	var params = new Object();
      	var params = AOS.getValue('f_query');
      	params.proj_id = record.data.proj_id;
      	manage_grid_store.getProxy().extraParams = params;
      	manage_grid_store.loadPage(1);
      }
      //项目周报信息
      function week_grid_query(){
      	var record = AOS.select(proj_work_grid,true)[0];
      	var params = new Object();
      	var params = AOS.getValue('f_query');
      	params.proj_id = record.data.proj_id;
      	week_grid_store.getProxy().extraParams = params;
      	week_grid_store.loadPage(1);
      }

		//状态颜色
		function render_state(value){
			if(value=='1002')return '<span style="color:green;">已发布</span>'
			if(value=='1003')return '<span style="color:blue;">已接收</span>'
			if(value=='1004')return '<span style="color:red;">已完成</span>'
			if(value=='1005')return '<span style="color:gray;">已关闭</span>'
			if(value=='1007')return '<span style="color:gray;">已暂停</span>'
			return "草稿";
		}
		
		function flag(value, metaData, record) {
			if (value == '1') {
				return "<span  font-weight:bold'>特急</span>";
			}if(value == '2'){
				return "<span  font-weight:bold'>急</span>";
			}if(value == '3'){
				return "<span  font-weight:bold'>普通</span>";
			}else{
				return "<span  font-weight:bold'>一般</span>";
			}
			return value;
		}
		function t_flag(value, metaData, record) {
			if (value == '1') {
				return "<span style='color:green; font-weight:bold'>已提交</span>";
			}
			else{
				return "<span style='color:red; font-weight:bold'>草稿</span>";
			}
			return value;
		}
		function state(value, metaData, record) {
			if (value =='1') {
				return "<span style='color:green; font-weight:bold'>已启用</span>";
			} else {
				return "<span style='color:red; font-weight:bold'>未启用</span>";
			}
			return value;
		}

		function flag(value, metaData, record) {
			if (value == '1') {
				return "<span style='color:green; font-weight:bold'>已上传</span>";
			}
			else{
				return "<span style='color:red; font-weight:bold'>未上传</span>";
			}
			return value;
		}

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
			if (val == "1") {
				AOS.setValue('f_query.plan_begin_time', week_begin_date_);
				AOS.setValue('f_query.plan_end_time', week_end_date_);
			} else if (val == "2") {
				AOS.setValue('f_query.plan_begin_time', date_);
				AOS.setValue('f_query.plan_end_time', date1_);
			} else if (val == "3") {
				AOS.setValue('f_query.plan_begin_time', year_begin_date_);
				AOS.setValue('f_query.plan_end_time', year_end_date_);
		
			} else if (val == "4") {
				AOS.setValue('f_query.plan_begin_time', today_date_);
				AOS.setValue('f_query.plan_end_time', today_date_);
		
			}
			AOS.setValue('f_query.user_id',id);
			var params = AOS.getValue('f_query');
			proj_work_grid_store.getProxy().extraParams = params;
			proj_work_grid_store.loadPage(1);
		}
		
		
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
	</script>
</aos:onready>
<script type="text/javascript">
	//项目详情显示窗口
	function show_proj_detail(){
			AOS.get("proj_particulars").show();
			AOS.get("buggird").show();
			AOS.get("manage_grid").show();
			AOS.get("contract_particulars").show();
			AOS.get("taskgird").show();
	}
</script>