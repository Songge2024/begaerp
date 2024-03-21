
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();
	String time = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("time", time);
%>
<aos:html title="测试用例管理" base="http" lib="ext,ueditor">
<aos:body>
	<div id="bug_desc_div">
		<script type="text/plain" id="bug_desc_editor"
			style="text-align: left; margin-top: 5px; margin-right: 5px; width: 85%; height: 500px;"></script>
	</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:window id="execute_win" width="550" height="630" title="执行">
			<aos:formpanel id="execute_form" layout="column" center="true"
				labelWidth="60">
				<aos:textfield name="dm_name" fieldLabel="模块名称" readOnly="true"
					columnWidth=".5" />
				<aos:textfield name="execute_code" fieldLabel="执行序号" readOnly="true"
					columnWidth=".5" />
				<aos:fieldset title="测试前提">
					<aos:textareafield name="test_premise" columnWidth="1"
						margin="4 4 4 4" height="120" editable="false" />
				</aos:fieldset>
				<aos:fieldset title="测试步骤">
					<aos:textareafield name="standard_detail" columnWidth="1"
						margin="4 4 4 4" height="120" editable="false" />
				</aos:fieldset>
				<aos:fieldset title="结果">
					<%-- <aos:combobox fieldLabel="是否通过" name="pass_or_fail" value="1"
						dicField="pass_or_fail" columnWidth="1" allowBlank="false">
					</aos:combobox> --%>
					<aos:radioboxgroup fieldLabel="是否通过" columns="[100,100,100,100]" columnWidth="1">
						<aos:radiobox name="pass_or_fail" boxLabel="PASS" checked="true" inputValue="1" />
						<aos:radiobox name="pass_or_fail" boxLabel="FAIL" inputValue="0" />
						<aos:radiobox name="pass_or_fail" boxLabel="BLOCK" inputValue="2" />
						<aos:radiobox name="pass_or_fail" boxLabel="N/A" inputValue="3" />
					</aos:radioboxgroup>
					<aos:textareafield fieldLabel="期望结果" name="expected_results"
						columnWidth="0.5" height="120" margin="4" editable="false" />
					<aos:textareafield fieldLabel="实际结果" name="actual_results"
						columnWidth="0.5" height="120" margin="4" />
				</aos:fieldset>
				<aos:hiddenfield name="standard_id" fieldLabel="测试用例id" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="execute_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem id="next_btn" onclick="execute_form_next" text="下一步"
					icon="icon85.png" />
				<aos:dockeditem id="new_bug_btn" onclick="bug_win_show" text="新增缺陷并保存"
					icon="close.png" />
			</aos:docked>
		</aos:window>
		<%-- 新增窗口 --%>
		<aos:window id="example_win" width="860" height="450"
			onhide="hide_reset">
			<aos:formpanel id="example_form" layout="column" center="true"
				width="855" labelWidth="90" msgTarget="qtip" padding="10 10 10 10 ">
				<aos:hiddenfield name="standard_id" fieldLabel="缺陷id" />
				<aos:fieldset title="基本信息">
					<aos:combobox fieldLabel="项目" name="proj_id" margin="5"
						editable="false" allowBlank="false" columnWidth="0.5"
						url="projCommonsService.listComboBoxUerid&type=all"
						onchange="on_from_com" />
					<aos:combobox fieldLabel="测试版本号" name="test_version_id" margin="5" allowBlank="false"
						editable="false" columnWidth="0.5" url="testExampleService.exportTestVersionId"/>
					<aos:combobox fieldLabel="模块" name="stand_id" margin="5"
						editable="false" columnWidth="0.5" queryMode="local"
						url="testExampleService.listModuleDivideComboBox"
						onchange="on_module" />
					<aos:numberfield fieldLabel="执行序号" name="execute_code" margin="5"
						columnWidth="0.5" value="1" minValue="1" allowBlank="false" />
					<aos:combobox fieldLabel="优先级" name="priority" value="P1" margin="5"
						columnWidth="0.5" allowBlank="false" editable="true"
						forceSelection="false">
						<aos:option value="P0" display="P0"/>
						<aos:option value="P1" display="P1" />
						<aos:option value="P2" display="P2" />
						<aos:option value="P3" display="P3"/>
					</aos:combobox>
					<aos:combobox fieldLabel="关联需求" name="demand_id" margin="5"
						columnWidth="0.5" allowBlank="false"
						url="testExampleService.demandSite" />
					<aos:combobox fieldLabel="模块编码" name="standard_code" margin="5"
						columnWidth="0.5" allowBlank="false" editable="false"
						forceSelection="false" url="testExampleService.standardCode"
						queryMode="local" onchange="on_standard" />
					<aos:textfield fieldLabel="功能模块" name="function_module" margin="5"
						columnWidth="0.5" />
					<aos:textfield fieldLabel="用例标题" name="standard_name" margin="5"
						columnWidth="0.5" />
					<aos:hiddenfield fieldLabel="修改前执行序号" name="raw_execute_code" />
					<%-- <aos:textfield fieldLabel="测试数据sql" name="data_sql" margin="5"
						columnWidth="0.5" allowBlank="true" maxLength="200" />
					<aos:combobox fieldLabel="版本号" name="version" columnWidth="0.5"
						margin="5" url="testExampleService.listVersionComboBox" editable="true"
						forceSelection="false" /> --%>
				</aos:fieldset>
				<%-- <aos:fieldset title="环境">
					<aos:textareafield name="test_environment" fieldLabel="测试环境"
						allowBlank="true" maxLength="200" columnWidth="1"
						padding="5 5 5 5" height="70"
						emptyText="测试浏览器：IE10以上	 测试分辨率：1080*1024" />
				</aos:fieldset> --%>
				<aos:fieldset title="前提">
					<aos:textareafield name="test_premise" fieldLabel="测试前提"
						allowBlank="false" columnWidth="1" padding="5 5 5 5" height="70"
						emptyText="请输入测试前提" />
				</aos:fieldset>
				<aos:fieldset title="步骤">
					<aos:textareafield name="standard_detail" fieldLabel="测试步骤"
						allowBlank="false" columnWidth="1" padding="5 5 5 5" height="100"
						emptyText="请输入测试步骤" />
				</aos:fieldset>
				<%-- <aos:fieldset title="条件">
					<aos:textareafield name="precondition" fieldLabel="前置条件"
						allowBlank="true" columnWidth="1" padding="5 5 5 5" height="70"
						emptyText="请输入前置条件" />
				</aos:fieldset> --%>
				<aos:fieldset title="结果">
					<aos:textareafield fieldLabel="期望结果" name="expected_results"
						allowBlank="false" columnWidth="1" padding="5 5 5 0"
						maxLength="200" />
					<%-- <aos:textareafield fieldLabel="实际结果"  name="actual_results" columnWidth="1" 
					padding="5 5 5 0" maxLength="200"/> --%>
				</aos:fieldset>
				<aos:fieldset title="状态" hidden="true">
					<aos:combobox fieldLabel="是否通过" name="pass_or_fail"
						columnWidth="0.50" padding="0 10 10 0">
						<aos:option value="1" display="是" />
						<aos:option value="0" display="否" />
					</aos:combobox>
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem id="save_btn" onclick="example_form_save" text="保存"
					icon="ok.png" />
				<aos:dockeditem id="hide_btn" onclick="#example_win.hide();"
					text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<aos:panel width="320" collapsible="true" title="" region="west">
			<%@ include file="../../public/public_module_divide_tree.jsp"%>
		</aos:panel>
		<!-- 查询栏 -->
		<aos:panel region="center">
			<aos:panel layout="border">
				<aos:panel bodyBorder="0 0 1 0" region="north">
					<aos:formpanel id="query_form" layout="column" labelWidth="85"
						header="false" border="false">
						<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
							editable="false" columnWidth="0.5"
							url="projCommonsService.listComboBoxUerid&type=all"
							onchange="on_query_com" hidden="true" />
						<aos:combobox fieldLabel="模块" name="stand_id" margin="4"
							editable="false" columnWidth="0.5"
							url="moduleDivideService.listModuleDivideComboBox" hidden="true" />
						<aos:textfield fieldLabel="模糊查询" name="dim_search" margin="4"
							columnWidth="0.20" labelWidth="60"/>
						<aos:combobox fieldLabel="测试版本号" name="test_version_id"
							allowBlank="false" columnWidth="0.22" queryMode="local" 
							id="test_version_id" editable="false" labelWidth="50"
							url="testExampleService.exportTestVersionId"/>
						<aos:combobox fieldLabel="状态" name="pass_or_fail"
							columnWidth="0.15" margin="4" dicField="pass_or_fail" labelWidth="30">
						</aos:combobox>
						<aos:combobox fieldLabel="版本号" name="version" columnWidth="0.15" hidden="true"
							margin="4" url="testExampleService.listVersionComboBox" labelWidth="45"/>
