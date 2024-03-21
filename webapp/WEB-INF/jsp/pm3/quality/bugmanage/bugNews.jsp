<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("userinfo", userModel);
	String userid = userModel.getId().toString();
%>

<aos:html title="回复内容信息" base="http" lib="ext,ueditor">
	<aos:body>
		<div id="news_desc_div">
			<script type="text/plain" id="news_desc_editor"
				style="text-align: left; margin-top: 5px; margin-right: 5px; width: 99%; min-height: 250px;"></script>
		</div>
		<div id="task_desc_news_div">
			<script type="text/plain" id="task_desc_news_editor"
				style="text-align: left; margin-top: 5px; margin-right: 5px; width: 99%; min-height: 400px;"></script>
		</div>
	</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="anchor">
		<aos:panel id="p_main" anchor="100% 100% " layout="hbox"
			autoScroll="true" border="true">
			<aos:formpanel id="news_form" flex="1" layout="column" height="950" labelWidth="70" msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:hiddenfield name="bug_id" fieldLabel="缺陷id" value="${bug.bug_id}" />
					<aos:textfield name="bug_code" fieldLabel="缺陷编码" allowBlank="true"
						value="${bug.bug_code}" readOnly="true" emptyText="保存后自动生成" columnWidth="0.25" />
					<%-- <aos:textfield name="proj_id" fieldLabel="项目" allowBlank="true"
						value="${bug.proj_id}" readOnly="true" columnWidth="0.25" /> --%>
					<aos:textfield name="proj_name" fieldLabel="项目" allowBlank="true" 
						value="${bug.proj_name}" readOnly="true" columnWidth="0.25" />
					<aos:textfield name="dm_name" fieldLabel="关联模块" allowBlank="true"
						value="${bug.dm_name}" readOnly="true" columnWidth="0.25" />
					<aos:textfield name="demand_name" fieldLabel="关联需求"
						allowBlank="true" value="${bug.demand_name}" readOnly="true" columnWidth="0.25" />
					<%-- <aos:textfield name="stand_id" fieldLabel="关联模块" allowBlank="true"
						value="${bug.stand_id}" readOnly="true" columnWidth="0.25" /> --%>
					<aos:textfield name="bug_name" fieldLabel="缺陷名称" allowBlank="true"
						value="${bug.bug_name}" readOnly="true" columnWidth="0.25" />
					<aos:hiddenfield name="standard_id" value="${bug.standard_id}" />
					<aos:triggerfield fieldLabel="测试用例" name="standard_name"
						value="${bug.standard_name}" editable="false" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="standard_grid_show" columnWidth="0.25" />

					<%--  <aos:textfield name="standard_id" fieldLabel="测试用例"
						allowBlank="true" value="${bug.standard_name}" readOnly="true"
						columnWidth="0.25" />--%>

					<aos:combobox fieldLabel="缺陷状态" name="state" id="old_state"
						value="${bug.state}" dicField="bug_states" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="严重程度" name="severity"
						value="${bug.severity}" dicField="bug_severity" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="优先级" name="priority"
						value="${bug.priority}" dicField="bug_priority" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷位置" name="bug_addr"
						value="${bug.bug_addr}" dicField="bug_addr" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="出现频率" name="rate" value="${bug.rate}" 
						dicField="bug_rate" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="来源类型" name="source" value="${bug.source}" 
						dicField="bug_source" columnWidth="0.25" readOnly="true">
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷类型" name="bug_type"
						value="${bug.bug_type}" dicField="bug_type" columnWidth="0.25"
						readOnly="true">
					</aos:combobox>
					<aos:textfield name="find_name" fieldLabel="发现人"
						value="${bug.find_name}" readOnly="true" allowBlank="true"
						columnWidth="0.25" />
					<aos:datetimefield name="find_time" fieldLabel="发现时间"
						value="${bug.find_newtime}" format="Y-m-d H:i:s" readOnly="true"
						allowBlank="true" columnWidth="0.25" />
					<aos:combobox name="create_name" fieldLabel="新增人" allowBlank="true"
						columnWidth="0.25" readOnly="true"
						url="projCommonsService.listComboBoxProjId&proj_id=${bug.proj_id}" />
					<%-- <aos:textfield name="create_name" fieldLabel="新增人"
						value="${bug.create_name}" readOnly="true" allowBlank="true"
						columnWidth="0.25" /> --%>
					<aos:datetimefield name="create_time" fieldLabel="新增时间"
						value="${bug.create_newtime}" readOnly="true" format="Y-m-d H:i:s"
						allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="close_name" fieldLabel="关闭人" allowBlank="true"
						readOnly="true" value="${bug.close_name}" columnWidth="0.25" />
					<aos:datetimefield name="close_time" fieldLabel="关闭时间"
						value="${bug.close_newtime}" format="Y-m-d H:i:s"
						allowBlank="true" readOnly="true" columnWidth="0.25" />
					<aos:combobox name="deal_man" id="now_man" fieldLabel="当前处理人"
						allowBlank="true" columnWidth="0.25" readOnly="true"
						url="projCommonsService.listComboBoxProjId&proj_id=${bug.proj_id}" />
				</aos:fieldset>
				<!-- 相关产品缺陷编码 -->
				<aos:fieldset title="相关产品缺陷编码" columnWidth="1" margin="5 0 5 0" labelWidth="100" >
