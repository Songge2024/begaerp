<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="扣分标准ID" dataIndex="id" width="100" hidden="true"/>
	<aos:column header="问题等级" dataIndex="problem_level" width="100" rendererField="problem_level" align="center"/>
	<aos:column header="扣分标准" dataIndex="deduct_point" width="100" align="center"/>
	<aos:column header="解决时限扣分标准" dataIndex="solve_deduct_point" width="100" align="center"/>
	<aos:column header="问题解决时限" dataIndex="solve_times" width="100" align="center"/>
