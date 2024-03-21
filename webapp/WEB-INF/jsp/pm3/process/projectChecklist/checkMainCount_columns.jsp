<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="检查单ID" dataIndex="check_id" width="100" align="center" hidden="true"/>
	<aos:column header="检查单类型" dataIndex="check_name" width="100" align="center"/>
	<aos:column header="检查项编码" dataIndex="check_code" width="120" align="center" rendererFn="fn_check_detail"/>
	<aos:column header="符合数" dataIndex="yes_num" width="100" align="center" summaryRenderer="function(){return  '符合总数：'+summary.sum_yes_num}" />
	<aos:column header="不符合数" dataIndex="no_num" width="100" align="center" summaryRenderer="function(){return '不符合总数：'+summary.sum_no_num}" />
	<aos:column header="不适用数" dataIndex="none_num" width="100" align="center" summaryRenderer="function(){return '不适用总数：'+summary.sum_none_num}" />
	<aos:column header="检查数合计" dataIndex="all_num" width="100" align="center" summaryRenderer="function(){return '检查总数：'+summary.sum_all_num}" />
	<aos:column header="转为问题数" dataIndex="problem_num" width="100" align="center"/>
	<aos:column header="检查人" dataIndex="check_user_name" width="100" align="center"/>
	<aos:column header="检查人" dataIndex="check_user_id" width="100" hidden="true"/>
	<aos:column header="检查时间" dataIndex="check_time" width="150" align="center"/>
	
	<aos:column header="proj_id" dataIndex="proj_id" width="100" hidden="true"/>
	<aos:column header="检查项维护ID" dataIndex="check_cata_id" width="100" hidden="true"/>
	<aos:column header="说明" dataIndex="comment" width="100" hidden="true"/>
	<aos:column header="建议与意见" dataIndex="suggest" width="100" hidden="true"/>
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
	<aos:column header="计划检查时间" dataIndex="plan_check_time" width="100" hidden="true"/>
	