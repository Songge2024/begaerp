<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="st_work_user_id" fieldLabel="项目工作量人员月度统计ID" />
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="false" maxLength="10"/>
	<aos:textfield name="user_id" fieldLabel="user_id" allowBlank="false" maxLength="10"/>
	<aos:textfield name="month" fieldLabel="年月（默认格式YYYYMM）" allowBlank="false" maxLength="10"/>
	<aos:textfield name="demand_num" fieldLabel="需求数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="demand_total_num" fieldLabel="总需求数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="task_num" fieldLabel="任务数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="task_total_num" fieldLabel="总任务数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="defect_num" fieldLabel="缺陷数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="defect_total_num" fieldLabel="总缺陷数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="plan_workload" fieldLabel="项目的计划工作量" allowBlank="true" maxLength="11"/>
	<aos:textfield name="real_workload" fieldLabel="实际工作量" allowBlank="true" maxLength="11"/>
	<aos:textfield name="total_plan_workload" fieldLabel="总计划工作量" allowBlank="true" maxLength="11"/>
	<aos:textfield name="total_real_workload" fieldLabel="总实际工作量" allowBlank="true" maxLength="11"/>
	<aos:textfield name="create_user_id" fieldLabel="生成人" allowBlank="false" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="生成时间" allowBlank="false" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态，默认1有效，0无效" allowBlank="true" maxLength="12"/>