<%-- 					<aos:textareafield name="relate_bug_code" fieldLabel="关联编码" value="${bug.relate_bug_code}" --%>
<%-- 						columnWidth="1"  height="50" readOnly="true" padding="5 5 5 5"/> --%>
					<aos:gridpanel id="bug_copy_grid"  url="bugManageService.bugCopyPage" onrender="bugCopy_query"
							width="1100" height="200" autoScroll="true" hidePagebar="true" border="true" 
							anchor="100%" region="center" layout="fit" forceFit="false" padding="5 10 5 10" columnWidth="1"> 
						<aos:docked forceBoder="1 0 1 0"> 
							<aos:dockeditem xtype="tbtext" text="关联编码" /> 
						</aos:docked> 
						<aos:column type="rowno" /> 
 						<aos:column header="被关联项目ID" dataIndex="from_proj_id" width="100" hidden="true"/> 
 						<aos:column header="被关联缺陷ID" dataIndex="from_bug_id" width="100" hidden="true"/> 
 						<aos:column header="被关联项目名称" dataIndex="from_proj_name" width="220" celltip="true" align="center"/> 
						<aos:column header="被关联缺陷编码" dataIndex="from_bug_code" width="200" rendererFn="from_bug_render" align="center"/> 
						<aos:column header="被关联状态" dataIndex="from_state" width="150" rendererFn="fn_bug_state" align="center"/>
						<aos:column header="被关联缺陷名称" dataIndex="from_bug_name" width="350" celltip="true"/>
						<aos:column header="关联项目ID" dataIndex="to_proj_id" width="100" hidden="true"/>
						<aos:column header="关联缺陷ID" dataIndex="to_bug_id" width="100" hidden="true"/>
						<aos:column header="关联项目名称" dataIndex="to_proj_name" width="220" celltip="true" align="center"/>
						<aos:column header="关联缺陷编码" dataIndex="to_bug_code" width="200" rendererFn="to_bug_render" align="center"/>
						<aos:column header="关联状态" dataIndex="to_state" width="150" rendererFn="fn_bug_state" align="center"/>
						<aos:column header="关联缺陷名称" dataIndex="to_bug_name" width="350" celltip="true"/>
					</aos:gridpanel>
				</aos:fieldset>
