<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="测试用例名称" dataIndex="standard_name" fixedWidth="100" />
	<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100" />
	<aos:column header="模块ID" dataIndex="stand_id" fixedWidth="100" />
	<aos:column header="用例类型（功能测试，集成测试）" dataIndex="standard_type" fixedWidth="100" />
	<aos:column header="前置条件" dataIndex="precondition" fixedWidth="100" />
	<aos:column header="测试步骤" dataIndex="standard_detail" fixedWidth="100" />
	<aos:column header="预期结果" dataIndex="expected_results" fixedWidth="100" />
	<aos:column header="实际结果" dataIndex="actual_results" fixedWidth="100" />
	<aos:column header="是否通过（0否，1是）" dataIndex="pass_or_fail" fixedWidth="100" />
	<aos:column header="是否回归测试（0否，1是）" dataIndex="return_state" fixedWidth="100" />
	<aos:column header="新增人" dataIndex="create_name" fixedWidth="100" />
	<aos:column header="新增时间" dataIndex="create_time" fixedWidth="100" />
	<aos:column header="修改人" dataIndex="update_name" fixedWidth="100" />
	<aos:column header="修改时间" dataIndex="update_time" fixedWidth="100" />
