<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="ta_week_report" base="http" lib="ext">
<script type="text/javascript" src="monthPick.jsp"></script>
<aos:body>

</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="f_query" labelWidth="70" header="false" 
			region="north" border="false" anchor="100%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield name="proj_name" fieldLabel="项目名称" columnWidth="0.25" />
			<aos:hiddenfield name="user_id" fieldLabel="人员ID" value='${id}'  />
			<aos:combobox fieldLabel="日期" id="id_main_time"   name="main_time" columnWidth="0.19"
							margin="0 10 0 10" onselect="fn_change"  value="2">
							<aos:option value="4" display="当天"   />
							<aos:option value="1" display="本周" />
							<aos:option value="2" display="本月" />
							<aos:option value="3" display="本年" />
						</aos:combobox>
			<aos:combobox fieldLabel="项目状态" id="id_proj_id_state"   name="proj_id_state" columnWidth="0.19"
							margin="0 10 0 10" onselect="fn_state" value="0" >
							<aos:option value="0" display="全部" />
							<aos:option value="1" display="进行中" />
							<aos:option value="2" display="历史项目" />
						</aos:combobox>
						<aos:datefield name="plan_begin_time" fieldLabel="开始时间"
							format="Y-m-d " columnWidth="0.18" editable="false"
							margin="0 0 0 0" />
						<aos:datefield name="plan_end_time" fieldLabel="结束时间"
							format="Y-m-d " columnWidth="0.18" editable="false"
							margin="0 0 0 0" />
							
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
			         <aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查询" onclick="proj_work_query"
						icon="query.png"  />
					<aos:dockeditem xtype="button" text="重置"
						onclick="AOS.reset(f_query);" icon="refresh.png" 
						 />
					<aos:dockeditem xtype="button" text="生成"
						onclick="add_clickes"     icon="add.png" 
						/>
					<aos:dockeditem xtype="button" text="撤销"
						onclick="remove_clickes"     icon="del.png" 
						 />
					<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		
		</aos:formpanel>
		<aos:tabpanel id="_id_tabsss" region="center" bodyBorder="0 0 0 0"
			margin="0 0 2 0">
			<aos:tab id="week_c" title="月工作检查表" layout="anchor"
				autoScroll="false">
				<!-- 列表窗口 -->
				<aos:gridpanel id="proj_work_grid" url="workChecklistService.page"     hidePagebar="true"
					onitemclick="commons_click" onrender="proj_work_query_onerad"
					pageSize="20" anchor="100% 50%" border="true" margin="5"  >
					<aos:column type="rowno" />
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
						align="left" />
					<aos:column header="项目启动时间" dataIndex="begin_date" fixedWidth="280"
						hidden="true" align="center" />
					<aos:column header="项目计划周期" dataIndex="priod" fixedWidth="280"
						hidden="true" align="center" />
					<aos:column header="成员id" dataIndex="id" hidden="true"
						fixedWidth="100" align="center" />
					<aos:column header="项目id" dataIndex="proj_id" hidden="true"
						fixedWidth="100" align="center" />
					<aos:column header="周报上传" dataIndex="flag" rendererFn="flag"
						hidden="true" width="80" align="center" />
					<aos:column header="需求数量" dataIndex="demand_num" width="80" align="right"
						 />
					<aos:column header="总需求数" dataIndex="all_demand_num" width="80" align="right"
						 />
					<aos:column header="任务数量" dataIndex="task_num"  align="right"
						width="80" />
					<aos:column header="总任务数" dataIndex="all_task_num"  align="right"
						width="80" />
					<aos:column header="缺陷数量" dataIndex="bug_num" width="80"
						align="right" />
					<aos:column header="总缺陷数" dataIndex="all_bug_num" width="80"
						align="right" />
					<aos:column header="会议数量" dataIndex="manage_num" width="80"
						align="right" />
					<aos:column header="总会议数" dataIndex="all_manage_num" width="80"
						align="right" />
					<aos:column header="计划工作量" dataIndex="jhgzl" width="80" rendererFn="fn_jhgzl"
						align="right" />
					<aos:column header="实际工作量" dataIndex="sjgzl" width="80" rendererFn="fn_jhgzl"
						align="right" />
					<aos:column header="计划工作总量" dataIndex="all_jhgzl" width="80" rendererFn="fn_jhgzl"
						align="right" />
					<aos:column header="实际工作总量" dataIndex="all_sjgzl" width="80" rendererFn="fn_jhgzl"
						align="right" />
						
						
					<aos:column header="详情" fixedWidth="120" rendererFn="proj_"
						align="center" />
				</aos:gridpanel>
				
				<aos:window id="proj_particulars" width="1000" height="375"
					title="工作详情窗口">
					<aos:tabpanel id="id_tabs2" plain="true">
						<aos:tab title="总需求详情" onshow="contract_grid_query"
							id="contract_particulars">
							<aos:gridpanel id="contract_grid"
								url="workChecklistService.demandPage"
								onrender="contract_grid_query">
								<aos:column type="rowno" header="序号" />
								<aos:column header="主键ID" dataIndex="ad_id" fixedWidth="100"
									hidden="true" />
								<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100"
									hidden="true" />
								<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
									align="left" />
								<aos:column header="功能模块ID" dataIndex="dm_code" fixedWidth="100"
									hidden="true" />
								<aos:column header="功能模块" dataIndex="dm_name" fixedWidth="100"
									align="center" hidden="true" />
								<aos:column header="状态" dataIndex="state" fixedWidth="80"
									rendererFn="state" align="center">
								</aos:column>
								<aos:column header="需求ID" dataIndex="ad_code" hidden="true"
									fixedWidth="100" />
								<aos:column header="名称" dataIndex="ad_name" fixedWidth="200"
									align="left" />
								<aos:column header="需求类型" dataIndex="ad_type"
									rendererField="ad_type_id" fixedWidth="100" align="center" />
									<aos:column header="创建人" dataIndex="name"
									fixedWidth="100"  />
								<aos:column header="提出时间" dataIndex="ad_raise_date" type="date"
									format="Y-m-d" fixedWidth="100" align="center" />
								<aos:column header="计划完成时间" dataIndex="ad_plan_finish_date"
									type="date" format="Y-m-d" fixedWidth="100" align="center" />
								<aos:column header="要求完成时间" dataIndex="ad_claim_finish_date"
									type="date" format="Y-m-d" fixedWidth="100" align="center" />
								<aos:column header="实际完成时间" dataIndex="ad_actual_finish_date"
									type="date" format="Y-m-d" fixedWidth="100" align="center" />
								<aos:column header="需求来源" dataIndex="ad_source"
									rendererField="re_ad_source" fixedWidth="100" align="center" />
								<aos:column header="来源说明" dataIndex="ad_source_remark"
									fixedWidth="100" align="left" />
								<aos:column header="难易程度" dataIndex="ad_difficulty"
									rendererField="re_ad_difficulty" fixedWidth="100"
									align="center" />
								<aos:column header="优先级" dataIndex="ad_priority"
									fixedWidth="100" rendererFn="flag" align="center">
								</aos:column>
								<aos:column header="估计工作量" dataIndex="ad_workload"
									fixedWidth="100" align="right" />
								<aos:column header="内容" dataIndex="ad_content" fixedWidth="100"
									align="left" />
								<aos:column header="备注" dataIndex="ad_remark" fixedWidth="100"
									align="left" />
								<aos:column header="修改人" dataIndex="update_user_name"
									fixedWidth="100" hidden="true" />
								<aos:column header="修改人" dataIndex="update_user_id"
									fixedWidth="100" hidden="true" />
								<aos:column header="修改时间" dataIndex="update_time"
									fixedWidth="100" hidden="true" />
								<aos:column header="新增人" dataIndex="create_user_name"
									fixedWidth="100" hidden="true" />
								<aos:column header="新增时间" dataIndex="create_time"
									fixedWidth="100" hidden="true" />
								<aos:column header="变更来源" dataIndex="ad_chage_source"
									rendererField="re_ad_chage_source" fixedWidth="100"
									align="center" hidden="true" />
								<aos:column header="变更提出人" dataIndex="ad_chage_introducer"
									fixedWidth="100" align="center" hidden="true"/>
								<aos:column header="变更软件版本号" dataIndex="ad_chage_number"
									fixedWidth="100" hidden="true" align="center" />
								<aos:column header="变更审核意见" dataIndex="ad_chage_audit"
									fixedWidth="100" align="left" hidden="true" />
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总任务详情" onshow="money_grid_query" id="taskgird">
							<aos:gridpanel id="money_grid"
								url="workChecklistService.taskPage" onrender="money_grid_query">
								<aos:column type="rowno" header="序号" />
								<aos:column header="分组编码" dataIndex="group_id" fixedWidth="200"
									hidden="true" />
								<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
									align="left" />
								<aos:column header="编码" dataIndex="task_code" fixedWidth="140"
									hidden="true" align="center" />
								<aos:column header="状态" dataIndex="state" fixedWidth="65"
									rendererFn="render_state" />
								<aos:column header="任务名称" dataIndex="task_name" fixedWidth="200"
									align="left">
									<aos:textareafield allowBlank="false" />
								</aos:column>
								<aos:column header="任务类型" dataIndex="task_type"
									rendererField="task_type" fixedWidth="80">
								</aos:column>
								<aos:column header="任务等级" dataIndex="task_level" fixedWidth="80"
									rendererField="task_level" align="left">
									<aos:combobox allowBlank="false" dicField="task_level"
										dicDataType="char" />
								</aos:column>
								<aos:column header="计划开始时间" dataIndex="plan_begin_time"
									type="date" fixedWidth="150" format="Y-m-d h:m">
									<aos:datetimefield name="plan_begin_time" format="Y-m-d h:m"
										allowBlank="false" />
								</aos:column>
								<aos:column header="计划完成时间" dataIndex="plan_end_time"
									type="date" fixedWidth="150" format="Y-m-d h:m">
									<aos:datetimefield name="plan_end_time" format="Y-m-d h:m"
										allowBlank="false" />
								</aos:column>
								<aos:column header="指派人" dataIndex="assign_user_id"
									fixedWidth="120">
								</aos:column>
								<aos:column header="处理人" dataIndex="handler_user_id"
									fixedWidth="150">
								</aos:column>
								<aos:column header="需求" dataIndex="demand_id" fixedWidth="180"
									hidden="true" />
								<aos:column header="模块" dataIndex="module_id" fixedWidth="180"
									hidden="true" />
							</aos:gridpanel>
						</aos:tab>
						<aos:tab title="总缺陷详情" onshow="file_grid_query" id="buggird">
							<aos:gridpanel id="file_grid" url="workChecklistService.bugPage"
								onrender="file_grid_query" forceFit="false">
								<aos:column type="rowno" header="序号" />
								<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
									align="left" />
								<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="280"
									align="left" />
								<aos:column header="当前状态" dataIndex="state" align="center"
									rendererFn="fn_bug_state" fixedWidth="100">
								</aos:column>
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
						<aos:tab  title="总会议详情" onshow="manage_grid_query">
							<aos:gridpanel id="manage_grid"
								url="workChecklistService.managePage" onrender="manage_grid_query">
								<aos:column type="rowno" header="序号" />
								<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
									align="left" />
								<aos:column header="会议主题" dataIndex="theme" fixedWidth="140"
									 align="center" />
								<aos:column header="会议方式" dataIndex="review_type" fixedWidth="65" rendererFn="fnReview"
									 />
								<aos:column header="会议类型" dataIndex="meeting_type" fixedWidth="200" rendererFn="fnMeeting"
									align="left" />
								<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="180" />
								<aos:column header="结束时间" dataIndex="end_date" fixedWidth="180" />
								<aos:column header="用时" dataIndex="workload" fixedWidth="180" />
								<aos:column header="参与人(内)" dataIndex="attende_mans" fixedWidth="180" />
								<aos:column header="参与人(外)" dataIndex="attende_mans_out" fixedWidth="180" />
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
				<!-- 明细窗口 -->
				<aos:gridpanel id="work_grid" url="workChecklistService.proj" 
					 hidePagebar="true" anchor="100% 50%"
					border="true" margin="5">
					<aos:column type="rowno" />
					<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
						fixedWidth="180" align="center" />
					<aos:column header="成员姓名" dataIndex="name" fixedWidth="120"
						align="center" />
					<aos:column header="成员id" dataIndex="id" fixedWidth="100"
						hidden="true" align="center" />
					<aos:column header="项目id" dataIndex="proj_id" hidden="true"
						fixedWidth="100" align="center" />
					
					<aos:column header="需求数量" dataIndex="demand_num"
						rendererFn="demand_num" width="100" align="right" />
					<aos:column header="总需求数" dataIndex="demand_nums"
					 rendererFn="demand_nums"   width="100" align="right" />
					<aos:column header="任务数量" dataIndex="task_num"
						rendererFn="task_num" align="right" width="100" />
					<aos:column header="总任务数" dataIndex="task_nums"
						rendererFn="task_nums"     align="right" width="100" />
					<aos:column header="缺陷数量" dataIndex="bug_num" rendererFn="bug_num"
						width="100" align="right" />
					<aos:column header="总缺陷数" dataIndex="bug_nums" rendererFn="bug_nums"
						width="100" align="right" />
					<aos:column header="会议数量" dataIndex="manage_num" rendererFn="manage_num"
						width="100" align="right" />
					<aos:column header="会议总数" dataIndex="manage_nums" rendererFn="manage_nums"
						width="100" align="right" />
						
					<aos:column header="计划工作量" dataIndex="jhgzl" 
						width="100" align="right"  rendererFn="fn_jhgzl"   />
					<aos:column header="实际工作量" dataIndex="sjgzl"  rendererFn="fn_jhgzl"
						width="100" align="right" />
					<aos:column header="计划工作总量" dataIndex="jhgzls"  rendererFn="fn_jhgzl"
						width="100" align="right" />
					<aos:column header="实际工作总量" dataIndex="sjgzls" rendererFn="fn_jhgzl"
						width="100" align="right" />
						
					<aos:column header="周报上传" dataIndex="week_num" width="150"
						align="center" hidden="true">
					</aos:column>
					<aos:window id="task_num_win" title="任务详情" onshow="task_click">
						<aos:gridpanel id="task_num_grid" width="900" height="400"
							url="workChecklistService.task_num" onrender="task_num_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" fixedWidth="200"
								hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="编码" dataIndex="task_code" fixedWidth="100"
								hidden="true" align="center" />
							<aos:column header="状态" dataIndex="state" fixedWidth="65"
								rendererFn="render_state" />
							<aos:column header="任务名称" dataIndex="task_name" fixedWidth="200"
								align="left">
								<aos:textareafield allowBlank="false" />
							</aos:column>
							<aos:column header="任务类型" dataIndex="task_type"
								rendererField="task_type" fixedWidth="80">
							</aos:column>
							<aos:column header="任务等级" dataIndex="task_level" fixedWidth="80"
								rendererField="task_level" align="center">
								<aos:combobox allowBlank="false" dicField="task_level"
									dicDataType="char" />
							</aos:column>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" fixedWidth="150" format="Y-m-d h:m">
								<aos:datetimefield name="plan_begin_time" format="Y-m-d h:m"
									allowBlank="false" />
							</aos:column>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date"
								fixedWidth="150" format="Y-m-d h:m">
								<aos:datetimefield name="plan_end_time" format="Y-m-d h:m"
									allowBlank="false" />
							</aos:column>
							<aos:column header="指派人" dataIndex="assign_user_id"
								fixedWidth="120">
							</aos:column>
							<aos:column header="处理人" dataIndex="handler_user_id"
								fixedWidth="150">
							</aos:column>
							<aos:column header="需求" dataIndex="demand_id" fixedWidth="180"
								hidden="true" />
							<aos:column header="模块" dataIndex="module_id" fixedWidth="180"
								hidden="true" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_num_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="task_nums_win" title="总任务数" onshow="tasks_click">
						<aos:gridpanel id="task_nums_grid" width="900" height="400"
							url="workChecklistService.task_nums" onrender="task_nums_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="分组编码" dataIndex="group_id" fixedWidth="200"
								hidden="true" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="编码" dataIndex="task_code" fixedWidth="100"
								hidden="true" align="center" />
							<aos:column header="状态" dataIndex="state" fixedWidth="65"
								rendererFn="render_state" />
							<aos:column header="任务名称" dataIndex="task_name" fixedWidth="200"
								align="left">
								<aos:textareafield allowBlank="false" />
							</aos:column>
							<aos:column header="任务类型" dataIndex="task_type"
								rendererField="task_type" fixedWidth="80">
							</aos:column>
							<aos:column header="任务等级" dataIndex="task_level" fixedWidth="80"
								rendererField="task_level" align="center">
								<aos:combobox allowBlank="false" dicField="task_level"
									dicDataType="char" />
							</aos:column>
							<aos:column header="计划开始时间" dataIndex="plan_begin_time"
								type="date" fixedWidth="150" format="Y-m-d h:m">
								<aos:datetimefield name="plan_begin_time" format="Y-m-d h:m"
									allowBlank="false" />
							</aos:column>
							<aos:column header="计划完成时间" dataIndex="plan_end_time" type="date"
								fixedWidth="150" format="Y-m-d h:m">
								<aos:datetimefield name="plan_end_time" format="Y-m-d h:m"
									allowBlank="false" />
							</aos:column>
							<aos:column header="指派人" dataIndex="assign_user_id"
								fixedWidth="120">
							</aos:column>
							<aos:column header="处理人" dataIndex="handler_user_id"
								fixedWidth="150">
							</aos:column>
							<aos:column header="需求" dataIndex="demand_id" fixedWidth="180"
								hidden="true" />
							<aos:column header="模块" dataIndex="module_id" fixedWidth="180"
								hidden="true" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#task_nums_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					
					<aos:window id="bug_num_win" title="缺陷详情" onshow="bug_click">
						<aos:gridpanel id="bug_num_grid" width="900" height="400"
							url="workChecklistService.bug_num" onrender="bug_num_query"
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
							<aos:dockeditem onclick="#bug_num_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					<aos:window id="bug_nums_win" title="总缺陷数" onshow="bugs_click">
						<aos:gridpanel id="bug_nums_grid" width="900" height="400"
							url="workChecklistService.bug_nums" onrender="bug_nums_query"
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
							<aos:dockeditem onclick="#bug_nums_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>

					<aos:window id="demand_num_win" title="需求详情" onshow="demand_click">
						<aos:gridpanel id="demand_num_grid" width="900" height="400"
							url="workChecklistService.demand_num" onrender="demand_num_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="主键ID" dataIndex="ad_id" fixedWidth="100"
								hidden="true" />
							<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100"
								hidden="true" />
							<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="功能模块ID" dataIndex="dm_code" fixedWidth="100"
								hidden="true" />
							<aos:column header="功能模块" dataIndex="dm_name" hidden="true"
								fixedWidth="100" align="center" />
							<aos:column header="需求ID" dataIndex="ad_code" hidden="true"
								fixedWidth="100" />
							<aos:column header="名称" dataIndex="ad_name" fixedWidth="200"
								align="left" />
							<aos:column header="状态" dataIndex="state" fixedWidth="80"
								rendererFn="state" align="center">
							</aos:column>
							<aos:column header="需求类型" dataIndex="ad_type"
								rendererField="ad_type_id" fixedWidth="100" align="center" />
								<aos:column header="创建人" dataIndex="name"
								fixedWidth="100"  />
							<aos:column header="提出时间" dataIndex="ad_raise_date" type="date"
								format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="计划完成时间" dataIndex="ad_plan_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="要求完成时间" dataIndex="ad_claim_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="实际完成时间" dataIndex="ad_actual_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="需求来源" dataIndex="ad_source"
								rendererField="re_ad_source" fixedWidth="100" align="center" />
							<aos:column header="来源说明" dataIndex="ad_source_remark"
								fixedWidth="100" align="left" />
							<aos:column header="难易程度" dataIndex="ad_difficulty"
								rendererField="re_ad_difficulty" fixedWidth="100" align="center" />
							<aos:column header="优先级" dataIndex="ad_priority" fixedWidth="100"
								rendererFn="flag" align="center">
							</aos:column>
							<aos:column header="估计工作量" dataIndex="ad_workload"
								fixedWidth="100" align="right" />
							<aos:column header="内容" dataIndex="ad_content" fixedWidth="100"
								align="left" />
							<aos:column header="备注" dataIndex="ad_remark" fixedWidth="160"
								align="left" />
							<aos:column header="修改人" dataIndex="update_user_name"
								fixedWidth="100" hidden="true" />
							<aos:column header="修改人" dataIndex="update_user_id"
								fixedWidth="100" hidden="true" />
							<aos:column header="修改时间" dataIndex="update_time"
								fixedWidth="100" hidden="true" />
							<aos:column header="新增人" dataIndex="create_user_id"
								fixedWidth="100" hidden="true" />
							<aos:column header="新增时间" dataIndex="create_time"
								fixedWidth="100" hidden="true" />
							<aos:column header="变更来源" dataIndex="ad_chage_source"
								rendererField="re_ad_chage_source" fixedWidth="100"
								align="center" hidden="true" />
							<aos:column header="变更提出人" dataIndex="ad_chage_introducer"
								fixedWidth="100" align="center" hidden="true" />
							<aos:column header="变更软件版本号" dataIndex="ad_chage_number"
								fixedWidth="100" align="center" hidden="true" />
							<aos:column header="变更审核意见" dataIndex="ad_chage_audit"
								fixedWidth="100" align="left" hidden="true" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#demand_num_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					<aos:window id="demand_nums_win" title="总需求数" onshow="demands_click">
						<aos:gridpanel id="demand_nums_grid" width="900" height="400"
							url="workChecklistService.demand_nums" onrender="demand_nums_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="主键ID" dataIndex="ad_id" fixedWidth="100"
								hidden="true" />
							<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100"
								hidden="true" />
							<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="功能模块ID" dataIndex="dm_code" fixedWidth="100"
								hidden="true" />
							<aos:column header="功能模块" dataIndex="dm_name" hidden="true"
								fixedWidth="100" align="center" />
							<aos:column header="需求ID" dataIndex="ad_code" hidden="true"
								fixedWidth="100" />
							<aos:column header="名称" dataIndex="ad_name" fixedWidth="200"
								align="left" />
							<aos:column header="状态" dataIndex="state" fixedWidth="80"
								rendererFn="state" align="center">
							</aos:column>
							<aos:column header="需求类型" dataIndex="ad_type"
								rendererField="ad_type_id" fixedWidth="100" align="center" />
								<aos:column header="创建人" dataIndex="name"
								fixedWidth="100"  />
							<aos:column header="提出时间" dataIndex="ad_raise_date" type="date"
								format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="计划完成时间" dataIndex="ad_plan_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="要求完成时间" dataIndex="ad_claim_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="实际完成时间" dataIndex="ad_actual_finish_date"
								type="date" format="Y-m-d" fixedWidth="100" align="center" />
							<aos:column header="需求来源" dataIndex="ad_source"
								rendererField="re_ad_source" fixedWidth="100" align="center" />
							<aos:column header="来源说明" dataIndex="ad_source_remark"
								fixedWidth="100" align="left" />
							<aos:column header="难易程度" dataIndex="ad_difficulty"
								rendererField="re_ad_difficulty" fixedWidth="100" align="center" />
							<aos:column header="优先级" dataIndex="ad_priority" fixedWidth="100"
								rendererFn="flag" align="center">
							</aos:column>
							<aos:column header="估计工作量" dataIndex="ad_workload"
								fixedWidth="100" align="right" />
							<aos:column header="内容" dataIndex="ad_content" fixedWidth="100"
								align="left" />
							<aos:column header="备注" dataIndex="ad_remark" fixedWidth="160"
								align="left" />
							<aos:column header="修改人" dataIndex="update_user_name"
								fixedWidth="100" hidden="true" />
							<aos:column header="修改人" dataIndex="update_user_id"
								fixedWidth="100" hidden="true" />
							<aos:column header="修改时间" dataIndex="update_time"
								fixedWidth="100" hidden="true" />
							<aos:column header="新增人" dataIndex="create_user_id"
								fixedWidth="100" hidden="true" />
							<aos:column header="新增时间" dataIndex="create_time"
								fixedWidth="100" hidden="true" />
							<aos:column header="变更来源" dataIndex="ad_chage_source"
								rendererField="re_ad_chage_source" fixedWidth="100"
								align="center" hidden="true" />
							<aos:column header="变更提出人" dataIndex="ad_chage_introducer"
								fixedWidth="100" align="center" hidden="true" />
							<aos:column header="变更软件版本号" dataIndex="ad_chage_number"
								fixedWidth="100" align="center" hidden="true" />
							<aos:column header="变更审核意见" dataIndex="ad_chage_audit"
								fixedWidth="100" align="left" hidden="true" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#demand_nums_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					<aos:window id="manage_num_win" title="会议详情" onshow="manage_click">
						<aos:gridpanel id="manage_num_grid" width="900" height="400"
							url="workChecklistService.manage_num" onrender="manage_num_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="会议主题" dataIndex="theme" fixedWidth="280" 
								align="left" />
							<aos:column header="会议方式" dataIndex="review_type" fixedWidth="280" rendererFn="fnReview"
								align="left" />
							<aos:column header="会议类型" dataIndex="meeting_type" fixedWidth="280" rendererFn="fnMeeting"
								align="left" />
							<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="280"
								align="left" />
							<aos:column header="结束时间" dataIndex="end_date" fixedWidth="280"
								align="left" />
							<aos:column header="用时" dataIndex="workload" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（内部）" dataIndex="attende_mans" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（外部）" dataIndex="attende_mans_out" fixedWidth="280"
								align="left" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#manage_num_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
					<aos:window id="manage_nums_win" title="会议总详情" onshow="manages_click">
						<aos:gridpanel id="manage_nums_grid" width="900" height="400"
							url="workChecklistService.manage_nums" onrender="manage_nums_query"
							hidePagebar="true" border="true">
							<aos:column type="rowno" header="序号" />
							<aos:column header="项目" dataIndex="proj_name" fixedWidth="280"
								align="left" />
							<aos:column header="会议主题" dataIndex="theme" fixedWidth="280" 
								align="left" />
							<aos:column header="会议方式" dataIndex="review_type" fixedWidth="280" rendererFn="fnReview"
								align="left" />
							<aos:column header="会议类型" dataIndex="meeting_type" fixedWidth="280" rendererFn="fnMeeting"
								align="left" />
							<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="280"
								align="left" />
							<aos:column header="结束时间" dataIndex="end_date" fixedWidth="280"
								align="left" />
							<aos:column header="用时" dataIndex="workload" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（内部）" dataIndex="attende_mans" fixedWidth="280"
								align="left" />
							<aos:column header="参与人（外部）" dataIndex="attende_mans_out" fixedWidth="280"
								align="left" />
						</aos:gridpanel>
						<aos:docked dock="bottom" ui="footer">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem onclick="#manage_nums_win.hide();" text="关闭"
								icon="close.png" />
						</aos:docked>
					</aos:window>
				</aos:gridpanel>
			</aos:tab>
			<aos:tab id="week_month" title="月度考核数据一览表" layout="anchor"
				                autoScroll="false">
				              <%@ include file="Projworkloadmonth/projWorkloadMonth_grid.jsp"%>
				              <%@ include file="Projworkloadmonth/projWorkloadMonth_win.jsp"%>
	                          <%@ include file="Projworkloadmonth/projWorkloadMonth_handler.jsp"%>
	                          
		                      <%@ include file="Projworkuserloadmonth/projWorkloadUserMonth_grid.jsp"%>
							  <%@ include file="Projworkuserloadmonth/projWorkloadUserMonth_win.jsp"%>
							  <%@ include file="Projworkuserloadmonth/projWorkloadUserMonth_handler.jsp"%>
				       </aos:tab>
		</aos:tabpanel>
	</aos:viewport>
	<script type="text/javascript">
	//人天
	function fn_jhgzl(value,maction,record){
	    if(value==0){
            return value;
         }else{
	        return  value+"<span style=' font-size:5px; color:green;'>人天</span>";
	
	  }
	}
	//生成数据
	function add_clickes(){
		var recode=AOS.selection(proj_work_grid,'proj_id');
		var str=recode.split(",");
		var proj_id_=[]
		Ext.each(str,function(data){
			proj_id_.push(data);
		});
		var moeny=AOS.get('id_main_time').getValue();
		if(AOS.empty(recode)){
			AOS.tip('需要选择一个项目生成!')
			return;
		}
		//如果选择了项目
		if(moeny==2){
			var param=AOS.getValue('f_query');
			console.log("proj_id_,="+proj_id_);
			param.proj_id=proj_id_;
			AOS.ajax({
				url:"workChecklistService.getworkCherckistData",
				params:param,
				ok:function(data){
					AOS.tip(data.appmsg);
					var params = AOS.getValue('f_query');
					projWorkloadMonth_grid_store.getProxy().extraParams =params;
					projWorkloadMonth_grid_store.loadPage(1);
				}
			})
		}else
			{
			AOS.tip("[日期]请选择本月数据进行生成!");
			return;
			}
	}
	//撤销数据
	function remove_clickes(){
		var recode=AOS.selection(projWorkloadMonth_grid,'st_work_id');
		if(AOS.empty(recode)){
			AOS.tip('需要选择一条数据撤销!')
			return;
		}
		//如果选择了项目
		console.log("recode",recode);
	   AOS.ajax({
			url:"workChecklistService.delworkCherckistData",
			params:{
				aos_rows:recode
			},
				ok:function(data){
					AOS.tip(data.appmsg);
					var params = AOS.getValue('f_query');
					projWorkloadMonth_grid_store.getProxy().extraParams =params;
					projWorkloadMonth_grid_store.loadPage(1);
					projWorkloadUserMonth_grid_store.getProxy().extraParams =params;
					projWorkloadUserMonth_grid_store.loadPage(1);
			}
		})
	}
	//表格数据
			function task_num_query() {
				task_num_grid_store.loadPage(1);
			}
			function task_nums_query() {
				task_nums_grid_store.loadPage(1);
			}
			function bug_num_query() {
				bug_num_grid_store.loadPage(1);
			}
			function bug_nums_query() {
				bug_nums_grid_store.loadPage(1);
			}
			
			function demand_num_query() {
				demand_num_grid_store.loadPage(1);
			}
			function demand_nums_query() {
				demand_nums_grid_store.loadPage(1);
			}
			function manage_num_query() {
				manage_num_grid_store.loadPage(1);
			}
			function manage_nums_query() {
				manage_nums_grid_store.loadPage(1);
			}
			function work_grid_query() {
				//var params = AOS.getValue('f_query');
			   //	work_grid_store.getProxy().extraParams = params;
			  //	work_grid_store.loadPage(1);
			}
			
			function fn_state(){
				proj_work_query();
			}
			function proj_work_query() {
				var params = AOS.getValue('f_query');
				var state=AOS.get('id_proj_id_state').getValue();
				proj_work_grid_store.getProxy().extraParams =params;
				proj_work_grid_store.loadPage(1);
				projWorkloadMonth_grid_store.getProxy().extraParams =params;
				projWorkloadMonth_grid_store.loadPage(1);
			}
			function proj_work_query_onerad() {
				AOS.setValue('f_query.plan_begin_time', '${plan_begin_time}');
				AOS.setValue('f_query.plan_end_time', '${plan_end_time}');
				var params = AOS.getValue('f_query');
				proj_work_grid_store.getProxy().extraParams =params;
				proj_work_grid_store.loadPage(1);
				projWorkloadMonth_grid_store.getProxy().extraParams =params;
				projWorkloadMonth_grid_store.loadPage(1);
			}
			
		//项目树点击方法
		function on_public_tree(view, record, node, item, e) {
				//sAOS.tip("节点ID：" + record.raw.id + "; 节点名称：" + record.raw.text);
				var record = AOS.selectone(public_tree);
				var params = new Object();
				params.proj_id=record.data.id;
				work_grid_store.getProxy().extraParams = params;
				work_grid_store.loadPage(1);
		}
		
		function commons_click() {
			var select = AOS.select(proj_work_grid, 'proj_id');
			var proj_id = select[0].data.proj_id;
			var params = AOS.getValue('f_query');
			params.proj_id=proj_id;
			work_grid_store.getProxy().extraParams =params;
			work_grid_store.loadPage(1);
		}
		
		
		 //导出
		function fn_export_excel(){
			var week_id = AOS.selection(week_grid,'week_id');
			var test_code = AOS.selection(week_grid,'test_code');
			if(test_code.length == 0){
				AOS.tip("选择需要导出的数据。");
				return;
			}
			var record = AOS.select(week_grid);
			if(record.length==1 ){
				AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&test_code='+test_code+'&week_id='+week_id);
				return;
			}
			for(var i=1;i<record.length;i++){
				if(record[i].data.test_code != record[0].data.test_code ){
					AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&test_code='+test_code+'&week_id='+week_id);
					return;
				}
			}
			//juid需要再这个页面的初始化方法中赋值,这里才引用得到
			AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&selection='+selection);
		}
	
		
		//按钮列转换
		function task_num(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.task_num +  '</a>' ;
			//return '<input type="button" value="任务详情" metaData.style = "color:blue" class="cbtn"  onclick="show_task_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 4 ) {
				AOS.get('task_num_win').show();
			} 
		});
		function task_nums(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.task_nums +  '</a>' ;
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 5 ) {
				AOS.get('task_nums_win').show();
			} 
		});
		
		function demand_num(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.demand_num +  '</a>' ;
			//return '<input type="button" value="需求详情" metaData.style = "color:blue" class="cbtn"  onclick="show_demand_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 2 ) {
				AOS.get('demand_num_win').show();
			} 
		});
		function demand_nums(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.demand_nums +  '</a>' ;
			//return '<input type="button" value="需求详情" metaData.style = "color:blue" class="cbtn"  onclick="show_demand_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 3 ) {
				AOS.get('demand_nums_win').show();
			} 
		});
		function bug_num(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.bug_num +  '</a>' ;
			//return '<input type="button" value="缺陷详情" metaData.style = "color:blue" class="cbtn"  onclick="show_bug_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 6 ) {
				AOS.get('bug_num_win').show();
			} 
		});
		function bug_nums(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.bug_nums +  '</a>' ;
			//return '<input type="button" value="缺陷详情" metaData.style = "color:blue" class="cbtn"  onclick="show_bug_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 7 ) {
				AOS.get('bug_nums_win').show();
			} 
		});
		 function manage_num(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.manage_num +  '</a>' ;
			//return '<input type="button" value="缺陷详情" metaData.style = "color:blue" class="cbtn"  onclick="show_bug_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 8 ) {
				AOS.get('manage_num_win').show();
			} 
		});
		function manage_nums(value, metaData, record) {
			return '<a href="javascript:void(0);">' + record.data.manage_nums +  '</a>' ;
			//return '<input type="button" value="缺陷详情" metaData.style = "color:blue" class="cbtn"  onclick="show_bug_num();" />';
		}
		work_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			if (columnIndex == 9 ) {
				AOS.get('manage_nums_win').show();
			}
		}); 
		function proj_(value, metaData, record) {
			return '<input type="button" value="详情" metaData.style = "color:blue" class="cbtn"   onclick="show_proj();" />';
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
		//个人任务
		function task_click() {
			var select = AOS.select(work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var proj_id = select[0].data.proj_id;
			var handler_user_id = select[0].data.id;
			task_num_grid_store.reload({
								params:{
									proj_id : proj_id,
									handler_user_id:handler_user_id,
									plan_begin_time:plan_begin_time,
									plan_end_time:plan_end_time
									}
							});
						}
		//个人任务总数
		function tasks_click() {
			var select = AOS.select(work_grid, 'proj_id');
			//var select1 = AOS.select(work_grid, 'id');
			var handler_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			task_nums_grid_store.reload({
								params:{
									proj_id : proj_id,
									handler_user_id:handler_user_id
									}
							});
						}
		//个人缺陷
		function bug_click() {
			var select = AOS.select(work_grid, 'proj_id');
			//var select1 = AOS.select(work_grid, 'id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var proj_id = select[0].data.proj_id;
			var id = select[0].data.id;
			bug_num_grid_store.reload({
								params:{
									proj_id : proj_id,
									id:id,
									plan_begin_time:plan_begin_time,
									plan_end_time:plan_end_time
									}
							});
						}
		//个人总缺陷
		function bugs_click() {
			var select = AOS.select(work_grid, 'proj_id');
			var id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			bug_nums_grid_store.reload({
								params:{
									proj_id : proj_id,
									id:id
									}
							});
						}
		
		
		//个人需求
		function demand_click() {
			var select = AOS.select(work_grid, 'proj_id');
			//var select1 = AOS.select(work_grid, 'id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var proj_id = select[0].data.proj_id;
			var create_user_id = select[0].data.id;
			demand_num_grid_store.reload({
								params:{
									proj_id : proj_id,
									create_user_id:create_user_id,
									plan_begin_time:plan_begin_time,
									plan_end_time:plan_end_time
									}
							});
						}
		//个人总需求
		function demands_click() {
			var select = AOS.select(work_grid, 'proj_id');
			var create_user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			demand_nums_grid_store.reload({
								params:{
									proj_id : proj_id,
									create_user_id:create_user_id
									}
							});
						}
		//个人会议
		function manage_click() {
			var select = AOS.select(work_grid, 'proj_id');
			var plan_begin_time = AOS.getValue('f_query.plan_begin_time');
			var plan_end_time  = AOS.getValue('f_query.plan_end_time');
			var user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			manage_num_grid_store.reload({
				params:{
					proj_id : proj_id,
					user_id:user_id,
					plan_begin_time:plan_begin_time,
					plan_end_time:plan_end_time
				}
			});
		}
		//个人总会议
		function manages_click() {
			var select = AOS.select(work_grid, 'proj_id');
			var user_id = select[0].data.id;
			var proj_id = select[0].data.proj_id;
			manage_nums_grid_store.reload({
				params:{
					proj_id : proj_id,
					user_id:user_id
				}
			});
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
			}
			else{
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
function show_proj(){
		AOS.get("proj_particulars").show();
		AOS.get("taskgird").show();
		AOS.get("buggird").show();
		AOS.get("manage_grid").show();
		AOS.get("contract_particulars").show();
}
</script>