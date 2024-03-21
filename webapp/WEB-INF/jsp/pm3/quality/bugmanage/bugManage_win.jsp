<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

	<aos:window id="w_stand_find"  title="模块树[双击选择]" height="-60" layout="fit"  width="320" autoScroll="true"  >
			<aos:treepanel id="t_stand_find" singleClick="false" bodyBorder="0 0 0 0"  url="projTypesService.getModuleDivideTreeData" rootVisible="false" onitemdblclick="t_stand_find_select" />
	</aos:window> 
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	<aos:window id="copyw_org_find" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
			<aos:treepanel id="copyt_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="copy_org_find_select" />
	</aos:window>
	<aos:window id="copyw_stand_find"  title="模块树[双击选择]" height="-60" layout="fit"  width="320" autoScroll="true"  >
		<aos:treepanel id="copyt_stand_find" singleClick="false" bodyBorder="0 0 0 0"  url="projTypesService.getModuleDivideTreeData" rootVisible="false" onitemdblclick="copy_stand_find_select" />
	</aos:window>
	
	
	<aos:window id="w_standard_find" title="测试用例[双击选择]" height="-60" width="900" layout="fit" onshow="g_account_query">
			<aos:gridpanel id="g_account" url="testExampleService.listdemandgrid" onrender="g_account_query" forceFit="false" onitemdblclick="g_account_dbclick">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="用例名称" id="standard_name_query" onenterkey="g_account_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_account_query" width="250" />
				</aos:docked>
				<aos:column type="rowno" header="执行" align="center" width="35"/>
					<aos:column header="测试用例ID" dataIndex="standard_id" width="100"
						hidden="true" />
					<aos:column header="用例编码" dataIndex="standard_code" width="100"
						align="center" />
					<aos:column header="用例名称" dataIndex="standard_name" width="150"
						align="left" />
					<aos:column header="项目名称" dataIndex="proj_name" width="150"
						align="left" hidden="true" />
					<aos:column header="模块id" dataIndex="stand_id" width="150"
						align="left" hidden="true" />
					<aos:column header="模块名称" dataIndex="dm_name" width="120"
						align="left" />
					<aos:column header="执行序号" dataIndex="execute_code" width="80"
						align="center" />
					<aos:column header="执行步骤" dataIndex="standard_detail" width="150" />
					<aos:column header="期望结果" dataIndex="expected_results" width="150" />
					<aos:column header="实际结果" dataIndex="actual_results" width="150" />
					<aos:column header="状态" dataIndex="pass_or_fail" width="100"
						align="center" rendererField="pass_or_fail" />
					<aos:column header="通过时间" dataIndex="pass_time" width="150"
						align="center" rendererFn="fn_pass_time" />
					<aos:column header="执行次数" dataIndex="execute_number" width="100"
						align="center" />
					<aos:column header="关联需求" dataIndex="demand_site" width="150"
						align="left" />
					<aos:column header="测试数据sql" dataIndex="data_sql" width="150"
						align="left" hidden="true"/>
					<aos:column header="测试环境" dataIndex="test_environment" width="150"
						align="left" hidden="true"/>
					<aos:column header="前置条件" dataIndex="precondition" width="150" hidden="true"/>
					<aos:column header="版本号" dataIndex="version" width="150" hidden="true"/>
					<aos:column header="创建人" dataIndex="create_name" width="100"
						align="center" hidden="true" />
					<aos:column header="创建时间" dataIndex="create_time" width="150"
						align="center" hidden="true" />
					<aos:column header="修改人" dataIndex="update_name" width="100"
						align="center" hidden="true" />
					<aos:column header="修改时间" dataIndex="update_time" width="150"
						align="center" hidden="true" />
					<aos:column header="执行人" dataIndex="tester_name" width="100"
						align="center" />
					<aos:column header="执行时间" dataIndex="test_time" width="150"
						align="center" />
			</aos:gridpanel>
		</aos:window>
		
		<aos:window id="copyw_standard_find" title="测试用例[双击选择]" height="-60" width="900" layout="fit" onshow="copyg_account_query">
			<aos:gridpanel id="copyg_account" url="testExampleService.listdemandgrid" onrender="copyg_account_query" forceFit="false" onitemdblclick="copyg_account_dbclick">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="用例名称" id="copystandard_name_query" onenterkey="copyg_account_query" trigger1Cls="x-form-search-trigger" onTrigger1Click="copyg_account_query" width="250" />
				</aos:docked>
				<aos:column type="rowno" header="执行" align="center" width="35"/>
					<aos:column header="测试用例ID" dataIndex="standard_id" width="100"
						hidden="true" />
					<aos:column header="用例编码" dataIndex="standard_code" width="100"
						align="center" />
					<aos:column header="用例名称" dataIndex="standard_name" width="150"
						align="left" />
					<aos:column header="项目名称" dataIndex="proj_name" width="150"
						align="left" hidden="true" />
					<aos:column header="模块id" dataIndex="stand_id" width="150"
						align="left" hidden="true" />
					<aos:column header="模块名称" dataIndex="dm_name" width="120"
						align="left" />
					<aos:column header="执行序号" dataIndex="execute_code" width="80"
						align="center" />
					<aos:column header="执行步骤" dataIndex="standard_detail" width="150" />
					<aos:column header="期望结果" dataIndex="expected_results" width="150" />
					<aos:column header="实际结果" dataIndex="actual_results" width="150" />
					<aos:column header="状态" dataIndex="pass_or_fail" width="100"
						align="center" rendererField="pass_or_fail" />
					<aos:column header="通过时间" dataIndex="pass_time" width="150"
						align="center" rendererFn="fn_pass_time" />
					<aos:column header="执行次数" dataIndex="execute_number" width="100"
						align="center" />
					<aos:column header="关联需求" dataIndex="demand_site" width="150"
						align="left" />
					<aos:column header="测试数据sql" dataIndex="data_sql" width="150"
						align="left" hidden="true"/>
					<aos:column header="测试环境" dataIndex="test_environment" width="150"
						align="left" hidden="true"/>
					<aos:column header="前置条件" dataIndex="precondition" width="150" hidden="true"/>
					<aos:column header="版本号" dataIndex="version" width="150" hidden="true"/>
					<aos:column header="创建人" dataIndex="create_name" width="100"
						align="center" hidden="true" />
					<aos:column header="创建时间" dataIndex="create_time" width="150"
						align="center" hidden="true" />
					<aos:column header="修改人" dataIndex="update_name" width="100"
						align="center" hidden="true" />
					<aos:column header="修改时间" dataIndex="update_time" width="150"
						align="center" hidden="true" />
					<aos:column header="执行人" dataIndex="tester_name" width="100"
						align="center" />
					<aos:column header="执行时间" dataIndex="test_time" width="150"
						align="center" />
			</aos:gridpanel>
		</aos:window>	 