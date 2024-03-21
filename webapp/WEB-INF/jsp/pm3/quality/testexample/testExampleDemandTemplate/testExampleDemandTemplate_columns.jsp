<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<aos:column header="测试用例ID" dataIndex="standard_id" width="100"
		hidden="true" />
	<aos:column header="模块名称" dataIndex="dm_name" width="100"
		align="center" />
	<aos:column header="模块编码" dataIndex="standard_code" width="100"
		align="center" hidden="true"/>
	<aos:column header="用例名称" dataIndex="standard_name" width="150"
		align="left" />
	<aos:column header="前置条件" dataIndex="precondition" width="150" hidden="true" />
	<aos:column header="测试前提" dataIndex="test_premise" width="120"
		align="left" />
	<aos:column header="执行步骤" dataIndex="standard_detail" width="150" />
	<aos:column header="期望结果" dataIndex="expected_results" width="150" />
	<aos:column header="来源于模板项目ID" dataIndex="from_templete_proj_id" width="150"
		align="center"  />
	<aos:column header="来源于测试版本号" dataIndex="from_test_version_id" width="150"
		align="center"  />
	<aos:column header="来源于测试用例ID" dataIndex="from_standard_id" width="150"
		align="center"  />
	<aos:column header="优先级" dataIndex="priority" width="80"
		align="center" />
	<aos:column header="执行序号" dataIndex="execute_code" width="80"
		align="center" />
	<aos:column header="功能模块" dataIndex="function_module" width="80"
		align="center" />
	
	<aos:column header="项目名称" dataIndex="proj_name" width="150"
		align="left" hidden="true" />
	<aos:column header="模块id" dataIndex="stand_id" width="150"
		align="left" hidden="true" />
	<aos:column header="测试版本号id" dataIndex="test_version_id" width="150"
		align="left" hidden="true" />
	<aos:column header="模块名称" dataIndex="dm_name" width="120"
		align="left" hidden="true"/>
	<aos:column header="实际结果" dataIndex="actual_results" width="150" hidden="true"/>
	<aos:column header="状态" dataIndex="pass_or_fail" width="100"
		align="center" rendererField="pass_or_fail" hidden="true" />
	<aos:column header="通过时间" dataIndex="pass_time" width="150"
		align="center" rendererFn="fn_pass_time" hidden="true"/>
	<aos:column header="执行次数" dataIndex="execute_number" width="100"
		align="center" hidden="true"/>
	<aos:column header="关联需求" dataIndex="demand_site" width="150"
		align="left" hidden="true"/>
	<aos:column header="测试数据sql" dataIndex="data_sql" width="150"
		align="left" hidden="true"/>
	<aos:column header="测试环境" dataIndex="test_environment" width="150"
		align="left" hidden="true"/>
	<aos:column header="版本号" dataIndex="version" width="150" hidden="true"/>
	<aos:column header="创建人" dataIndex="create_name" width="100"
		align="center"  />
	<aos:column header="创建人id" dataIndex="create_id" width="100"
		align="center" hidden="true" />
	<aos:column header="创建时间" dataIndex="create_time" width="150"
		align="center"  />
	<aos:column header="修改人" dataIndex="update_name" width="100"
		align="center" hidden="true" />
	<aos:column header="修改时间" dataIndex="update_time" width="150"
		align="center" hidden="true" />
	<aos:column header="执行人" dataIndex="tester_name" width="100"
		align="center" hidden="true"/>
	<aos:column header="执行时间" dataIndex="test_time" width="150"
		align="center" hidden="true"/>