<%-- 				<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="缺陷详情" margin="5 0 5 0"> --%>
<%-- 					<aos:htmleditor margin="5" name="bug_detail" height="400" --%>
<%-- 						value="${bug.bug_detail}" readOnly="true" columnWidth="1" /> --%>
<%-- 				</aos:fieldset> --%>
				
				<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="缺陷详情" margin="5 0 5 0" height="500">
					<aos:panel columnWidth="1" margin="5" padding="5" contentEl="task_desc_news_div" height="500" />
				</aos:fieldset>
				<!-- 处理信息 -->
				<aos:fieldset title="处理信息" columnWidth="1" border="true"  margin="5 0 5 0">
					<aos:combobox fieldLabel="缺陷当前状态" name="info_old_state" id="info_old_state" labelWidth="80"
								  value="${bug.state}"  readOnly="true"
								  dicField="bug_states"  allowBlank="true"
								  columnWidth="0.1" margin="5  5 10 0">
					</aos:combobox>
					<aos:combobox fieldLabel="指派处理人" labelWidth="80"
						name="next_deal_man" id="next_deal_man" editable="true"
						allowBlank="false" columnWidth="0.15" margin="5  10 10 5"
						queryMode="local" typeAhead="true" forceSelection="true" selectOnFocus="true"
						url="projCommonsService.listComboBoxProjId&proj_id=${bug.proj_id}" />
					<aos:combobox fieldLabel="指派状态" name="next_state" id="new_state" labelWidth="80"
						dicField="bug_states" value="1001" allowBlank="true" 
						columnWidth="0.1" margin="5  5 10 0">
					</aos:combobox>
					<aos:numberfield margin="5 0 0 0" columnWidth="0.15" name="plan_wastage" id="id_bug_plan_wastage" labelWidth="200" 
						minValue="0.00" fieldLabel="计划消耗天数(负责人填写)" step="0.05" value="${bug.plan_wastage}" onchange="changePlanWastage"/>
 					<aos:hiddenfield id="id_bug_real_wastage" name="real_wastage"
 						fieldLabel="实际消耗天数" value="${bug.real_wastage}"/>					
					<aos:dockeditem text="提交" columnWidth="0.07" margin="5  5 10 5"
						onclick="b_save" />
					<aos:dockeditem text="返回 " columnWidth="0.07" margin="5  5 10 5"
						onclick="b_return" />
					<aos:panel columnWidth="0.9" margin="5" padding="5"
						contentEl="news_desc_div" height="320" />
					<aos:htmleditor id="userinfo" name="news_detail" columnWidth="1"
						hidden="true" height="300" margin="10" allowBlank="false" />
				</aos:fieldset>
				<!-- 历史回复信息 -->
				<aos:fieldset title="历史回复信息" layout="anchor" collapsed="false">
					<c:forEach var="user" items="${userTx}">
						<aos:panel id="id_ta_${user.log_id}" constrain="false" autoShow="true" minHeight="200" 
							html="${user.news_detail}" autoScroll="true"
							title=" 处理人 :  <b>${user.create_name}</b> , 处理时间  :  <b>${user.create_time}</b>"
							margin="10 50 10 10" collapsible="true" collapsed="false">
						</aos:panel>
					</c:forEach>
				</aos:fieldset>
			</aos:formpanel>
		</aos:panel>
	</aos:viewport>

	<aos:window id="bug_news_standard_win" title="查看测试用例" height="200"
		width="900" onshow="g_account_query">
		<aos:gridpanel id="bugnews_standard_grid"
			url="testExampleService.listbugnewdemandgrid" hidePagebar="true"
			onrender="g_account_query" forceFit="false">
			<aos:column type="rowno" header="执行" align="center" width="35" />
			<aos:column header="用例编码" dataIndex="standard_code" width="100" align="center" />
			<aos:column header="用例名称" dataIndex="standard_name" width="150" align="left" />
			<aos:column header="模块名称" dataIndex="dm_name" width="120" align="left" />
			<aos:column header="执行序号" dataIndex="execute_code" width="80" align="center" />
			<aos:column header="执行步骤" dataIndex="standard_detail" width="150" />
			<aos:column header="期望结果" dataIndex="expected_results" width="150" />
			<aos:column header="实际结果" dataIndex="actual_results" width="150" />
			<aos:column header="状态" dataIndex="pass_or_fail" width="100" align="center" rendererField="pass_or_fail" />
			<aos:column header="通过时间" dataIndex="pass_time" width="150" align="center" rendererFn="fn_pass_time" />
			<aos:column header="执行次数" dataIndex="execute_number" width="100" align="center" />
			<aos:column header="关联需求" dataIndex="demand_site" width="150" align="left" />
			<aos:column header="测试数据sql" dataIndex="data_sql" width="150" align="left" />
			<aos:column header="测试环境" dataIndex="test_environment" width="150" align="left" />
			<aos:column header="前置条件" dataIndex="precondition" width="150" />
			<aos:column header="版本号" dataIndex="version" width="150" />
			<aos:column header="执行人" dataIndex="tester_name" width="100" align="center" />
			<aos:column header="执行时间" dataIndex="test_time" width="150" align="center" />
		</aos:gridpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="#bug_news_standard_win.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>

	<script type="text/javascript">
		news_desc_editor=UM.getEditor('news_desc_editor',{
			autoHeightEnabled:false,
			autoFloatEnabled:true
		});
		news_desc_editor.setContent("");
		task_desc_news_editor=UM.getEditor('task_desc_news_editor',{
			autoHeightEnabled:false,
			autoFloatEnabled:true
		});
		task_desc_news_editor.setContent('${bug.bug_detail}');
		// 设置默认值