<%-- 						<aos:combobox fieldLabel="关联需求" name="query_demand_id" margin="4" editable="true" --%>
<%-- 							queryMode="local" typeAhead="true" forceSelection="true" selectOnFocus="true" --%>
<%-- 							columnWidth="0.25" url="testExampleService.demandSite" labelWidth="60"/> --%>
						<aos:textfield fieldLabel="执行人" name="tester_name" margin="4" columnWidth="0.20" labelWidth="60"/>
						<aos:combobox fieldLabel="是否执行" name="is_execute" columnWidth="0.12" margin="4" labelWidth="60">
							<aos:option value="1" display="已执行"/>
							<aos:option value="2" display="未执行"/>
						</aos:combobox>
						<aos:combobox fieldLabel="优先级" name="priority" margin="5" labelWidth="50"
							columnWidth="0.11" allowBlank="true" editable="true"
							forceSelection="false">
							<aos:option value="P0" display="P0"/>
							<aos:option value="P1" display="P1" />
							<aos:option value="P2" display="P2" />
							<aos:option value="P3" display="P3"/>
						</aos:combobox>
						<aos:button text="查询" onclick="example_grid_query"
							icon="query.png" margin="4 4 4 10" />
						<aos:button text="重置" onclick="AOS.reset(query_form);"
							icon="refresh.png" margin="4 4 4 10" />
					</aos:formpanel>
				</aos:panel>
				
				<aos:gridpanel id="example_grid" url="testExampleService.page"
					region="center" forceFit="false" 
					onitemdblclick="#example_win_show('update');" bodyBorder="1 0 1 0">
					<aos:menu>
						<aos:menuitem text="查看" onclick="example_win_show('particulars');"
							icon="zoom_out.png" />
						<aos:menuitem text="新增" onclick="example_win_show('create');"
							icon="add.png" />
						<aos:menuitem text="修改" onclick="example_win_show('update');"
							icon="edit.png" />
						<aos:menuitem text="删除" onclick="fn_del" icon="del.png" />
						<aos:menuitem text="导出" onclick="fn_export_excel"
							icon="icon70.png" />
						<aos:menuitem text="导入" onclick="fn_import_excel" icon="up.png" />
						<aos:menuitem text="复制" onclick="fn_copy" icon="copy.png" hidden="true"/>
						<aos:menuitem xtype="menuseparator" />
						<aos:menuitem text="查看用例执行历史记录" onclick="fn_query_detail"
							icon="search.png" />
					</aos:menu>
					<aos:docked forceBoder="1 0 1 0">
						<aos:dockeditem xtype="tbtext" text="测试用例信息" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem text="新增" icon="add.png"
							onclick="example_win_show('create');" />
						<aos:dockeditem text="修改" icon="edit.png"
							onclick="example_win_show('update');" />
						<aos:dockeditem text="删除" icon="del.png"
							onclick="example_grid_del" />
						<aos:dockeditem xtype="button" text="导出" onclick="fn_export_excel"
							icon="icon70.png" />
						<aos:dockeditem xtype="button" text="全部导出" onclick="fn_all_export_excel"
							icon="icon70.png" />
						<aos:dockeditem xtype="button" text="导入" onclick="fn_import_excel"
							icon="up.png" />
						<aos:dockeditem xtype="button" text="复制" onclick="fn_copy"
							icon="copy.png" hidden="true"/>
						<aos:dockeditem xtype="button" text="PASS" onclick="fn_pass"
							icon="go.gif" />
						<aos:dockeditem xtype="button" text="N/A" onclick="fn_na"
							icon="go.gif" />
						<aos:dockeditem xtype="button" text="BLOCK" onclick="fn_block"
							icon="go.gif" />
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查看用例执行历史记录"
							onclick="fn_query_detail" icon="search.png" />
					</aos:docked>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column type="rowno" />
					<aos:column header="执行" width="50" rendererFn="fn_button_execute"
						align="center" />
					<aos:column header="测试用例ID" dataIndex="standard_id" width="100"
						hidden="true" />
					<aos:column header="测试版本号ID" dataIndex="test_version_id" width="150" align="center" hidden="true"/>
					<aos:column header="测试结果" dataIndex="pass_or_fail" width="100"
						align="center"  rendererFn="fn_example_state"/>
					<aos:column header="执行序号" dataIndex="execute_code" width="80"
						align="center" />
					<aos:column header="优先级" dataIndex="priority" width="80"
						align="center" />
					<aos:column header="功能模块" dataIndex="function_module" width="80"
						align="center" />
					<aos:column header="用例标题" dataIndex="standard_name" width="150"
						align="left" celltip="true"/>
					<aos:column header="测试前提" dataIndex="test_premise" width="120"
						align="left" celltip="true"/>
					<aos:column header="测试步骤" dataIndex="standard_detail" width="150" celltip="true"/>
					<aos:column header="期望结果" dataIndex="expected_results" width="150" celltip="true"/>
					<aos:column header="实际结果" dataIndex="actual_results" width="150" celltip="true"/>
					<aos:column header="执行次数" dataIndex="execute_number" width="100"
						align="center" />
					<aos:column header="回归测试结果" dataIndex="regress_result" width="95" align="center" rendererFn="fn_test_result" />
					<aos:column header="缺陷总数" dataIndex="bug_counts" width="70" align="center" rendererFn="fn_bug_show"/>
					<aos:column header="未解决数" dataIndex="unsolve_counts" width="70" align="center"/>
					<aos:column header="已解决数" dataIndex="resolved_counts" width="70" align="center"/>
					<aos:column header="关闭数" dataIndex="close_counts" width="55" align="center"/>
					<aos:column header="其它bug数" dataIndex="other_counts" width="75" align="center"/>
					<aos:column header="测试版本号" dataIndex="test_version_number" width="150" align="center" />
					<aos:column header="延期处理数" dataIndex="delay_counts" width="70" align="center" hidden="true"/>
					<aos:column header="重新打开数" dataIndex="reopen_counts" width="70" align="center" hidden="true"/>
					<aos:column header="通过时间" dataIndex="pass_time" width="150"
						align="center" rendererFn="fn_pass_time" />
					<aos:column header="执行人" dataIndex="tester_name" width="100"
						align="center" />
					<aos:column header="执行时间" dataIndex="test_time" width="150"
						align="center" />
					<aos:column header="模块编码" dataIndex="standard_code" width="100"
						align="center" />
					<aos:column header="模块id" dataIndex="stand_id" width="150"
						align="left" hidden="true" />
					<aos:column header="模块名称" dataIndex="dm_name" width="120"
						align="left" />
					<aos:column header="关联需求" dataIndex="demand_site" width="150"
						align="left" />
					<aos:column header="项目名称" dataIndex="proj_name" width="150"
						align="left" hidden="true" />
					<%-- <aos:column header="测试数据sql" dataIndex="data_sql" width="150"
						align="left" />
					<aos:column header="测试环境" dataIndex="test_environment" width="150"
						align="left" />
					<aos:column header="前置条件" dataIndex="precondition" width="150" />
					<aos:column header="版本号" dataIndex="version" width="150" /> --%>
					<aos:column header="创建人" dataIndex="create_name" width="100"
						align="center" hidden="true" />
					<aos:column header="创建人id" dataIndex="create_id" width="100"
						align="center" hidden="true" />
					<aos:column header="创建时间" dataIndex="create_time" width="150"
						align="center" hidden="true" />
					<aos:column header="修改人" dataIndex="update_name" width="100"
						align="center" hidden="true" />
					<aos:column header="修改时间" dataIndex="update_time" width="150"
						align="center" hidden="true" />
					<aos:column header="模板项目来源ID" dataIndex="from_templete_proj_id" width="150"
						align="center" hidden="true"/>
					<aos:column header="测试版本号来源ID" dataIndex="from_test_version_id" width="150"
						align="center" hidden="true"/>
					<aos:column header="测试用例来源ID" dataIndex="from_standard_id" width="150"
						align="center" hidden="true"/>
					
				</aos:gridpanel>
			</aos:panel>
		</aos:panel>
		<!-- 查看缺陷详情 -->
		<aos:window id="bug_count_win" width="860" height="450"
			onhide="hide_reset" title="缺陷详情" >
			<aos:gridpanel id="bug_count_grid" url="bugManageService.bugpage"
				forceFit="false" anchor="100%" border="true"
				 region="center" bodyBorder="1 0 1 0" >
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<aos:column header="缺陷ID" dataIndex="bug_id" fixedWidth="100"
					hidden="true" />
				<aos:column header="消息记录ID" dataIndex="log_id" width="100"
					hidden="true" />
				<aos:column header="需求ID" dataIndex="demand_id" width="100"
					hidden="true" />
				<aos:column header="测试用例ID" dataIndex="standard_id" width="100"
					hidden="true" />
				<aos:column header="测试用例名称" dataIndex="standard_name" width="100"
					hidden="true" />
				<aos:column header="缺陷详情" dataIndex="bug_detail" width="100"
					hidden="true" />
				<aos:column header="当前状态" dataIndex="state" width="80"
					align="center" rendererFn="fn_bug_state" />
				<aos:column header="缺陷编码" dataIndex="bug_code" width="130"
					align="center" />
				<aos:column header="缺陷名称" dataIndex="bug_name" width="300"
					rendererFn="fn_bug_read" />
				<aos:column header="严重程度" dataIndex="severity" width="80"
					align="center" rendererField="bug_severity" />
				<aos:column header="缺陷位置" dataIndex="bug_addr" width="80"
					rendererField="bug_addr" align="center" />
				
				<aos:column header="优先级" dataIndex="priority" width="60"
					align="center" rendererField="bug_priority" />
				<aos:column header="类型" dataIndex="bug_type" width="100"
					align="center" rendererField="bug_type" />
				<aos:column header="模块" dataIndex="dm_name" width="100" align="left" />
				<aos:column header="上级模块" dataIndex="dm_parent_name" width="100" />
				<aos:column header="当前处置人" dataIndex="deal_man_name" width="100"
					align="center" />
				<aos:column header="发现人" dataIndex="find_name" width="100"
					align="center" />
				<aos:column header="发现时间" dataIndex="find_time" width="150"
					align="center" />
				<aos:column header="创建人id" dataIndex="create_name" width="100"
					align="center" hidden="true" />
				<aos:column header="创建人" dataIndex="bug_create_name" width="100"
					align="center" />
				<aos:column header="创建时间" dataIndex="create_time" width="150"
					hidden="true" />
				<aos:column header="版本号id" dataIndex="version_id" width="150"
					align="center" hidden="true" />
				<aos:column header="代码版本号id" dataIndex="code_version_id" width="150"
					align="center" hidden="true" />
				<aos:column header="版本号" dataIndex="version_number" width="150"
					align="center" />
				<aos:column header="代码版本号" dataIndex="code_version_number"
					width="150" align="center" />
				<aos:column header="测试版本号id" dataIndex="test_version_id" width="150"
					align="center" hidden="true" />
				<aos:column header="测试版本号" dataIndex="test_version_number" width="150"
					align="center"  />
				<aos:column header="项目ID" dataIndex="proj_id" width="100"
					hidden="true" />
				<aos:column header="模块ID" dataIndex="stand_id" width="100"
					hidden="true" />
				<aos:column header="出现频率" dataIndex="rate" width="100"
					align="center" rendererField="bug_rate" />
				<aos:column header="当前处置人id" dataIndex="deal_man" width="100"
					align="center" hidden="true" />
				<aos:column header="来源方" dataIndex="source" width="100"
					align="center" rendererField="bug_source" />
				<aos:column header="修改人" dataIndex="bug_update_name" width="100"
					align="center" />
				<aos:column header="修改时间" dataIndex="update_time" width="150"
					align="center" />
				<aos:column header="关闭人" dataIndex="close_name" width="100"
					align="center" />
				<aos:column header="关闭时间" dataIndex="close_time" width="150"
					align="center" />
				<aos:column header="项目" dataIndex="proj_name" width="150"
					align="left" />
			</aos:gridpanel>
		</aos:window>
		
		<aos:window id="importExcle_win" title="导入测试用例">
			<aos:formpanel id="importExcle_form" width="450" layout="anchor"
				labelWidth="70">
				<aos:filefield id="excel_file" name="excel_file" fieldLabel="文件路径"
					buttonText="选择" labelWidth="60" allowBlank="false" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="importExcle_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#importExcle_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>
		<%-- 新增窗口 --%>
		<aos:window id="bug_win" title="新增缺陷">
			<aos:formpanel id="bug_form" width="1500" layout="column"
				height="800" labelWidth="70" msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:hiddenfield name="bug_id" fieldLabel="缺陷id" />
					<aos:hiddenfield name="log_id" fieldLabel="消息记录id" />
					<aos:textfield name="bug_code" fieldLabel="缺陷编码" allowBlank="true"
						readOnly="true" emptyText="保存后自动生成" columnWidth="0.25" />
					<aos:combobox fieldLabel="项目" name="proj_id" editable="false"
						allowBlank="false" columnWidth="0.25" readOnly="true"
						url="projCommonsService.listComboBoxUerid&type=all"
						onchange="on_public_com_win" />
					<aos:combobox fieldLabel="模块" name="stand_id" editable="false"
						allowBlank="true" columnWidth="0.25"
						url="moduleDivideService.listModuleDivideComboBox"
						onchange="on_public_stand_id" />
					<aos:combobox fieldLabel="需求" name="demand_id" editable="false"
						allowBlank="true" columnWidth="0.25"
						url="demandActionService.listdemand" />
					<aos:textfield name="bug_name" fieldLabel="缺陷名称" maxLength="100"
						allowBlank="false" columnWidth="0.25" />
					<aos:combobox fieldLabel="测试用例" name="standard_id" id="bug_standard_id"
						columnWidth="0.25" url="testExampleService.listdemand" />
					<aos:combobox fieldLabel="缺陷状态" name="state" value="1000"
						dicField="bug_states" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="严重程度" name="severity" value="1001"
						dicField="bug_severity" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="优先级" name="priority" value="1001"
						dicField="bug_priority" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷位置" name="bug_addr" value="1000"
						dicField="bug_addr" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="出现频率" name="rate" value="1000"
						dicField="bug_rate" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="来源类型" name="source" value="1000"
						dicField="bug_source" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷类型" name="bug_type" value="1000"
						dicField="bug_type" columnWidth="0.25">
					</aos:combobox>
					<aos:textfield name="find_name" fieldLabel="发现人"
						value="${user.name}" readOnly="false" allowBlank="true"
						columnWidth="0.25" />
					<aos:datetimefield name="find_time" fieldLabel="发现时间"
						editable="false" value="${time}" format="Y-m-d H:i:s"
						allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="create_name" fieldLabel="创建人"
						value="${user.id}" readOnly="true" allowBlank="true"
						columnWidth="0.25" />
					<aos:datetimefield name="create_time" fieldLabel="创建时间"
						value="${time}" readOnly="true" format="Y-m-d H:i:s"
						allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="close_name" fieldLabel="关闭人" allowBlank="true"
						readOnly="true" columnWidth="0.25" />
					<aos:datetimefield name="close_time" fieldLabel="关闭时间"
						format="Y-m-d H:i:s" allowBlank="true" readOnly="true"
						columnWidth="0.25" />
					<aos:combobox fieldLabel="指派处理人" name="deal_man" typeAhead="true" forceSelection="true" selectOnFocus="true" 
						id="combo_deal_man" editable="true" allowBlank="false" queryMode="local"
						columnWidth="0.25" url="projCommonsService.listComboBoxProjId" />
					<aos:combobox fieldLabel="版本号" name="version_id" allowBlank="false"
						columnWidth="0.25" id="bug_version_id" queryMode="local"
						onselect="versionOnSelect"
						url="bugManageService.listComboBoxVersionId" />
					<aos:combobox fieldLabel="测试版本号" name="test_version_id" id="bug_test_version_id"
						allowBlank="false" columnWidth="0.25" queryMode="local" onselect="test_versionOnSelect"
						editable="false" url="bugManageService.listComboBoxTestVersionId" />
					<aos:combobox fieldLabel="代码版本号" name="code_version_id"
						allowBlank="false" columnWidth="0.25" queryMode="local"
						id="bug_code_version_id" editable="false" 
						url="bugManageService.listComboBoxCodeVersionId" />
				</aos:fieldset>
				<aos:fieldset labelWidth="70" columnWidth="1" border="true"
					title="缺陷详情">
					<aos:panel columnWidth="0.9" margin="5" padding="5"
						contentEl="bug_desc_div" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="bug_form_save" text="保存" icon="ok.png"
					tooltip="保存" />
				<aos:dockeditem onclick="#bug_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>

		<%-- 复制窗口 --%>
		<aos:window id="copy_win" width="400" height="140" title="复制测试用例">
			<aos:formpanel id="copy_form" layout="anchor" labelWidth="70"
				msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:textfield fieldLabel="版本号" width="350" name="version"
						id="version" allowBlank="false" maxLength="20" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="fn_copy_save" text="保存" icon="ok.png"
					tooltip="保存" />
				<aos:dockeditem onclick="#copy_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>


		<%-- 复制窗口2 --%>
		<aos:window id="copy_win2" width="400" height="140" title="复制测试用例">
			<aos:formpanel id="copy_form2" layout="anchor" labelWidth="70"
				msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:textfield fieldLabel="版本号" name="version" width="350"
						id="version" allowBlank="false" maxLength="20" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="fn_copy_save2" text="保存" icon="ok.png"
					tooltip="保存" />
				<aos:dockeditem onclick="#copy_win2.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>

		<aos:window id="pass_or_fail_na" title="备注（实际结果）">
			<aos:formpanel id="change_test_na" 
				width="450"
			  	layout="anchor" 
			  	labelWidth="70"
			  	msgTarget="qtip"
			  	center="true">
					<aos:textfield fieldLabel="备注" name="actual_results" allowBlank="false"  />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="sure_pass_or_fail" text="确定" icon="ok.png" />
				<aos:dockeditem onclick="#pass_or_fail_na.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="pass_or_fail_block" title="备注（实际结果）">
			<aos:formpanel id="change_test_block" 
				width="450"
			  	layout="anchor" 
			  	labelWidth="70"
			  	msgTarget="qtip"
			  	center="true">
					<aos:textfield fieldLabel="备注" name="actual_results" allowBlank="false"  />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="sure_pass_or_fail_two" text="确定" icon="ok.png" />
				<aos:dockeditem onclick="#pass_or_fail_block.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>

		<aos:window id="testexample_log_win" title="历史执行详情">
			<aos:gridpanel id="log_grid" url="testExampleService.logPage"
				onrender="fn_query_detail" forceFit="true" region="center"
				bodyBorder="1 0 1 0" hidePagebar="true" autoScroll="true"
				width="1030" height="400">
				<aos:column type="rowno" align="center" />
				<aos:column header="实际结果" dataIndex="actual_results" width="150" />
				<aos:column header="执行人" dataIndex="tester_name" width="150" />
				<aos:column header="执行时间" dataIndex="test_time" width="150" />
				<aos:column header="执行结果" dataIndex="pass_or_fail"
					rendererField="pass_or_fail" width="150" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#testexample_log_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
		<script type="text/javascript">
		//按钮列转换
			function fn_button_execute(value, metaData, record) {
				return '<input type="button" value="执行" class="cbtn" onclick="w_execute_show();" />';
			}
			//按钮列转换
			function fn_button_del(value, metaData, record) {
				return '<input type="button" value="删除" class="cbtn" onclick="fn_del();" />';
			}
			
			function proj_name_query(){
				var proj_name = AOS.getValue('proj_name');
				t_org_find_store.load({
					params:{
						proj_name : proj_name
					}
				})
			}
			
			function reset(){
				AOS.reset(query_form);
				AOS.setValue('query_form.stand_id',"");
			}
			
			//批量PASS处理
			function fn_pass(){
				var record = AOS.select(example_grid);
				var selection = AOS.selection(example_grid,'standard_id');
				if(AOS.empty(record)){
					AOS.tip("请选择要PASS的数据。");
					return;
				}
				var rows = AOS.rows(example_grid);
				var msg = AOS.merge('确定要对选中的{0}条用例进行PASS操作吗？',rows);
				AOS.confirm(msg,function(btn){
					if(btn == 'cancel'){
						return;
					}
					AOS.ajax({
						url : 'testExampleService.changePass',
						params : {
							aos_rows : selection
						},
						ok : function(data){
							AOS.tip(data.appmsg);
							example_grid_store.reload();
						}
					});
				});
			}
			
			//批量N/A处理
			function fn_na(){
				AOS.reset(change_test_na);
				var record = AOS.select(example_grid);
				if(AOS.empty(record)){
					AOS.tip("请选择要N/A的数据。");
					return;
				}
				pass_or_fail_na.show();
			}
			
			//批量N/A处理
			function sure_pass_or_fail(){
				var record = AOS.select(example_grid);
				var selection = AOS.selection(example_grid,'standard_id');
				var params = AOS.getValue('change_test_na');
				var actual_results = params.actual_results;
				AOS.ajax({
					url : 'testExampleService.changeNA',
					params : {
						aos_rows : selection,
						actual_results : actual_results
					},
					ok : function(data){
						AOS.tip(data.appmsg);
						pass_or_fail_na.hide();
						example_grid_store.reload();
					}
				});
			}
			
			//批量处理BLOCK
			function fn_block(){
				AOS.reset(change_test_block);
				var record = AOS.select(example_grid);
				if(AOS.empty(record)){
					AOS.tip("请选择要BLOCK的数据。");
					return;
				}
				pass_or_fail_block.show();
			}
			
			//批量处理BLOCK
			function sure_pass_or_fail_two(){
				var record = AOS.select(example_grid);
				var selection = AOS.selection(example_grid,'standard_id');
				var params = AOS.getValue('change_test_block');
				var actual_results = params.actual_results;
				AOS.ajax({
					url : 'testExampleService.changeBLOCK',
					params : {
						aos_rows : selection,
						actual_results : actual_results
					},
					ok : function(data){
						AOS.tip(data.appmsg);
						pass_or_fail_block.hide();
						example_grid_store.reload();
					}
				});
			}
			
			//查看总缺陷
			function fn_bug_show(value, metaData, record){
				if(value != 0) {
					return '<a href="javascript:void(0);">' + record.data.bug_counts + '</a>';
				}
				return value;
			}
			example_grid.on("cellclick", function(grid, rowIndex, columnIndex, e){
				var record = AOS.selectone(example_grid, true);
				if(AOS.empty(record) || record.length>1){
					AOS.tip('只能勾选一列查看缺陷详情。');
					return;
				}
				if (columnIndex == 14 ) {
					var record = AOS.selectone(example_grid);
					bug_count_win.show();
					var standard_id = record.data.standard_id;
					var proj_id = id_proj_name.getValue();
					var params = {standard_id : standard_id , proj_id : proj_id};
					bug_count_grid_store.getProxy().extraParams = params;
					bug_count_grid_store.loadPage(1);
				}
			});
			
			function fn_bug_read(value, metaData, record){
				return '<a href="javascript:void(0);">' + record.data.bug_name + '</a>';
			}
			bug_count_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				 var record = AOS.selectone(bug_count_grid, true); 
				if(AOS.empty(record) || record.length>1){
					AOS.tip('只能勾选一列查看缺陷详情。');
					return;
				}
				if (columnIndex == 4 ) {
					window.open("do.jhtml?router=bugManageService.newsdataInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+record.get("bug_id"));
				} 
			});
			
			//回归测试结果渲染
			function fn_test_result(value, metaData, record){
				var bug_counts = record.get('bug_counts');
				var close_counts = record.get('close_counts');
				var delay_counts = record.get('delay_counts');
				var reopen_counts = record.get('reopen_counts');
				if(bug_counts == 0){
					return null;
				}else{
					if(bug_counts == close_counts){
						return "<span style='color:green; font-weight:bold'>Y</span>";
					}else if(reopen_counts !== 0 ){
						return "<span style='color:red; font-weight:bold'>N</span>";
					}else{
						return null;
					}				
				}
			}
			
			//测试用例状态渲染
			function fn_example_state(value, metaData, record){
				if(value =='0'){
					return "<span style='background-color:#E8C1E0; font-weight:bold'>FAIL</span>";
				}else if(value =='1'){
					return "<span style='background-color:#11EE96; font-weight:bold'>PASS</span>";
				}else if(value =='2'){
					return "<span style='background-color:#E8C1E0; font-weight:bold'>BLOCK</span>";
				}else if(value =='3'){
					return "<span style='background-color:#F3F350; font-weight:bold'>N/A</span>";
				}else{
					return null;
				}
				
			}
			 //缺陷状态渲染
			function fn_bug_state(value, metaData, record){
				if(value =='1000'){
					return "<span style='color:#EEC900; font-weight:bold'>未解决</span>"; 
				}else if(value == '1001'){
					return "<span style='color:green; font-weight:bold'>已解决</span>"; 
				}else if(value == '1002'){
					return "<span style='color:blue; font-weight:bold'>延期处理</span>"; 
				}else if(value == '1003'){
					return "<span style='color:#D3D3D3; font-weight:bold'>关闭</span>"; 
				}else if(value == '1004'){
					return "<span style='color:red; font-weight:bold'>拒绝</span>"; 
				}else if(value == '1005'){
					return "<span style='color:#EE0000; font-weight:bold'>重新打开</span>"; 
				}else if(value == '1006'){
					return "<span style='color:#3399CC; font-weight:bold'>无法复现</span>";
				}else{
					return value;
				}
			}			
			
			//项目版本号下拉框选择
			function versionOnSelect(me, records){
				var version_id = me.getValue();
				bug_test_version_id.getStore().getProxy().extraParams = {
					version_id : version_id
				}; 
				bug_test_version_id.getStore().load({
					callback : function(records, operation, success) {
						//这个回调里还可以根据是否查询到二级模块再去做一些事情
						if (records.length > 0) {
							AOS.edit(bug_test_version_id);
						}else{
							AOS.read(bug_test_version_id);
						}
					}
				});
			}
			
			//代码版本号下拉框选择
			function test_versionOnSelect(me,records){
				var test_version_id = me.getValue();
				bug_code_version_id.getStore().getProxy().extraParams = {
					test_version_id : test_version_id
				}
				bug_code_version_id.getStore().load({
					callback : function(records, operation, success){
						if (records.length > 0) {
							AOS.edit(bug_code_version_id);
						}else{
							AOS.read(bug_code_version_id);
						}
					}
				});
			}
			 
			 //查询测试用例列表/分页
	        function example_grid_query() {
				var proj_id = id_proj_name.getValue();
	        	var params = AOS.getValue('query_form');
	        	var record = AOS.selectone(public_module_divide_tree);
	        	var stand_id = record.data.id;
	        	params.stand_id = stand_id;
	        	if(AOS.empty(params.test_version_id)){
	        		AOS.tip("请先选择测试用例版本号。");
	        		return;
	        	}else{
	        		if(proj_id == stand_id){
	        			params.stand_id = null;
	        			example_grid_store.getProxy().extraParams = params;
			            example_grid_store.loadPage(1);
	        		}else{
			            example_grid_store.getProxy().extraParams = params;
			            example_grid_store.loadPage(1);	        			
	        		}
	        	}
	        }  
	        //窗口隐藏触发
	        function hide_reset(){
	        	AOS.reset(example_form);
	        	AOS.setValue("example_form.stand_id","");
	        }
	        //通过时间渲染
	        function fn_pass_time(value){
	        	var date1 = new Date(value).getTime();
	        	var date2 = new Date("1999-01-01 00:00:00").getTime();
	        	if(date1 == date2){
	        		return "";
	        	}
	        	return value;
	        }
			//显示新增/修改 窗口
			function example_win_show(editModel){
				AOS.reads(example_form, 'proj_id');
				example_form.editModel=editModel;
				var records = AOS.select(example_grid, true);
				var record = records[0];
				var proj_id = id_proj_name.getValue();
				if(!AOS.empty(record)){
					var standard_id = record.data.standard_id;
				}
				if(editModel=="update" || editModel=="particulars"){
					if(AOS.empty(records)||records.length>1){
							AOS.tip('请选择一条需要修改的数据。');
							return;   
					}
					if(editModel=="particulars"){
						example_win.setTitle("查看测试用例");
						reads(true);
					}else{
						example_win.setTitle("修改测试用例");
						reads(false);
					}
					//from表单注入数据
					AOS.setValues(example_form,record.raw);
					var standard_detail = record.data.standard_detail;//测试步骤
					var expected_results = record.data.expected_results;//期待结果
					standard_detail = standard_detail.replace(/<br>/g,"\n" );
					expected_results = expected_results.replace(/<br>/g,"\n");
					AOS.get('example_form.test_version_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					}
					AOS.get('example_form.test_version_id').getStore().load();
					AOS.setValue("example_form.standard_detail",standard_detail);
					AOS.setValue("example_form.expected_results",expected_results);
					AOS.setValue("example_form.demand_id",Number(record.raw.demand_id));
					AOS.setValue("example_form.raw_execute_code",record.data.execute_code+"");
					//AOS.setValue("example_form.version",record.data.version);
					AOS.setValue("example_form.test_version_id",record.data.test_version_id);
					example_win.show();
				}else{
					example_win.setTitle("新增测试用例");
					AOS.reset(example_form);
					var record = AOS.selectone(public_module_divide_tree);
					if(!AOS.empty(record)){
						var stand_id = record.data.id;
						AOS.setValue("example_form.proj_id",Number(id_proj_name.getValue()));
						AOS.setValue("example_form.stand_id",stand_id);
					}
					var proj_id = id_proj_name.getValue();
					/* AOS.get('example_form.version').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('example_form.version').getStore().load(); */
					AOS.get('example_form.test_version_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					}
					AOS.get('example_form.test_version_id').getStore().load();
					AOS.setValue("example_form.demand_id", Number(AOS.get('query_form.query_demand_id').value));
					//AOS.setValue("example_form.version", AOS.get('query_form.version').value);
					AOS.get('example_form.standard_code').getStore().load({
						params :{
							proj_id : proj_id,
							flag : 0,
							version : AOS.get('query_form.version').value
						}
					});
					example_win.show();
					reads(false);
				}
			}
			
			//是否只读
			function reads(flag){
				var save_btn = AOS.get("save_btn");
				var hide_btn = AOS.get("hide_btn");
				if(flag == true){
				//批量只读
					AOS.reads(example_form, 'proj_id,stand_id,standard_name,standard_code,test_resolution,execute_code'
						+',demand_id,test_browser,standard_detail,pass_or_fail'
						+',expected_results,actual_results');
					hide_btn.hide();
					save_btn.hide();
				}else if(flag == false){
					AOS.edits(example_form, 'stand_id,standard_name,standard_code,test_resolution,execute_code'
						+',demand_id,test_browser,standard_detail,pass_or_fail'
						+',expected_results,actual_results');
					hide_btn.show();
					save_btn.show();
				}
			}
			//导出excel
			function fn_export_excel(){
				//+a预防界面选择都是空模块的数据，后台字符串转数组截取不到
				var standardCodes = AOS.selection(example_grid,'standard_code');
				var standardIds = AOS.selection(example_grid,'standard_id');
				if(standardCodes.length == 0){
					AOS.tip("导出前请选择数据。");
					return;
				}
				var record = AOS.select(example_grid);
				AOS.file('do.jhtml?router=testExampleService.exportExcel&juid=${juid}&standardIds='+standardIds+'&standardCodes='+standardCodes);
			}
			
			//全部导出excel
			function fn_all_export_excel(){
				var record = AOS.selectone(public_module_divide_tree);
				var params = AOS.getValue('query_form');
				var proj_id = all_proj_id;
				var stand_id = '';
				var id = record.data.id;
				if(id == proj_id){
					stand_id = '';
				}else{
					stand_id = id;
				}
				var start = 0;
				var limit = 50;
				var test_version_id = params.test_version_id;
				if(test_version_id === undefined){
					test_version_id ="";
				}
				var pass_or_fail = params.pass_or_fail;
				if(pass_or_fail === undefined){
					pass_or_fail ="";
				}
// 				var query_demand_id = params.query_demand_id;
// 				if(query_demand_id === undefined){
// 					query_demand_id ="";
// 				}
				var tester_name = params.tester_name;
				if(tester_name === undefined){
					tester_name ="";
				}
				var is_execute = params.is_execute;
				if(is_execute === undefined){
					is_execute ="";
				}
				AOS.file('do.jhtml?router=testExampleService.allExportExcel&juid=${juid}&proj_id='+proj_id
						+'&pass_or_fail='+pass_or_fail
// 						+'&query_demand_id='+query_demand_id
						+'&tester_name='+tester_name
						+'&is_execute='+is_execute
						+'&start='+start
						+'&limit='+limit
						+'&stand_id='+stand_id
						+'&test_version_id='+test_version_id);
			}
			
			//导入excel
			function fn_import_excel(){
				/* var record = AOS.selectone(public_module_divide_tree);
				var stand_id = record.data.id;
				if(stand_id == 0){
					 AOS.tip("请在模块树当中选择你要导入数据的模块！");
					 return;
				} */
// 				var demand_id = AOS.getValue('query_form.query_demand_id');
				var test_version_id = AOS.getValue('query_form.test_version_id');
				if(AOS.empty(test_version_id)){
					AOS.tip("请先选择测试版本号");
					return ;
				}
				importExcle_win.show();
			}
			//导入保存按钮
			function importExcle_save(){
				 var filenPath = AOS.getValue('importExcle_form.excel_file');
				   if(filenPath==''){
					   AOS.tip("请选择一个文件！");
					   return;
				   }
// 				    var demand_id = AOS.getValue('query_form.query_demand_id');
					var test_version_id = AOS.getValue('query_form.test_version_id');
				    var record = AOS.selectone(public_module_divide_tree);
					var stand_id = record.data.id;
					var params = new Object();
					if(record.data.parentId == 0){
						var proj_id = id_proj_name.getValue();
						params.proj_id=proj_id;
						params.demand_id = demand_id;
						params.test_version_id = test_version_id;
					}else{
						var proj_id = id_proj_name.getValue();
						AOS.setValue("query_form.stand_id",stand_id);
						AOS.setValue("query_form.proj_id",proj_id);
						params.proj_id=proj_id;
						params.stand_id=stand_id;
						params.demand_id = demand_id;
						params.test_version_id = test_version_id;
					}
				   fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
				   if (fileExtension != ".xls" && fileExtension != ".xlsx") {
		 				AOS.tip('请选择excel文件进行导入!');
		 				return;
				    }
				   importExcle_form.getForm().fileUpload = true;
				   importExcle_form.getForm().submit({
				    		type : 'POST',
				    		params : params,
							url:'do.jhtml?router=testExampleService.importFile&juid=${juid}',
							waitMsg:'文件导入中...',
							success: function(form, action) {
								AOS.tip(action.result.msg);
								importExcle_win.hide(); 
								example_grid_store.reload();
				    		},
							 failure: function() {
								 importExcle_win.hide();
								AOS.tip("数据导入失败！");
							 } 
					 });
				  
			}
			
			//所属用例下拉变更事件
	function on_standard(me, records){
		var standard_code = me.getValue();
		var stand_id = AOS.getValue('example_form.stand_id');
		if(AOS.empty(standard_code)){
			//AOS.edits(example_form,'precondition,demand_id,data_sql,test_environment');
			//AOS.get('example_form.precondition').setValue("");
			AOS.get('example_form.demand_id').setValue("");
			//AOS.get('example_form.data_sql').setValue("");
			//AOS.get('example_form.test_environment').setValue("");
		}else{
			var records = AOS.get('example_grid').getStore().getRange(0, AOS.get('example_grid').getStore().getCount());
			//var precondition = "";
			var demand_id = "";
			//var data_sql = "";
			//var test_environment = "";
			var number = 1;
			for(var i=0;i<records.length;i++){
				if(AOS.empty(stand_id)){
					if(records[i].data.standard_code == standard_code){
						//precondition = records[i].data.precondition;
						demand_id = Number(records[i].raw.demand_id);
						//data_sql = records[i].data.data_sql;
						//test_environment = records[i].data.test_environment;
						number++;
					}
				}else {
					if(records[i].data.stand_id == stand_id){
						//precondition = records[i].data.precondition;
						demand_id = Number(records[i].raw.demand_id);
						//data_sql = records[i].data.data_sql;
						//test_environment = records[i].data.test_environment;
						number++;
					}
				}
			}
			//AOS.get('example_form.precondition').setValue(precondition);
			AOS.get('example_form.demand_id').setValue(demand_id);
			//AOS.get('example_form.data_sql').setValue(data_sql);
			//AOS.get('example_form.test_environment').setValue(test_environment);
			AOS.get('example_form.execute_code').setValue(number);
			/* if(!AOS.empty(demand_id)){
				AOS.reads(example_form,'proj_id,standard_code,precondition,demand_id,data_sql,test_environment');
			}else{
				AOS.edits(example_form,'standard_code,stand_id,precondition,demand_id,data_sql,test_environment');
			} */
		}
	}
	
			//新增/修改测试用例保存
	        function example_form_save() {
	        	 // 表单验证通过标志，缺省为true
			    var isValid = true;
			    if (!Ext.isEmpty(example_form)) {
			        Ext.Array.each(example_form, function (form) {
			            // 表单验证
			            if (!form.isValid()) {
			                isValid = false;
			            }
			        });
			    }
			    // 如果是表单提交，且表单验证不通过则返回
			    if (!isValid) {
			        Ext.log('表单合法性校验未通过，Ajax请求取消。如果这和您的预期不符，请检查调用AOS.ajax()时是否多传或错传了forms参数。');
			        return;
			    }
	        	AOS.ajax({
					params:{
							standard_code : AOS.get('example_form.standard_code').rawValue,
							standard_name : AOS.getValue('example_form.standard_name'),
							standard_id : AOS.getValue('example_form.standard_id'),
							proj_id : AOS.getValue('example_form.proj_id'),
							stand_id : AOS.getValue('example_form.stand_id'),
							execute_code : AOS.getValue('example_form.execute_code'),
							demand_id : AOS.getValue('example_form.demand_id'),
							//test_environment : AOS.getValue('example_form.test_environment'),
							//precondition : AOS.getValue('example_form.precondition'),
							standard_detail : AOS.getValue('example_form.standard_detail'),
							expected_results : AOS.getValue('example_form.expected_results'),
							//data_sql : AOS.getValue('example_form.data_sql'),
							raw_execute_code : AOS.getValue('example_form.raw_execute_code'),
							//version : AOS.getValue('example_form.version'),
							priority : AOS.getValue('example_form.priority'),
							function_module : AOS.getValue('example_form.function_module'),
							test_premise : AOS.getValue('example_form.test_premise'),
							test_version_id : AOS.getValue('example_form.test_version_id')
						},
					url : example_form.editModel=="update" ? 'testExampleService.update':'testExampleService.create',
					ok : function(data) {
						AOS.tip(data.appmsg);
						var record = AOS.select(example_grid,true)[0];
						example_grid_store.reload({
							callback : function(records, operation, success) {
								example_grid.getSelectionModel().select(example_form.editModel=="update" ? record.index:0);
							}
						});
						example_win.hide();
					}
				});
	        }
	        
			//删除选中的测试用例
			function example_grid_del(){
				var record = AOS.select(example_grid);
				var selection = AOS.selection(example_grid,'standard_id');
				var execute_code = AOS.selection(example_grid,'execute_code');
				var standard_code = AOS.selection(example_grid,'standard_code');
				if(AOS.empty(record)){
					AOS.tip('请选择需要删除的数据。');
					return;
				}
				for(var i=0;i<record.length;i++){
					if(record[i].data.return_state == 1){
						AOS.tip('已回归测试的用例不能删除。');
						return;
					}
				}
				var rows = AOS.rows(example_grid);
				var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						return;
					}
					AOS.ajax({
						url : 'testExampleService.delete',
						params:{
							aos_rows: selection,
							execute_code:execute_code,
							standard_code:standard_code
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							example_grid_store.reload();
						}
					});
				});
			}
			
			//响应导航菜单树节点单击事件
		function fn_node_click(view, record, item, index, e) {
			//菜单节点所属的那个卡片标识，也是当前菜单树的根节点
			var root_id = record.getPath().split('/')[2];
			var url =  record.raw.a;
			if (!Ext.isEmpty(url)) {
				fnaddtab(url,record.raw.text,record.raw.id,  root_id);
			}else{
				if(record.raw.leaf){
					 AOS.tip('没有配置菜单的请求地址。');
				}
			}
		}
		
