<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="检查单类型" dataIndex="check_name" width="100" align="center" summaryRenderer="function(){return '合计'}"/>
	<aos:column header="问题等级" dataIndex="problem_level" width="100" align="center" rendererField="problem_level"/>
	<aos:column header="扣分标准" dataIndex="deduct_point" width="100" align="center"/>
	<aos:column header="问题数" dataIndex="problem_count" width="100" align="center"/>
	<aos:column header="问题解决时限(天)" dataIndex="solve_times" width="100" align="center"/>
	<aos:column header="时限扣分标准" dataIndex="solve_deduct_point" width="100" align="center"/>
	<aos:column header="时限扣分数量" dataIndex="count_point" width="100" align="center"/>
	<aos:column header="扣分小计" dataIndex="check_all" width="100" align="center" summaryRenderer="function(){return summary.count}"/>

	
	