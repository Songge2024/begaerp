<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.util.Date"%>
<aos:html title="ta_week" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel tabPosition="top" id="id_tabpanel" region="center"  
			bodyBorder="0 0 0 0" margin="0 0 2 0">
			<aos:tab id="t_weekly" title="项目周报" layout="border"
				autoScroll="false">
			<%@ include file="../../pm3/public/public_proj_commons_tree.jsp"%>
			<aos:gridpanel id="g_account_week" url="weekService.page"
					onitemdblclick="action_tab_db" onrender="g__week_query"
					region="center">
					<aos:docked forceBoder="1 0 1 0">
						<aos:dockeditem xtype="tbtext" text="周报列表" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem text="新增" icon="add.png" onclick="f_week_save" />
						<aos:dockeditem text="删除" icon="del.png" onclick="g_week_del" />
						<aos:dockeditem text="提交" icon="up.png" onclick="fn_commit" />
						<aos:dockeditem text="导出" icon="icon70.png"
							onclick="fn_export_excel1" />
					</aos:docked>
					<aos:menu>
						<aos:menuitem text="新增" onclick="f_week_save" icon="add.png" />
						<aos:menuitem text="删除" onclick="g_week_del" icon="del.png" />
						<aos:menuitem xtype="menuseparator" />
						<aos:menuitem text="提交" onclick="fn_commit" icon="up.png" />
						<aos:dockeditem text="退回" icon="undp.png" onclick="fn_update" />
						<aos:menuitem text="刷新" onclick="refresh" icon="refresh.png" />
					</aos:menu>
					<aos:selmodel type="checkbox" mode="multi" />
					<aos:column type="rowno" />
					<!-- 隐藏的内容 -->
					<aos:column header="周报ID" dataIndex="week_id" hidden="true" />
					<!-- 显示内容 -->
					<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
					<aos:column header="项目ID" dataIndex="proj_id" hidden="true"
						fixedWidth="80" />
					<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="280" >
					<aos:textfield allowBlank="false" />
					</aos:column>
					<aos:column header="状态" dataIndex="flag" rendererFn="flag"
						fixedWidth="100" align="center" />
					<aos:column header="项目周" dataIndex="task_plan_num" fixedWidth="80" />
					<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="140"
						type="date" format="Y-m-d" width="100" align="center" />
					<aos:column header="结束时间" dataIndex="end_date" fixedWidth="140"
						type="date" format="Y-m-d" width="100" align="center" />
					<aos:column header="测试组长" dataIndex="test_leader" hidden="true"
						fixedWidth="100" align="center" />
					<aos:column header="创建人" dataIndex="add_name" fixedWidth="100"
						align="center" />
						<aos:column header="打回意见" dataIndex="opiniontion"  celltip="true"
						fixedWidth="260"  align="left" />
						<aos:column header="打回人" dataIndex="back_user_id"  celltip="true"
						fixedWidth="100"  align="center" />
						<aos:column header="打回时间" dataIndex="back_time"  celltip="true"
						fixedWidth="150"  align="center" />
					<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150"
						align="center" />
					<aos:column header="提交时间" dataIndex="commit_time" fixedWidth="150"
						align="center" />
					<aos:column header="任务数量" dataIndex="task_plan_num"
						fixedWidth="150" hidden="true" align="center" />
					<aos:column header="周报类型" dataIndex="type" fixedWidth="150"
						hidden="true" align="center" />
					<aos:column header="备注" dataIndex="solve" align="center"
						hidden="true" />
					<aos:column header="对外情况说明" dataIndex="description" align="center"
						hidden="true" />
					<aos:column header="下周工作计划" dataIndex="week_plan" align="center"
						hidden="true" />
			</aos:gridpanel>
			</aos:tab>
			<aos:tab id="t_weekly_detai" title="周报明细" layout="anchor">
			<aos:panel   bodyBorder="0 0 0 0"  
					anchor="100% 50%" layout="hbox" >
					<aos:layout type="hbox" align="stretch" />
					<aos:panel flex="6" >
				<aos:formpanel id="f_query_d"  
						  layout="column" >
						<aos:docked forceBoder="0 0 1 0" >
							<aos:dockeditem xtype="tbtext" text="明细概要"   scale="large" />
							<aos:dockeditem id="dis_save" xtype="button" text="草稿"
								onclick="saveDate" icon="ok.png" columnWidth="0.07"
								margin="0 0 0 10" />
							<aos:dockeditem id="dis_del" xtype="button" text="作废"
								onclick="delWeekly" icon="del.png" columnWidth="0.07"
								margin="0 0 10 10" />
							<aos:dockeditem id="dis_copy" xtype="button" text="复制"
								onclick="copy" icon="copy.png" columnWidth="0.07"
								margin="0 0 10 10" />
							<aos:dockeditem text="导出" icon="icon70.png"
								onclick="fn_export_excel1" hidden="true" margin="0 0 10 10" />
						</aos:docked>
						<aos:textfield fieldLabel="项目周" columnWidth="0.5" labelWidth="70" 
							name="task_plan_num" />
						<aos:datefield name="begin_date" fieldLabel="开始时间" 
							onchange="changeBdt" columnWidth="0.25" editable="false" />
						<aos:datefield name="end_date" fieldLabel="结束时间" onchange="changeBdt"
							columnWidth="0.25" msgTarget="qtip" allowBlank="false"
							editable="false" />
						<aos:hiddenfield fieldLabel="项目ID" name="proj_id" />
						<aos:hiddenfield fieldLabel="项目名称" name="proj_name" />
						<aos:textareafield  name="solve" fieldLabel="内部总结:" value=" "  height="240" labelWidth="70"
						 allowBlank="false"  msgTarget="qtip" columnWidth="0.5" />
						<aos:textareafield height="240" name="description" value=" " 
						allowBlank="false"	fieldLabel="对外沟通:"  msgTarget="qtip"
							columnWidth="0.5" />
						<aos:hiddenfield name="test_code" />
						<aos:dockeditem xtype="tbfill" />
					</aos:formpanel>
					</aos:panel>
				<aos:gridpanel id="work_hs" flex="2" border="true" 
						 hidePagebar="true" url="weekReportService.work_hours">
						 <aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="成员工时" />
						</aos:docked> 
						<aos:plugins>
							<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1"  onedit="fn_edit"   />
						</aos:plugins>
						<aos:column type="rowno" />
						<aos:column header="姓名" dataIndex="name">
						</aos:column>
						<aos:column header="编号" dataIndex="user_id" hidden="true" />
						<aos:column header="账号" dataIndex="account" hidden="true"/>
						<aos:column header="项目ID" dataIndex="proj_id" hidden="true" />
						<aos:column header="基地工时" dataIndex="work_hours" width="80" align="right"  > 
						<aos:numberfield  emptyText="请填数字"  step="0.5" decimalPrecision="1"
							allowBlank="true" msgTarget="qtip" minValue="0"  />
						</aos:column>
						<aos:column header="出差工时" dataIndex="business_hours" width="80"  align="right" >
							<aos:numberfield allowBlank="true" msgTarget="qtip" minValue="0"  
							step="0.5" decimalPrecision="1" emptyText="请填数字" />
						</aos:column>
						
					</aos:gridpanel>
					</aos:panel>
				
	
				<aos:tabpanel layout="vbox " anchor="100% 50%"  region="center"  tabBarHeight="22"  tabPosition="top"  >
				<aos:tab title="本周完成情况" >
					<aos:gridpanel id="g_account" url="weekReportService.pageProj"   hidePagebar="true"
						onitemdblclick="#w_account2.show();" anchor="100% 100%" >
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbtext" text="周报明细" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem id="dis_add" xtype="button" text="新增"
								onclick="w_account_show" icon="add.png" columnWidth="0.07"
								margin="0 0 10 10" />
					
					<aos:checkbox id="id_T"  boxLabel="标题" inputValue="0"  margin="5 10 0 0" />
					<aos:checkbox id="id_N"  boxLabel="内容" inputValue="1"  margin="5 5 0 0" />
							<aos:dockeditem id="dis_addall" text="生成数据" icon="add.png"
								onclick="f_account_save" />
							<aos:dockeditem id="dis_update" text="修改" icon="edit.png"
								onclick="#w_account2.show();" />
							<aos:dockeditem id="dis_delete" text="删除" icon="del.png"
								onclick="g_acount_del" />
						</aos:docked>
						<aos:menu>
							<aos:menuitem id="dis_men_add" text="新增" onclick="w_account_show"
								icon="add.png" />
							<aos:menuitem id="dis_men_delete" text="删除"
								onclick="g_acount_del" icon="del.png" />
							<aos:menuitem id="dis_men_update" text="修改"
								onclick="#w_account2.show()" icon="edit.png" />
							<aos:menuitem xtype="menuseparator" />
							<aos:menuitem text="刷新" onclick="refresh2" icon="refresh.png"
								hidden="true" />
						</aos:menu>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" />
						<!-- 隐藏的内容 -->
						<aos:column header="周报ID" dataIndex="id" hidden="true" />
						<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
						<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
						<aos:column header="排序号" dataIndex="no" hidden="true" />
						<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
							align="left" />
						<aos:column header="周报名称" dataIndex="week_name" hidden="true"
							align="left" />
						<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
							align="center" />
						<!-- 显示内容 -->
						<aos:column header="任务类型" dataIndex="week_class" rendererField="week_classs" celltip="true" width="80"
							align="center"  />
						<aos:column header="任务描述" dataIndex="remarks" celltip="true" width="500" 
							align="left" />
						<aos:column header="负责人id" dataIndex="owner_id" width="120" hidden="true"
							align="center" />
						<aos:column header="负责人" dataIndex="owner_name" width="120"  celltip="true"
							align="center" />
						<aos:column header="实际完成时间" dataIndex="finish_time" type="date" 
							format="Y-m-d" fixedWidth="100" />
						<aos:column header="完成情况" dataIndex="finish_cond" width="100"
							align="center">
							<aos:combobox name="finish_cond" allowBlank="false">
								<aos:option value="已完成" display="已完成" />
								<aos:option value="未完成" display="未完成" />
							</aos:combobox>
						</aos:column>
						<aos:column header="任务偏差分析及解决措施" dataIndex="descc" celltip="true" width="400">
						</aos:column>
						<aos:column header="内部总结" dataIndex="solve" hidden="true" 
							fixedWidth="100">
							<aos:textfield allowBlank="false" />
						</aos:column>
						<aos:column header="对外沟通" dataIndex="description" hidden="true"
							fixedWidth="100">
							<aos:textfield allowBlank="false" />
						</aos:column>
					</aos:gridpanel>
					</aos:tab>
					<aos:tab title="下周工作计划"> 
					<aos:gridpanel id="work_plan" url="weekReportService.work_plan"   hidePagebar="true"
						onitemdblclick="#plan_win_update.show();" anchor="100% 100%" >
						<aos:docked forceBoder="1 0 1 0">
							<aos:dockeditem xtype="tbseparator" />
							<aos:dockeditem id="plan_add"  xtype="button" text="新增"
								onclick="plan_win_show" icon="add.png" columnWidth="0.07"
								margin="0 0 10 10" />
							<aos:dockeditem id="plan_update" text="修改" icon="edit.png"
								onclick="#plan_win_update.show();" />
							<aos:dockeditem id="plan_delete" text="删除" icon="del.png"
								onclick="plan_del" />
						</aos:docked>
						<aos:menu>
							<aos:menuitem id="plan_men_add" text="新增" onclick="plan_win_show"
								icon="add.png" />
							<aos:menuitem id="plan_men_delete" text="删除"
								onclick="plan_del" icon="del.png" />
							<aos:menuitem id="plan_men_update" text="修改"
								onclick="#plan_win_update.show()" icon="edit.png" />
							<aos:menuitem xtype="menuseparator" />
						</aos:menu>
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column type="rowno" />
						<!-- 隐藏的内容 -->
						<aos:column header="周报ID" dataIndex="id" hidden="true" />
						<aos:column header="项目id" dataIndex="proj_id" hidden="true" />
						<aos:column header="周报编码" dataIndex="test_code" hidden="true" />
						<aos:column header="项目名称" dataIndex="proj_name" hidden="true"
							align="left" />
						<aos:column header="周报名称" dataIndex="week_name" hidden="true"
							align="left" />
						<aos:column header="项目周" dataIndex="task_plan_num" hidden="true"
							align="center" />
						<!-- 显示内容 -->
						<aos:column header="任务类型" dataIndex="week_class" rendererField="week_classs" celltip="true" width="80"
							align="center"  />
						<aos:column header="任务描述" dataIndex="remarks" celltip="true" width="500" 
							align="left" />
						<aos:column header="负责人id" dataIndex="owner_id" width="120" hidden="true"
							align="center" />
						<aos:column header="资源配置要求" dataIndex="owner_name" width="120"  celltip="true"
							align="center" />
						<aos:column header="计划开始时间" dataIndex="begin_date" 
							type="date" format="Y-m-d" width="100" />
						<aos:column header="计划结束时间" dataIndex="end_date" 
							type="date" format="Y-m-d" width="100" />
					</aos:gridpanel>
					</aos:tab>
				</aos:tabpanel>
			</aos:tab>
		</aos:tabpanel>
		
		
		<%-- 新增本周任务完成情况窗口 --%>
				<aos:window id="w_account" title="新增信息" width="800" height="490" 
					layout="anchor" autoScroll="true" draggable="true">
					<aos:formpanel id="f_account" anchor="100%" layout="anchor">
						<!--  隐藏内容 -->
						<aos:hiddenfield name="id" fieldLabel="周报ID" />
						<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
						<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
							<aos:hiddenfield fieldLabel="周报名称" name="week_name"
								value="本周工作任务" readOnly="true" columnWidth="1" margin="5" />
							<aos:hiddenfield fieldLabel="项目周" name="task_plan_num"
								columnWidth="1" margin="5" />
							<aos:combobox fieldLabel="负责人" allowBlank="false" name="owner_id" 
								multiSelect="true" columnWidth="0.5" editable="false" margin="5"
								url="weekReportService.listComboBoxProjId" />
							<aos:combobox fieldLabel="完成情况" name="finish_cond"
								allowBlank="false" columnWidth="0.5" margin="5" msgTarget="qtip">
								<aos:option value="已完成" display="已完成" />
								<aos:option value="未完成" display="未完成" />
							</aos:combobox>
							<aos:combobox fieldLabel="任务分类" name="week_class" dicField="week_classs" 
								allowBlank="false" columnWidth="0.5" margin="5"  msgTarget="qtip" onselect="fn_text">
							</aos:combobox>
							<aos:datefield name="finish_time" fieldLabel="实际完成时间" 
								columnWidth="0.5" margin="5" editable="false" />
							</aos:fieldset>
							<aos:fieldset title="任务描述"   id="id_remarks" >
							<aos:htmleditor    name="remarks" height="150" columnWidth="1" allowBlank="false"
								  	  msgTarget="title" >
							</aos:htmleditor>
								</aos:fieldset>
						<aos:fieldset title="任务偏差分析及解决措施" >
							<aos:htmleditor name="descc" columnWidth="1" allowBlank="false" height="91"
								margin="3" />
						</aos:fieldset>
					</aos:formpanel>

					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="addDate" text="保存" icon="ok.png" />
						<aos:dockeditem onclick="#w_account.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
				<%-- 修改本周任务完成窗口 --%>
				<aos:window id="w_account2" title="修改信息" width="800" height="490"
					layout="anchor" autoScroll="true" draggable="false"
					onshow="w_account2_onshow">
					<aos:formpanel id="f_account2" anchor="100%" layout="anchor">
						<!--  隐藏内容 -->
						<aos:hiddenfield name="id" fieldLabel="周报ID" />
						<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
						<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
							<aos:hiddenfield fieldLabel="周报名称" name="week_name"
								value="本周工作任务" readOnly="true" columnWidth="1" margin="5" />
							<aos:hiddenfield fieldLabel="项目周" name="task_plan_num"
								columnWidth="1" margin="5" />
							<aos:combobox fieldLabel="负责人" allowBlank="false" name="owner_id"
								multiSelect="true" columnWidth="0.5" editable="false" margin="5"
								url="weekReportService.listComboBoxProjName" />
							<aos:combobox fieldLabel="完成情况" name="finish_cond"
								allowBlank="false" columnWidth="0.5" margin="5" msgTarget="qtip">
								<aos:option value="已完成" display="已完成" />
								<aos:option value="未完成" display="未完成" />
							</aos:combobox>
								<aos:combobox fieldLabel="任务分类" name="week_class" dicField="week_classs"
								allowBlank="false" columnWidth="0.5" margin="5" msgTarget="qtip">
							</aos:combobox>
							<aos:datefield name="finish_time" fieldLabel="实际完成时间"
								columnWidth="0.5" margin="5" editable="false" />
							<aos:fieldset title="任务描述" labelWidth="85" columnWidth="1">
								<aos:htmleditor name="remarks" columnWidth="1" height="115"
									allowBlank="false" msgTarget="qtip" margin="3" />
							</aos:fieldset>
						</aos:fieldset>
						<aos:fieldset title="任务偏差分析及解决措施" labelWidth="85" columnWidth="1">
							<aos:htmleditor name="descc" columnWidth="1" allowBlank="false" height="115"
								margin="3" />
						</aos:fieldset>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem id="update_" onclick="updateDate" text="保存"
							icon="ok.png" />
						<aos:dockeditem onclick="#w_account2.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
				
				<%-- 新增下周工作计划窗口 --%>
				<aos:window id="plan_win" title="新增信息" width="800" height="490"
					layout="anchor" autoScroll="true" draggable="true">
					<aos:formpanel id="plan_win_account" anchor="100%" layout="anchor">
						<!--  隐藏内容 -->
						<aos:hiddenfield name="id" fieldLabel="周报ID" />
						<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
						<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
							<aos:hiddenfield fieldLabel="周报名称" name="week_name"
								value="下周工作计划" readOnly="true" columnWidth="1" margin="5" />
							<aos:hiddenfield fieldLabel="项目周" name="task_plan_num"
								columnWidth="1" margin="5" />
							<aos:combobox fieldLabel="负责人" allowBlank="false" name="owner_id" 
								multiSelect="true" columnWidth="0.5" editable="false" margin="5"
								url="weekReportService.listComboBoxProjId" />
							<aos:combobox fieldLabel="任务分类" name="week_class" dicField="week_classs"
								allowBlank="false" columnWidth="0.5" margin="5" msgTarget="qtip">
							</aos:combobox>
							<aos:datefield name="begin_date" fieldLabel="计划开始时间" allowBlank="false" onchange="changeBd"
								columnWidth="0.5" margin="5" editable="false" />
							<aos:datefield name="end_date" fieldLabel="计划完成时间" allowBlank="false" onchange="changeBd"
								columnWidth="0.5" margin="5" editable="false" />
						</aos:fieldset>
							<aos:fieldset title="任务描述"    >
							<aos:htmleditor name="remarks" height="280" columnWidth="1" allowBlank="false" msgTarget="title" >
							</aos:htmleditor>
							</aos:fieldset>
					</aos:formpanel>

					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="week_plan_save" text="保存" icon="ok.png" />
						<aos:dockeditem onclick="#plan_win.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
				<%-- 修改下周工作计划窗口 --%>
				<aos:window id="plan_win_update" title="修改信息" width="800" height="490"
					layout="anchor" autoScroll="true" draggable="false"
					onshow="plan_win_update_onshow">
					<aos:formpanel id="plan_win_update_account" anchor="100%" layout="anchor">
						<!--  隐藏内容 -->
							<aos:hiddenfield name="id" fieldLabel="周报ID" />
						<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
						<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
							<aos:hiddenfield fieldLabel="周报名称" name="week_name"
								value="下周工作计划" readOnly="true" columnWidth="1" margin="5" />
							<aos:hiddenfield fieldLabel="项目周" name="task_plan_num"
								columnWidth="1" margin="5" />
							<aos:combobox fieldLabel="负责人" allowBlank="false" name="owner_id" 
								multiSelect="true" columnWidth="0.5" editable="false" margin="5"
								url="weekReportService.listComboBoxProjId" />
							<aos:combobox fieldLabel="任务分类" name="week_class" dicField="week_classs"
								allowBlank="false" columnWidth="0.5" margin="5" msgTarget="qtip">
							</aos:combobox>
							<aos:datefield name="begin_date" fieldLabel="计划开始时间" allowBlank="false"
								columnWidth="0.5" margin="5" editable="false" />
							<aos:datefield name="end_date" fieldLabel="计划完成时间" allowBlank="false"
								columnWidth="0.5" margin="5" editable="false" />
						</aos:fieldset>
							<aos:fieldset title="任务描述"    >
							<aos:htmleditor name="remarks" height="280" columnWidth="1" allowBlank="false" msgTarget="title" >
							</aos:htmleditor>
							</aos:fieldset>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem id="update_week_plan" onclick="updatePlan" text="保存"
							icon="ok.png" />
						<aos:dockeditem onclick="#plan_win_update.hide();" text="关闭"
							icon="close.png" />
					</aos:docked>
				</aos:window>
				
				
	</aos:viewport>
	<script type="text/javascript">
	 function fn_text(){
		var a = AOS.getValue('f_account.week_class');
		if(a=="1"){
			 Ext.getCmp('id_remarks').setTitle("任务描述(会议，电话，短信，微信等)");
		}
		if(a=="2"){
			 Ext.getCmp('id_remarks').setTitle("任务描述(文档，会议纪要，demo等)");
		}
		if(a=="1030"){
			 Ext.getCmp('id_remarks').setTitle("任务描述(需求、设计、开发  )");
		}
		if(a=="1040"){
			 Ext.getCmp('id_remarks').setTitle("任务描述(测试,缺陷类  )");
		}
		if(a=="1090"){
			 Ext.getCmp('id_remarks').setTitle("任务描述(其他类 )");
		}
	} 

	//新增窗口本周任务完成情况
	function w_account_show(){
			AOS.reset(f_account);
			var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
			AOS.setValue('f_account.task_plan_num',task_plan_num);
			w_account.show();
			AOS.setValue('f_account.finish_time',new Date());
			
			var proj_id =AOS.getValue('f_query_d.proj_id');
			AOS.get('f_account.owner_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('f_account.owner_id').getStore().load();
	}
	
	//新增窗口下周工作计划
	function plan_win_show(){
			AOS.reset(plan_win_account);
			 var week_begin_date_ = '${x_week_begin_date}';
			  var week_end_date_ = '${x_week_end_date}';
			var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
			AOS.setValue('plan_win_account.task_plan_num',task_plan_num);
			plan_win.show();
			AOS.setValue('plan_win_account.begin_date',week_begin_date_);
			AOS.setValue('plan_win_account.end_date',week_end_date_);
			var proj_id =AOS.getValue('f_query_d.proj_id');
			AOS.get('plan_win_account.owner_id').getStore().getProxy().extraParams = {
				proj_id : proj_id
			};
			AOS.get('plan_win_account.owner_id').getStore().load();
	}
	
	//新增下周工作计划
	function week_plan_save(){
		if(plan_win_account.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		var week_name=AOS.getValue('plan_win_account.week_name');
		var owner_id=AOS.getValue('plan_win_account.owner_id');
		var remarks=AOS.getValue('plan_win_account.remarks');
		var  week_class= AOS.getValue('plan_win_account.week_class');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  proj_id= AOS.getValue('f_query_d.proj_id');
		var  proj_name= AOS.getValue('f_query_d.proj_name');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		var  begin_date= AOS.getValue('plan_win_account.begin_date');
		var  end_date= AOS.getValue('plan_win_account.end_date');
		work_plan_store.insert(0,{
			week_name :week_name,
			owner_id : owner_id,
			remarks:remarks,
			week_class:week_class,
			begin_date:begin_date,
			end_date : end_date,
			test_code:test_code,
			proj_id : proj_id,
			proj_name:proj_name,
			task_plan_num:task_plan_num
		 });
		AOS.reset(plan_win_account);
		plan_win.hide();
		week_planSave();
	}
	//新增一行
	function addDate(){
		if(f_account.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		var week_name=AOS.getValue('f_account.week_name');
		var owner_id=AOS.getValue('f_account.owner_id');
		var finish_cond=AOS.getValue('f_account.finish_cond');
		var remarks=AOS.getValue('f_account.remarks');
		var  week_class= AOS.getValue('f_account.week_class');
		var  solve= AOS.getValue('f_query_d.solve');
		var  description= AOS.getValue('f_query_d.description');
		var descc=AOS.getValue('f_account.descc');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  proj_id= AOS.getValue('f_query_d.proj_id');
		var  proj_name= AOS.getValue('f_query_d.proj_name');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		var  begin_date= AOS.getValue('f_query_d.begin_date');
		var  end_date= AOS.getValue('f_query_d.end_date');
		var  finish_time= AOS.getValue('f_account.finish_time');
		g_account_store.insert(0,{
			week_name :week_name,
			owner_id : owner_id,
			finish_cond : finish_cond,
			begin_date:begin_date,
			end_date : end_date,
			remarks:remarks,
			descc : descc,
			solve:solve,
			description:description,
			finish_time:finish_time,
			test_code:test_code,
			proj_id : proj_id,
			proj_name:proj_name,
			task_plan_num:task_plan_num,
			week_class:week_class
		 });
		AOS.reset(f_account);
		w_account.hide();
		addSave();
	}
	//新增下周工作计划保存
	function week_planSave() {
		var  test_code=  AOS.getValue('f_query_d.test_code');
		var  proj_id=  AOS.getValue('f_query_d.proj_id');
		var  proj_name=  AOS.getValue('f_query_d.proj_name');
		var  task_plan_num=  AOS.getValue('f_query_d.task_plan_num');
		AOS.ajax({
			params : {
				aos_rows : AOS.mrs(work_plan),
				test_code :test_code,
				proj_id : proj_id,
				proj_name:proj_name,
				task_plan_num:task_plan_num
			},
			url : 'weekReportService.week_plan_create',
			ok : function(data) {
				plan_win.hide();
				var params = AOS.getValue('f_query_d');
				work_plan_store.getProxy().extraParams = params;
				work_plan_store.reload();
				g_account_week_store.reload();
			}
		});
	}
	//新增保存数据
	function addSave() {
		if(f_query_d.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  solve=  AOS.getValue('f_query_d.solve');
		var  description=  AOS.getValue('f_query_d.description');
		var  test_code=  AOS.getValue('f_query_d.test_code');
		var  proj_id=  AOS.getValue('f_query_d.proj_id');
		var  proj_name=  AOS.getValue('f_query_d.proj_name');
		var  task_plan_num=  AOS.getValue('f_query_d.task_plan_num');
		AOS.ajax({
			params : {
				aos_rows : AOS.mrs(g_account),
				begin_date:begin_date,
				end_date :end_date,
				solve : solve,
				description:description,
				test_code :test_code,
				proj_id : proj_id,
				proj_name:proj_name,
				task_plan_num:task_plan_num
			},
			url : 'weekReportService.create',
			ok : function(data) {
				w_account.hide();
			     g_account_store.reload();
			     g_account_week_store.reload();
		      
			}
		});
	}
	//保存数据
	function saveDate() {
		if(f_query_d.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  solve=  AOS.getValue('f_query_d.solve');
		var  description=  AOS.getValue('f_query_d.description');
		var  test_code=  AOS.getValue('f_query_d.test_code');
		var  proj_id=  AOS.getValue('f_query_d.proj_id');
		var  proj_name=  AOS.getValue('f_query_d.proj_name');
		var  task_plan_num=  AOS.getValue('f_query_d.task_plan_num');
		var  week_plan=  AOS.getValue('f_work.week_plan');
		AOS.ajax({
			params : {
				aos_rows : AOS.mrs(g_account),
				begin_date:begin_date,
				end_date :end_date,
				solve : solve,
				description:description,
				test_code :test_code,
				proj_id : proj_id,
				proj_name:proj_name,
				task_plan_num:task_plan_num,
				week_plan:week_plan
			
			},
			url : 'weekReportService.saveData',
			ok : function(data) {
				w_account.hide();
			   //  AOS.tip('数据保存成功');
			     g_account_store.reload();
			     g_account_week_store.reload();
			 	saveHour();
			}
		});
	}
	
	//生成数据
	function f_account_save(){
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  week_name= AOS.getValue('f_account.week_name');
		var  proj_name= AOS.getValue('f_query_d.proj_name');
		var  proj_id= AOS.getValue('f_query_d.proj_id');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		var  solve= AOS.getValue('f_query_d.solve');
		var  description= AOS.getValue('f_query_d.description');
		var  week_plan=  AOS.getValue('f_work.week_plan');
		 if(AOS.get('id_T').getValue()==true&&AOS.get('id_N').getValue()==false){
			 f_account_save0();
	 	   }else if(AOS.get('id_N').getValue()==true&&AOS.get('id_T').getValue()==false){
	 		  f_account_save1();
	 	   }else{
			AOS.ajax({
				url : 'weekReportService.createData',
				params : {
					test_code :test_code,
					week_name:week_name,
					proj_id:proj_id,
					solve:solve,
					description:description,
					task_plan_num:task_plan_num,
					proj_name:proj_name,
					begin_date:begin_date,
					end_date:end_date
				},
				ok : function(data){
					Ext.each(data,function(item){
						if(item.test_code != null){
							g_account_store.insert(0,{
									week_name:item.week_name,
									begin_date:item.begin_date,
									end_date :item.end_date,
									test_code:item.test_code,
									proj_id:item.proj_id,
									solve:item.solve,
									description:item.description,
									task_plan_num:task_plan_num,
									proj_name:proj_name,
									remarks:item.remarks,
									owner_id:item.owner_id,
									owner_name:item.owner_name,
									finish_time:item.finish_time,
									finish_cond:item.finish_cond,
									week_class:item.week_class
							});
						}
					
					});
					if(data.length==0){
						AOS.tip("没有获取到本周任务，请核实！");
						return;
					}
					AOS.ajax({
						params : {
							aos_rows : AOS.mrs(g_account),
							begin_date:begin_date,
							end_date :end_date,
							solve : solve,
							description:description,
							test_code :test_code,
							proj_id : proj_id,
							proj_name:proj_name,
							task_plan_num:task_plan_num,
							week_plan:week_plan
						
						},
						url : 'weekReportService.saveData',
						ok : function(data) {
							w_account.hide();
						     AOS.tip('数据生成成功');
						     g_account_store.reload();
						     g_account_week_store.reload();
						}
					});
			   }
	   });
	 }
	}
	//生成任务标题
	function f_account_save0(){
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  week_name= AOS.getValue('f_account.week_name');
		var  proj_name= AOS.getValue('f_query_d.proj_name');
		var  proj_id= AOS.getValue('f_query_d.proj_id');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		var  solve= AOS.getValue('f_query_d.solve');
		var  description= AOS.getValue('f_query_d.description');
		var  week_plan=  AOS.getValue('f_work.week_plan');
			AOS.ajax({
				url : 'weekReportService.createData0',
				params : {
					test_code :test_code,
					week_name:week_name,
					proj_id:proj_id,
					solve:solve,
					description:description,
					task_plan_num:task_plan_num,
					proj_name:proj_name,
					begin_date:begin_date,
					end_date:end_date
				},
				ok : function(data){
					Ext.each(data,function(item){
						if(item.test_code != null){
							g_account_store.insert(0,{
									week_name:item.week_name,
									begin_date:item.begin_date,
									end_date :item.end_date,
									test_code:item.test_code,
									proj_id:item.proj_id,
									solve:item.solve,
									description:item.description,
									task_plan_num:task_plan_num,
									proj_name:proj_name,
									remarks:item.remarks,
									owner_id:item.owner_id,
									owner_name:item.owner_name,
									finish_time:item.finish_time,
									finish_cond:item.finish_cond,
									week_class:item.week_class
							});
						}
					
					});
					if(data.length==0){
						AOS.tip("没有获取到本周任务，请核实！");
						return;
					}
					AOS.ajax({
						params : {
							aos_rows : AOS.mrs(g_account),
							begin_date:begin_date,
							end_date :end_date,
							solve : solve,
							description:description,
							test_code :test_code,
							proj_id : proj_id,
							proj_name:proj_name,
							task_plan_num:task_plan_num,
							week_plan:week_plan
						
						},
						url : 'weekReportService.saveData',
						ok : function(data) {
							w_account.hide();
						     AOS.tip('数据生成成功');
						     g_account_store.reload();
						     g_account_week_store.reload();
						}
					});
			   }
	   });
	}
	//生成任务内容
	function f_account_save1(){
		var  begin_date=  AOS.getValue('f_query_d.begin_date');
		var  end_date=  AOS.getValue('f_query_d.end_date');
		var  test_code= AOS.getValue('f_query_d.test_code');
		var  week_name= AOS.getValue('f_account.week_name');
		var  proj_name= AOS.getValue('f_query_d.proj_name');
		var  proj_id= AOS.getValue('f_query_d.proj_id');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		var  solve= AOS.getValue('f_query_d.solve');
		var  description= AOS.getValue('f_query_d.description');
		var  week_plan=  AOS.getValue('f_work.week_plan');
			AOS.ajax({
				url : 'weekReportService.createData1',
				params : {
					test_code :test_code,
					week_name:week_name,
					proj_id:proj_id,
					solve:solve,
					description:description,
					task_plan_num:task_plan_num,
					proj_name:proj_name,
					begin_date:begin_date,
					end_date:end_date
				},
				ok : function(data){
					Ext.each(data,function(item){
						if(item.test_code != null){
							g_account_store.insert(0,{
									week_name:item.week_name,
									begin_date:item.begin_date,
									end_date :item.end_date,
									test_code:item.test_code,
									proj_id:item.proj_id,
									solve:item.solve,
									description:item.description,
									task_plan_num:task_plan_num,
									proj_name:proj_name,
									remarks:item.remarks,
									owner_id:item.owner_id,
									owner_name:item.owner_name,
									finish_time:item.finish_time,
									finish_cond:item.finish_cond,
									week_class:item.week_class
							});
						}
					
					});
					if(data.length==0){
						AOS.tip("没有获取到本周任务，请核实！");
						return;
					}
					AOS.ajax({
						params : {
							aos_rows : AOS.mrs(g_account),
							begin_date:begin_date,
							end_date :end_date,
							solve : solve,
							description:description,
							test_code :test_code,
							proj_id : proj_id,
							proj_name:proj_name,
							task_plan_num:task_plan_num,
							week_plan:week_plan
						
						},
						url : 'weekReportService.saveData',
						ok : function(data) {
							w_account.hide();
						     AOS.tip('数据生成成功');
						     g_account_store.reload();
						     g_account_week_store.reload();
						}
					});
			   }
	   });
	}
	
	
	function saveHour(){
		var  test_code =  AOS.getValue('f_query_d.test_code');
		var  begin_date =  AOS.getValue('f_query_d.begin_date');
		var  end_date =  AOS.getValue('f_query_d.end_date');
		  var records = work_hs.store.getModifiedRecords();
		  var select = AOS.selectone(work_hs,true);
		  if(!AOS.empty(select)){
		 	 var name=select.data.name;
			}
		    var jsonArray = [];
		    Ext.each(records, function (record) {
		    	console.log(record);
		    	if(record.data.business_hours!=null&&record.data.work_hours!=null ){
		    		 jsonArray.push(record.data);
		    	}
		    });
		AOS.ajax({
			params : {
				aos_rows :  Ext.encode(jsonArray),
				test_code:test_code,
				begin_date:begin_date,
				end_date:end_date
			},
			url : 'weekReportService.saveHour',
		ok : function(data) {
			if(data.appmsg=="录入的工期不能大于结束时间和开始时间之差,请重输!"){
				AOS.warn(name + data.appmsg);
				return;
			}else{
				AOS.tip(data.appmsg);
				id_tabpanel.setActiveTab(0);
			}
			//work_hs_store.reload();
		}
		});
			
	}
	
	
	//跳转明细tab
	function f_week_save(){
		var select = AOS.selectone(public_tree,true);
		var a = AOS.empty(select) ? "" : select.raw.a
		if(AOS.empty(select)||a=='0'){
			AOS.tip('新增前请先选择项目');
			return;
		}
		//获得项目编码
		var proj_id = AOS.empty(select) ? "" : select.raw.id;
		AOS.reset(f_query_d);
		AOS.enableCmps('dis_add'); 
		AOS.enableCmps('dis_addall'); 
	    AOS.enableCmps('dis_update'); 
		AOS.enableCmps('dis_delete'); 
		AOS.enableCmps('dis_save'); 
	    AOS.enableCmps('dis_del'); 
		AOS.enableCmps('dis_copy'); 
		AOS.enableCmps('plan_add');
		AOS.enableCmps('plan_update');
		AOS.enableCmps('plan_delete');
		AOS.ajax({
				 params:{
					 proj_id : proj_id
				 },
			url : 'weekReportService.actionTab',
			ok : function(data) {
				 AOS.setValue('f_query_d.end_date',data.week_end_date);
				 AOS.setValue('f_query_d.begin_date',data.week_begin_date);
				 console.log(data.getendDate);
				AOS.setValue('f_query_d.test_code',data.test_code);
				AOS.setValue('f_query_d.task_plan_num',data.task_plan_num);
				AOS.setValue('f_query_d.proj_id',AOS.empty(select) ? "" : select.raw.id);
				AOS.setValue('f_query_d.proj_name',AOS.empty(select) ? "" : select.raw.text);
				var params = AOS.getValue('f_query_d');
				g_account_store.getProxy().extraParams = params;
				//跳转
				id_tabpanel.setActiveTab(1);
				g_account_store.reload(1);
				work_hs_store.getProxy().extraParams = params;
				work_hs_store.reload(1);
				work_plan_store.getProxy().extraParams = params;
				work_plan_store.reload(1);
			}
		});
	}
	
	//列表双击跳转
	function  action_tab_db(me, record){
		   var test_code =record.data.test_code;
		   var solve  =  record.data.solve;
		   var description  =  record.data.description;
		   var end_date  =  record.data.end_date;
		   var flag  =  record.data.flag;
		   var proj_id  =  record.data.proj_id;
		   var task_plan_num  =  record.data.task_plan_num;
		   var proj_name  =  record.data.proj_name;
		   var week_plan  =  record.data.week_plan;
		  AOS.ajax({
				params:{
					test_code:test_code,
					solve:solve,
					description:description,
					end_date:end_date,
					flag:flag,
					proj_id:proj_id,
					task_plan_num:task_plan_num,
					proj_name:proj_name,
					week_plan:week_plan
				},
				url : 'weekReportService.actionTabDb',
				ok : function(data) {
					AOS.reset(f_query_d);
					AOS.setValue('f_query_d.test_code',data.test_code);
					AOS.setValue('f_query_d.solve',data.solve);
					AOS.setValue('f_query_d.description',data.description);
					AOS.setValue('f_query_d.proj_id',data.proj_id);
					AOS.setValue('f_query_d.task_plan_num',data.task_plan_num);
					AOS.setValue('f_query_d.proj_name',data.proj_name);
					AOS.setValue('f_work.week_plan',data.week_plan);
					//如果主表对应的数据提交，禁用明细的相关操作
					if(data.flag==1){
					    AOS.disableCmps('dis_add');
						AOS.disableCmps('dis_addall');
						AOS.disableCmps('dis_update');
						AOS.disableCmps('dis_delete');
						AOS.disableCmps('dis_save');
						AOS.disableCmps('dis_del');
						AOS.disableCmps('dis_men_add');
						AOS.disableCmps('dis_men_update');
						AOS.disableCmps('dis_men_delete');
						AOS.disableCmps('update_');
						AOS.disableCmps('dis_copy');
						AOS.disableCmps('plan_add');
						AOS.disableCmps('plan_update');
						AOS.disableCmps('plan_delete');
						AOS.disableCmps('plan_men_add');
						AOS.disableCmps('plan_men_update');
						AOS.disableCmps('plan_men_delete');
						AOS.disableCmps('update_week_plan');
					 }else
					{      
						 AOS.enableCmps('dis_add'); 
						 AOS.enableCmps('dis_addall'); 
						 AOS.enableCmps('dis_update'); 
						 AOS.enableCmps('dis_delete'); 
						 AOS.enableCmps('dis_save'); 
						 AOS.enableCmps('dis_del'); 
						 AOS.enableCmps('dis_men_add');
						 AOS.enableCmps('dis_men_update');
						 AOS.enableCmps('dis_men_delete');
						 AOS.enableCmps('update_');
						 AOS.enableCmps('dis_copy');
						 AOS.enableCmps('plan_add');
						 AOS.enableCmps('plan_update');
						 AOS.enableCmps('plan_delete');
						 AOS.enableCmps('plan_men_add');
						 AOS.enableCmps('plan_men_update');
						 AOS.enableCmps('plan_men_delete');
						 AOS.enableCmps('update_week_plan');
					}
					var params = AOS.getValue('f_query_d');
					g_account_store.getProxy().extraParams = params;
					g_account_store.reload(1);
					id_tabpanel.setActiveTab(1);
					AOS.setValue('f_query_d.end_date',record.data.end_date);
					AOS.setValue('f_query_d.begin_date',record.data.begin_date);
					work_hs_store.getProxy().extraParams = params;
					work_hs_store.reload(1);
					work_plan_store.getProxy().extraParams = params;
					work_plan_store.reload(1);
				}
	   });
	}
	
	//监听行编辑事件newValues
	function fn_edit(editor, e) {
		var record = AOS.selectone(work_hs, true);
		var  begin_date =  AOS.getValue('f_query_d.begin_date');
		var  end_date =  AOS.getValue('f_query_d.end_date');
		var work_hours=record.data.work_hours;
		var name=record.data.name;
		var business_hours=record.data.business_hours;
		AOS.ajax({	
			url : 'weekReportService.getDate',
			params : {
				begin_date:begin_date,
				end_date :end_date
			},
			ok : function(data) {
				if(AOS.empty(work_hours)){
					work_hours=0;
				}
				if(AOS.empty(business_hours)){
					business_hours=0;
	      	  }

		  if(work_hours+business_hours>data.appmsg){
		  AOS.warn(name+" 基地工时，出差工时之和不能超过7天!");
		  return;
		}
	 }
	})
}
	
	
	//触发编辑前事件
	function fn_beforeedit(obj, e) {
		var editing = work_hs.getPlugin('id_plugin');
		var rowEditor = editing.getEditor();
		//这行是修复行编辑的一个bug，当数据校验时候如果初始时数据不合法，则数据纠正后保存按钮也不能用的bug。
		rowEditor.on('fieldvaliditychange', rowEditor.onFieldChange,
				rowEditor);
	}
	
	
	//监听修改窗口弹出owner_id
	function w_account2_onshow(){
		//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
		var selection = AOS.select(g_account, true);
    	if(AOS.empty(selection)||selection.length>1){
			w_account2.hide();
    		AOS.tip('请选择一条需要修改的数据!');
    		return;
		}
    	var proj_id =AOS.getValue('f_query_d.proj_id');
		AOS.get('f_account2.owner_id').getStore().getProxy().extraParams = {
			proj_id : proj_id
		};
    	var record = AOS.selectone(g_account, true);
    	var records=record.data.id;
    	var owner_id=record.data.owner_id;
    	var str=owner_id.replace("[","");
		var str_=str.replace("]","");
		var owner_id_=str_.split(",");
		f_account2.loadRecord(record);
		var number_=[];
		Ext.each(owner_id_,function(item){
			number_.push(Number(item)) ;
		});
		
		if(AOS.empty(records)){
			w_account2.hide();
			AOS.tip('请先保存 才能修改!');
		}else{
			f_account2.loadRecord(record);
		}
		AOS.setValue('f_account2.owner_id',number_);
	}
	
	//修改保存
	function updateDate(){
		var  begin_date= AOS.getValue('f_query_d.begin_date');
		var  end_date= AOS.getValue('f_query_d.end_date');
		var  solve= AOS.getValue('f_query_d.solve');
		var  description= AOS.getValue('f_query_d.description');
		var  task_plan_num= AOS.getValue('f_query_d.task_plan_num');
		if(f_account2.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		 AOS.ajax({
			forms : f_account2,
			url : 'weekReportService.update',
			params : {
				begin_date:begin_date,
				end_date :end_date,
				solve:solve,
				task_plan_num:task_plan_num,
				description:description
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				g_account_store.reload();
				g_account_week_store.reload();
				w_account2.hide();
			}
	}); 
	}
	
	
	//监听修改下周工作计划窗口弹出
	function plan_win_update_onshow(){
		//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
		var selection = AOS.select(work_plan, true);
    	if(AOS.empty(selection)||selection.length>1){
    		plan_win_update.hide();
    		AOS.tip('请选择一条需要修改的数据!');
    		return;
		}
    	var proj_id =AOS.getValue('f_query_d.proj_id');
		AOS.get('plan_win_update_account.owner_id').getStore().getProxy().extraParams = {
			proj_id : proj_id
		};
    	var record = AOS.selectone(work_plan, true);
    	var records=record.data.id;
    	var owner_id=record.data.owner_id;
    	var str=owner_id.replace("[","");
		var str_=str.replace("]","");
		var owner_id_=str_.split(",");
		plan_win_update_account.loadRecord(record);
		var number_=[];
		Ext.each(owner_id_,function(item){
			number_.push(Number(item)) ;
		});
		plan_win_update_account.loadRecord(record);
		AOS.setValue('plan_win_update_account.owner_id',number_);
	}
	
	//下周计划保存
	function updatePlan(){
		if(plan_win_update_account.isValid()==false){
			AOS.tip('请填必写项!');
			return;
		};
		 AOS.ajax({
			forms : plan_win_update_account,
			url : 'weekReportService.update_plan',
			ok : function(data) {
				AOS.tip(data.appmsg);
				work_plan_store.reload();
				plan_win_update.hide();
			}
	}); 
	}
	
	//监听开始时间不能大于结束时间
	  function changeBdt(){
		  var begin_date=AOS.getValue('f_query_d.begin_date');
		  var end_date=AOS.getValue('f_query_d.end_date');
		  if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
		  AOS.setValue('f_query_d.end_date',null);
  		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
  		  return;
		 }
	}
	//监听开始时间不能大于结束时间
	  function changeBd(){
		  var begin_date=AOS.getValue('plan_win_account.begin_date');
		  var end_date=AOS.getValue('plan_win_account.end_date');
		  if(end_date<begin_date &&!AOS.empty(begin_date) &&!AOS.empty(end_date)){
		  AOS.setValue('plan_win_account.end_date',null);
  		  AOS.tip("结束时间不能小于开始时间,请重新选择!");
  		  return;
		 }
	}
	//工时校正
	  function fn_hours(value, metaData, record ){
		  var work_hours=AOS.getValue('work_hs.work_hours');
		  var business_hours=AOS.getValue('work_hs.business_hours');
		  if(work_hours+business_hours>=7){
  		  AOS.tip("周报工时不能超过7天!");
  		  return;
		 }
	}
	
	
	//监听获取开始时间
    function   changeDt(){
		var end_date=AOS.getValue('f_query_d.end_date');
    	AOS.ajax({
			params:{
				end_date : end_date
			},
			url : 'weekReportService.changeDate',
			ok : function(data) {
				// AOS.setValue('f_query_d.begin_date',data.getDate);
				// AOS.setValue('f_query_d.end_date',data.getend_date);
			}
         });
    } 
 
    //删除明细信息
 	function g_acount_del(){
			var selection = AOS.selection(g_account, 'id');
			var test_code = AOS.selection(g_account, 'test_code');
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var record = AOS.selectone(g_account, true);
	    	var records=record.data.id;
			if(AOS.empty(records)){
				AOS.tip('请先保存 才能删除!');
			}else{
			var rows = AOS.rows(g_account);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'weekReportService.delete',
					params:{
						aos_rows: selection,
						test_code:test_code
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_store.reload();
						g_account_week_store.reload();
					}
				});
			});
		}
    }
    //删除明细信息
 	function plan_del(){
 		var selection = AOS.selection(work_plan, 'id');
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var record = AOS.selectone(work_plan, true);
	    	var records=record.data.id;
			var rows = AOS.rows(work_plan);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'weekReportService.delete',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						work_plan_store.reload();
					}
				});
			});
	
    }
    //删除周报
 	function g_week_del(){
			
			var selection = AOS.selection(g_account_week, 'week_id');
			var test_code = AOS.selection(g_account_week, 'test_code');
			var record = AOS.select(g_account_week);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			for(var i=0;i<record.length;i++){
				if(record[i].data.flag=="1"){
					AOS.tip('选中的周报已提交无法删除！');
					return;
				}
			}
			var rows = AOS.rows(g_account_week);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'weekService.delete',
					params:{
						aos_rows: selection,
						test_code:test_code
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_account_week_store.reload();
					}
				});
			});
		}
    
 	//作废
	function delWeekly(){
		var test_code=AOS.getValue('f_query_d.test_code');
		var msg =  AOS.merge('确认要作废吗？');
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
		AOS.ajax({
			params:{
				test_code:test_code
				},
				url:'weekReportService.delWeekly',
				ok: function(data){
					g_account_store.reload();
					g_account_week_store.reload();
					work_hs_store.reload();
					AOS.reset(f_query_d);
					AOS.tip(data.appmsg);
				}
			
		});
		});
	}
 	
	function copy(){
		var solve=AOS.getValue('f_query_d.solve');
		
		AOS.setValue('f_query_d.description',AOS.getValue('f_query_d.solve'));
		
	}
 	
 	
    //导出
	function fn_export_excel(){
		var selection = AOS.selection(g_account_week,'test_code');
		if(selection.length == 0){
			AOS.tip("选择需要导出的数据。");
			return;
		}
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		AOS.file('do.jhtml?router=weekReportService.exportExcel&juid=${juid}&selection='+selection);
	}
    
	 //导出
	function fn_export_excel1(){
		var week_id = AOS.selection(g_account_week,'week_id');
		var test_code = AOS.selection(g_account_week,'test_code');
		if(test_code.length == 0){
			AOS.tip("选择需要导出的数据。");
			return;
		}
		var record = AOS.select(g_account_week);
		if(record.length==1 ){
			AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&test_code='+test_code+'&week_id='+week_id);
			return;
		}
		for(var i=1;i<record.length;i++){
			if(record[i].data.test_code != record[0].data.test_code ){
				AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&test_code='+test_code+'&week_id='+week_id);
				return;
			}
		}
		
		//juid需要再这个页面的初始化方法中赋值,这里才引用得到
		AOS.file('do.jhtml?router=weekReportService.exportExcel1&juid=${juid}&selection='+selection);
	}
    
	//提交状态
	function fn_commit(){
		var selection = AOS.selection(g_account_week, 'week_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择一条需要提交的数据。');
			return;
		}
		var record = AOS.selectone(AOS.get('g_account_week'));
		var task_plan_num = record.data.task_plan_num
		var proj_id = record.data.proj_id
		var proj_name = record.data.proj_name
		var createTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		var sedTime = Ext.Date.format(new Date(),'Y-m-d H:i:s');
		if (record.data.flag==1){
			AOS.warn('请勿重复提交！')
		}else{
			var record = AOS.selectone(AOS.get('g_account_week'));
			var msg =  AOS.merge('确认将周报提交？');
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
		AOS.ajax({
			url : 'weekReportService.state_commit',
			params:{
				week_id: record.data.week_id,
				test_code:record.data.test_code
			},
			ok : function(data) {
				AOS.tip("数据提交成功。");
				AOS.get('g_account_week').getStore().reload();
				var  token=data.appmsg;
				var count="{\"proj_id\":\""+proj_id+"\","+"\"proj_name\":\""+proj_name+"\","+"\"type\":\""+1001+"\","+"\"content\":\""+"${user_name}提交"
					+task_plan_num+"项目周报\","+"\"createTime\":\""+createTime+"\"}";
				var title="项目周报"; 
				mesVO={
						"title"  : title, 
						 "content": count,
						 "extras": {proj_id,proj_name,createTime,sedTime},
						 "mesGroup": "CUSTOM",
						 "toUserAccounts": [
							    "yirongkun"
							  ]
					 }
				AOS.weekSend(token,mesVO);
			}
		  });
		
	   });
	}}
	function flag(value, metaData, record) {
		if (value == '1') {
			return "<span style='color:green; font-weight:bold'>已提交</span>";
		}
		if (value == '2') {
			return "<span style='color:red; font-weight:bold'>打回</span>";
		}
		else{
			return "<span style='color:red; font-weight:bold'>草稿</span>";
		}
		return value;
	}
	function week_cl(value, metaData, record) {
		if (value == '1010') {
			return "<span  font-weight:bold'>需求</span>";
		}
		if (value == '1020') {
			return "<span  font-weight:bold'>设计</span>";
		}
	}
	function work_plan_type(value, metaData, record) {
		if (value == '1') {
			return "<span  font-weight:bold'>交流沟通</span>";
		}
		if (value == '2') {
			return "<span  font-weight:bold'>成果输出</span>";
		}
		if (value == '3') {
			return "<span  font-weight:bold'>需求响应</span>";
		}
		if (value == '4') {
			return "<span  font-weight:bold'>测试与缺陷</span>";
		}
		if (value == '5') {
			return "<span  font-weight:bold'>其他</span>";
		}
	}
	
	
	
	//刷新
	function refresh() {
		g_account_week_store.loadPage(1);
	
	}
	function refresh2() {
		g_account_store.loadPage(1);
	}
	
	function refresh3() {
		  work_hs_store.loadPage(1);
	}
	
	//加载表格数据
	function g__week_query() {
		//var params = AOS.getValue('f_query_week.add_name');
		//AOS.setValue('query_week_hz.add_name',add_name);
		//var params = AOS.getValue('query_week_hz');
		g_account_week_store.getProxy().extraParams ={add_name:'${name}'} ;
		g_account_week_store.loadPage(1);
	}
	
	
	//项目树点击方法
	function on_public_tree(view, record, node, item, e){
			//AOS.tip("节点ID：" + record.raw.id + "; 节点名称：" + record.raw.text);
			var record = AOS.selectone(public_tree);
			var params = new Object();
			var a = AOS.empty(record) ? "" : record.raw.a
					if(a=='0'){
						//AOS.tip('请先选择项目');
						return;
					}
			params.proj_id=record.data.id;
			params.add_name = {add_name:'${name}'};
			g_account_week_store.getProxy().extraParams = params;
			g_account_week_store.loadPage(1);
			<%--  var proj_id=record.raw.id;
			 g_account_week_store.reload({
					params:{
						proj_id : proj_id
						}});
					--%>
	}
	
	
	
	</script>
</aos:onready>