//打开菜单功能页面
	function fnaddtab(url, menuname, module_id, root_id) {
		if (Ext.isEmpty(url)) {
			return;
		}
		var id = "id_tab_" + module_id;
		url = url.indexOf('http://') === 0 ? url : '${cxt}/http/do.jhtml?router=' + url;
		var index = url.indexOf('?');
		//一级菜单的主页面所属的页面元素其pageid_同moduleid_。
		url = url + (index === -1 ? '?' : '&') + 'juid=${juid}' + '&aos_module_id=' + module_id;
		var tabs = Ext.getCmp('tabs');
		var tab = tabs.getComponent(id);
		var tempflag = 0;
		if (!tab) {
			var iframe = Ext.create('AOS.ux.IFrame', {
				id : id + '.iframe',
				mask : true,
				layout : 'fit',
				//这个参数仅起到将iframe组件自带的mask调节到相对居中位置的作用
				height : document.body.clientHeight - 200,
				loadMask : '${page_load_msg}'
			});
			tab = tabs.add({
				id : id,
				module_id: module_id, //供Tab与导航树逆向联动使用。
				root_id: root_id, //菜单节点所属的那个卡片标识，也是当前菜单树的根节点。供Tab与导航树逆向联动使用。
				title : '<span class="app-container-title-normal">' + menuname + '</span>',
				closable : true,
				layout : 'fit',
				items : [ iframe ]
			});
			tab.on('activate', function() {
				//防止已打开的功能页面切回时再次加载
				if (tempflag === 0) {
					iframe.load(url);
					tempflag = 1;
				}
				//切换的时候和导航树保持同步
				fn_sync_tab_tree(tab);
			});
		}
		//激活新增Tab
		tabs.setActiveTab(tab);
	}
	
	//树节点单击函数
	function on_public_tree(){
		var record = AOS.selectone(public_module_divide_tree);
		var stand_id = record.data.id;
		var params = AOS.getValue('query_form');
		if(record.data.parentId == 0){
			params.stand_id = '';
			var proj_id = id_proj_name.getValue();
			params.proj_id=proj_id;
			AOS.get('query_form.version').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('query_form.version').getStore().load({
				callback : function(){
					var count = AOS.get('query_form.version').store.getCount();
					if(count>0){
						var value = AOS.get('query_form.version').store.getAt(0).raw.value;
						var version = AOS.getValue('query_form.version');
						params.version = value;
						AOS.get('query_form.version').setValue(value);
						example_grid_store.getProxy().extraParams = params;
				        example_grid_store.loadPage(1);
					}else{
						example_grid_store.getProxy().extraParams = params;
				        example_grid_store.loadPage(1);
					}
				}
			});
		}else{
			var proj_id = id_proj_name.getValue();
			AOS.setValue("query_form.stand_id",stand_id);
			AOS.setValue("query_form.proj_id",proj_id);
			params.proj_id=proj_id;
			params.stand_id=stand_id;
			params.version = version;
			AOS.get('query_form.version').getStore().getProxy().extraParams = {
				proj_id : proj_id,
				stand_id:stand_id
			};
			AOS.get('query_form.version').getStore().load({
				callback : function(){
				var count = AOS.get('query_form.version').store.getCount();
				if(count>0){
					var value = AOS.get('query_form.version').store.getAt(0).raw.value;
					var version = AOS.getValue('query_form.version');
					params.version = value;
					AOS.get('query_form.version').setValue(value);
					example_grid_store.getProxy().extraParams = params;
			        example_grid_store.loadPage(1);
				}else{
					example_grid_store.getProxy().extraParams = params;
			        example_grid_store.loadPage(1);
					 }
				}
			});
		}
	}
	
	//项目下拉框添加变更事件
	function on_query_com(me, records){
		var proj_id = me.getValue();
		AOS.get('query_form.stand_id').getStore().getProxy().extraParams = {
			proj_id : proj_id
		};
		AOS.get('query_form.stand_id').getStore().load();
	}
	//模块下拉变更事件
	function on_module(me, records){
		var stand_id = me.getValue();
		var flag = 0;
		if(!AOS.empty(stand_id)){
			flag = 1;
		}
		var proj_id = AOS.getValue('query_form.proj_id');
	/* 	AOS.get('example_form.standard_code').getStore().getProxy().extraParams = {
			stand_id : stand_id,
			proj_id : proj_id,
			flag : flag
		}; */
		AOS.get('example_form.standard_code').getStore().load({
			params :{
			stand_id : stand_id,
				proj_id : proj_id,
				flag : flag
			},
			callback : function(records, operation, success) {
				if(flag == 1){
					AOS.get('example_form.standard_code').setValue(stand_id);
					AOS.reads(example_form,'standard_code');
				}else{
					AOS.get('example_form.standard_code').setValue("");
					AOS.edits(example_form,'standard_code');
				};
			}}
		);
	}
	
	//项目下拉框添加变更事件
	function on_from_com(me, records){
		var proj_id = me.getValue();
			AOS.get('example_form.stand_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('example_form.stand_id').getStore().load();
			
			/* var stand_id = AOS.getValue('example_form.stand_id');
			AOS.get('example_form.standard_code').getStore().getProxy().extraParams = {
				proj_id : proj_id,
				stand_id : stand_id
			};
			AOS.get('example_form.standard_code').getStore().load(); */
			
			var stand_id = AOS.getValue('example_form.stand_id');
			AOS.get('example_form.demand_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('example_form.demand_id').getStore().load();
	}
	
	//根据选择项目名称刷新树和grid
		function tree_query(obj) {
			public_module_divide_tree_refresh('dm_parent_code');
			all_proj_id=obj.lastSelection[0].data.value;
			AOS.setValue("query_form.proj_id",all_proj_id);
			AOS.get('query_form.version').getStore().getProxy().extraParams = {
				proj_id : all_proj_id
			};
			AOS.get('query_form.version').getStore().load({
				callback : function(){
					var version_store_count =  AOS.get('query_form.version').store.totalCount;
					if(version_store_count>0){
						 AOS.setValue('query_form.version',AOS.get('query_form.version').store.getAt(0).raw.value);
					}
				}
			});
			
			AOS.get('query_form.query_demand_id').getStore().getProxy().extraParams = {
				proj_id : all_proj_id
			};
			AOS.get('query_form.query_demand_id').getStore().load({
				callback : function(){
					var demand_id_store_count =  AOS.get('query_form.query_demand_id').store.totalCount;
					if(demand_id_store_count>0){
						var value = AOS.get('query_form.query_demand_id').store.getAt(0).raw.value;
						AOS.setValue('query_form.query_demand_id',Number(value));
						example_grid_query();
					}
				}
			});
		}
		
		//默认选中第一个项目
		window.onload=function combobox_select(){/* 
	 		var record = AOS.get('t_org_find');
			var arr = record.store.tree.root.childNodes;
			if(arr.length >0){
				var proj_id = arr[0].raw.id;
				var porj_name = arr[0].raw.text;
				AOS.get('id_proj_name').setValue(proj_id);
				AOS.get('tree_proj_name').setValue(porj_name);
				//var proj_id = arr[0].raw.id;
		        var value = arr[0].raw.id;
				//AOS.get('pm_proj_id').setValue(value);
				all_proj_id=Number(value);
				AOS.setValue("query_form.proj_id",all_proj_id);
				public_module_divide_tree_refresh();
				AOS.get('query_form.query_demand_id').getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				};
				AOS.get('query_form.query_demand_id').getStore().load({
					callback : function(){
						var demand_id_store_count =  AOS.get('query_form.query_demand_id').store.totalCount;
						if(demand_id_store_count>0){
							var value = AOS.get('query_form.query_demand_id').store.getAt(0).raw.value;
							AOS.setValue('query_form.query_demand_id',Ext.util.Format.number(value));
						}
					}
				});
				
				AOS.get('query_form.version').getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				};
				AOS.get('query_form.version').getStore().load({
					callback : function(){
						var version_store_count =  AOS.get('query_form.version').store.totalCount;
						if(version_store_count>0){
							AOS.setValue('query_form.version',AOS.get('query_form.version').store.getAt(0).raw.value);
						}
						example_grid_query();
					}
				});
			}else{
				AOS.tip('该角色未分配项目，请先分配项目！');
			}  */
		}
		
		//执行窗口单元按钮变更事件
	function radioGroupChange(me,newValue){
		var pass_or_fail = me.getValue().pass_or_fail;
		if(pass_or_fail == 1){
			AOS.setValue("execute_form.actual_results",AOS.getValue("execute_form.expected_results"));
		}else if(pass_or_fail == 0){
			AOS.setValue("execute_form.actual_results","");
		}
	}
	//执行用例保存
       function execute_form_save() {
   	   		var pass_or_fail = AOS.getValue('execute_form.pass_or_fail');
   	   		if(AOS.empty(pass_or_fail )){
   	   			AOS.tip('请先选择结果。');
   	   			return;
   	   		}
       	AOS.ajax({
       		forms : execute_form,
			url : 'testExampleService.executeUpdate',
			ok : function(data) {
				AOS.tip(data.appmsg);
				var record = AOS.select(example_grid,true)[0];
				example_grid_store.reload({
					callback : function(records, operation, success) {
						example_grid.getSelectionModel().select(record.index);
					}
				});
				execute_win.hide();
			}
		});
       }
       
       //执行用例下一步按钮事件
       function execute_form_next(){
			var pass_or_fail = AOS.getValue('execute_form.pass_or_fail');
  	   		if(AOS.empty(pass_or_fail )){
  	   			AOS.tip('请先选择结果。');
  	   			return;
  	   		}
	       AOS.confirm("确定执行用例并跳到下一步吗？", function(btn){
				if(btn === 'cancel'){
					return;
				}
		     	AOS.ajax({
		       		forms : execute_form,
					url : 'testExampleService.executeUpdate',
					ok : function(data) {
						AOS.tip(data.appmsg);
						var record = AOS.select(example_grid,true)[0];
						example_grid_store.reload({
							callback : function(records, operation, success) {
								example_grid.getSelectionModel().select(record.index);
								execute_win.hide();
					       		var records = example_grid.getStore().getRange(0, example_grid.getStore().getCount())
					       		for(var i=0;i<records.length;i++){
					       			if(record.data.standard_code == records[i].data.standard_code){
					       				if(record.data.execute_code+1 <= records[i].data.execute_code){
					       					example_grid.getSelectionModel().select(i);
						       				w_execute_show();
						       				return;
					       				}
					       			}
					       		}
					       		AOS.tip("已经没有下一步了。。。"); 
							}
						});
					}
				});
			})
       }
       //----------------------------------------------------------------------
       //项目ID全局变量
		      var all_proj_id='';
       //新增\修改页面项目下拉框添加变更事件
				function on_public_com_win(me, records){
					var proj_id = all_proj_id;
					var stand_id = AOS.getValue("bug_form.stand_id");
					AOS.get('bug_form.stand_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('bug_form.stand_id').getStore().load({
						callback : function(records, operation, success) {
						}
					});
					AOS.get('bug_form.deal_man').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('bug_form.deal_man').getStore().load({
						callback : function(records, operation, success) {
						}
					});
					AOS.get('bug_form.demand_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('bug_form.demand_id').getStore().load({
						callback : function(records, operation, success) {
						}
					});
					if(Ext.isEmpty(stand_id)){
						AOS.get('bug_form.standard_id').getStore().getProxy().extraParams = {
							proj_id : proj_id
						};
						AOS.get('bug_form.standard_id').getStore().load({
							callback : function(records, operation, success) {
							}
						});
					}else{
						AOS.get('bug_form.standard_id').getStore().getProxy().extraParams = {
							proj_id : proj_id,
							stand_id : stand_id
						};
						AOS.get('bug_form.standard_id').getStore().load({
							callback : function(records, operation, success) {
							}
						});
					}
					
				}
				//模块下拉框添加变更事件
				function on_public_stand_id(me, records){
					var proj_id = all_proj_id;
					var stand_id = AOS.getValue("bug_form.stand_id");
					AOS.get('bug_form.standard_id').getStore().getProxy().extraParams = {
						proj_id : proj_id,
						stand_id : stand_id
					};
					AOS.get('bug_form.standard_id').getStore().load({
						callback : function(records, operation, success) {
							var record = AOS.selectone(AOS.get('example_grid'), true);
							AOS.setValue("bug_form.standard_id",Number(record.data.standard_id));
						}
					});
				}
			
	//显示新增/修改 窗口
			function bug_win_show(){
				/* AOS.ajax({
		       		forms : execute_form,
					url : 'testExampleService.executeUpdate',
					ok : function(data) {
						AOS.tip(data.appmsg);
						var record = AOS.select(example_grid,true)[0];
						example_grid_store.reload({
							callback : function(records, operation, success) {
								example_grid.getSelectionModel().select(record.index);
								execute_win.hide(); */
								//bug新增窗口
								var pass_or_fail = AOS.getValue('execute_form.pass_or_fail');
					   	   		if(AOS.empty(pass_or_fail )){
					   	   			AOS.tip('请先选择结果。');
					   	   			return;
					   	   		}
								bug_desc_editor=UM.getEditor('bug_desc_editor',{
									autoHeightEnabled:false,
									autoFloatEnabled:true
								});
								bug_win.setTitle("新增缺陷");
								var a = "执行前提：<br>&nbsp;&nbsp;"+AOS.getValue("execute_form.test_premise").replace(/\n/g, "<br>&nbsp;&nbsp;")+
									"<br><br>执行步骤：<br>&nbsp;&nbsp;"+AOS.getValue("execute_form.standard_detail").replace(/\n/g, "<br>&nbsp;&nbsp;")+
									"<br><br>期望结果：<br>&nbsp;&nbsp;"+AOS.getValue("execute_form.expected_results").replace(/\n/g, "<br>&nbsp;&nbsp;")+
									"<br><br>实际结果：<br>&nbsp;&nbsp;"+AOS.getValue("execute_form.actual_results").replace(/\n/g, "<br>&nbsp;&nbsp;");
								bug_desc_editor.setContent(a);
								var record = AOS.selectone(AOS.get('example_grid'), true);
								AOS.setValue("bug_form.proj_id",Number(id_proj_name.getValue()));
								AOS.setValue("bug_form.stand_id",record.data.stand_id);
								AOS.setValue("bug_form.demand_id",Number(record.raw.demand_id));
								AOS.setValue("bug_form.standard_id",Number(record.data.standard_id));
								AOS.setValue("bug_form.bug_name",record.data.dm_name+AOS.getValue("execute_form.actual_results"));
								/* bug_standard_id_store.getProxy().extraParams = {
									proj_id : id_proj_name.getValue()
								}
								bug_standard_id_store.load(); */
								AOS.setValue("bug_form.deal_man",Number(<%=userid%>));
								AOS.get('bug_form.deal_man').setReadOnly(false);
								AOS.get('bug_form.state').setReadOnly(false);
								AOS.get('bug_form.deal_man').setFieldLabel("指派处理人");
								bug_version_id_store.getProxy().extraParams = {
									proj_id : id_proj_name.getValue()
								};
								bug_version_id_store.load({
									callback : function() {
										AOS.ajax({
											url : 'testExampleService.selectVersionId',
											params : {
												test_version_id : record.data.test_version_id
											},
											ok : function(data){
												var version_id = data.appmsg;
												AOS.setValue('bug_form.version_id',Number(version_id));
												
												bug_test_version_id_store.getProxy().extraParams = {
													version_id :version_id
												}
												bug_test_version_id_store.load({
													callback : function() {
														AOS.setValue('bug_form.test_version_id',Number(record.data.test_version_id));
													}
												});
											}
										});
									}
								});
								bug_code_version_id_store.getProxy().extraParams = {
									test_version_id : record.data.test_version_id
								}
								bug_code_version_id_store.load({
									callback : function() {
										var code_version_id_store_count =  AOS.get('bug_form.code_version_id').store.totalCount;
										if(code_version_id_store_count > 0){
											var value = AOS.get('bug_form.code_version_id').store.getAt(0).raw.value;
											AOS.setValue('bug_form.code_version_id',value);
										}
									}
								});
								bug_win.show();
								bug_win.maximize();
							/* }
						});
					}
				}); */
			}
			
			//新增/修改缺陷保存
	        function bug_form_save() {
	        	AOS.ajax({
					forms : bug_form,
					url : 'bugManageService.create',
					params:{
								submit_name: "${user.name}",
								bug_detail :bug_desc_editor.getContent()
							},
					ok : function(data) {
						AOS.tip(data.appmsg);
						//bug_grid_store.reload();
						bug_win.hide();
						//AOS.reset(bug_form);
						execute_form_save();
					}
				});
	        }
	      //弹出选择上级模块窗口
			  function proj_tree_show() {
			  	w_org_find.show();
			  }
	      
	      //自动加载默认项目
	      window.onload = function(){
	    	  var proj_id = '${proj_id}';
  			  var proj_name = '${proj_name}';
	    	  if(proj_id !=null && proj_id!=''){
	    		    
	    			AOS.setValue('id_proj_name',proj_id);
	    			AOS.setValue('tree_proj_name',proj_name);
					public_module_divide_tree_refresh('dm_parent_code');
					all_proj_id='${proj_id}';
					AOS.setValue("query_form.proj_id",all_proj_id);
					AOS.get('query_form.version').getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					};
					AOS.get('query_form.version').getStore().load({
						callback : function(){
							var version_store_count =  AOS.get('query_form.version').store.totalCount;
							if(version_store_count>0){
								 AOS.setValue('query_form.version',AOS.get('query_form.version').store.getAt(0).raw.value);
							}
						}
					});
					AOS.get('query_form.test_version_id').getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					};
					AOS.get('query_form.test_version_id').getStore().load();
