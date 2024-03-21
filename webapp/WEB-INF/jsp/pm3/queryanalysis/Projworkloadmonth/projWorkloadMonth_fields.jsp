<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="st_work_id" fieldLabel="项目工作量月度统计ID" />
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="false" maxLength="10"/>
	<aos:textfield name="month" fieldLabel="年月（默认格式YYYYMM）" allowBlank="false" maxLength="10"/>
	<aos:textfield name="proj_demand_num" fieldLabel="项目的总需求数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="proj_task_num" fieldLabel="proj_task_num" allowBlank="true" maxLength="10"/>
	<aos:textfield name="proj_defect_num" fieldLabel="项目的缺陷数量" allowBlank="true" maxLength="10"/>
	<aos:textfield name="proj_plan_workload" fieldLabel="项目的工作量" allowBlank="true" maxLength="11"/>
	<aos:textfield name="proj_real_workload" fieldLabel="proj_real_workload" allowBlank="true" maxLength="12"/>
	<aos:textfield name="create_user_id" fieldLabel="生成人" allowBlank="false" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="生成时间" allowBlank="false" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态，默认1有效，0无效" allowBlank="true" maxLength="12"/>
