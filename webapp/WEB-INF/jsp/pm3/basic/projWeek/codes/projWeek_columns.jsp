<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目周id" dataIndex="week_id" hidden="true"/>
	<aos:column header="项目周名称" dataIndex="week_name" />
	<aos:column header="项目ID" dataIndex="proj_id"  fixedWidth="100" hidden="true"/>
	<aos:column header="项目名" dataIndex="proj_name"  />
	<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="140" />
	<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140" />
	<aos:column header="说明" dataIndex="comment"  />
	<aos:column header="设计人" dataIndex="create_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="设计人" dataIndex="create_user_name" fixedWidth="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="140" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_name" fixedWidth="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="create_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state_name" align="center" rendererFn="fn_balance_render" />
