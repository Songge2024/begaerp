<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>

<aos:html title="缺陷管理" base="http" lib="ext,ueditor">
<aos:body>
	<div id="bug_desc_div">
		<script type="text/plain" id="bug_desc_editor"
			style="text-align: left; margin-top: 5px; margin-right: 5px; width: 85%; min-height: 500px;"></script>
	</div>
	<div id="copy_bug_desc_div">
		<script type="text/plain" id="copy_bug_desc_editor"
			style="text-align: left; margin-top: 5px; margin-right: 5px; width: 85%; min-height: 500px;"></script>
	</div>
	<div id='bug_page_refresh' onclick="bug_refresh()"></div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="west" width="320" collapsible="true">
<%-- 			<%@ include file="../../public/public_module_divide_tree.jsp"%> --%>
			<aos:docked>
				<%-- <aos:combobox id="pm_proj_id"   dicField="proj_name" emptyText="请选择项目" selectAll="true" 
				        width="300" allowBlank="false"
						url="projCommonsService.listComboBoxUerid" onselect="tree_query" />  --%>
						<aos:dockeditem xtype="tbtext" text="项目选择" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="240" />
						<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
			</aos:docked>
			<aos:treepanel id="public_module_divide_tree" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTree" 
							border="true" onitemclick="on_public_tree">
			</aos:treepanel>
		</aos:panel>
		<aos:panel region="center" layout="border" border="true">
			<%-- hidden="true" --%>
			<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
				<aos:formpanel id="bug_query_form" layout="column" labelWidth="100" header="false" border="false">
					<aos:combobox fieldLabel="项目" name="proj_id" margin="4" hidden="true" editable="false" columnWidth="0.4"
						url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" onchange="on_public_com" />
					<aos:combobox fieldLabel="模块" name="stand_id" margin="4" hidden="true" editable="true" columnWidth="0.3" labelWidth="45"
						url="moduleDivideService.listModuleDivideComboBox" />
					<%-- <aos:textfield fieldLabel="缺陷编码" name="bug_code" columnWidth="0.2"
						margin="4" />
					<aos:textfield fieldLabel="缺陷名称" name="bug_name" columnWidth="0.2"
						margin="4" /> --%>
					<aos:combobox fieldLabel="缺陷状态" dicField="bug_states" multiSelect="true" name="bug_states" columnWidth="0.33" />
					<aos:combobox fieldLabel="严重程度" dicField="bug_severity" multiSelect="true" name="severitys" columnWidth="0.33" />
					<%-- <aos:combobox fieldLabel="优先级" dicField="bug_priority" multiSelect="false" name="priority" columnWidth="0.24"/> --%>
					<aos:combobox fieldLabel="缺陷位置" dicField="bug_addr" multiSelect="true" name="bug_addrs" columnWidth="0.33" />
					<aos:combobox fieldLabel="类型"  dicField="bug_type" multiSelect="true" name="bug_types" columnWidth="0.33"/>
					<aos:textfield emptyText="缺陷编码/缺陷名称" fieldLabel="缺陷名称" name="query_values" columnWidth="0.33"  />
<%-- 					<aos:datefield  name="update_begin_time" fieldLabel="更新开始时间" columnWidth="0.33"  editable="false" /> --%>
<%-- 					<aos:datetimefield  name="final_deal_begin_time" fieldLabel="解决开始时间" columnWidth="0.33"  editable="false" /> --%>
					<aos:datetimefield  name="final_deal_begin_time" fieldLabel="解决开始时间" columnWidth="0.33" editable="false" format="Y-m-d H:i:s" msgTarget="qtip"/>
					<aos:combobox id="bug_deal_man" fieldLabel="处理人" name="deal_man" editable="true" columnWidth="0.14"  queryMode="local"
						typeAhead="true" forceSelection="true" selectOnFocus="true" url="bugManageService.listDealmanComboBox" width="40" emptyText="处理人查询"/>
					
					<aos:combobox id="condition" width="20" columnWidth="0.05" name="condition" fieldLabel="">
						<aos:option value="1" display="并" />
						<aos:option value="2" display="或"/>
					</aos:combobox>
						
					<aos:combobox id="bug_final_deal_man" fieldLabel="解决人" name="final_deal_man" editable="true" columnWidth="0.14"  queryMode="local"
						typeAhead="true" forceSelection="true" selectOnFocus="true" url="bugManageService.listFindnameComboBox" width="20" emptyText="解决人"/>	
					<aos:combobox id="id_find_name" fieldLabel="发现人" name="find_name" editable="true" columnWidth="0.18"  queryMode="local"
						typeAhead="true" forceSelection="true" selectOnFocus="true" url="bugManageService.listFindnameComboBox" width="100" emptyText="发现人查询"/>
					<aos:combobox id="priority" width="20" columnWidth="0.15" name="priority" multiSelect="true" dicField="bug_priority" fieldLabel="优先级" />
<%-- 					<aos:datefield name="update_end_time" fieldLabel="更新结束时间" columnWidth="0.33"  editable="false" /> --%>
<%-- 					<aos:datetimefield  name="final_deal_end_time" fieldLabel="解决结束时间" columnWidth="0.33"  editable="false" /> --%>
					<aos:datetimefield  name="final_deal_end_time" fieldLabel="解决结束时间" columnWidth="0.33" editable="false" format="Y-m-d H:i:s" msgTarget="qtip"/>
					<aos:datefield  name="find_begin_time" fieldLabel="发现开始时间" columnWidth="0.33"  editable="false" />
					<aos:datefield  name="find_end_time" fieldLabel="发现结束时间" columnWidth="0.33"  editable="false" />
					<aos:combobox id="search_test_version_id" fieldLabel="测试版本号" name="test_version_id" editable="false" columnWidth="0.33" queryMode="local"
						width="100" url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
						
					<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查询" onclick="bug_grid_query" icon="query.png" />
						<aos:dockeditem xtype="button" text="模糊查询" onclick="bug_vague_query" icon="query.png" /> 
						<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(bug_query_form);" icon="refresh.png" />
						<aos:dockeditem xtype="tbfill" />
					</aos:docked>
				</aos:formpanel>
			</aos:panel>
			<aos:gridpanel id="bug_grid" url="bugManageService.bugpage" forceFit="false" anchor="100%" border="true"
				onitemdblclick="#bug_win_show('update');" region="center" bodyBorder="1 0 1 0">
