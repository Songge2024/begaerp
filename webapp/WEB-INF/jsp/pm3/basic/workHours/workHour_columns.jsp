<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="人员ID" dataIndex="user_id" width="100"  hidden="true"/>
	<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true"/>
	<aos:column header="周报编码" dataIndex="test_code" width="100" hidden="true"/>
	<aos:column header="名称" dataIndex="NAME" width="80" align="center"/>
	<aos:column header="项目名称" dataIndex="project_for_short" width="200"  />
	<aos:column header="开始时间" dataIndex="begin_date" width="100" format="Y-m-d "   type="date"  align="center" />
	<aos:column header="结束时间" dataIndex="end_date" width="100" format="Y-m-d "   type="date" align="center" />
	<aos:column header="基地工时" dataIndex="work_hours" width="100" align="right"  rendererFn="fn_hours"/>
	<aos:column header="出差工时" dataIndex="business_hours" width="100"  align="right" rendererFn="fn_hours"/>
