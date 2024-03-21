<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="100"
	hidden="true" />
<aos:column header="里程碑编码" dataIndex="milest_code" fixedWidth="100"
	hidden="true" />
<aos:column header="里程碑名称" dataIndex="milest_name" fixedWidth="180" />
<aos:column header="计划天数" dataIndex="plan_wastage" fixedWidth="100"
	hidden="true" />
<aos:column header="第几周" dataIndex="weekday" fixedWidth="100"
	hidden="true" />
<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100"
	hidden="true" />
<aos:column header="分组ID" dataIndex="group_id" fixedWidth="100"
	hidden="true" />
<aos:column header="父ID" dataIndex="parent_id" fixedWidth="100"
	hidden="true" />
<aos:column header="is_leaf" dataIndex="is_leaf" fixedWidth="100"
	hidden="true" />
<aos:column header="sort_no" dataIndex="sort_no" fixedWidth="100"
	/>
<aos:column header="类型" dataIndex="type" hidden="true" />
<aos:column header="是否周节点" dataIndex="type_name" align="center"
	hidden="true" />
<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="140"
	align="center" />
<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140"
	align="center" />
<aos:column header="说明" dataIndex="comment" fixedWidth="100" />
<aos:column header="设计人" dataIndex="create_user_id" fixedWidth="100"
	hidden="true" />
<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100"
	hidden="true" />
<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100"
	hidden="true" />
<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100"
	hidden="true" />
<aos:column header="状态" dataIndex="state" hidden="true" />
<aos:column header="状态" dataIndex="state_name"
	rendererFn="fn_balance_render" align="center" />
