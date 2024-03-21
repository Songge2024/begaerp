<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="检查单汇总查询" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel tabPosition="top" id="id_tabpanel" region="center">
			<aos:tab id="bug_type_query" title="缺陷类型统计" layout="border" autoScroll="false">
				<aos:panel region="west" bodyBorder="0 1 0 1" width="330">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="项目选择" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:triggerfield  id="type_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="type_proj_tree_show" width="240" />
						<aos:hiddenfield id="type_id_proj_name" name="id_proj_name"/>
					</aos:docked>
					<aos:treepanel id="public_module_divide_tree_type" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
						border="true" onitemclick="on_public_tree_type">
					</aos:treepanel>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="bug_type_form" layout="column" labelWidth="100"
							header="false" border="false">
							<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
								hidden="true" editable="false" columnWidth="0.4"
								url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"	/>
							<aos:datefield  name="find_begin_time" fieldLabel="发现开始时间" columnWidth="0.5"  editable="false" />
							<aos:datefield  name="find_end_time" fieldLabel="发现结束时间" columnWidth="0.5"  editable="false" />
							<aos:combobox id="test_version_id" fieldLabel="测试版本号" name="test_version_id" 
								editable="false" columnWidth="0.5" queryMode="local" width="100" 
								url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
							<aos:combobox id="stand_ids" fieldLabel="项目模块" name="dm_code" multiSelect="true"
								editable="false" columnWidth="0.5" queryMode="local" width="100"
								url="projBugAnalysisService.selectModel" emptyText="项目模块"/>
							<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
								<aos:dockeditem xtype="tbfill" />
								<aos:dockeditem xtype="button" text="查询" onclick="select_type_count"
									icon="query.png" />
								<aos:dockeditem xtype="button" text="重置"
									onclick="AOS.reset(bug_type_form);" icon="refresh.png" />
								<aos:dockeditem xtype="tbfill" />
							</aos:docked>
						</aos:formpanel>
					</aos:panel>
					<aos:gridpanel id="bug_type_grid" url="projBugAnalysisService.bugTypeCountPage"  features="summary"
						forceFit="true" anchor="100%" border="true" region="center" bodyBorder="1 0 1 0">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="缺陷类型统计信息" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem text="全部导出" icon="icon70.png" onclick="bugType_export_excel" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" header="序号" align="center" width="35" />
						<aos:column header="子系统" dataIndex="stard_name" width="120" align="center" summaryRenderer="function(){return '合计'}"/>
						<aos:column header="轻微" dataIndex="slight" width="130" align="center" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return '待解决：'+summary.unsolve_total}"/>
						<aos:column header="一般" dataIndex="general" width="80" align="center" rendererFn="fn_bug_bgcolor_render"/>
						<aos:column header="严重" dataIndex="severitys" width="80" align="center" rendererFn="fn_bug_bgcolor_render"/>
						<aos:column header="致命" dataIndex="deadly" width="80" align="center" rendererFn="fn_bug_bgcolor_render"/>
						<aos:column header="小计" dataIndex="subtotal" width="80" align="center"/>
						<aos:column header="重新打开" dataIndex="open" width="100" align="center" rendererFn="fn_bugs_bgcolor_render"  summaryRenderer="function(){return '重新打开:'+summary.reopen_total}"/>
						<aos:column header="延后处理" dataIndex="postpone" width="120" align="center" rendererFn="fn_bug_bgcolor_render"  summaryRenderer="function(){return '延后处理:'+summary.postpone_total}"/>
						<aos:column header="已解决" dataIndex="resolved" width="120" align="center" rendererFn="fn_bugs_bgcolor_render" summaryRenderer="function(){return '已解决:'+summary.solve_total}"/>
						<aos:column header="关闭" dataIndex="close" width="100" align="center" rendererFn="fn_bugs_bgcolor_render"/>
						<aos:column header="拒绝" dataIndex="refuse" width="100" align="center" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return '其他:'+summary.other_total}"/>
						<aos:column header="无法复现" dataIndex="reappear" width="100" align="center" rendererFn="fn_bug_bgcolor_render"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="bug_deal_query" title="缺陷处理人统计" layout="border" autoScroll="false">
				<aos:panel region="west" bodyBorder="0 1 0 1" width="330">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="项目选择" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:triggerfield  id="deal_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="deal_proj_tree_show" width="240" />
						<aos:hiddenfield id="deal_id_proj_name" name="id_proj_name"/>
					</aos:docked>
					<aos:treepanel id="public_module_divide_tree_deal" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
						border="true" onitemclick="on_public_tree_deal">
					</aos:treepanel>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="bug_deal_form" layout="column" labelWidth="100"
							header="false" border="false">
							<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
								hidden="true" editable="false" columnWidth="0.4"
								url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"	/>
							<aos:combobox fieldLabel="模块" name="stand_id" margin="4" 
								hidden="true" editable="true" columnWidth="0.3" labelWidth="45"
								url="moduleDivideService.listModuleDivideComboBox" />
							<aos:datefield  name="find_begin_time" fieldLabel="发现开始时间" columnWidth="0.5"  editable="false" />
							<aos:datefield  name="find_end_time" fieldLabel="发现结束时间" columnWidth="0.5"  editable="false" />
							<aos:combobox id="deal_test_version_id" fieldLabel="测试版本号" name="test_version_id" 
								editable="false" columnWidth="0.5" queryMode="local" width="100" 
								url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
							<aos:combobox id="deal_mans" fieldLabel="处理人" name="deal_mans" multiSelect="true"
								editable="false" columnWidth="0.5" queryMode="local" width="100" 
								url="bugManageService.listDealmanComboBox" emptyText="处理人查询"/>
							<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
								<aos:dockeditem xtype="tbfill" />
								<aos:dockeditem xtype="button" text="查询" onclick="select_deal_count"
									icon="query.png" />
								<aos:dockeditem xtype="button" text="重置"
									onclick="AOS.reset(bug_deal_form);" icon="refresh.png" />
								<aos:dockeditem xtype="tbfill" />
							</aos:docked>
						</aos:formpanel>
					</aos:panel>
					<aos:gridpanel id="bug_deal_grid" url="projBugAnalysisService.bugDealCountPage"  features="summary"
						forceFit="true" anchor="100%" border="true" region="center" bodyBorder="1 0 1 0">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="缺陷类型统计信息" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem text="全部导出" icon="icon70.png" onclick="bugDeal_export_excel" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" header="序号" align="center" width="35" />
						<aos:column header="bug处置人" dataIndex="deal_name" width="70" align="center" summaryRenderer="function(){return '合计'}"/>
						<aos:column header="处理人" dataIndex="deal_man" width="80" align="center" hidden="true"/>
						<aos:column header="待解决" type="group">
							<aos:column header="轻微" dataIndex="slight" width="130" align="center" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return '待解决：'+summary.to_be_solved}"/>
							<aos:column header="一般" dataIndex="general" width="100" align="center" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return '已解决:'+summary.resolved}"/>
							<aos:column header="严重" dataIndex="severitys" width="100" align="center" rendererFn="fn_bug_bgcolor_render" summaryRenderer="function(){return '已关闭:'+summary.closed}"/>
							<aos:column header="致命" dataIndex="deadly" width="100" align="center" rendererFn="fn_bug_bgcolor_render"/>
							<aos:column header="小计" dataIndex="subtotal" width="130" align="center" />							
						</aos:column>
						<aos:column header="重新打开" dataIndex="open" width="130" align="center" rendererFn="fn_bugs_bgcolor_render" summaryRenderer="function(){return '总计:'+summary.total_bug_num}"/>
						<aos:column header="延期处理" dataIndex="postpone" width="100" align="center" rendererFn="fn_bug_bgcolor_render"/>
						<aos:column header="已解决" dataIndex="resolved" width="100" align="center" rendererFn="fn_bugs_bgcolor_render"/>
						<aos:column header="关闭" dataIndex="close" width="100" align="center" rendererFn="fn_bugs_bgcolor_render"/>
						<aos:column header="拒绝" dataIndex="refuse" width="100" align="center" rendererFn="fn_bug_bgcolor_render"/>
						<aos:column header="无法复现" dataIndex="reappear" width="100" align="center" rendererFn="fn_bug_bgcolor_render"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="bug_solve_query" title="缺陷解决率统计" layout="border" autoScroll="false">
				<aos:panel region="north" height ="34"  bodyBorder="0 0 0 0">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="选择项目:" />
							<aos:triggerfield  id="solve_tree_proj_name" name="tree_proj_name" editable="false" 
								trigger1Cls="x-form-search-trigger" onTrigger1Click="solve_proj_tree_show" width="220" />
							<aos:hiddenfield id="solve_id_proj_name" name="id_proj_name"/>
					</aos:docked>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="bug_solve_form" layout="column" labelWidth="100"
							header="false" border="false">
							<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
								hidden="true" editable="false" columnWidth="0.4"
								url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"	/>
							<aos:combobox id="solve_test_version_id" fieldLabel="测试版本号" name="test_version_id" 
								editable="false" columnWidth="0.15" queryMode="local" labelWidth="70" 
								url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
							<aos:datefield  name="find_begin_time" fieldLabel="发现开始时间" columnWidth="0.15" labelWidth="85" editable="false" />
							<aos:datefield  name="find_end_time" fieldLabel="发现结束时间" columnWidth="0.15" labelWidth="85" editable="false" />
							<aos:button text="查询" onclick="select_solve_count"
								icon="query.png" margin="0 4 4 10" />
							<aos:button text="重置" onclick="AOS.reset(bug_solve_form);"
								icon="refresh.png" margin="0 4 4 10" />
						</aos:formpanel>
					</aos:panel>
					<aos:gridpanel id="bug_solve_grid" url="projBugAnalysisService.bugSolveCountPage"
						forceFit="true" anchor="100%" border="true" region="center" bodyBorder="1 0 1 0">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="缺陷解决率统计信息" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem text="全部导出" icon="icon70.png" onclick="bugSolve_export_excel" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" header="序号" align="center" width="35" />
						<aos:column header="solve_severitys" dataIndex="solve_severitys" width="100" align="center" hidden="true"/>
						<aos:column header="严重等级" dataIndex="dic_descs" width="80" align="center" />
						<aos:column header="缺陷总数" dataIndex="bug_total" width="80" align="center"/>
						<aos:column header="已解决数" dataIndex="solved" width="80" align="center"/>
						<aos:column header="待解决数" dataIndex="tobesolve" width="80" align="center"/>
						<aos:column header="其他" dataIndex="other" width="80" align="center"/>
						<aos:column header="解决率" dataIndex="resolution" width="100" align="center"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="test_example_query" title="测试用例通过率统计" layout="border" autoScroll="false">
				<aos:panel region="west" bodyBorder="0 1 0 1" width="330">
					<aos:docked>
						<aos:dockeditem xtype="tbtext" text="项目选择" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:triggerfield  id="test_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="test_proj_tree_show" width="240" />
						<aos:hiddenfield id="test_id_proj_name" name="id_proj_name"/>
					</aos:docked>
					<aos:treepanel id="public_module_divide_test_type" flex="1" title="项目模块树" singleClick="false" rootVisible="false" url="projTypesService.getModuleDivideTreeData" 
						border="true" >
					</aos:treepanel>
				</aos:panel>
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="test_query_form" layout="column" labelWidth="100"
							header="false" border="false">
							<aos:combobox fieldLabel="项目" name="proj_id" margin="4"
								hidden="true" editable="false" columnWidth="0.4"
								url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"	/>
							<aos:combobox id="example_test_version_id" fieldLabel="测试版本号" name="test_version_id" 
								editable="false" columnWidth="0.5" queryMode="local" width="100" 
								url="bugManageService.listSearchTestVersionId" emptyText="测试版本号查询"/>
							<aos:combobox id="test_stand_ids" fieldLabel="项目模块" name="dm_code" multiSelect="true"
								editable="false" columnWidth="0.5" queryMode="local" width="100"
								url="projBugAnalysisService.selectModel" emptyText="项目模块"/>
							<aos:docked dock="bottom" ui="footer" margin="0 0 0 0">
								<aos:dockeditem xtype="tbfill" />
								<aos:dockeditem xtype="button" text="查询" onclick="select_test_count"
									icon="query.png" />
								<aos:dockeditem xtype="button" text="重置"
									onclick="AOS.reset(test_query_form);" icon="refresh.png" />
								<aos:dockeditem xtype="tbfill" />
							</aos:docked>
						</aos:formpanel>
					</aos:panel>
					<aos:gridpanel id="test_query_grid" url="projBugAnalysisService.testExamplePage"  
						forceFit="true" anchor="100%" border="true" region="center" bodyBorder="1 0 1 0">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="测试用例通过率信息" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem text="全部导出" icon="icon70.png" onclick="test_export_excel" />
						</aos:docked>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" header="序号" align="center" width="35" />
						<aos:column header="子系统" dataIndex="stard_name" width="100" align="center"/>
						<aos:column header="子系统ID" dataIndex="stand_id" width="100" align="center"/>
						<aos:column header="用例总数" dataIndex="all_example" width="80" align="center"/>
						<aos:column header="用例通过数" dataIndex="pass_example" width="80" align="center"/>
						<aos:column header="通过率" dataIndex="pass_rate" width="80" align="center"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="example_statistics" title="用例执行统计" layout="border" autoScroll="false">
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="example_query"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
							<aos:docked forceBoder="0 0 1 0">
								<aos:dockeditem xtype="tbtext" text="查询条件" />
							</aos:docked>
							<aos:textfield name="account_number_name" fieldLabel="成员姓名" columnWidth="0.2" onenterkey="example_statistics_query"/>
							<aos:hiddenfield name="user_id" fieldLabel="人员ID" value='${id}' />
							<aos:combobox fieldLabel="日期" id="id_main_time" name="main_time"
								columnWidth="0.15" margin="0 10 0 10" onselect="fn_change" value="2">
								<aos:option value="1" display="本周" />
								<aos:option value="2" display="本月" />
								<aos:option value="3" display="本年" />
								<aos:option value="4" display="当天" />
							</aos:combobox>
							<aos:combobox id="search_principal_org" fieldLabel="负责人部门" name="subordinate_departments" 
									editable="false" columnWidth="0.33" queryMode="local" onselect="fn_org"  value='${principal_org}' width="100">
									<aos:option value="-1" display="图元科技" />
									<aos:option value="1278" display="研发部" />
									<aos:option value="8998" display="质量管理部" />
									<aos:option value="9091" display="工程部" />
									<aos:option value="9117" display="QA" />
									<aos:option value="10541" display="售后服务部" />
									<aos:option value="17251" display="其他" />
							</aos:combobox>
							<aos:datefield name="plan_begin_time" fieldLabel="开始时间" format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
							<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
								
							<aos:dockeditem xtype="button" text="查询" onclick="example_statistics_query" icon="query.png" margin="0 5 0 10" />
							<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(example_query);" icon="refresh.png"  margin="0 5 0 5" />
						</aos:formpanel>
					</aos:panel>
					<!-- 列表窗口 -->
					<aos:gridpanel id="example_statistics_grid"  autoScroll="true" hidePagebar="true" url="projBugAnalysisService.exampleStatisticsPage" 
								forceFit="false" onrender="example_statistics_query_onder" onitemdblclick="show_example_detail" region="center">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="用例执行统计" />
						</aos:docked>
						<aos:column type="rowno" width="40"/>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column header="成员id" dataIndex="tester_id"  width="240" align="center" hidden="true"/>
						<aos:column header="成员姓名" dataIndex="account_number_name" width="240" align="left" celltip="true" />
						<aos:column header="所属部门" dataIndex="subordinate_departments" width="240" align="left" />	
						<aos:column header="个人用例执行次数" dataIndex="example_times" width="150" align="left" />
						<aos:column header="执行总次数" dataIndex="total_execution_times" width="150" align="left" />
						<aos:column header="执行项目个数" dataIndex="statistics_num" width="150" align="left" />
						<aos:column header="详情" align="center" rendererFn="example_detail" width="150"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
			
			<aos:tab id="bug_submit_statistics" title="bug提交统计" layout="border" autoScroll="false">
				<aos:panel region="center" border="false" layout="border">
					<aos:panel region="north" bodyBorder="0 0 1 0" hidden="false">
						<aos:formpanel id="bug_submit_query" labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
							<aos:docked forceBoder="0 0 1 0">
								<aos:dockeditem xtype="tbtext" text="查询条件" />
							</aos:docked>
							<aos:textfield name="account_number_name" fieldLabel="成员姓名" columnWidth="0.2" onenterkey="bug_submit"/>
							<aos:hiddenfield name="user_id" fieldLabel="人员ID" value='${id}' />
							<aos:combobox fieldLabel="日期" id="bug_main_time" name="main_time"
								columnWidth="0.15" margin="0 10 0 10" onselect="bug_change" value="2">
								<aos:option value="1" display="本周" />
								<aos:option value="2" display="本月" />
								<aos:option value="3" display="本年" />
								<aos:option value="4" display="当天" />
							</aos:combobox>
							<aos:combobox id="bug_principal_org" fieldLabel="负责人部门" name="subordinate_departments" 
									editable="false" columnWidth="0.33" queryMode="local" onselect="bug_org" value='${principal_org}' width="100">
									<aos:option value="-1" display="图元科技" />
									<aos:option value="1278" display="研发部" />
									<aos:option value="8998" display="质量管理部" />
									<aos:option value="9091" display="工程部" />
									<aos:option value="9117" display="QA" />
									<aos:option value="10541" display="售后服务部" />
									<aos:option value="17251" display="其他" />
							</aos:combobox>
							<aos:datefield name="plan_begin_time" fieldLabel="开始时间" format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
							<aos:datefield name="plan_end_time" fieldLabel="结束时间" format="Y-m-d " columnWidth="0.14" editable="false" margin="0 0 0 0" />
								
							<aos:dockeditem xtype="button" text="查询" onclick="bug_submit" icon="query.png" margin="0 5 0 10" />
							<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(bug_submit_query);" icon="refresh.png"  margin="0 5 0 5" />
						</aos:formpanel>
					</aos:panel>
					<!-- 列表窗口 -->
					<aos:gridpanel id="bug_submit_grid"  autoScroll="true" hidePagebar="true" url="projBugAnalysisService.bugSubmitPage" 
								forceFit="false" onrender="bug_submit_query_onder" region="center">
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="bug提交统计" />
						</aos:docked>
						<aos:column type="rowno" width="40"/>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column header="成员id" dataIndex="create_name"  width="240" align="center" hidden="true"/>
						<aos:column header="成员姓名" dataIndex="account_number_name" width="240" align="center" celltip="true" />
						<aos:column header="所属部门" dataIndex="subordinate_departments" width="240" align="center" />	
						<aos:column header="BUG总数量" dataIndex="example_times" width="150" align="center" />
						<aos:column header="项目总数" dataIndex="statistics_num" width="150" align="center" />
						<aos:column header="所有BUG详情" align="center" rendererFn="bug_submit_detail" width="130"/>
						<aos:column header="项目BUG统计" align="center" rendererFn="bug_proj_detail" width="130"/>
					</aos:gridpanel>
				</aos:panel>
			</aos:tab>
		</aos:tabpanel>
		
		<!-- 工作详情窗口 -->
		<aos:window id="example_particulars" title="个人用例执行详情窗口" width="1200" height="550" autoScroll="true" onshow="example_particulars_grid_query">
			<aos:gridpanel id="example_particulars_grid"  forceFit="false" hidePagebar="true"  border="true" 
				url="projBugAnalysisService.examplePage" onrender="example_particulars_grid_query" features="summary">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="项目名称:" />
					<aos:triggerfield id="example_proj_name" onenterkey="projCommons_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="projCommons_name_query" width="180" />
					<aos:combobox fieldLabel="状态" name="pass_or_fail" id="pass_or_fail" dicField="pass_or_fail" onselect="projCommons_name_query" labelWidth="40"></aos:combobox>
				</aos:docked>
				<aos:column type="rowno" width="40"/>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column header="执行人id" dataIndex="tester_id" width="100" align="center" hidden="true"/>
				<aos:column header="执行人" dataIndex="tester_name" width="100" align="center"/>
				<aos:column header="执行时间" dataIndex="test_time" width="160" align="center" summaryRenderer="function(){return '共 ' +summary.example_num+'条用例'}"/>
				<aos:column header="项目名称" dataIndex="proj_name" width="150" align="left" />
				<aos:column header="优先级" dataIndex="priority" width="80" align="center" />
				<aos:column header="用例标题" dataIndex="standard_name" width="150" align="left" celltip="true"/>
				<aos:column header="执行次数" dataIndex="execute_number" width="80" align="right" summaryRenderer="function(){return '执行' +summary.execution_times+'次'}"/>
				<aos:column header="功能模块" dataIndex="function_module" width="150" align="center" />
				<aos:column header="测试结果" dataIndex="pass_or_fail" width="100" align="center"  rendererFn="fn_example_state"/>
				<aos:column header="测试版本号ID" dataIndex="test_version_id" width="150" align="center" hidden="true"/>
				<aos:column header="测试版本号" dataIndex="test_version_number" width="150" align="center" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#example_particulars.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<!-- 工作详情窗口 -->
		<aos:window id="bug_particulars" title="所有BUG详情" width="1200" height="550" autoScroll="true" onshow="bug_particulars_grid_query">
			<aos:gridpanel id="bug_particulars_grid"  forceFit="false" hidePagebar="true"  border="true" 
				  url="projBugAnalysisService.bugPage" onrender="bug_particulars_grid_query" features="summary">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="项目名称:" />
					<aos:triggerfield id="bug_particulars_proj_name" onenterkey="bug_particulars_name_query" trigger1Cls="x-form-search-trigger"
						 onTrigger1Click="bug_particulars_name_query" width="180" />
				</aos:docked>
				<aos:column type="rowno" width="40"/>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column header="提交人id" dataIndex="create_name" width="100" align="center" hidden="true" />
				<aos:column header="提交人" dataIndex="bug_create_name" width="100" align="center" />
				<aos:column header="当前状态" dataIndex="state" width="80" align="center" rendererFn="fn_bug_state" />
				<aos:column header="缺陷编码" dataIndex="bug_code" width="130" align="center" summaryRenderer="function(){return '共 ' +summary.bug_num+'条bug'}"/>
				<aos:column header="缺陷名称" dataIndex="bug_name" width="350" celltip="true"/>
				<aos:column header="项目名称" dataIndex="proj_name" width="170" align="left" celltip="true"/>
				<aos:column header="提交时间" dataIndex="create_time" width="150" />
				<aos:column header="当前处置人" dataIndex="deal_man_name" width="100" align="center" />
				<aos:column header="解决人" dataIndex="final_deal_man" width="100" align="center" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#bug_particulars.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<!-- 工作详情窗口 -->
		<aos:window id="bug_proj_particulars" title="项目BUG统计" width="800" height="550" autoScroll="true" onshow="bug_proj_particulars_grid_query">
			<aos:gridpanel id="bug_proj_particulars_grid"  forceFit="false" hidePagebar="true"  border="true" 
				  url="projBugAnalysisService.bugProjPage" onrender="bug_proj_particulars_grid_query" features="summary">
			  	<aos:column type="rowno" width="40"/>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column header="发起人id" dataIndex="create_name" width="100" align="center" hidden="true" />
				<aos:column header="姓名" dataIndex="bug_create_name" width="100" align="center" />
				<aos:column header="项目名称" dataIndex="proj_name" width="270" align="left" celltip="true"/>
				<aos:column header="BUG数量" dataIndex="bug_initiate_num" width="150" align="center" summaryRenderer="function(){return '共 ' +summary.bug_num+'条bug'}"/>
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#bug_proj_particulars.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	</aos:viewport>
	
	<aos:window id="type_w_org_find" x="0" y="30" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="type_proj_name" onenterkey="type_proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="type_proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="type_t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="type_org_find_select" />
	</aos:window>
	<aos:window id="deal_w_org_find" x="0" y="30" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="deal_proj_name" onenterkey="deal_proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="deal_proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="deal_t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="deal_org_find_select" />
	</aos:window>
	<aos:window id="solve_w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="solve_proj_name" onenterkey="solve_proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="solve_proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="solve_t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="solve_org_find_select" />
	</aos:window>
	<aos:window id="test_w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
			<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
			<aos:triggerfield  id="test_proj_name" onenterkey="test_proj_name_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="test_proj_name_query" width="180" />
		</aos:docked>
		<aos:treepanel id="test_t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="test_org_find_select" />
	</aos:window>
	
	
	<script type="text/javascript">
		window.onload = function (){
			var proj_id = '${proj_id}';
			var proj_name = '${proj_name}';
			AOS.setValue('type_id_proj_name',proj_id);
			AOS.setValue('type_tree_proj_name',proj_name);
			AOS.setValue('deal_id_proj_name',proj_id);
			AOS.setValue('deal_tree_proj_name',proj_name);
			AOS.setValue('solve_id_proj_name',proj_id);
			AOS.setValue('solve_tree_proj_name',proj_name);
			AOS.setValue('test_id_proj_name',proj_id);
			AOS.setValue('test_tree_proj_name',proj_name);
			public_module_divide_tree_type_refresh();
			public_module_divide_tree_deal_refresh();
			solve_refresh();
			public_module_divide_test_type_refresh();
			AOS.setValue("bug_type_form.proj_id",proj_id);
			test_version_id.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			test_version_id.getStore().load();
			deal_test_version_id.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			deal_test_version_id.getStore().load();
			stand_ids.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			stand_ids.getStore().load();
			deal_mans.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			deal_mans.getStore().load();
			solve_test_version_id.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			solve_test_version_id.getStore().load();
			example_test_version_id.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			example_test_version_id.getStore().load();
			test_stand_ids.getStore().getProxy().extraParams = {
				proj_id : proj_id
			}
			test_stand_ids.getStore().load();
			type_w_org_find.hide();
			deal_w_org_find.hide();
			solve_w_org_find.hide();
			test_w_org_find.hide();
		}
		//弹出选择上级模块窗口
		function type_proj_tree_show() {
			type_w_org_find.show();
		}
		//弹出选择上级模块窗口
		function deal_proj_tree_show() {
			deal_w_org_find.show();
		}
		//弹出选择上级模块窗口
		function solve_proj_tree_show() {
			solve_w_org_find.show();
		}
		//弹出选择上级模块窗口
		function test_proj_tree_show() {
			test_w_org_find.show();
		}
		//树节点单击
		function on_public_tree_type() {
			
		}
		
		function type_proj_name_query(){
			var proj_name = AOS.getValue('type_proj_name');
			type_t_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		function deal_proj_name_query(){
			var proj_name = AOS.getValue('deal_proj_name');
			deal_t_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		function solve_proj_name_query(){
			var proj_name = AOS.getValue('solve_proj_name');
			solve_t_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		function test_proj_name_query(){
			var proj_name = AOS.getValue('test_proj_name');
			test_t_org_find_store.load({
				params:{
					proj_name : proj_name
				}
			})
		}
		
		//处理树节点单击
		function on_public_tree_deal() {
			var record = AOS.selectone(public_module_divide_tree_deal);
		    var proj_id = deal_id_proj_name.getValue();
		    //查询条件
		    var params = AOS.getValue('bug_deal_form');
		    params.proj_id = proj_id;
		    //当前节点
			var id = record.data.id;
			if(id == proj_id){
				 params.stand_id = null;
			} else{
				params.stand_id = id;
			}
			AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
		    	params : params,
		    	url : 'projBugAnalysisService.bugDealTotal',
		    	ok : function(data){
		    		summary = data; 
					bug_deal_grid_store.getProxy().extraParams = params;
					bug_deal_grid_store.loadPage(1);					
		    	}
			});
		}
		//类型统计查询
		function select_type_count(){
		    var proj_id = type_id_proj_name.getValue();
		    //查询条件
		    var params = AOS.getValue('bug_type_form');
		    params.proj_id = proj_id;
		    AOS.ajax({
		    	wait : false, //防止出现2个遮罩层。(ajax和表格load)
		    	params : params,
		    	url : 'projBugAnalysisService.bugTypeTotal',
		    	ok : function(data){
		    		summary = data; 
					bug_type_grid_store.getProxy().extraParams = params;
					bug_type_grid_store.loadPage(1);
		    	}
		    });
		}
		//人员统计查询
		function select_deal_count(){
			on_public_tree_deal();
		}
		//解决率统计查询
		function select_solve_count(){
			var proj_id = solve_id_proj_name.getValue();
			//查询条件
			var params = AOS.getValue('bug_solve_form');
			params.proj_id = proj_id;
			/* AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.bugTypeTotal',
				ok : function(data){
					summary = data;  */
					bug_solve_grid_store.getProxy().extraParams = params;
					bug_solve_grid_store.loadPage(1);
			/* 	}
			}); */
		}
		//用例通过率查询
		function select_test_count(){
			var proj_id = test_id_proj_name.getValue();
			var params = AOS.getValue('test_query_form');
			params.proj_id = proj_id;
			test_query_grid_store.getProxy().extraParams = params;
			test_query_grid_store.loadPage(1);
		}
		
		//类型点击选择项目
		function type_org_find_select() {
			var record = AOS.selectone(type_t_org_find);
			if(record.raw.a=="1"){
				AOS.setValue('type_id_proj_name',record.raw.id);
				AOS.setValue('type_tree_proj_name',record.raw.text);
				public_module_divide_tree_type_refresh();
				var proj_id=record.raw.id
				AOS.setValue("bug_type_form.proj_id",proj_id);
				test_version_id.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				test_version_id.getStore().load();
				
				stand_ids.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				stand_ids.getStore().load();
				
				type_w_org_find.hide();
			}else{
				AOS.tip("请选择项目！");
				return;
			}
		}
		//处理人点击选择项目
		function deal_org_find_select(){
			var record = AOS.selectone(deal_t_org_find);
			if(record.raw.a=="1"){
				AOS.setValue('deal_id_proj_name',record.raw.id);
				AOS.setValue('deal_tree_proj_name',record.raw.text);
				public_module_divide_tree_deal_refresh();
				var proj_id=record.raw.id
				AOS.setValue("bug_deal_form.proj_id",proj_id);
				deal_test_version_id.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				deal_test_version_id.getStore().load();
				deal_mans.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				deal_mans.getStore().load();
				deal_w_org_find.hide();
			}else{
				AOS.tip("请选择项目！");
				return;
			}
		}
		//解决率点击选择项目
		function solve_org_find_select(){
			AOS.reset(bug_solve_form);
			var record = AOS.selectone(solve_t_org_find);
			if(record.raw.a=="1"){
				AOS.setValue('solve_id_proj_name',record.raw.id);
				AOS.setValue('solve_tree_proj_name',record.raw.text);
				solve_refresh();
				var proj_id=record.raw.id
				AOS.setValue("bug_solve_form.proj_id",proj_id);
				solve_test_version_id.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				solve_test_version_id.getStore().load();
				solve_w_org_find.hide();
			}else{
				AOS.tip("请选择项目！");
				return;
			}
		}
		//通过率点击选择项目
		function test_org_find_select(){
			var record = AOS.selectone(test_t_org_find);
			if(record.raw.a=="1"){
				AOS.setValue('test_id_proj_name',record.raw.id);
				AOS.setValue('test_tree_proj_name',record.raw.text);
				public_module_divide_test_type_refresh();
				var proj_id=record.raw.id
				AOS.setValue("test_example_query.proj_id",proj_id);
				example_test_version_id.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				example_test_version_id.getStore().load();
				
				test_stand_ids.getStore().getProxy().extraParams = {
					proj_id : proj_id
				}
				test_stand_ids.getStore().load();
				
				test_w_org_find.hide();
			}else{
				AOS.tip("请选择项目！");
				return;
			}
		}
		//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
		function public_module_divide_tree_type_refresh() {
			var proj_id = type_id_proj_name.getValue();
			public_module_divide_tree_type_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					/* refreshnode.collapse();
					refreshnode.expand(); */
					public_module_divide_tree_type.getSelectionModel().select(public_module_divide_tree_type.getRootNode());
				}
			});
			
		}
		//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
		function public_module_divide_tree_deal_refresh() {
			var proj_id = deal_id_proj_name.getValue();
			public_module_divide_tree_deal_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					/* refreshnode.collapse();
					refreshnode.expand(); */
					public_module_divide_tree_deal.getSelectionModel().select(public_module_divide_tree_deal.getRootNode());
				}
			});
		}
		//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
		function solve_refresh() {
			var proj_id = solve_id_proj_name.getValue();
			var params = { proj_id : proj_id };
			bug_solve_grid_store.getProxy().extraParams = params;
			bug_solve_grid_store.loadPage(1);
		}
		//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
		function public_module_divide_test_type_refresh() {
			var proj_id = test_id_proj_name.getValue();
			public_module_divide_test_type_store.load({
				params:{
					proj_id : proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					/* refreshnode.collapse();
					refreshnode.expand(); */
					public_module_divide_test_type.getSelectionModel().select(public_module_divide_test_type.getRootNode());
				}
			});
			
		}
		//缺陷类型统计全部导出
		function bugType_export_excel(){
			var params = AOS.getValue("bug_type_form");
			var proj_id = deal_id_proj_name.getValue();
			var start = 0;
			var limit = 50;
			var find_begin_time = params.find_begin_time;
			if(find_begin_time === undefined){
				find_begin_time = "";
			}
			var find_end_time = params.find_end_time;
			if(find_end_time === undefined){
				find_end_time = "";
			}
			var test_version_id = params.test_version_id;
			if(test_version_id === undefined){
				test_version_id = "";
			}
			var dm_code = params.dm_code;
			if(dm_code === undefined){
				dm_code = "";
			}
			AOS.file('do.jhtml?router=projBugAnalysisService.exportTypeExcel&juid=${juid}&proj_id='+proj_id
					+'&find_begin_time='+find_begin_time
					+'&find_end_time='+find_end_time
					+'&test_version_id='+test_version_id
					+'&dm_code='+dm_code
					+'&start='+start
					+'&limit='+limit
			);
		}
		//缺陷处理人全部导出
		function bugDeal_export_excel(){
			var params = AOS.getValue("bug_deal_form");
			var proj_id = deal_id_proj_name.getValue();
			var start = 0;
			var limit = 50;
			var find_begin_time = params.find_begin_time;
			if(find_begin_time === undefined){
				find_begin_time = "";
			}
			var find_end_time = params.find_end_time;
			if(find_end_time === undefined){
				find_end_time = "";
			}
			var test_version_id = params.test_version_id;
			if(test_version_id === undefined){
				test_version_id = "";
			}
			var deal_mans = params.deal_mans;
			if(deal_mans === undefined){
				deal_mans = "";
			}
			AOS.file('do.jhtml?router=projBugAnalysisService.exportDealExcel&juid=${juid}&proj_id='+proj_id
					+'&find_begin_time='+find_begin_time
					+'&find_end_time='+find_end_time
					+'&test_version_id='+test_version_id
					+'&deal_mans='+deal_mans
					+'&start='+start
					+'&limit='+limit
			);
		}
		//缺陷解决率全部导出
		function bugSolve_export_excel(){
			var params = AOS.getValue("bug_deal_form");
			var proj_id = solve_id_proj_name.getValue();
			var start = 0;
			var limit = 50;
			var find_begin_time = params.find_begin_time;
			if(find_begin_time === undefined){
				find_begin_time = "";
			}
			var find_end_time = params.find_end_time;
			if(find_end_time === undefined){
				find_end_time = "";
			}
			var test_version_id = params.test_version_id;
			if(test_version_id === undefined){
				test_version_id = "";
			}
			AOS.file('do.jhtml?router=projBugAnalysisService.exportSolveExcel&juid=${juid}&proj_id='+proj_id
					+'&find_begin_time='+find_begin_time
					+'&find_end_time='+find_end_time
					+'&test_version_id='+test_version_id
					+'&start='+start
					+'&limit='+limit
			);
		}
		//缺陷类型统计全部导出
		function test_export_excel(){
			var params = AOS.getValue("test_query_form");
			var proj_id = test_id_proj_name.getValue();
			var start = 0;
			var limit = 50;
			var test_version_id = params.test_version_id;
			if(test_version_id === undefined){
				test_version_id = "";
			}
			var dm_code = params.dm_code;
			if(dm_code === undefined){
				dm_code = "";
			}
			AOS.file('do.jhtml?router=projBugAnalysisService.exportExampleExcel&juid=${juid}&proj_id='+proj_id
					+'&test_version_id='+test_version_id
					+'&dm_code='+dm_code
					+'&start='+start
					+'&limit='+limit
			);
		}
		
		//单元格样式
		function fn_bug_bgcolor_render(value, metaData, record) {
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #D1EEEE;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//单元格样式
		function fn_bugs_bgcolor_render(value, metaData, record) {
			//可以对单元格应用任何你想使用的样式信息
			metaData.style = 'background: #FAF0E6;height:25px;margin-top:1px;margin-right:1px;';
			return value;
		}
		
		//查询时间段改变
		function fn_change(obj) {
			var val = obj.getValue();
			var date_ = '${plan_begin_time}';
			var date1_ = '${plan_end_time}';
			var today_date_ = '${today_date}';
			var year_begin_date_ = '${year_begin_date}';
			var year_end_date_ = '${year_end_date}';
			var week_begin_date_ = '${week_begin_date}';
			var week_end_date_ = '${week_end_date}';
			if (val == "1") {
				AOS.setValue('example_query.plan_begin_time', week_begin_date_);
				AOS.setValue('example_query.plan_end_time', week_end_date_);
			} else if (val == "2") {
				AOS.setValue('example_query.plan_begin_time', date_);
				AOS.setValue('example_query.plan_end_time', date1_);
			} else if (val == "3") {
				AOS.setValue('example_query.plan_begin_time', year_begin_date_);
				AOS.setValue('example_query.plan_end_time', year_end_date_);
			} else if (val == "4") {
				AOS.setValue('example_query.plan_begin_time', today_date_);
				AOS.setValue('example_query.plan_end_time', today_date_);
			}
			var params = AOS.getValue('example_query');
			example_statistics_grid_store.getProxy().extraParams =params;
			example_statistics_grid_store.loadPage(1);	
		}
		
		//查询时间段改变
		function bug_change(obj) {
			var val = obj.getValue();
			var date_ = '${plan_begin_time}';
			var date1_ = '${plan_end_time}';
			var today_date_ = '${today_date}';
			var year_begin_date_ = '${year_begin_date}';
			var year_end_date_ = '${year_end_date}';
			var week_begin_date_ = '${week_begin_date}';
			var week_end_date_ = '${week_end_date}';
			if (val == "1") {
				AOS.setValue('bug_submit_query.plan_begin_time', week_begin_date_);
				AOS.setValue('bug_submit_query.plan_end_time', week_end_date_);
			} else if (val == "2") {
				AOS.setValue('bug_submit_query.plan_begin_time', date_);
				AOS.setValue('bug_submit_query.plan_end_time', date1_);
			} else if (val == "3") {
				AOS.setValue('bug_submit_query.plan_begin_time', year_begin_date_);
				AOS.setValue('bug_submit_query.plan_end_time', year_end_date_);
			} else if (val == "4") {
				AOS.setValue('bug_submit_query.plan_begin_time', today_date_);
				AOS.setValue('bug_submit_query.plan_end_time', today_date_);
			}
			var params = AOS.getValue('bug_submit_query');
			bug_submit_grid_store.getProxy().extraParams =params;
			bug_submit_grid_store.loadPage(1);	
		}
		
	  //个人工作量汇总表
		function example_statistics_query_onder() {
			AOS.setValue('example_query.plan_begin_time', '${plan_begin_time}');
			AOS.setValue('example_query.plan_end_time', '${plan_end_time}');
			AOS.setValue('example_query.subordinate_departments', '${principal_org}');
			var params = AOS.getValue('example_query');
			example_statistics_grid_store.getProxy().extraParams =params;
			example_statistics_grid_store.loadPage(1);	
		}
	  
		//个人工作量汇总表
		function bug_submit_query_onder() {
			AOS.setValue('bug_submit_query.plan_begin_time', '${plan_begin_time}');
			AOS.setValue('bug_submit_query.plan_end_time', '${plan_end_time}');
			AOS.setValue('bug_submit_query.subordinate_departments', '${principal_org}');
			var params = AOS.getValue('bug_submit_query');
			bug_submit_grid_store.getProxy().extraParams =params;
			bug_submit_grid_store.loadPage(1);	
		}
		
		//用例统计查询条件、查询部门
		function fn_org(){
			example_statistics_query();
		}
		
		//bug提交查询条件、查询部门
		function bug_org(){
			bug_submit();
		}
		
		//用例统计查询
		function example_statistics_query() {
			var params = AOS.getValue('example_query');
			example_statistics_grid_store.getProxy().extraParams =params;
			example_statistics_grid_store.loadPage(1);	
		}
		
		//bug提交查询
		function bug_submit() {
			var params = AOS.getValue('bug_submit_query');
			bug_submit_grid_store.getProxy().extraParams =params;
			bug_submit_grid_store.loadPage(1);	
		}
		
		function example_detail(value, metaData, record) {
			return '<input type="button" value="个人用例执行详情" metaData.style = "color:blue" class="cbtn" onclick="show_example_detail();"/>';
		}
		
		function bug_submit_detail(value, metaData, record) {
			return '<input type="button" value="所有BUG详情" metaData.style = "color:blue" class="cbtn" onclick="show_bug_detail();"/>';
		}
		
		function bug_proj_detail(value, metaData, record) {
			return '<input type="button" value="项目BUG统计" metaData.style = "color:blue" class="cbtn" onclick="show_bug_proj_detail();"/>';
		}
		
		//个人任务信息
	    function example_particulars_grid_query(){
	    	var record = AOS.select(example_statistics_grid,true)[0];
	    	var params = new Object();
	    	var params = AOS.getValue('example_query');
	    	params.tester_id = record.data.tester_id;
	    	AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.queryExampleSummary',
				ok : function(data) {
					summary = data;
			    	example_particulars_grid_store.getProxy().extraParams =params;
			    	example_particulars_grid_store.loadPage(1);	
				}
			});
	    }
		
	  //个人任务信息
	    function bug_particulars_grid_query(){
	    	var record = AOS.select(bug_submit_grid,true)[0];
	    	var params = new Object();
	    	var params = AOS.getValue('bug_submit_query');
	    	params.create_name = record.data.create_name;
	    	AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.queryBugSummary',
				ok : function(data) {
					summary = data;
					bug_particulars_grid_store.getProxy().extraParams =params;
			    	bug_particulars_grid_store.loadPage(1);	
				}
			});
	    }
	  
	  //个人任务信息
	    function bug_proj_particulars_grid_query(){
	    	var record = AOS.select(bug_submit_grid,true)[0];
	    	var params = new Object();
	    	var params = AOS.getValue('bug_submit_query');
	    	params.create_name = record.data.create_name;
	    	AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.queryBugSummary',
				ok : function(data) {
					summary = data;
					bug_proj_particulars_grid_store.getProxy().extraParams =params;
					bug_proj_particulars_grid_store.loadPage(1);	
				}
			});
	    }
		
	  //查询
	    function projCommons_name_query() {
	    	var record = AOS.select(example_statistics_grid,true)[0];
	    	var params = new Object();
	    	var params = AOS.getValue('example_query');
	    	params.tester_id = record.data.tester_id;
	    	params.proj_name = AOS.getValue('example_proj_name');
	    	params.pass_or_fail = AOS.getValue('pass_or_fail');
	    	AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.queryExampleSummary',
				ok : function(data) {
					summary = data;
			    	example_particulars_grid_store.getProxy().extraParams =params;
			    	example_particulars_grid_store.loadPage(1);	
				}
			});
	    }
	  
	  //查询
	    function bug_particulars_name_query() {
	    	var record = AOS.select(bug_submit_grid,true)[0];
	    	var params = new Object();
	    	var params = AOS.getValue('bug_submit_query');
	    	params.create_name = record.data.create_name;
	    	params.proj_name = AOS.getValue('bug_particulars_proj_name');
	    	AOS.ajax({
				wait : false, //防止出现2个遮罩层。(ajax和表格load)
				params : params,
				url : 'projBugAnalysisService.queryBugSummary',
				ok : function(data) {
					summary = data;
					bug_particulars_grid_store.getProxy().extraParams =params;
			    	bug_particulars_grid_store.loadPage(1);	
				}
			});
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
	</script>
</aos:onready>
<script type="text/javascript">
	//用例执行详情显示窗口
	function show_example_detail(){
		AOS.get("example_particulars").show();
	}
	
	//bug提交详情显示窗口
	function show_bug_detail(){
		AOS.get("bug_particulars").show();
	}
	
	//bug提交详情显示窗口
	function show_bug_proj_detail(){
		AOS.get("bug_proj_particulars").show();
	}
</script>
	