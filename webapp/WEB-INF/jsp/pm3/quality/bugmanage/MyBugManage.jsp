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
<%
	//获取当前时间
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();
	String time = simpleDateFormat.format(currentTime).toString();
	request.setAttribute("time", time);
%>
<aos:html title="我的缺陷" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north" bodyBorder="0 0 1 0">
			<aos:formpanel id="mybug_query_form" layout="column" labelWidth="85"
				header="false" border="false">
				<aos:combobox fieldLabel="项目" name="proj_id"
					editable="true" columnWidth="0.3" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true"
					url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
					onselect="on_public_com" />
				<aos:combobox fieldLabel="模块" name="stand_id" 
					editable="true" columnWidth="0.3" labelWidth="45" queryMode="local"
					typeAhead="true" forceSelection="true" selectOnFocus="true" 
					url="moduleDivideService.listModuleDivideComboBox" />
				<aos:combobox fieldLabel="缺陷状态" dicField="bug_states"
					multiSelect="true" name="state" columnWidth="0.33"/>
				<aos:textfield fieldLabel="缺陷编码" name="bug_code" columnWidth="0.3"
					 />
				<%-- <aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查询" onclick="bug_grid_query" icon="query.png" />
						<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(mybug_query_form);" icon="refresh.png" />
						<aos:dockeditem xtype="tbfill" />
					</aos:docked> --%>

			</aos:formpanel>
		</aos:panel>



		<aos:gridpanel id="mybug_grid" url="bugManageService.page"
			forceFit="false" anchor="100%" onrender="bug_grid_mydeal_query"
			border="true" region="center" bodyBorder="1 0 1 0">
			<aos:menu>
				<%-- <aos:menuitem text="修改"
						onclick="AOS.reset(my_bug_form);bug_win_show('update');"
						icon="edit.png" /> --%>
				<aos:menuitem text="延期处理" onclick="fn_delay()" icon="wand.png" />
			</aos:menu>
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="缺陷信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="待解决" onclick="bug_grid_mydeal_query" />
				<aos:dockeditem text="查询" onclick="bug_grid_all_query" />
				<aos:dockeditem text="已关闭" onclick="bug_grid_close_query" />
				<aos:dockeditem text="未关闭" onclick="bug_grid_unclose_query" />
				<aos:dockeditem xtype="button" text="重置查询条件"
					onclick="AOS.reset(mybug_query_form);" icon="refresh.png" />
				<%-- <aos:dockeditem text="已延期" /> --%>
				<%-- <aos:dockeditem text="更多">
						<aos:menu>
							<aos:menuitem text="由我发起" onclick="" />
							<aos:menuitem text="进行中" onclick="" icon="edit.png" />
							<aos:menuitem text="已完成" onclick="" icon="del.png" />
							<aos:menuitem xtype="menuseparator" />
							<aos:menuitem text="已关闭" onclick="" icon="refresh.png" />
						</aos:menu>
					</aos:dockeditem> --%>
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="缺陷ID" dataIndex="bug_id" fixedWidth="100"
				hidden="true" />
			<aos:column header="消息记录ID" dataIndex="log_id" width="100"
				hidden="true" />
			<aos:column header="需求ID" dataIndex="demand_id" width="100"
				hidden="true" />
			<aos:column header="缺陷详情" dataIndex="bug_detail" width="100"
				hidden="true" />
			<aos:column header="缺陷编码" dataIndex="bug_code" width="130"
				align="center" />
			<aos:column header="当前状态" dataIndex="state" width="100"
				align="center" rendererFn="fn_bug_state" />
			<aos:column header="严重程度" dataIndex="severity" width="80"
				align="center" rendererField="bug_severity" />
			<aos:column header="优先级" dataIndex="priority" width="60"
				align="center" rendererField="bug_priority" />
			<aos:column header="模块" dataIndex="dm_name" width="100" align="left" />
			<aos:column header="缺陷名称" dataIndex="bug_name" width="200"
				rendererFn="fn_link_render" celltip="true"/>
			<aos:column header="当前处置人id" dataIndex="deal_man" width="100"
				align="center" hidden="true" />
			<aos:column header="当前处置人" dataIndex="deal_man_name" width="100"
				align="center" />
			<aos:column header="发现人" dataIndex="find_name" width="100"
				align="center" />
			<aos:column header="创建时间" dataIndex="create_time" width="150"
				align="center" />
			<aos:column header="相关缺陷编码" dataIndex="relate_bug_code" width="150" />
			<aos:column header="模块ID" dataIndex="stand_id" width="100"
				hidden="true" />
			<aos:column header="类型" dataIndex="bug_type" width="50"
				align="center" rendererField="bug_type" />
			<aos:column header="缺陷位置" dataIndex="bug_addr" width="100"
				rendererField="bug_addr" align="center" />
			<aos:column header="出现频率" dataIndex="rate" width="100" align="center"
				rendererField="bug_rate" />
			<aos:column header="项目" dataIndex="proj_name" width="150"
				align="left" />
			<aos:column header="项目ID" dataIndex="proj_id" width="100"
				hidden="true" />
			<aos:column header="来源方" dataIndex="source" width="100"
				align="center" rendererField="bug_source" />
			<aos:column header="创建人" dataIndex="create_name" width="100"
				align="center" />
			<aos:column header="发现时间" dataIndex="find_time" width="150"
				hidden="true" />
			<aos:column header="关闭人" dataIndex="close_name" width="100"
				align="center" />
			<aos:column header="关闭时间" dataIndex="close_time" width="150"
				align="center" />
		</aos:gridpanel>

		<%-- 新增窗口 --%>
		<aos:window id="my_bug_win" title="新增缺陷">
			<aos:formpanel id="my_bug_form" width="1500" layout="column"
				height="800" labelWidth="70" msgTarget="qtip">
				<aos:fieldset title="基本信息">
					<aos:hiddenfield name="bug_id" fieldLabel="缺陷id" />
					<aos:hiddenfield name="log_id" fieldLabel="消息记录id" />
					<aos:textfield name="bug_code" fieldLabel="缺陷编码" allowBlank="true"
						readOnly="true" emptyText="保存后自动生成" columnWidth="0.25" />
					<aos:combobox fieldLabel="项目" name="proj_id" editable="false"
						allowBlank="false" columnWidth="0.25" readOnly="true"
						url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
						onchange="on_public_com_win" />
					<aos:combobox fieldLabel="模块" name="stand_id" editable="false"
						allowBlank="true" columnWidth="0.25"
						url="moduleDivideService.listModuleDivideComboBox"
						value="${all_stand_id}" />
					<aos:combobox fieldLabel="需求" name="demand_id" editable="false"
						allowBlank="true" columnWidth="0.25"
						url="demandActionService.listdemand" value="${all_stand_id}" />
					<aos:textfield name="bug_name" fieldLabel="缺陷名称" maxLength="100"
						allowBlank="false" columnWidth="0.25" />
					<aos:combobox fieldLabel="测试用例" name="standard_id" value="a用例"
						columnWidth="0.25">
						<aos:option value="a用例" display="a用例" />
						<aos:option value="乙模块" display="乙模块" />
						<aos:option value="丙模块" display="丙模块" />
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷状态" name="state" value="1000"
						dicField="bug_states" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="严重程度" name="severity" value="1001"
						dicField="bug_severity" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="优先级" name="priority" value="1001"
						dicField="bug_priority" columnWidth="0.25">
					</aos:combobox>
					<aos:combobox fieldLabel="缺陷位置" name="bug_addr" dicField="bug_addr"
						columnWidth="0.25">
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
						value="${user.name}" readOnly="true" allowBlank="true"
						columnWidth="0.25" />
					<aos:datetimefield name="create_time" fieldLabel="创建时间"
						value="${time}" readOnly="true" format="Y-m-d H:i:s"
						allowBlank="true" columnWidth="0.25" />
					<aos:textfield name="close_name" fieldLabel="关闭人" allowBlank="true"
						readOnly="true" columnWidth="0.25" />
					<aos:datetimefield name="close_time" fieldLabel="关闭时间"
						format="Y-m-d H:i:s" allowBlank="true" readOnly="true"
						columnWidth="0.25" />
					<aos:combobox fieldLabel="指派处理人" name="deal_man"
						id="combo_deal_man" editable="false" allowBlank="true"
						columnWidth="0.25" url="projCommonsService.listComboBoxProjId" />
				</aos:fieldset>
				<aos:fieldset labelWidth="70" columnWidth="1" border="true"
					title="缺陷详情">
					<aos:htmleditor margin="5" name="bug_detail" columnWidth="1" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="bug_form_save" text="保存" icon="ok.png"
					tooltip="保存" />
				<aos:dockeditem onclick="#my_bug_win.hide();" text="关闭"
					icon="close.png" />
			</aos:docked>
		</aos:window>
		<script type="text/javascript">
			 //查询缺陷列表/分页
	        function bug_grid_query() {
	        	var params = AOS.getValue('mybug_query_form');
	        	params.deal_man = Number(<%=userid%>);
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	        }
			 
	      //缺陷状态渲染
			function fn_bug_state(value, metaData, record){
				if(value =='1000'){
					return "<span >未解决</span>"; 
				}else if(value == '1002'){
					return "<span style='color:blue; font-weight:bold'>延期处理</span>"; 
				}else if(value == '1004'){
					return "<span style='color:red; font-weight:bold'>拒绝</span>"; 
				}else if(value == '1001'){
					return "<span style='color:green; font-weight:bold'>已解决</span>"; 
				}else if(value == '1003'){
					return "<span style='font-weight:bold'>关闭</span>"; 
				}else if(value == '1005'){
					return "<span style='color:blue; font-weight:bold'>重新打开</span>"; 
				}else if(value == '1006'){
					return "<span style='color:#3399CC; font-weight:bold'>无法复现</span>";
				}else{
					return value;
				}
			}
			 
	        //查询我的缺陷，未关闭
	        function bug_grid_unclose_query() {
	        	var params = AOS.getValue('mybug_query_form');
	        	var query_proj_id = params.proj_id;
	        	if(AOS.empty(query_proj_id)){
					AOS.tip('请选择项目，再查询该项目未关闭数据！');
					return;
				}
	        	params.unclose_state="1003";
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	        }
	        
	      //查询我的缺陷，已关闭
	        function bug_grid_close_query() {
	        	var params = AOS.getValue('mybug_query_form');
	        	var query_proj_id = params.proj_id;
	        	if(AOS.empty(query_proj_id)){
					AOS.tip('请选择项目，再查询该项目已关闭数据！');
					return;
				}
	        	params.close_state="1003";
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	        }
	        
	        //查询指派给我的关联模块的缺陷列表/分页
	        function bug_grid_deal_query() {
	        	var params = {deal_man : "<%=userid%>"};
	        	params.proj_id=all_proj_id;
	        	params.stand_id=all_stand_id;
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	            /* console.log(mybug_grid_store); */
	        }
			 
	        
	        //查询指派给我待处理的缺陷  未解决1000   延期1002 重新打开1005
	        function bug_grid_mydeal_query() {
	        	var params = AOS.getValue('mybug_query_form');
	        	params.deal_man="<%=userid%>"
	        	params.dealed_state="1000"
		        params.delay_state="1002"
		        params.again_state="1005"
		        params.unable_state="1006"
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	            /* console.log(mybug_grid_store); */
	        }
	        //查询所有缺陷列表/分页
	        function bug_grid_all_query() {
	        	var params = AOS.getValue('mybug_query_form');
	        	params.deal_man="<%=userid%>"
	        	var query_proj_id = params.proj_id;
	        	if(AOS.empty(query_proj_id)){
					AOS.tip('请选择项目，再查询该项目所有数据！');
					return;
				}
	            mybug_grid_store.getProxy().extraParams = params;
	            mybug_grid_store.loadPage(1);
	        }
	        
			//显示新增/修改 窗口
			function bug_win_show(editModel){
				//console.log("${user.name}","${user.juid}","${user.account}");
				my_bug_form.editModel=editModel;
				if(editModel=="update"){
					my_bug_win.setTitle("修改缺陷");
					var record = AOS.selectone(mybug_grid, true);
					if(AOS.empty(record)){
						AOS.tip('请选择一条需要修改的数据。');
						return;
					}
					if(record.data.state=="1003"){
						AOS.tip('该缺陷已关闭，不能直接修改内容！');
						return;
					}
					my_bug_form.loadRecord(record);
					AOS.setValue("my_bug_form.proj_id",Number(record.data.proj_id));
					AOS.setValue("my_bug_form.deal_man",Number(record.data.deal_man));
					AOS.setValue("bug_form.demand_id",Number(record.data.demand_id));
					AOS.get('my_bug_form.deal_man').getStore().getProxy().extraParams = {
						proj_id : Number(record.data.proj_id)
					};
					AOS.get('my_bug_form.deal_man').getStore().load({
						callback : function(records, operation, success) {
						}
					});
				}else{
					my_bug_win.setTitle("新增缺陷");
					AOS.setValue("my_bug_form.proj_id",all_proj_id);
					AOS.setValue("my_bug_form.stand_id",all_stand_id);
					AOS.setValue("my_bug_form.deal_man",Number(<%=userid%>));
				}
				my_bug_win.show();
				my_bug_win.maximize();
			}
			//新增/修改缺陷保存
	        function bug_form_save() {
	        	AOS.ajax({
					forms : my_bug_form,
					url : my_bug_form.editModel=="update" ? 'bugManageService.update':'bugManageService.create',
					ok : function(data) {
						AOS.tip(data.appmsg);
						mybug_grid_store.reload();
						my_bug_win.hide();
					}
				});
	        }
	      //保存提交信息
			 function b_save() {
		        	AOS.ajax({
						forms : news_form,
						url :  'bugManageService.saveNews',
						params:{
							submit_name: "${user.name}"
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							mybug_grid_store.reload();
							news_detail.close();
						}
					});
		        }
	      //项目ID全局变量
	      var all_proj_id='';
	      //模块ID全局变量
	      var all_stand_id='';
				//查询页面项目下拉框添加变更事件
				function on_public_com(me, records){
					var proj_id = me.getValue();
					all_proj_id=proj_id;
					AOS.get('mybug_query_form.stand_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('mybug_query_form.stand_id').getStore().load({
						callback : function(records, operation, success) {
						}
					}); 
				}
	     		
				//新增\修改页面项目下拉框添加变更事件
				function on_public_com_win(me, records){
					var proj_id = me.getValue();
					AOS.get('my_bug_form.stand_id').getStore().getProxy().extraParams = {
						proj_id : proj_id
					};
					AOS.get('my_bug_form.stand_id').getStore().load({
						callback : function(records, operation, success) {
						}
					});
				}
	      //超链接列转换开始
			function fn_link_render(value, metaData, record) {
				//可以根据record.data.xx数据来判断该列是否要加超连接
				return '<a href="javascript:void(0);">' + record.data.bug_name + '</a>';
			}
			mybug_grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				 var record = AOS.selectone(mybug_grid, true); 
				//var records = AOS.select(bug_grid, true);
				if(AOS.empty(record) || record.length>1){
					AOS.tip('只能勾选一列查看缺陷详情。');
					return;
				}
				//record = records[0];
				//var a=record.data.deal_man;
			
				//判断列数是否为超链接列
				if (columnIndex == 7 ) {
					window.open("do.jhtml?router=bugManageService.newsdataInit&juid=<%=request.getAttribute("juid")%>&user_name=${user.name}&bug_id="+record.get("bug_id"));
				} 
			});
			//超链接列转换结束
			
			
			
			//删除选中的缺陷
			function bug_grid_del(){
				var selection = AOS.selection(mybug_grid, 'bug_id');
				if(AOS.empty(selection)){
					AOS.tip('请选择需要删除的数据。');
					return;
				}
				var rows = AOS.rows(mybug_grid);
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
							mybug_grid_store.reload();
						}
					});
				});
			}
		</script>
	</aos:viewport>
</aos:onready>
<script type="text/javascript"> 
function w_account2_show(){
	AOS.get('my_bug_win').setTitle("修改缺陷");
	AOS.get('my_bug_form').editModel='update';
	var record = AOS.selectone(AOS.get('mybug_grid'), true);
	if(AOS.empty(record)){
		AOS.tip('请选择要修改的记录。');
		return;
	}
	AOS.get('my_bug_form').loadRecord(record);
	AOS.get('my_bug_win').show(); 
	AOS.get('my_bug_win').maximize(); 
}

//延期处理缺陷
function fn_delay(){
	var record = AOS.selectone(AOS.get('mybug_grid'),true);
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
				AOS.get('mybug_grid').getStore().reload();
			}
		});
	});
}



</script>