// 					AOS.get('query_form.query_demand_id').getStore().getProxy().extraParams = {
// 						proj_id : all_proj_id
// 					};
					AOS.get('query_form.query_demand_id').getStore().load({
						callback : function(){
							var demand_id_store_count =  AOS.get('query_form.query_demand_id').store.totalCount;
							if(demand_id_store_count>0){
								var value = AOS.get('query_form.query_demand_id').store.getAt(0).raw.value;
								//AOS.setValue('query_form.query_demand_id',Number(value));
							}
						}
					});
					var params = AOS.getValue('query_form');
					params.proj_id = all_proj_id;
					example_grid_store.getProxy().extraParams = params;
					example_grid_store.loadPage(1);
	    	  }
	      }
	      //点击选择项目
			  function t_org_find_select() {
				  
				var record = AOS.selectone(t_org_find);
			//	AOS.tip(record.raw.a);
				if(record.raw.a=="1"){
				AOS.setValue('id_proj_name',record.raw.id);
				AOS.setValue('tree_proj_name',record.raw.text);
				public_module_divide_tree_refresh('dm_parent_code');
				all_proj_id=id_proj_name.getValue();
				AOS.setValue("query_form.proj_id",all_proj_id);
				AOS.get('query_form.version').getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				};
				AOS.get('query_form.version').getStore().load({
					callback : function(){
						var version_store_count =  AOS.get('query_form.version').store.totalCount;
						if(version_store_count>0){
							 AOS.setValue('query_form.version',AOS.get('query_form.version').store.getAt(0).raw.value);
						}
					}
				});
				AOS.get('query_form.test_version_id').getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				}
				AOS.get('query_form.test_version_id').getStore().load();
