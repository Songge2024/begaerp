<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="检查单ID" dataIndex="check_id" width="100" align="center" hidden="true"/>
	<aos:column header="检查项编码" dataIndex="check_code" fixedWidth="100" />
	<aos:column header="proj_id" dataIndex="proj_id" fixedWidth="100" />
	<aos:column header="检查项维护ID" dataIndex="check_cata_id" fixedWidth="100" />
	<aos:column header="检查单名称" dataIndex="check_name" fixedWidth="100" />
	<aos:column header="说明" dataIndex="comment" fixedWidth="100" />
	<aos:column header="统计 符合数" dataIndex="yes_num" fixedWidth="100" />
	<aos:column header="统计 不符合数" dataIndex="no_num" fixedWidth="100" />
	<aos:column header="统计 不适应数" dataIndex="none_num" fixedWidth="100" />
	<aos:column header="建议与意见" dataIndex="suggest" fixedWidth="100" />
	<aos:column header="检查人" dataIndex="check_user_id" fixedWidth="100" />
	<aos:column header="检查时间" dataIndex="check_time" fixedWidth="100" />
	<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="100" />
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" />
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" />
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" />
	<aos:column header="状态" dataIndex="state" fixedWidth="100" />
	<aos:column header="计划检查时间" dataIndex="plan_check_time" fixedWidth="100" />
