<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="周报详情" />
	<aos:dockeditem xtype="tbseparator" />
</aos:docked>
<aos:panel region="center" layout="border" border="true">
	<aos:panel region="north" width="350" bodyBorder="0 1 0 0"
		anchor="100%">
		<aos:formpanel id="week_detail_form" labelWidth="70" header="false"
			region="north" border="true">
			<aos:textareafield height="100" name="solve" fieldLabel="对内情况:"
				readOnly="true" msgTarget="qtip" columnWidth="0.5" />
			<aos:textareafield height="100" name="description" fieldLabel="对外情况:"
				readOnly="true" msgTarget="qtip" columnWidth="0.5" />
			<aos:hiddenfield name="test_code" />
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
	</aos:panel>

	<aos:tabpanel layout="vbox " anchor="100% 50%" region="center"
		tabBarHeight="22" tabPosition="top">
		<aos:tab title="本周完成情况">
			<aos:gridpanel id="week_detail_grid" url="weekReportService.pageProj" hidePagebar="true"
				region="center">
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<!-- 隐藏的内容 -->
				<aos:column header="周报ID" dataIndex="id" hidden="true" />
				<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
				<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
				<aos:column header="排序号" dataIndex="no" hidden="true" />
				<!-- 显示内容 -->
				<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
					fixedWidth="200" align="left" />
				<aos:column header="周报名称" dataIndex="week_name" hidden="true"
					fixedWidth="200" align="left" />
				<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
					fixedWidth="80" align="center" />
				<aos:column header="任务类型" dataIndex="week_class"
					rendererField="week_classs" celltip="true" width="80"
					align="center" />
				<aos:column header="任务描述" dataIndex="remarks" fixedWidth="500"
					align="left">
				</aos:column>
				<aos:column header="负责人" dataIndex="owner_name" width="120"
					celltip="true" align="center" />
				<aos:column header="负责人id" dataIndex="owner_id" fixedWidth="120"
					align="center" hidden="true">
				</aos:column>
				<aos:column header="计划开始时间" dataIndex="begin_date" hidden="true"
					type="date" format="Y-m-d" width="100">
				</aos:column>
				<aos:column header="计划结束时间" dataIndex="end_date" hidden="true"
					type="date" format="Y-m-d" width="100">
				</aos:column>
				<aos:column header="实际完成时间" dataIndex="finish_time" type="date"
					format="Y-m-d" fixedWidth="100">
				</aos:column>
				<aos:column header="完成情况" dataIndex="finish_cond" width="100"
					align="center">
					<aos:combobox name="finish_cond" allowBlank="false">
						<aos:option value="已完成" display="已完成" />
						<aos:option value="未完成" display="未完成" />
					</aos:combobox>
				</aos:column>
				<aos:column header="任务偏差分析及解决措施" dataIndex="descc" width="400">
				</aos:column>
				<aos:column header="对内情况说明" dataIndex="solve" hidden="true"
					fixedWidth="100">
					<aos:textfield allowBlank="false" />
				</aos:column>
				<aos:column header="对外情况说明" dataIndex="description" hidden="true"
					fixedWidth="100">
					<aos:textfield allowBlank="false" />
				</aos:column>
			</aos:gridpanel>
		</aos:tab>
		<aos:tab title="下周工作计划">
			<aos:gridpanel id="nextweek_work_plan"
				url="weekReportService.work_plan" hidePagebar="true"
				onitemdblclick="#plan_win_update.show();" anchor="100% 100%">
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<!-- 隐藏的内容 -->
				<aos:column header="周报ID" dataIndex="id" hidden="true" />
				<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
				<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
				<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
					align="left" />
				<aos:column header="周报名称" dataIndex="week_name" hidden="true"
					align="left" />
				<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
					align="center" />
				<!-- 显示内容 -->
				<aos:column header="任务类型" dataIndex="week_class"
					rendererField="week_classs" celltip="true" width="80"
					align="center" />
				<aos:column header="任务描述" dataIndex="remarks" celltip="true"
					width="500" align="left" />
				<aos:column header="负责人id" dataIndex="owner_id" width="120"
					hidden="true" align="center" />
				<aos:column header="负责人" dataIndex="owner_name" width="120"
					celltip="true" align="center" />
				<aos:column header="计划开始时间" dataIndex="begin_date" type="date"
					format="Y-m-d" width="100" />
				<aos:column header="计划结束时间" dataIndex="end_date" type="date"
					format="Y-m-d" width="100" />
			</aos:gridpanel>
		</aos:tab>
		<aos:tab title="成员用时">
			<aos:gridpanel id="work_hours" flex="2" border="true"
				hidePagebar="true" url="weekReportService.work_hours">
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35"/>
				<aos:column header="姓名" dataIndex="name">
				</aos:column>
				<aos:column header="编号" dataIndex="user_id" hidden="true" />
				<aos:column header="账号" dataIndex="account" hidden="true" />
				<aos:column header="项目ID" dataIndex="proj_id" hidden="true" />
				<aos:column header="基地工时" dataIndex="work_hours" width="80">
					<aos:numberfield emptyText="请填数字" allowBlank="true"
						msgTarget="qtip" minValue="0" />
				</aos:column>
				<aos:column header="出差工时" dataIndex="business_hours" width="80">
					<aos:numberfield allowBlank="true" msgTarget="qtip" minValue="0"
						emptyText="请填数字" />
				</aos:column>
			</aos:gridpanel>
		</aos:tab>
	</aos:tabpanel>

</aos:panel>