// 				AOS.get('query_form.query_demand_id').getStore().getProxy().extraParams = {
// 					proj_id : all_proj_id
// 				};
// 				AOS.get('query_form.query_demand_id').getStore().load({
// 					callback : function(){
// 						var demand_id_store_count =  AOS.get('query_form.query_demand_id').store.totalCount;
// 						if(demand_id_store_count>0){
// 							var value = AOS.get('query_form.query_demand_id').store.getAt(0).raw.value;
// 							//AOS.setValue('query_form.query_demand_id',Number(value));
// 						}
// 					}
// 				});
				var params = AOS.getValue('query_form');
				params.proj_id = all_proj_id;
				example_grid_store.getProxy().extraParams = params;
				example_grid_store.loadPage(1);
					w_org_find.hide();
				}else{
					AOS.tip("请选择项目!");
					return;
					//w_org_find.hide();
				}
					
				  }
			  
			
		</script>
	</aos:viewport>
</aos:onready>
<script type="text/javascript">
	//显示执行用例窗口
	function w_execute_show(){
		var record = AOS.selectone(AOS.get('example_grid'), true);
		var test_premise = record.data.test_premise;//测试前提
		var standard_detail = record.data.standard_detail;//测试步骤
		var expected_results = record.data.expected_results;//期待结果
		standard_detail = standard_detail.replace(/<br>/g,"\n" );
		test_premise = test_premise.replace(/<br>/g,"\n")
		expected_results = expected_results.replace(/<br>/g,"\n");
		AOS.setValue('execute_form.standard_detail',standard_detail);
		AOS.setValue('execute_form.test_premise',test_premise);
		AOS.setValue('execute_form.expected_results',expected_results);
		AOS.setValue('execute_form.standard_id',record.data.standard_id);
		//AOS.setValue('execute_form.pass_or_fail',0);
		AOS.setValue('execute_form.actual_results',"");
		if(AOS.empty(record.data.dm_name)){
			
		}else{
			AOS.setValue('execute_form.dm_name',record.data.dm_name);
		}
		AOS.setValue('execute_form.execute_code',record.data.execute_code);
		AOS.get('execute_win').show(); 
	}
	
	//测试用例单条删除
	function fn_del(){
		//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
		var record = AOS.selectone(AOS.get('example_grid'));
		if(record.data.return_state == 1){
			AOS.tip('已回归测试的用例不能删除。');
			return;
		}
		var msg =  AOS.merge('确认要删除选中的1条数据吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'testExampleService.delete',
				params:{
					aos_rows: record.data.standard_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('example_grid').getStore().reload();
				}
			});
		});
	}
	
	//复制
	function fn_copy(){
		var example_grid_record = AOS.select(AOS.get('example_grid'));
		if (example_grid_record.length >0){
			var rows = AOS.rows(AOS.get('example_grid'));
			var msg =  AOS.merge('确认要复制选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					//AOS.tip('删除操作被取消。');
					return;
				}
				AOS.reset(AOS.get('copy_form'));
				AOS.get('copy_win').show();
			});
		}else{
			var record = AOS.selectone(AOS.get('public_module_divide_tree'));
			if(record.raw.a=='true'&&record.raw.parentId=='0'){
				var msg =  AOS.merge('确认要复制该项目所有的测试用例数据(共{0}条)？',AOS.get('example_grid').store.data.length);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						//AOS.tip('删除操作被取消。');
						return;
					}
					AOS.reset(AOS.get('copy_form2'));
					AOS.get('copy_win2').show();
				});
			}else{
				var msg =  AOS.merge('确认要复制该模块所有的测试用例数据(共{0}条)？',AOS.get('example_grid').store.data.length);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						//AOS.tip('删除操作被取消。');
						return;
					}
					AOS.reset(AOS.get('copy_form2'));
					AOS.get('copy_win2').show();
				});
			}
		}
	}
	//复制保存
	function fn_copy_save(){
		var redord = AOS.selection(AOS.get('example_grid'),'standard_id');
		var version =  AOS.getValue('copy_form.version');
		var old_version = AOS.getValue('query_form.version');
		 var isValid = true;
		    if (!Ext.isEmpty(AOS.get('copy_form'))) {
		        Ext.Array.each(AOS.get('copy_form'), function (form) {
		            // 表单验证
		            if (!form.isValid()) {
		                isValid = false;
		            }
		        });
		    }
		    // 如果是表单提交，且表单验证不通过则返回
		    if (!isValid) {
		        Ext.log('表单合法性校验未通过，Ajax请求取消。如果这和您的预期不符，请检查调用AOS.ajax()时是否多传或错传了forms参数。');
		        return;
		    }
		AOS.ajax({
			url : 'testExampleService.copy',
			params:{
				aos_rows: AOS.selection(AOS.get('example_grid'),'standard_id'),
				version :version,
				old_version : old_version
			},
			ok : function(data) {
			 	AOS.tip(data.appmsg);
			 	AOS.get('copy_win').hide();
			 	AOS.get('example_grid').getStore().reload();
			}
		});
	}
	//复制保存
	function fn_copy_save2(){
		var record = AOS.selectone(AOS.get('public_module_divide_tree'));
		var version =  AOS.getValue('copy_form2.version');
		var old_version = AOS.getValue('query_form.version');
		 var isValid = true;
		    if (!Ext.isEmpty(AOS.get('copy_form2'))) {
		        Ext.Array.each(AOS.get('copy_form2'), function (form) {
		            // 表单验证
		            if (!form.isValid()) {
		                isValid = false;
		            }
		        });
		    }
		    // 如果是表单提交，且表单验证不通过则返回
		    if (!isValid) {
		        Ext.log('表单合法性校验未通过，Ajax请求取消。如果这和您的预期不符，请检查调用AOS.ajax()时是否多传或错传了forms参数。');
		        return;
		    }
		AOS.ajax({
			url : 'testExampleService.copy2',
			params:{
				stand_id: record.raw.id,
				version :version,
				old_version : old_version
			},
			ok : function(data) {
			 	AOS.tip(data.appmsg);
			 	AOS.get('copy_win2').hide();
			 	AOS.get('example_grid').getStore().reload();
			}
		});
	}
	
	//查看详情
	function fn_query_detail(){
		//var record = AOS.select(example_grid);
		var record = AOS.selectone(AOS.get('example_grid'));
		var params = {
				 standard_id : record.data.standard_id
		}; 
		AOS.get('testexample_log_win').show();
		AOS.get('log_grid').getStore().getProxy().extraParams = params;
		AOS.get('log_grid').getStore().loadPage(1);
		
	}
	
</script>