// 		var task_desc_news_editor ='${bug.bug_detail}';
// 		console.log(task_desc_news_editor);
// 		task_desc_news_editor.setContent("");
		AOS.setValue("news_form.deal_man",${bug.deal_man});
		AOS.setValue("news_form.next_deal_man",${bug.deal_man});
		AOS.setValue("news_form.create_name",${bug.create_name});
		var manager_user_count = ${manager_user_count};
		if(manager_user_count > 0){
			id_bug_plan_wastage.setReadOnly(false); //支持修改工作量
		}else{
			id_bug_plan_wastage.setReadOnly(true); //普通员工不支持修改工作量
		}
		
		//答复回复人获取焦点
		function f_mesg_show() {
			var cmp = AOS.get('news_form');
			cmp.focus();
		}
		//弹出测试用例选择表格
		function standard_grid_show(){
			bug_news_standard_win.show();
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
		//加载表格数据
		function g_account_query() {
			var params = {
					proj_id : ${bug.proj_id},
					standard_id : ${bug.standard_id}
				};
			//这个Store的命名规则为：表格ID+"store"。
			bugnews_standard_grid_store.getProxy().extraParams = params;
			bugnews_standard_grid_store.load();
		}

		//保存提交信息
		function b_save() {
			//判断状态有无变化
			var state = old_state.getRawValue();
			var next_state = new_state.getRawValue();
			//处理人有无变化
			var deal_man = now_man.getRawValue();
			var next_man =next_deal_man.getRawValue();
			 
			if(news_desc_editor.getContent().length < 10){
				AOS.tip("处理信息不能为空，且不能少3个字。");
				return;
			}
			var trans_news_detail ;
			if ((state != next_state)&&(deal_man != next_man)){
				trans_news_detail = news_desc_editor.getContent().replace(/'/g,"&#39;")+"</br></br>"+"·缺陷状态由"+"【"+state+"】"+"变为"+"【"+next_state+"】"+"</br>"+"·处置人由"+"【"+deal_man+"】"+"变为"+"【"+next_man+"】";//AOS.setValue("news_form.news_detail",UM.utils.unhtml(news_desc_editor.getContent())+"</br></br>"+"·缺陷状态由"+"【"+state+"】"+"变为"+"【"+next_state+"】"+"</br>"+"·处置人由"+"【"+deal_man+"】"+"变为"+"【"+next_man+"】");
			}else if (deal_man != next_man){
				trans_news_detail = news_desc_editor.getContent().replace(/'/g,"&#39;")+"</br></br>"+"·处置人由"+"【"+deal_man+"】"+"变为"+"【"+next_man+"】";
			}else{
				trans_news_detail=news_desc_editor.getContent().replace(/'/g,"&#39;")+"</br></br>"+"·缺陷状态由"+"【"+state+"】"+"变为"+"【"+next_state+"】";
			}
			console.log(trans_news_detail)
			if((state == next_state) && (deal_man == next_man)){
				trans_news_detail=news_desc_editor.getContent().replace(/'/g,"&#39;");
			}
			
			AOS.ajax({
				forms : news_form,
				url :  'bugManageService.saveNews',
				params:{
					submit_name: "${userinfo.name}",
					proj_id : ${bug.proj_id},
					trans_news_detail : trans_news_detail
				},
				ok : function(data) {
					window.close();
				}
			});
	     }

		//返回信息
		function b_return() {
			window.close();
			refresh();
		}
		
		function changePlanWastage(){
			if(manager_user_count > 0){
				id_bug_real_wastage.setValue(id_bug_plan_wastage.getValue());
			}else{
				var value = id_bug_plan_wastage.getValue();
				if(value == null){
					id_bug_plan_wastage.setValue(${bug.plan_wastage});
				}
			}
		}
		
		function bugCopy_query(){
			var bug_id = ${bug.bug_id}
			bug_copy_grid_store.getProxy().extraParams = {
				bug_id : bug_id
			};
			bug_copy_grid_store.load();
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
		
		function from_bug_render(value, metaData, record) {
			var bug_code = '${bug.bug_code}'
			var from_bug_code = record.data.from_bug_code;
			if(bug_code != from_bug_code){
				return '<a href="javascript:void(0);">' + record.data.from_bug_code + '</a>';
			}else{
				return record.data.from_bug_code;
			}
		}
		function to_bug_render(value, metaData, record) {
			var bug_code = '${bug.bug_code}'
			var to_bug_code = record.data.to_bug_code;
			if(bug_code != to_bug_code){
				return '<a href="javascript:void(0);">' + record.data.to_bug_code + '</a>';
			}else{
				return record.data.to_bug_code;
			}
		}
		bug_copy_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			 var record = AOS.selectone(bug_copy_grid, true); 
			if(AOS.empty(record) || record.length>1){
				AOS.tip('只能勾选一列查看缺陷详情。');
				return;
			}
			var bug_code = '${bug.bug_code}'
			var from_bug_code = record.data.from_bug_code;
			var to_bug_code = record.data.to_bug_code;
			if(bug_code != from_bug_code){
				if (columnIndex == 2 ) {
					var bug_id = record.data.from_bug_id;
					window.open("do.jhtml?router=bugManageService.newsdataInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+bug_id);
				} 
			}
			if(bug_code != to_bug_code){
				if (columnIndex == 6 ) {
					var bug_id = record.data.to_bug_id;
					window.open("do.jhtml?router=bugManageService.newsdataInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+bug_id);
				} 
			}
		});
	</script>
</aos:onready>