<%-- 				<aos:menu> --%>
<%-- 					<aos:menuitem text="修改" --%>
<%-- 						onclick="AOS.reset(bug_form);bug_win_show('update');" --%>
<%-- 						icon="edit.png" /> --%>
<%-- 					<aos:menuitem text="关闭" onclick="fn_close()" icon="plugin2.png" /> --%>
<%-- 					<aos:menuitem text="延期处理" onclick="fn_delay()" icon="plugin2.png" /> --%>
<%-- 					<aos:menuitem text="删除" onclick="fn_del()" icon="del.png" /> --%>
<%-- 				</aos:menu> --%>
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="缺陷信息" />
					<aos:dockeditem xtype="tbseparator" />
					<%-- <aos:dockeditem text="待处理缺陷" onclick="bug_grid_mydeal_query" />
					<aos:dockeditem text="项目所有缺陷" onclick="bug_grid_all_query" />
					<aos:dockeditem text="未关闭" onclick="bug_grid_unclose_query" />
					<aos:dockeditem text="已关闭" onclick="bug_grid_close_query" /> --%>
					<aos:dockeditem text="新增" icon="add.png" onclick="AOS.reset(bug_form);bug_win_show('create');" />
					<aos:dockeditem text="修改" icon="edit.png" onclick="AOS.reset(bug_form);bug_win_show('update');" />
					<aos:dockeditem text="删除" icon="del.png" onclick="bug_grid_del" />
					<aos:dockeditem text="复制"	icon="copy.png"	onclick="AOS.reset(copy_bug_form);copy_bug_win_show()"/>
					<%-- <aos:dockeditem text="粘贴" 	tooltip="批量粘贴"	icon="save_all.png"	onclick="bug_docked_copy_save_button_click"/> --%>
					<aos:dockeditem text="导出" icon="icon70.png" onclick="bug_export_excel" />
					<aos:dockeditem text="全部导出" icon="icon70.png" onclick="bug_allexport_excel" />
					<aos:dockeditem text="bug关联" icon="icq.png" onclick="bug_relation" />
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
				<aos:column header="缺陷ID" dataIndex="bug_id" fixedWidth="100" hidden="true" />
				<aos:column header="消息记录ID" dataIndex="log_id" width="100" hidden="true" />
				<aos:column header="需求ID" dataIndex="demand_id" width="100" hidden="true" />
				<aos:column header="测试用例ID" dataIndex="standard_id" width="100" hidden="true" />
				<aos:column header="测试用例名称" dataIndex="standard_name" width="100" hidden="true" />
				<aos:column header="缺陷详情" dataIndex="bug_detail" width="100" hidden="true" />
				<aos:column header="当前状态" dataIndex="state" width="80" align="center" rendererFn="fn_bug_state" />
				<aos:column header="缺陷编码" dataIndex="bug_code" width="130" align="center" />
				<aos:column header="缺陷名称" dataIndex="bug_name" width="300" rendererFn="fn_link_render" celltip="true"/>
				<aos:column header="解决时间" dataIndex="final_deal_time" width="150" align="center" />
				<aos:column header="严重程度" dataIndex="severity" width="80" align="center" rendererField="bug_severity" />
				<aos:column header="缺陷位置" dataIndex="bug_addr" width="80" rendererField="bug_addr" align="center" />
				<aos:column header="优先级" dataIndex="priority" width="60" align="center" rendererField="bug_priority" />
				<aos:column header="类型" dataIndex="bug_type" width="100" align="center" rendererField="bug_type" />
				<aos:column header="模块" dataIndex="dm_name" width="100" align="left" />
				<aos:column header="上级模块" dataIndex="dm_parent_name" width="100" />
				<aos:column header="当前处置人" dataIndex="deal_man_name" width="100" align="center" />
				<aos:column header="发现人" dataIndex="find_name" width="100" align="center" />
				<aos:column header="发现时间" dataIndex="find_time" width="150" align="center" />
				<aos:column header="创建人id" dataIndex="create_name" width="100" align="center" hidden="true" />
				<aos:column header="创建人" dataIndex="bug_create_name" width="100" align="center" />
				<aos:column header="创建时间" dataIndex="create_time" width="150" hidden="true" />
				<aos:column header="项目版本号id" dataIndex="version_id" width="150" align="center" hidden="true" />
				<aos:column header="代码版本号id" dataIndex="code_version_id" width="150" align="center" hidden="true" />
				<aos:column header="测试版本号id" dataIndex="test_version_id" width="150" align="center" hidden="true" />
				<aos:column header="项目版本号" dataIndex="version_number" width="150" align="center" />
				<aos:column header="测试版本号" dataIndex="test_version_number" width="150" align="center" />
				<aos:column header="代码版本号" dataIndex="code_version_number" width="150" align="center" />
				<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true" />
				<aos:column header="模块ID" dataIndex="stand_id" width="100" hidden="true" />
				<aos:column header="相关缺陷编码" dataIndex="relate_bug_code" width="150" />
				<aos:column header="出现频率" dataIndex="rate" width="100" align="center" rendererField="bug_rate" />
				<aos:column header="当前处置人id" dataIndex="deal_man" width="100" align="center" hidden="true" />
				<aos:column header="来源方" dataIndex="source" width="100" align="center" rendererField="bug_source" />
				<aos:column header="修改人" dataIndex="bug_update_name" width="100" align="center" />
				<aos:column header="修改时间" dataIndex="update_time" width="150" align="center" />
				<aos:column header="关闭人" dataIndex="close_name" width="100" align="center" />
				<aos:column header="关闭时间" dataIndex="close_time" width="150" align="center" />
				<aos:column header="解决人" dataIndex="final_deal_man" width="100" align="center" />
				<aos:column header="处理时间" dataIndex="deal_time" width="150" align="center" />
				<aos:column header="项目" dataIndex="proj_name" width="150" align="left" />
				<aos:column header="计划消耗天数" dataIndex="plan_wastage" width="150" align="right" />
				<aos:column header="实际消耗天数" dataIndex="real_wastage" width="150" align="right" />
			</aos:gridpanel>
		</aos:panel>

		<%-- 新增窗口 --%>
		<aos:window id="bug_win" title="新增缺陷">
			<aos:formpanel id="bug_form" width="1500" layout="column" height="500" labelWidth="70" msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:hiddenfield name="bug_id" fieldLabel="缺陷id" />
					<aos:hiddenfield name="log_id" fieldLabel="消息记录id" />
					<aos:textfield name="bug_code" fieldLabel="缺陷编码" allowBlank="true" readOnly="true" emptyText="保存后自动生成" columnWidth="0.25" />
					<aos:combobox fieldLabel="项目" name="proj_id" editable="false" allowBlank="false" columnWidth="0.25" readOnly="true"
						url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" onchange="on_public_com_win" />
					<aos:hiddenfield name="stand_id" />
					<aos:triggerfield fieldLabel="模块" name="stand_id_name" allowBlank="false" editable="false" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="stand_tree_show" columnWidth="0.25" />
					<aos:combobox fieldLabel="需求" name="demand_id" editable="false" allowBlank="true" columnWidth="0.25" url="demandActionService.listdemand" />
					<aos:textfield name="bug_name" fieldLabel="缺陷名称" maxLength="100" allowBlank="false" columnWidth="0.25" />

					<%-- 隐藏域用来存储弹出表格选中的ID --%>
					<aos:hiddenfield name="standard_id" />
					<aos:triggerfield fieldLabel="测试用例" name="standard_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="standard_grid_show" columnWidth="0.25" />

					<%--
					<aos:combobox fieldLabel="测试用例" name="standard_id"
						columnWidth="0.25" url="testExampleService.listdemand" />--%>
					<aos:combobox fieldLabel="缺陷状态" name="state" value="1000" dicField="bug_states" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="严重程度" name="severity" value="1001" dicField="bug_severity" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="优先级" name="priority" value="1001" dicField="bug_priority" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="缺陷位置" name="bug_addr" value="1000" dicField="bug_addr" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="出现频率" name="rate" value="1000" dicField="bug_rate" columnWidth="0.25"> </aos:combobox>
					<aos:combobox fieldLabel="来源类型" name="source" value="1000" dicField="bug_source" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="缺陷类型" name="bug_type" value="1000" dicField="bug_type" columnWidth="0.25"></aos:combobox>
					<aos:textfield name="find_name" fieldLabel="发现人" value="${user.name}" readOnly="false" maxLength="20" allowBlank="true" columnWidth="0.25" />
					<aos:datetimefield name="find_time" fieldLabel="发现时间" editable="false" format="Y-m-d H:i:s" allowBlank="true" columnWidth="0.25" />
					<aos:combobox fieldLabel="创建人" name="create_name" editable="false" allowBlank="true" readOnly="true" columnWidth="0.25" url="projCommonsService.listComboBoxProjId" />
					<aos:datetimefield name="create_time" fieldLabel="创建时间" readOnly="true" format="Y-m-d H:i:s" allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="close_name" fieldLabel="关闭人" allowBlank="true" readOnly="true" columnWidth="0.25" />
					<aos:hiddenfield name="final_deal_man" fieldLabel="关闭人" allowBlank="true" columnWidth="0.25" />
					<aos:hiddenfield name="final_deal_time" fieldLabel="关闭人" allowBlank="true" columnWidth="0.25" />
					<aos:datetimefield name="close_time" fieldLabel="关闭时间" format="Y-m-d H:i:s" allowBlank="true" readOnly="true" columnWidth="0.25" />
					<aos:combobox fieldLabel="指派处理人" name="deal_man" id="combo_deal_man" editable="true" allowBlank="false" queryMode="local" 
						typeAhead="true" forceSelection="true" selectOnFocus="true" columnWidth="0.25" url="projCommonsService.listComboBoxProjId"/>
					<aos:combobox fieldLabel="项目版本号" name="version_id" allowBlank="false" columnWidth="0.25" id="bug_version_id" queryMode="local"
						onselect="versionOnSelect" editable="false" url="bugManageService.listComboBoxVersionId" />
					<aos:combobox fieldLabel="测试版本号" name="test_version_id" id="bug_test_version_id" allowBlank="false" columnWidth="0.25" 
						queryMode="local" onselect="test_versionOnSelect" editable="false" url="bugManageService.listComboBoxTestVersionId" />
					<aos:combobox fieldLabel="代码版本号" name="code_version_id" allowBlank="false" columnWidth="0.25" queryMode="local"
						id="bug_code_version_id" editable="false" url="bugManageService.listComboBoxCodeVersionId" />
				</aos:fieldset>
				<aos:fieldset title="相关产品缺陷编码">
					<aos:textareafield name="relate_bug_code" fieldLabel="关联编码" columnWidth="1" padding="5 5 5 5" height="70" emptyText="请输入项目名称+缺陷编码" />
				</aos:fieldset>
				<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="缺陷详情">
					<aos:panel columnWidth="0.9" margin="5" padding="5" contentEl="bug_desc_div" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="bug_form_save" text="保存" icon="ok.png" tooltip="保存" />
				<aos:dockeditem onclick="#bug_win.hide();AOS.reset(bug_form);" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		
		
		<%-- 复制缺陷新增窗口 --%>
		<aos:window id="copy_bug_win" title="新增缺陷">
			<aos:formpanel id="copy_bug_form" width="1500" layout="column" height="500" labelWidth="70" msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:hiddenfield name="bug_id" fieldLabel="缺陷id" />
					<aos:hiddenfield name="log_id" fieldLabel="消息记录id" />
					<aos:textfield name="bug_code" fieldLabel="缺陷编码" allowBlank="true" readOnly="true" emptyText="保存后自动生成" columnWidth="0.25" />
					<aos:triggerfield fieldLabel="项目" id="copy_tree_proj_name" allowBlank="false" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="copy_proj_tree_show" columnWidth="0.25" />
					<aos:hiddenfield id="copy_id_proj_name" name="id_proj_name"/>
					<aos:hiddenfield name="stand_id" />
					<aos:triggerfield fieldLabel="模块" name="stand_id_name" id="copy_stand_id_name" editable="false" trigger1Cls="x-form-search-trigger" 
						allowBlank="false" onTrigger1Click="copy_stand_tree_show" columnWidth="0.25" />
					<aos:combobox fieldLabel="需求" name="demand_id" editable="false" allowBlank="true" columnWidth="0.25" id="copy_demand_id"
						url="demandActionService.listdemand" />
					<aos:textfield name="bug_name" fieldLabel="缺陷名称" maxLength="100" allowBlank="false" columnWidth="0.25" />

					<%-- 隐藏域用来存储弹出表格选中的ID --%>
					<aos:hiddenfield name="standard_id" />
					<aos:triggerfield fieldLabel="测试用例" name="standard_name" editable="false" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="copy_standard_grid_show" columnWidth="0.25" />
					<aos:combobox fieldLabel="缺陷状态" name="state" value="1000" dicField="bug_states" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="严重程度" name="severity" dicField="bug_severity" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="优先级    " name="priority" dicField="bug_priority" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="缺陷位置" name="bug_addr" dicField="bug_addr" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="出现频率" name="rate" dicField="bug_rate" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="来源类型" name="source" dicField="bug_source" columnWidth="0.25"></aos:combobox>
					<aos:combobox fieldLabel="缺陷类型" name="bug_type" dicField="bug_type" columnWidth="0.25"></aos:combobox>
					<aos:textfield name="find_name" fieldLabel="发现人" readOnly="false" maxLength="20" allowBlank="true" columnWidth="0.25" />
					<aos:datetimefield name="find_time" fieldLabel="发现时间" editable="false" format="Y-m-d H:i:s" allowBlank="true" columnWidth="0.25" />
					<aos:combobox fieldLabel="创建人" name="create_name" editable="false" allowBlank="true" readOnly="true" columnWidth="0.25" url="projCommonsService.listComboBoxProjId" />
					<aos:datetimefield name="create_time" fieldLabel="创建时间" readOnly="true" format="Y-m-d H:i:s" allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="close_name" fieldLabel="关闭人" allowBlank="true" readOnly="true" columnWidth="0.25" />
					<aos:datetimefield name="close_time" fieldLabel="关闭时间" format="Y-m-d H:i:s" allowBlank="true" readOnly="true" columnWidth="0.25" />
					<aos:combobox fieldLabel="指派处理人" name="deal_man" id="copy_combo_deal_man" editable="true" allowBlank="false" queryMode="local" 
						typeAhead="true" forceSelection="true" selectOnFocus="true" columnWidth="0.25" url="projCommonsService.listComboBoxProjId" />
					<aos:combobox fieldLabel="项目版本号" name="version_id" allowBlank="false" columnWidth="0.25" id="copybug_version_id" queryMode="local"
						onselect="copyVersionOnSelect" editable="false" url="bugManageService.listComboBoxVersionId" />
					<aos:combobox fieldLabel="测试版本号" name="test_version_id" id="copybug_test_version_id" allowBlank="false" columnWidth="0.25" 
						queryMode="local" onselect="copytest_versionOnSelect" editable="false" url="bugManageService.listComboBoxTestVersionId" />
					<aos:combobox fieldLabel="代码版本号" name="code_version_id" allowBlank="false" columnWidth="0.25" queryMode="local"
						id="copybug_code_version_id" editable="false" url="bugManageService.listComboBoxCodeVersionId" />
				</aos:fieldset>
				<aos:fieldset title="相关产品缺陷编码">
					<aos:textareafield name="relate_bug_code" fieldLabel="关联编码" columnWidth="1" padding="5 5 5 5" height="70" emptyText="请输入缺陷编码" readOnly="false"/>
				</aos:fieldset>
				<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="缺陷详情">
					<aos:panel columnWidth="0.9" margin="5" padding="5" contentEl="copy_bug_desc_div" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="copy_bug_form_save" text="保存" icon="ok.png" tooltip="保存"/>
				<aos:dockeditem onclick="#copy_bug_win.hide();AOS.reset(copy_bug_form);" text="关闭" icon="close.png"/>
			</aos:docked>
		</aos:window>
		
		<!-- bug关联 -->
		<aos:window id="bug_relation_win" title="bug关联">
			<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="bug_relation_form" labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
							<aos:docked forceBoder="0 0 1 0">
								<aos:dockeditem xtype="tbtext" text="查询条件" />
							</aos:docked>
							<aos:combobox fieldLabel="项目名称" name="proj_id" id="relation_proj_id" editable="true" queryMode="local" typeAhead="true" forceSelection="true" 
								selectOnFocus="true" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" labelWidth="60" width="350" onselect="bug_relation_query"/> 
							<aos:textfield emptyText="缺陷编码/缺陷名称" fieldLabel="缺陷名称" name="query_values" id="bug_relation_name"  labelWidth="60" onenterkey="bug_relation_query"/> 
							<aos:dockeditem xtype="button" text="查询" onclick="bug_relation_query" icon="query.png" margin="0 5 0 10" />
							<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(bug_relation_form);" icon="refresh.png"  margin="0 5 0 5" />
						</aos:formpanel>
					</aos:panel>
					<aos:gridpanel id="bug_relation_grid" url="bugManageService.bugRelationPage" forceFit="false" anchor="100%" border="true" region="center"
						 bodyBorder="1 0 1 0" onrender="bug_relation_query_onder">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="缺陷信息" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" header="序号" align="center" fixedWidth="35" />
						<aos:column header="缺陷ID" dataIndex="bug_id" fixedWidth="100" hidden="true" />
						<aos:column header="消息记录ID" dataIndex="log_id" width="100" hidden="true" />
						<aos:column header="需求ID" dataIndex="demand_id" width="100" hidden="true" />
						<aos:column header="测试用例ID" dataIndex="standard_id" width="100" hidden="true" />
						<aos:column header="测试用例名称" dataIndex="standard_name" width="100" hidden="true" />
						<aos:column header="缺陷详情" dataIndex="bug_detail" width="100" hidden="true" />
						<aos:column header="项目" dataIndex="proj_name" width="150" align="left" />
						<aos:column header="当前状态" dataIndex="state" width="80" align="center" rendererFn="fn_bug_state" />
						<aos:column header="缺陷编码" dataIndex="bug_code" width="130" align="center" />
						<aos:column header="缺陷名称" dataIndex="bug_name" width="300" rendererFn="fn_link_render" celltip="true"/>
						<aos:column header="解决时间" dataIndex="final_deal_time" width="150" align="center" />
						<aos:column header="严重程度" dataIndex="severity" width="80" align="center" rendererField="bug_severity" />
						<aos:column header="缺陷位置" dataIndex="bug_addr" width="80" rendererField="bug_addr" align="center" />
						<aos:column header="优先级" dataIndex="priority" width="60" align="center" rendererField="bug_priority" />
						<aos:column header="类型" dataIndex="bug_type" width="100" align="center" rendererField="bug_type" />
						<aos:column header="模块" dataIndex="dm_name" width="100" align="left" />
						<aos:column header="上级模块" dataIndex="dm_parent_name" width="100" />
						<aos:column header="当前处置人" dataIndex="deal_man_name" width="100" align="center" />
						<aos:column header="发现人" dataIndex="find_name" width="100" align="center" />
						<aos:column header="发现时间" dataIndex="find_time" width="150" align="center" />
						<aos:column header="创建人id" dataIndex="create_name" width="100" align="center" hidden="true" />
						<aos:column header="创建人" dataIndex="bug_create_name" width="100" align="center" />
						<aos:column header="创建时间" dataIndex="create_time" width="150" hidden="true" />
						<aos:column header="项目版本号id" dataIndex="version_id" width="150" align="center" hidden="true" />
						<aos:column header="代码版本号id" dataIndex="code_version_id" width="150" align="center" hidden="true" />
						<aos:column header="测试版本号id" dataIndex="test_version_id" width="150" align="center" hidden="true" />
						<aos:column header="项目版本号" dataIndex="version_number" width="150" align="center" />
						<aos:column header="测试版本号" dataIndex="test_version_number" width="150" align="center" />
						<aos:column header="代码版本号" dataIndex="code_version_number" width="150" align="center" />
						<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true" />
						<aos:column header="模块ID" dataIndex="stand_id" width="100" hidden="true" />
						<aos:column header="相关缺陷编码" dataIndex="relate_bug_code" width="150" />
						<aos:column header="出现频率" dataIndex="rate" width="100" align="center" rendererField="bug_rate" />
						<aos:column header="当前处置人id" dataIndex="deal_man" width="100" align="center" hidden="true" />
						<aos:column header="来源方" dataIndex="source" width="100" align="center" rendererField="bug_source" />
						<aos:column header="修改人" dataIndex="bug_update_name" width="100" align="center" />
						<aos:column header="修改时间" dataIndex="update_time" width="150" align="center" />
						<aos:column header="关闭人" dataIndex="close_name" width="100" align="center" />
						<aos:column header="关闭时间" dataIndex="close_time" width="150" align="center" />
						<aos:column header="解决人" dataIndex="final_deal_man" width="100" align="center" />
						<aos:column header="处理时间" dataIndex="deal_time" width="150" align="center" />
						<aos:column header="计划消耗天数" dataIndex="plan_wastage" width="150" align="right" />
						<aos:column header="实际消耗天数" dataIndex="real_wastage" width="150" align="right" />
					</aos:gridpanel>
				</aos:panel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="bug_relation_save" text="保存数据" icon="ok.png" />
					<aos:dockeditem onclick="#bug_relation_win.hide();" text="关闭" icon="close.png" />
				</aos:docked>
		</aos:window>

		
		<%@ include file="bugManage_win.jsp"%>
		<script type="text/javascript">
			//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
			function public_module_divide_tree_refresh() {
				var proj_id = id_proj_name.getValue();
				public_module_divide_tree_store.load({
					params:{
						proj_id : proj_id
					},
					callback : function() {
						//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
						/* refreshnode.collapse();
						refreshnode.expand(); */
						public_module_divide_tree.getSelectionModel().select(public_module_divide_tree.getRootNode());
					}
				});
				
			}
			//关闭按钮列转换
			function fn_button_close(value, metaData, record) {
				return '<input type="button" value="关闭" class="cbtn" onclick="fn_close();" />';
			}
			//修改按钮列转换
			function fn_button_update(value, metaData, record) {
				return '<input type="button" value="修改" class="cbtn" onclick="w_account2_show();" />';
			}
			//删除按钮列转换
			function fn_button_del(value, metaData, record) {
				return '<input type="button" value="删除" class="cbtn" onclick="fn_del();" />';
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
				}else if(value == '1007'){
					return "<span style='color:red; font-weight:bold'>已删除</span>"; 
				}else{
					return value;
				}
			}			  
 
			//查询缺陷列表/分页
			function bug_grid_query() {
				/* var params = AOS.getValue('bug_query_form');
				/* params.create_name = "${user.id}"; */
				/*params.proj_id=all_proj_id;
				params.stand_id='';
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1); */
				on_public_tree();
			}
			
			//模糊查询
			function bug_vague_query() {
// 				var params = AOS.getValue('bug_query_form');
// 				AOS.ajax({
// 					wait : false, //防止出现2个遮罩层。(ajax和表格load)
// 					params : params,
// 					url : 'bugManageService.bugVagueQuery',
// 					ok : function(data) {
// 						bug_grid_store.getProxy().extraParams = params;
// 					    bug_grid_store.loadPage(1);
// 					}
// 				});
				var params = AOS.getValue('bug_query_form');
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1);
			}
			
			//缺陷复制功能缓存数据
			var copy_bug_id = null;
			
			//复制
			function bug_docked_copy_button_click(){
				var records = AOS.selection(bug_grid,'bug_id');
				var rows = AOS.rows(bug_grid);
				if(rows === 0 ){
					AOS.tip("请先选择要复制的数据。");
					return;
				}
				copy_bug_id = records;
				msg = AOS.merge("本次复制成功{0}条记录",rows);
				AOS.tip(msg);
			}
			
			//粘贴
			function bug_docked_copy_save_button_click(){
				var bug_group_record = AOS.selectone(public_module_divide_tree, true);
				if(copy_bug_id == null){
					AOS.tip("请先进行复制。");
					return;
				}
				if(AOS.empty(bug_group_record)){
					AOS.tip('请选择一条分组记录');
					return;
				}
				if(bug_group_record.data.id == id_proj_name.getValue()){
					bug_group_record.data.id = null;
				}
				AOS.ajax({
					url : 'bugManageService.copyBug',
					params : {
						copy_bug_id : copy_bug_id , 
						stand_id : bug_group_record.data.id
					},
					ok : function(data){
						AOS.tip(data.appmsg);
					}
				});
			}
 
			//导出
			function bug_export_excel(){
				/* var bug_codes = AOS.selection(bug_grid,'bug_code');
				var bug_ids = AOS.selection(bug_grid,'bug_id'); */
				var selection = AOS.selection(bug_grid,'bug_id');
				if(selection.length == 0){
					AOS.tip('导出前请选择数据！');
					return;
				}
				AOS.file('do.jhtml?router=bugManageService.exportExcel&juid=${juid}&selection='+selection); 
				/* var selection = AOS.selection(bug_grid,'bug_id');
				if(selection == null || selection.length ==0){
					AOS.tip("导出前请选择数据！！");
				}else{
					AOS.file('do.jhtml?router=bugManageService.exportExcel&juid=${juid}&selection='+selection);
				} */
			}
			
			//全部导出
			function bug_allexport_excel(){
				var record = AOS.selectone(public_module_divide_tree);
				var params = AOS.getValue('bug_query_form');
				var proj_id = all_proj_id;
				var stand_id = '';
				var id = record.data.id;
				var parentId = record.data.parentId;
				if(id == proj_id){
					stand_id = '';
				}else{
					stand_id = id;
				}
				var start = 0;
				var limit = 50;
				var bug_states = params.bug_states;//AOS.getValue('bug_query_form.bug_states');
				if(bug_states === undefined){
					bug_states ="";
				}
				var bug_severity = params.severitys;//AOS.getValue('bug_query_form.bug_severity');
				if(bug_severity === undefined){
					bug_severity ="";
				}
				var bug_types = params.bug_types;
				if(bug_types === undefined){
					bug_types ="";
				}
				var bug_addrs =params.bug_addrs;
				if(bug_addrs === undefined){
					bug_addrs ="";
				}
				var final_deal_begin_time = params.final_deal_begin_time;
				if(final_deal_begin_time === undefined){
					final_deal_begin_time ="";
				}
				var final_deal_end_time = params.final_deal_end_time;
				if(final_deal_end_time === undefined){
					final_deal_end_time ="";
				}
				var find_begin_time = params.find_begin_time;
				if(find_begin_time === undefined){
					find_begin_time ="";
				}
				var find_end_time = params.find_end_time;
				if(find_end_time === undefined){
					find_end_time ="";
				}
				var find_name = params.find_name;
				if(find_name === undefined){
					find_name ="";
				}
				var deal_man = params.deal_man;
				if(deal_man === undefined){
					deal_man ="";
				}
				var query_values = params.query_values;
				if(query_values === undefined){
					query_values ="";
				}
				var test_version_id = params.test_version_id;
				if(test_version_id === undefined){
					test_version_id ="";
				}
				var final_deal_man = params.final_deal_man;
				if(final_deal_man === undefined){
					final_deal_man = "";
				}
				AOS.file('do.jhtml?router=bugManageService.exportExcel2&juid=${juid}&bug_states='+bug_states
						+'&severitys='+bug_severity
						+'&bug_types='+bug_types
						+'&bug_addrs='+bug_addrs
						+'&final_deal_begin_time='+final_deal_begin_time
						+'&final_deal_end_time='+final_deal_end_time
						+'&find_begin_time='+find_begin_time
						+'&find_end_time='+find_end_time
						+'&find_name='+find_name
						+'&deal_man='+deal_man
						+'&query_values='+query_values
						+'&proj_id='+proj_id
						+'&start='+start
						+'&limit='+limit
						+'&stand_id='+stand_id
						+'&test_version_id='+test_version_id
						+'&final_deal_man='+final_deal_man);
			}
			
			//查询项目未关闭缺陷1003 关闭
			function bug_grid_unclose_query() {
				var params = AOS.getValue('bug_query_form');
				params.unclose_state="1003";
				params.proj_id=all_proj_id;
				params.bug_code='';
				params.bug_name='';
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1);
			}
			//查询项目关闭缺陷1003 关闭
			function bug_grid_close_query() {
				var params = AOS.getValue('bug_query_form');
				params.close_state="1003";
				params.proj_id=all_proj_id;
				params.bug_code='';
				params.bug_name='';
				bug_grid_store.getProxy().extraParams = params;
				bug_grid_store.loadPage(1);
			}
			//查询指派给我的关联模块的缺陷列表/分页
			function bug_grid_deal_query() {
				var params = {create_name : "${user.id}"};
				params.proj_id=all_proj_id;
				params.stand_id=all_stand_id;
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1);
			}
 
			//待处理缺陷（已解决 1001、拒绝 1004）
			function bug_grid_mydeal_query() {
				var params = {create_name : "${user.id}"};
				params.dealed_state="1001"
				params.refused_state="1004"
				params.proj_id=all_proj_id;
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1);
			    /* console.log(bug_grid_store); */
			}
      
			//查询所有缺陷列表/分页
			function bug_grid_all_query() {
				var params = new Object();
				params.proj_id=all_proj_id;
			    bug_grid_store.getProxy().extraParams = params;
			    bug_grid_store.loadPage(1);
			}
      
			//显示新增/修改 窗口
			function bug_win_show(editModel){
				//console.log("${user.name}","${user.juid}","${user.account}");
				if(editModel=="update"){
					bug_win.setTitle("修改缺陷");
					bug_form.editModel="update";
					var record = AOS.selectone(bug_grid, true);
					var records = AOS.select(bug_grid, true);
					if(AOS.empty(records) || records.length>1){
						AOS.tip('请选择一条需要修改的数据。');
						return;
					}
					bug_desc_editor=UM.getEditor('bug_desc_editor',{
						autoHeightEnabled:false,
						autoFloatEnabled:true
					});
					bug_form.loadRecord(record);
					//修改页面：状态和处理人不能变更
					AOS.get('bug_form.deal_man').setReadOnly(true);
					AOS.get('bug_form.state').setReadOnly(true);
					AOS.get('bug_form.deal_man').setFieldLabel("当前处理人");
					bug_desc_editor.setContent(record.data.bug_detail||"");
					AOS.setValue("bug_form.demand_id",Number(record.data.demand_id));
					AOS.setValue("bug_form.proj_id",Number(record.data.proj_id));
					AOS.setValue("bug_form.deal_man",Number(record.data.deal_man));
					AOS.setValue("bug_form.standard_id",Number(record.data.standard_id));
					AOS.setValue("bug_form.create_name",Number(record.data.create_name));
					AOS.setValue("bug_form.stand_id_name",(record.data.dm_name));
					AOS.setValue("bug_form.standard_name",(record.data.standard_name));
					bug_version_id_store.getProxy().extraParams = {
						proj_id : id_proj_name.getValue()
					};
					bug_version_id_store.load({
						callback : function(records, operation, success) {
							//这个回调里还可以根据是否查询到二级模块再去做一些事情
							if (records.length > 0) {
								AOS.setValue('bug_form.version_id',Number(record.data.version_id));
							}else{
								AOS.read(bug_version_id);
							}
						}
					});
					bug_test_version_id_store.getProxy().extraParams = {
						version_id : record.data.version_id
					}
					bug_test_version_id_store.load({
						callback : function() {
							//这个回调里还可以根据是否查询到二级模块再去做一些事情
							var test_version_id_store_count = AOS.get('bug_form.test_version_id').store.totalCount;
							if(test_version_id_store_count>0){
								AOS.setValue('bug_form.test_version_id',Number(record.data.test_version_id));
							}
						}
					});
					bug_code_version_id_store.getProxy().extraParams = {
						test_version_id : record.data.test_version_id
					}
					bug_code_version_id_store.load({
						callback : function() {
							//这个回调里还可以根据是否查询到二级模块再去做一些事情
							var code_version_id_store_count =  AOS.get('bug_form.code_version_id').store.totalCount;
							if(code_version_id_store_count>0){
								AOS.setValue('bug_form.code_version_id',Number(record.data.code_version_id));
							}
						}
					});
				}else{
					bug_desc_editor=UM.getEditor('bug_desc_editor',{
						autoHeightEnabled:false,
						autoFloatEnabled:true
					});
					AOS.reset(bug_form);
					bug_win.setTitle("新增缺陷");
					bug_form.editModel="insert";
					bug_desc_editor.setContent("");
					//获取前台当前时间
					var time = new Date();
					var proj_id = id_proj_name.getValue();

					AOS.get('bug_form.deal_man').setReadOnly(false);
					AOS.ajax({ 
						params:{
							proj_id : proj_id
						},
						url : 'bugManageService.queryName',
						ok : function(data){
							if(data.appcode == 1){
								var developManageId = data.developManageId;
								if(developManageId != null && developManageId != undefined){
									AOS.setValue("bug_form.deal_man",Number(developManageId));
								}else{
									AOS.setValue("bug_form.deal_man","");
								}
							}
						/* if()
						AOS.get('bug_form.deal_man').setValue(''); */
						}
					});
					AOS.get('bug_form.state').setReadOnly(false);
					AOS.get('bug_form.deal_man').setFieldLabel("指派处理人");
					AOS.setValue("bug_form.find_time",time);
					AOS.setValue("bug_form.create_time",time);
					AOS.setValue("bug_form.stand_id",all_stand_id);
					AOS.setValue("bug_form.proj_id",Number(id_proj_name.getValue()));
					AOS.setValue("bug_form.stand_id_name",all_stand_id_name);
					AOS.setValue("bug_form.create_name",Number(<%=userid%>));
					AOS.setValue("bug_form.standard_id","");
					AOS.setValue("bug_form.demand_id","");
					var version_id;
					bug_version_id_store.getProxy().extraParams = {
						proj_id : id_proj_name.getValue()
					};
					bug_version_id_store.load({
						callback : function() {
							var version_id_store_count =  AOS.get('bug_form.version_id').store.totalCount;
							if (version_id_store_count > 0) {
								var value = AOS.get('bug_form.version_id').store.getAt(0).raw.value;
								AOS.setValue('bug_form.version_id',Number(value));
								
								var num_version_id = AOS.getValue('bug_form.version_id');
								bug_test_version_id_store.getProxy().extraParams = {
									version_id : num_version_id
								}
								bug_test_version_id_store.load({
									callback : function() {
										var test_version_id_store_count = AOS.get('bug_form.test_version_id').store.totalCount;
										if(test_version_id_store_count > 0){
											var value = AOS.get('bug_form.test_version_id').store.getAt(0).raw.value;
											AOS.setValue('bug_form.test_version_id',Number(value));
											
											var num_test_version_id = AOS.getValue('bug_form.test_version_id');
											bug_code_version_id_store.getProxy().extraParams = {
												test_version_id : num_test_version_id
											}
											bug_code_version_id_store.load({
												callback : function() {
													var code_version_id_store_count =  AOS.get('bug_form.code_version_id').store.totalCount;
													if(code_version_id_store_count>0){
														var value = AOS.get('bug_form.code_version_id').store.getAt(0).raw.value;
														AOS.setValue('bug_form.code_version_id',Number(value));
													}
												}
											});	
										}
									}
								});
							}
						}
					});
				}
				bug_win.show();
				bug_win.maximize();
			}
			
			function copy_proj_tree_show(){
				copyw_org_find.show();
			}
			
			function copy_org_find_select(){
				var record = AOS.selectone(copyt_org_find);
			  	if(record.raw.a=="1"){
				  	AOS.setValue('copy_id_proj_name',record.raw.id);
				  	AOS.setValue('copy_tree_proj_name',record.raw.text);
			  	}
			  	//var params = {proj_id : record.raw.id};
			  	var params;
			  	copy_demand_id_store.getProxy().extraParams = {
			  		proj_id : record.raw.id
			  	};
			  	copy_demand_id_store.load();
			  	copybug_version_id_store.getProxy().extraParams = {
			  		proj_id : record.raw.id
			  	};
			  	copybug_version_id_store.load();
			  	copy_combo_deal_man_store.getProxy().extraParams = {
			  		proj_id : record.raw.id
			  	}
			  	copy_combo_deal_man_store.load();
			  	copybug_test_version_id_store.getProxy().extraParams = params
			  	copybug_test_version_id_store.load();
			  	copybug_code_version_id_store.getProxy().extraParams = params
			  	copybug_code_version_id_store.load();
			  	//AOS.reset(copy_bug_form.copy_stand_id_name);
			  	copyw_org_find.hide();
			}
			
			function copy_stand_find_select(){
				var record = AOS.selectone(copyt_stand_find);
				AOS.setValue('copy_bug_form.stand_id',record.raw.id);
				AOS.setValue('copy_bug_form.stand_id_name',record.raw.text);
				copyw_stand_find.hide();
			}
			
			function copy_standard_grid_show(){
				copyw_standard_find.show();
			}
			
			function copyg_account_query(){
				var proj_id = copy_id_proj_name.getValue();
				var stand_id = AOS.getValue("copy_bug_form.stand_id");
				var standard_name = copystandard_name_query.getValue();
				var params = {
					proj_id : proj_id,
					stand_id : stand_id,
					standard_name:standard_name
				};
				copyg_account_store.getProxy().extraParams = params;
				copyg_account_store.load();
			}
			
			function copyg_account_dbclick(obj, record){
				AOS.setValue('copy_bug_form.standard_id',record.raw.standard_id);
				AOS.setValue('copy_bug_form.standard_name',record.raw.standard_name);
				copyw_standard_find.hide();
			}
			
			function copy_bug_win_show(){
				copy_bug_desc_editor=UM.getEditor('copy_bug_desc_editor',{
					autoHeightEnabled:false,
					autoFloatEnabled:true
				});
				var record = AOS.selectone(bug_grid,true);
				var records = AOS.select(bug_grid, true);
				if(AOS.empty(records) || records.length>1){
					AOS.tip('请选择一条需要复制的数据。');
					return;
				}
				var time = new Date();
				copy_bug_desc_editor.setContent(record.data.bug_detail||"");
				AOS.setValue("copy_bug_form.bug_name",record.data.bug_name);
				AOS.setValue("copy_bug_form.severity",record.data.severity);
				AOS.setValue("copy_bug_form.priority",record.data.priority);
				AOS.setValue("copy_bug_form.bug_addr",record.data.bug_addr);
				AOS.setValue("copy_bug_form.rate",record.data.rate);
				AOS.setValue("copy_bug_form.source",record.data.source);
				AOS.setValue("copy_bug_form.bug_type",record.data.bug_type);
				AOS.setValue("copy_bug_form.find_time",time);
				AOS.setValue("copy_bug_form.find_name",record.data.find_name);
				AOS.setValue("copy_bug_form.create_name",Number(<%=userid%>));
				AOS.setValue("copy_bug_form.create_time",time);
				var proj_name = tree_proj_name.getValue();
				if(record.data.state == '1000'){
					var copy_state = '未解决'
				}else if(record.data.state == '1001'){
					var copy_state = '已解决'
				}else if(record.data.state == '1002'){
					var copy_state = '延期处理'
				}else if(record.data.state == '1003'){
					var copy_state = '关闭'
				}else if(record.data.state == '1004'){
					var copy_state = '拒绝'
				}else if(record.data.state == '1005'){
					var copy_state = '重新打开'
				}else if(record.data.state == '1006'){
					var copy_state = '无法复现'
				}else {
					var copy_state = '已删除'
				}
				AOS.setValue("copy_bug_form.relate_bug_code",record.data.proj_name+"_"+record.data.bug_code+"_"+record.data.bug_name+"_"+copy_state);
				copy_bug_win.show();
				copy_bug_win.maximize();
			}
			
			function copy_bug_form_save(){
				var record = AOS.selectone(bug_grid,true);
				var bug_name=AOS.getValue("copy_bug_form.bug_name");
				var proj_id = copy_id_proj_name.getValue();
				var from_proj_id = record.data.proj_id;
				var stand_id = AOS.getValue("copy_bug_form.stand_id");
				var bug_name = AOS.getValue("copy_bug_form.bug_name");
				if(!Ext.isEmpty(bug_name)){
					if (bug_name.indexOf("'")>-1){
						AOS.tip("缺陷名称不能含有英文单引号！");
						return;
					}
				}
				AOS.ajax({
					forms : copy_bug_form, 
					params:{
						proj_id : proj_id,
						stand_id : stand_id,
						bug_name : bug_name
					},
					url : 'bugManageService.selectCopyBug',
					ok : function(data){
						var con = Number(data.appmsg);
						if(con == 0){
							AOS.ajax({
								forms : copy_bug_form,
								url : 'bugManageService.copyCreate',
								params:{
									submit_name: "${user.name}",
									bug_detail :copy_bug_desc_editor.getContent(),
									proj_id : proj_id,
									from_proj_id : from_proj_id,
									from_bug_id : record.data.bug_id,
									from_bug_proj : tree_proj_name.getValue()
								},
								ok : function(data){
									bug_grid_store.reload();
									copy_bug_win.hide();
								}
							});
						}else{
							var msg = AOS.merge('选取的项目模块下已存在同名缺陷，是否继续？');
							AOS.confirm(msg,function(btn){
								AOS.ajax({
									forms : copy_bug_form,
									url : 'bugManageService.copyCreate',
									params:{
										submit_name: "${user.name}",
										bug_detail :copy_bug_desc_editor.getContent(),
										proj_id : proj_id,
										from_bug_id : record.data.bug_id,
										from_bug_proj : tree_proj_name.getValue()
									},
									ok : function(data){
										bug_grid_store.reload();
										copy_bug_win.hide();
									}
								});
							});
						}
					}
				});
			}

			//新增/修改缺陷保存
			function bug_form_save() {
				var bug_name=AOS.getValue("bug_form.bug_name");
				if(!Ext.isEmpty(bug_name)){
					if (bug_name.indexOf("'")>-1){
						AOS.tip("缺陷名称不能含有英文单引号！");
						retrun;
					}
				}
				if(bug_form.editModel == "update"){
					AOS.ajax({
						forms : bug_form,
						url : 'bugManageService.update',
						params:{
									submit_name: "${user.name}",
									update_name: "${user.id}",
									bug_detail :bug_desc_editor.getContent()
								},
						ok : function(data) {
							AOS.tip(data.appmsg);
							bug_grid_store.reload();
							bug_win.hide();
						}
					});
				}else{
					var params = AOS.getValue("bug_form");
					var stand_id = params.stand_id;
					if(AOS.empty(stand_id)){
						AOS.tip("请选择关联模块。");
						return;
					}
					var deal_man = params.deal_man;
					if(AOS.empty(deal_man)){
						AOS.tip("请录入指派人。");
						return;
					}
					AOS.ajax({
						forms : bug_form,
						url : 'bugManageService.create',
						params:{
									submit_name: "${user.name}",
									bug_detail :bug_desc_editor.getContent()
								},
						ok : function(data) {
							AOS.tip(data.appmsg);
							bug_grid_store.reload();
							bug_win.hide();
						}
					});
				}
			}
			//项目版本号下拉框选择
			function versionOnSelect(me, records){
				var version_id = me.getValue();
				//console.log('bug_code_version_id.getStore()='+bug_code_version_id.getStore());
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
			
			function copyVersionOnSelect(me, records){
				var copy_version_id = me.getValue();
				copybug_test_version_id.getStore().getProxy().extraParams = {
					version_id : copy_version_id
				}; 
				copybug_test_version_id.getStore().load({
					callback : function(records, operation, success) {
						if (records.length > 0) {
							AOS.edit(copybug_test_version_id);
						}else{
							AOS.read(copybug_test_version_id);
						}
					}
				});
			}
			
			function copytest_versionOnSelect(me,records){
				var copy_test_version_id = me.getValue();
				copybug_code_version_id.getStore().getProxy().extraParams = {
					test_version_id : copy_test_version_id
				}
				copybug_code_version_id.getStore().load({
					callback : function(records, operation, success){
						if (records.length > 0) {
							AOS.edit(copybug_code_version_id);
						}else{
							AOS.read(copybug_code_version_id);
						}
					}
				});
			}

			//新增\修改页面项目下拉框添加变更事件
			function on_public_com_win(me, records){
				var proj_id = all_proj_id;
				var stand_id = AOS.getValue("bug_form.stand_id");
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
				
			}
	
			//模块下拉框添加变更事件
			/*function on_public_stand_id(me, records){
				var proj_id = all_proj_id;
				var stand_id = AOS.getValue("bug_form.stand_id");
				AOS.get('bug_form.standard_id').getStore().getProxy().extraParams = {
					proj_id : proj_id,
					stand_id : stand_id
				};
				AOS.get('bug_form.standard_id').getStore().load({
					callback : function(records, operation, success) {
					}
				});
			}*/
		    //超链接列转换开始
			function fn_link_render(value, metaData, record) {
				//可以根据record.data.xx数据来判断该列是否要加超连接
				return '<a href="javascript:void(0);">' + record.data.bug_name + '</a>';
			}
			bug_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				 var record = AOS.selectone(bug_grid, true); 
				if(AOS.empty(record) || record.length>1){
					AOS.tip('只能勾选一列查看缺陷详情。');
					return;
				}
				//record = records[0];
				//var a=record.data.deal_man;
				//判断列数是否为超链接列
				if (columnIndex == 4 ) {
					window.open("do.jhtml?router=bugManageService.newsManageInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+record.get("bug_id"));
				} 
			});
			//超链接列转换结束
		
			//删除选中的缺陷
			function bug_grid_del(){
				var selection = AOS.selection(bug_grid, 'bug_id');
				var rows = AOS.rows(bug_grid);
				if(AOS.empty(selection)){
					AOS.tip('请选择需要删除的数据。');
					return;
				}
				var selectstate = AOS.selection(bug_grid, 'state');
				//AOS.each();
				var strSelectstate = selectstate.split(",");
				for ( var now_state in strSelectstate) {
				if(strSelectstate[now_state]=="1003"){
				AOS.tip('包含关闭的缺陷，不能删除！');
				return;
					}
				}
				
				var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						//AOS.tip('删除操作被取消。');
						return;
					}
					AOS.ajax({
						url : 'bugManageService.deletes',
						params:{
							aos_rows: selection
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							bug_grid_store.reload();
						}
					});
				});
			}
			
			//项目ID全局变量
			var all_proj_id = '';
			//模块ID全局变量
			var all_stand_id = '';
			//模块名称全局变量
			var all_stand_id_name = '';
			//树节点单击函数
			function on_public_tree(){
				var record = AOS.selectone(public_module_divide_tree);
			    var proj_id = all_proj_id;
			    //查询条件
			    var params = AOS.getValue('bug_query_form');
			    params.proj_id = proj_id;
			    //当前节点
				var id = record.data.id;
			    //当前父节点
				var parentId = record.data.parentId;
				if(id == proj_id){
					 params.stand_id = null;
					 bug_grid_store.getProxy().extraParams = params;
				     bug_grid_store.loadPage(1);
				     all_stand_id_name = record.raw.text;
				     AOS.setValue("bug_query_form.stand_id","");
				     all_stand_id = '';
				} else{
					all_stand_id = id;
					all_stand_id_name = record.raw.text;
					AOS.setValue("bug_query_form.stand_id", id);
					params.stand_id = id;
				}
				
		        bug_grid_store.getProxy().extraParams = params;
		        bug_grid_store.loadPage(1);
			}
			//查询页面项目下拉框添加变更事件
			function on_public_com(me, records){
				var proj_id = me.getValue();
				all_stand_id_name='';
				all_stand_id='';
				AOS.get('bug_query_form.stand_id').getStore().getProxy().extraParams = {
					proj_id : proj_id
				};
				AOS.get('bug_query_form.stand_id').getStore().load({
					callback : function(records, operation, success) {
					}
				});
			}
		
			//刷新上级模块树
			function t_stand_find_refresh() {
				var proj_id = id_proj_name.getValue();
				var refreshnode = t_org_find.getRootNode();
				t_org_find_store.load({
					params:{
						proj_id : proj_id
					},
					callback : function() {
						//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
						refreshnode.collapse();
						refreshnode.expand();
					}
				});
			}
			//自动加载默认项目
			window.onload = function() {
				var proj_id = '${proj_id}';
				var proj_name = '${proj_name}';
				AOS.setValue('id_proj_name',proj_id);
				AOS.setValue('tree_proj_name',proj_name);
				
				public_module_divide_tree_refresh();
				all_proj_id= '${proj_id}';
				
				AOS.setValue("bug_query_form.proj_id",all_proj_id);
				//默认查询待处理缺陷（已解决 1001、拒绝 1004）
				bug_grid_mydeal_query();
				bug_deal_man.getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				}
				bug_deal_man.getStore().load();
				bug_final_deal_man.getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				}
				bug_final_deal_man.getStore().load();
				id_find_name.getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				}
				id_find_name.getStore().load();
				search_test_version_id.getStore().getProxy().extraParams = {
					proj_id : all_proj_id
				}
				search_test_version_id.getStore().load();
				w_org_find.hide();
			}
			//上级项目树节点双击事件
			function t_org_find_select() {
				var record = AOS.selectone(t_org_find);
				if(record.raw.a=="1"){
					AOS.setValue('id_proj_name',record.raw.id);
					AOS.setValue('tree_proj_name',record.raw.text);
					public_module_divide_tree_refresh();
					all_proj_id=record.raw.id
					AOS.setValue("bug_query_form.proj_id",all_proj_id);
					//默认查询待处理缺陷（已解决 1001、拒绝 1004）
					bug_grid_mydeal_query();
					bug_deal_man.getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					}
					bug_deal_man.getStore().load();
					bug_final_deal_man.getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					}
					bug_final_deal_man.getStore().load();
					id_find_name.getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					}
					id_find_name.getStore().load();
					search_test_version_id.getStore().getProxy().extraParams = {
						proj_id : all_proj_id
					}
					search_test_version_id.getStore().load();
					w_org_find.hide();
				}else{
					AOS.tip("请选择项目!");
					return;
				}
			}
			
			function proj_name_query(){
				var proj_name = AOS.getValue('proj_name');
				t_org_find_store.load({
					params:{
						proj_name : proj_name
					}
				})
			}
			
			//根据选择项目名称刷新树和grid
			function tree_query() {
				public_module_divide_tree_refresh();
				all_proj_id=id_proj_name.getValue();
				AOS.setValue("bug_query_form.proj_id",all_proj_id);
				//默认查询待处理缺陷（已解决 1001、拒绝 1004）
				bug_grid_mydeal_query();
			}
			
			//弹出选择上级模块窗口
			function stand_tree_show() {
				t_stand_find_store.load({
					 params:{
						 proj_id:id_proj_name.getValue()
					 }
				});
				w_stand_find.show();
			}
			
			//弹出选择上级模块窗口
			function copy_stand_tree_show() {
				copyt_stand_find_store.load({
					 params:{
						 proj_id:copy_id_proj_name.getValue()
					 }
				});
				copyw_stand_find.show();
			}
			
			//上级模块树节点双击事件
			function t_stand_find_select() {
				var record = AOS.selectone(t_stand_find);
				AOS.setValue('bug_form.stand_id',record.raw.id);
				AOS.setValue('bug_form.stand_id_name',record.raw.text);
				w_stand_find.hide();
			}
			
			//弹出测试用例选择表格
			function standard_grid_show(){
			 w_standard_find.show();
			}
			//账户表格双击事件
			function g_account_dbclick(obj, record) {
				AOS.setValue('bug_form.standard_id',record.raw.standard_id);
				//AOS.setValue('bug_form.standard_name',record.raw.standard_code+'-'+record.raw.execute_code);
				AOS.setValue('bug_form.standard_name',record.raw.standard_name);
				w_standard_find.hide();
			}
			//加载表格数据
			function g_account_query() {
				var proj_id = id_proj_name.getValue();
				var stand_id=AOS.getValue("bug_form.stand_id");
				var test_version_id = AOS.getValue("bug_form.test_version_id");
// 				alert(test_version_id);
				var standard_name =standard_name_query.getValue();
				var params = {
					proj_id : proj_id,
					stand_id : stand_id,
					standard_name:standard_name,
					test_version_id : test_version_id
				};
				//这个Store的命名规则为：表格ID+"store"。
				g_account_store.getProxy().extraParams = params;
				g_account_store.load();
			}
			
			//弹出选择上级模块窗口
			function proj_tree_show() {
				w_org_find.show();
			}
			
			//测试用例通过时间渲染
			function fn_pass_time(value){
				var date1 = new Date(value).getTime();
				var date2 = new Date("1999-01-01 00:00:00").getTime();
				if(date1 == date2){
					return "";
				}
				return value;
			}
			
			//bug关联
			function bug_relation(){
				AOS.reset(bug_relation_form);
				var record = AOS.selectone(bug_grid,true);
				var records = AOS.select(bug_grid, true);
				if(AOS.empty(records) || records.length>1){
					AOS.tip('请选择一条需要关联的数据。');
					return;
				}
				bug_relation_win.show();
				bug_relation_win.maximize();
			}
			
			function bug_relation_query_onder(){
				var params = AOS.getValue('bug_relation_form');
				params.proj_id = id_proj_name.getValue();
				bug_relation_grid_store.getProxy().extraParams =params;
				bug_relation_grid_store.loadPage(1);
			}
			
			function bug_relation_query(){
				var params = AOS.getValue('bug_relation_form');
				bug_relation_grid_store.getProxy().extraParams =params;
				bug_relation_grid_store.loadPage(1);
			}
			
			function bug_relation_save(){
				var record = AOS.selectone(bug_grid,true);
				var from_proj_id = record.data.proj_id;
				var from_bug_id = record.data.bug_id;
				var selection = AOS.selection(bug_relation_grid, 'bug_id');
				if(AOS.empty(selection)){
					AOS.tip('关联前请先选中数据。');
					return;
				}
				var rows = AOS.rows(bug_relation_grid);
				var msg =  AOS.merge('确认要关联选中的{0}条bug吗？', rows);
				AOS.confirm(msg,function(btn){
					if(btn === 'cancel'){
						AOS.tip('关联操作被取消。');
						return;
					}
					AOS.ajax({
						url : 'bugManageService.relationSave',
						params :{
							from_proj_id: from_proj_id,
							from_bug_id: from_bug_id,
							aos_rows: selection
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							bug_grid_store.reload();
							bug_relation_win.hide();
						}
					})
				})
			}
		</script>
	</aos:viewport>
