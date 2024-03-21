<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100"  hidden="true" />
	<aos:column header="ID" dataIndex="st_work_id"   hidden="true" />
	<aos:column header="项目名称" dataIndex="proj_name" width="400"   />
	<aos:column header="年月" dataIndex="month" width="100"   align="center"     />
	<aos:column header="需求数量" dataIndex="proj_demand_num" width="100"  align="right"  />
	<aos:column header="任务数量" dataIndex="proj_task_num" width="100"  align="right" />
	<aos:column header="缺陷数量" dataIndex="proj_defect_num" width="100"  align="right"    />
	<aos:column header="计划工作量" dataIndex="proj_plan_workload" width="100" align="right" rendererFn="fn_jhgzl"  />
	<aos:column header="实际工作量" dataIndex="proj_real_workload" width="100" align="right"  rendererFn="fn_jhgzl" />
	<aos:column header="生成人ID" dataIndex="create_user_id" width="100" hidden="true" />
	<aos:column header="生成时间" dataIndex="create_time" width="170" align="center" />
	<aos:column header="生成人" dataIndex="create_user_name" width="100" align="center"   />
	<aos:column header="更新人ID" dataIndex="update_user_id" width="100"  hidden="true" />
	<aos:column header="更新人" dataIndex="update_user_name" width="100"  align="center"  hidden="true" />
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true" align="center" />
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"  />
