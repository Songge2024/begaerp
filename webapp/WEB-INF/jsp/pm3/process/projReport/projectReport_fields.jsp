<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
<aos:textfield name="week_name" fieldLabel="周报名称" columnWidth="0.33"
	readOnly="true" emptyText="请选择周报" />
<aos:hiddenfield name="proj_name" id="proj_name" fieldLabel="项目名称" />
<aos:hiddenfield name="type_code" columnWidth="0.33" fieldLabel="项目类型id" />
<aos:hiddenfield name="type_code_name" fieldLabel="项目类型" />
<aos:textfield name="pm_user_name" columnWidth="0.33" fieldLabel="项目经理"
	readOnly="true" />
<aos:textfield name="pm2_user_name" columnWidth="0.33" fieldLabel="开发经理"
	readOnly="true" />
<aos:textfield name="demand_add_num" columnWidth="0.33"
	fieldLabel="需求新增数" readOnly="true" emptyText="请选择周报" />
<aos:textfield name="task_add_num" columnWidth="0.33" fieldLabel="任务新增数"
	readOnly="true" emptyText="请选择周报" />
<aos:textfield name="bug_add_num" columnWidth="0.33" fieldLabel="缺陷新增数"
	readOnly="true" emptyText="请选择周报" />
<aos:textfield name="demand_deal_num" columnWidth="0.33"
	fieldLabel="需求进行数" readOnly="true" emptyText="请选择周报" />
<aos:textfield name="task_deal_num" columnWidth="0.33"
	fieldLabel="任务进行数" readOnly="true" emptyText="请选择周报" />
<aos:textfield name="bug_deal_num" columnWidth="0.33" fieldLabel="缺陷进行数"
	readOnly="true" emptyText="请选择周报" />
<aos:textfield name="demand_fin_num" columnWidth="0.33"
	fieldLabel="需求完成数" readOnly="true" emptyText="请选择周报" />
<aos:textfield name="task_fin_num" columnWidth="0.33" fieldLabel="任务完成数"
	readOnly="true" emptyText="请选择周报" />
<aos:textfield name="bug_fin_num" columnWidth="0.33" fieldLabel="缺陷完成数"
	readOnly="true" emptyText="请选择周报" />
<aos:textareafield height="50" name="proj_person" fieldLabel="项目人员:"
	readOnly="true" msgTarget="qtip" columnWidth=".99" />