</aos:onready>

<script type="text/javascript"> 
	function w_account2_show(){
		AOS.get('bug_win').setTitle("修改缺陷");
		AOS.get('bug_form').editModel='update';
		var record = AOS.selectone(AOS.get('bug_grid'), true);
		if(AOS.empty(record)){
			AOS.tip('请选择要修改的记录。');
			return;
		}
		AOS.get('bug_form').loadRecord(record);
		AOS.get('bug_win').show(); 
		AOS.get('bug_win').maximize(); 
	}
	//删除缺陷
	function fn_del(){
		//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
		var record = AOS.selectone(AOS.get('bug_grid'));
		if(record.data.state=="1003"){
			AOS.tip('该缺陷已关闭，不能进行该操作！');
			return;
		}
		var msg =  AOS.merge('确认要删除缺陷【{0}】吗？', record.data.bug_code);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'bugManageService.delete',
				params:{
					id: record.data.bug_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('bug_grid').getStore().reload();
				}
			});
		});
	}
	//延期处理缺陷
	function fn_delay(){
		var record = AOS.selectone(AOS.get('bug_grid'),true);
		if(record.data.state=="1003"){
			AOS.tip('该缺陷已关闭，不能进行该操作！');
			return;
		}
		if(record.data.state=="1002"){
			AOS.tip('该缺陷状态为延期处理，不能进行该操作！');
			return;
		}
		var msg =  AOS.merge('确认要延期处理缺陷【{0}】吗？', record.data.bug_code);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'bugManageService.delay',
				params:{
					bug_id: record.data.bug_id,
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('bug_grid').getStore().reload();
				}
			});
		});
	}
	//关闭缺陷
	function fn_close() {
		var record = AOS.selectone(AOS.get('bug_grid'),true);
		if(record.data.state=="1003"){
			AOS.tip('该缺陷已关闭，不能进行该操作！');
			return;
		}
		var msg =  AOS.merge('确认要关闭缺陷【{0}】吗？', record.data.bug_code);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'bugManageService.close',
				params:{
					bug_id: record.data.bug_id,
					close_name: "${user.name}"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('bug_grid').getStore().reload();
				}
			});
		});
	}

	//默认选中第一个项目
	/* window.onload=function combobox_select(){
		var record = AOS.get('t_org_find');
		var arr = record.store.tree.nodeHash.A1.childNodes;
		if(arr.length >0){
			var proj_id = arr[0].raw.id;
			var porj_name = arr[0].raw.text;
			AOS.get('id_proj_name').setValue(proj_id);
			AOS.get('tree_proj_name').setValue(porj_name);
			AOS.setValue("bug_query_form.proj_id",arr[0].raw.id);
	
	
			var proj_id = arr[0].raw.id;
			AOS.get('public_module_divide_tree').store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					// refreshnode.collapse();
					//refreshnode.expand(); 
					AOS.get('public_module_divide_tree').getSelectionModel().select(AOS.get('public_module_divide_tree').getRootNode());
				}
			});
			//默认查询待处理缺陷（已解决 1001、拒绝 1004）
			var params = {create_name : "${user.id}"};
	    	params.dealed_state="1001"
	    	params.refused_state="1004"
	    	params.proj_id=arr[0].raw.i;
	        AOS.get('bug_grid').store.getProxy().extraParams = params;
	        AOS.get('bug_grid').store.loadPage(1);  
		}else{
			AOS.tip('该角色未分配项目，请先分配项目！');
		}
	} 
	 */
	 function bug_refresh() {
			AOS.get('bug_grid').getStore().reload();
		}
</script>