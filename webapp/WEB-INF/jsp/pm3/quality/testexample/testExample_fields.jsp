<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="standard_id" fieldLabel="测试用例ID" />
	<aos:textfield name="standard_name" fieldLabel="测试用例名称" allowBlank="true" maxLength="60"/>
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="true" maxLength="60"/>
	<aos:textfield name="stand_id" fieldLabel="模块ID" allowBlank="true" maxLength="60"/>
	<aos:textfield name="standard_type" fieldLabel="用例类型（功能测试，集成测试）" allowBlank="true" maxLength="30"/>
	<aos:textfield name="precondition" fieldLabel="前置条件" allowBlank="true" maxLength="150"/>
	<aos:textfield name="standard_detail" fieldLabel="测试步骤" allowBlank="true" maxLength="300"/>
	<aos:textfield name="expected_results" fieldLabel="预期结果" allowBlank="true" maxLength="300"/>
	<aos:textfield name="actual_results" fieldLabel="实际结果" allowBlank="true" maxLength="300"/>
	<aos:textfield name="pass_or_fail" fieldLabel="是否通过（0否，1是）" allowBlank="true" maxLength="10"/>
	<aos:textfield name="return_state" fieldLabel="是否回归测试（0否，1是）" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_name" fieldLabel="新增人" allowBlank="true" maxLength="60"/>
	<aos:textfield name="create_time" fieldLabel="新增时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_name" fieldLabel="修改人" allowBlank="true" maxLength="60"/>
	<aos:textfield name="update_time" fieldLabel="修改时间" allowBlank="true" maxLength="19"/>
