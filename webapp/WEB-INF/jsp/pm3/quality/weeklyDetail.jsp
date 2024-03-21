<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="增删改查" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
	<aos:tabpanel id="id_tabpanel" region="center" tabPosition="bottom" bodyBorder="0 0 0 0" margin="0 0 2 0">
	<aos:tab title="周报明细" layout="border"  >
		<aos:formpanel id="f_query_d"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:datefield name="text_name" fieldLabel="开始时间" columnWidth="0.15" />
			<aos:datefield name="text_name" fieldLabel="结束时间" columnWidth="0.15" />
		   	<aos:hiddenfield name="proj_code" />
			<aos:triggerfield fieldLabel="弹出选择表格"  labelWidth="80" name="proj_name" editable="false" trigger1Cls="x-form-search-trigger" margin="0 0 10 10" onTrigger1Click="w_account_find_show" columnWidth="0.25" />
			<aos:dockeditem xtype="button" text="查询" onclick="g_account_query" icon="query.png" columnWidth="0.07" margin="0 0 10 10"/>
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query_d);" icon="refresh.png" columnWidth="0.07"  margin="0 0 10 10"/>
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		<aos:gridpanel id="g_account" url="weeklyDetailService.page" columnLines="true" rowLines="true" onrender="g_account_query" onitemdblclick="#w_account2.show();" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="周报明细 信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="生成数据" icon="add.png" onclick="f_account_save" />
				<aos:dockeditem text="修改" icon="edit.png" onclick="#w_account2.show();" />
				<aos:dockeditem text="批量删除" icon="del.png" onclick="g_acount_del" />
				<aos:dockeditem text="导出" icon="icon70.png" onclick="fn_export_excel" />
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<!-- 隐藏的内容 -->
		    <aos:column header="周报ID" dataIndex="test_id"   hidden="true" />
		    <aos:column header="周报编码" dataIndex="test_code"  hidden="true"/>
		    <!-- 显示内容 -->
		    <aos:column header="项目名称" dataIndex="proj_code" fixedWidth="280" align="center" />
			<aos:column header="缺陷总数" dataIndex="bug_input_num" fixedWidth="80" align="center"  />
			<aos:column header="关闭数" dataIndex="bug_close_num" fixedWidth="60"  align="center" />
			<aos:column header="已解决数" dataIndex="bug_finish_num" fixedWidth="80" align="center" />
			<aos:column header="未解决数" dataIndex="bug_unfinish_num" fixedWidth="80" align="center" />
			<aos:column header="本周新增" dataIndex="bug_add_num" fixedWidth="70" align="center" />
			<aos:column header="本周关闭" dataIndex="lately_close_num" fixedWidth="70" align="center"  />
			<aos:column header="工作内容" dataIndex="job_content" fixedWidth="280" align="center"  />
			<aos:column header="本周任务数" dataIndex="input_cond" fixedWidth="80" />
			<aos:column header="任务接收情况" dataIndex="accept_cond" fixedWidth="100" />
			<aos:column header="进度比例调整" dataIndex="finish_cond" fixedWidth="100" />
			<aos:column header="问题描述" dataIndex="trouble_bewrite" align="center" fixedWidth="280"  />
			<aos:column header="建议" dataIndex="trouble_advise" align="center"  fixedWidth="280" />
			<aos:column header="活动内容" dataIndex="job_plan" fixedWidth="280"  align="center"/>
	        <aos:column header="负责人" dataIndex="charge"  fixedWidth="80"  align="center"/>
	        <aos:column header="备注" dataIndex="remarks"  align="center" fixedWidth="280"  />
			<aos:column header="修改" rendererFn="fn_button_render" align="center"
				fixedWidth="50" />
			<aos:column header="删除" rendererFn="fn_button_del_w" align="center"
				fixedWidth="50" />
		</aos:gridpanel>
		
		<!-- 项目信息 窗口 -->
		<aos:window id="w_account_find" title="项目[双击选择]" height="-200" width="800" layout="fit" onshow="g_account_query_porj">
			<aos:gridpanel id="g_account_proj" url="weeklyDetailService.getPoj" onrender="g_account_query_porj" onitemdblclick="g_account_dbclick">
				<aos:docked forceBoder="0 0 1 0">
					<aos:triggerfield emptyText="项目名称" id="proj_name" onenterkey="g_account_query_porj" trigger1Cls="x-form-search-trigger" onTrigger1Click="g_account_query_porj" width="250" />
				</aos:docked>
				<aos:column type="rowno" />
				<aos:column header="项目编码" dataIndex="proj_code"  width="60" />
				<aos:column header="项目名称" dataIndex="proj_name" width="180" />
			</aos:gridpanel>
		</aos:window>

		<%-- 修改窗口 --%>
		<aos:window id="w_account2" title="修改账户" onshow="w_account2_onshow">
			<aos:formpanel id="f_account2" width="650" layout="anchor" labelWidth="70">
				 <!--  隐藏内容 -->
				<aos:hiddenfield name="test_id" fieldLabel="周报ID" />
				<aos:hiddenfield name="test_code" fieldLabel="周报编码" />
				<aos:hiddenfield name="bug_add_num" fieldLabel="本周新建缺陷数" />
				<aos:hiddenfield name="lately_close_num" fieldLabel="本周关闭缺陷数" />
				<aos:hiddenfield name="bug_input_num" fieldLabel="总数" />
				<aos:hiddenfield name="bug_close_num" fieldLabel="关闭数" />
				<aos:hiddenfield name="bug_finish_num" fieldLabel="已解决数" />
				<aos:hiddenfield name="bug_unfinish_num" fieldLabel="未解决数" />
				<aos:hiddenfield name="input_cond" fieldLabel="本周任务数" allowBlank="true" />
				
				<aos:fieldset title="基础信息" labelWidth="85" columnWidth="1">
				<aos:textfield name="proj_code" fieldLabel="项目名称" allowBlank="false" maxLength="60" columnWidth="0.69" margin="5" />
				<aos:textfield name="charge" fieldLabel="负责人" allowBlank="true" maxLength="20" columnWidth="0.3" margin="5"/>
				<aos:textareafield name="job_content" fieldLabel="工作内容" allowBlank="true" maxLength="600" columnWidth="0.99"  margin="5"/>	
				</aos:fieldset>
				<aos:fieldset title="工作任务检查" labelWidth="85" columnWidth="1">
				<aos:textfield name="accept_cond" fieldLabel="任务接受情况" allowBlank="true" maxLength="600"  columnWidth="0.69"margin="5"/>
				<aos:textfield name="input_cond" fieldLabel="本周任务数" allowBlank="true" maxLength="600" columnWidth="0.3" margin="5"/>
			    <aos:textareafield name="finish_cond" fieldLabel="进度比例调整" allowBlank="true" maxLength="500"  columnWidth="0.99" margin="5"/>
				</aos:fieldset>
				<aos:fieldset title="问题" labelWidth="85" columnWidth="1">
			
				<aos:textfield name="trouble_bewrite" fieldLabel="问题描述"  allowBlank="true" maxLength="600" columnWidth="0.99" margin="5"/>
				<aos:textfield name="trouble_bewrite" fieldLabel="问题描述" allowBlank="true" maxLength="600" columnWidth="0.99" margin="5"/>
				<aos:textfield name="trouble_advise" fieldLabel="建议" allowBlank="true" maxLength="600" columnWidth="0.99" margin="5"/>
				</aos:fieldset>
			   <aos:textfield name="remarks" fieldLabel="备注" allowBlank="true" labelWidth="85" maxLength="600" columnWidth="0.97" />
			  </aos:formpanel>
		
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="f_account2_update" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_account2.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		</aos:tab>
		
		<aos:tab title="周报列表" layout="border"  autoScroll="true">
		<aos:formpanel id="f_query_week"   labelWidth="70" header="false" region="north" border="false" anchor= "100%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:datefield name="text_name" fieldLabel="开始时间" columnWidth="0.15" />
			<aos:datefield name="text_name" fieldLabel="结束时间" columnWidth="0.15" />
		    <aos:dockeditem xtype="button" text="查询" onclick="g__week_query" icon="query.png" columnWidth="0.07" margin="0 0 10 10"/>
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query);" icon="refresh.png" columnWidth="0.07"  margin="0 0 10 10"/>
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		
		<aos:gridpanel id="g_account_week" url="weeklyService.page"  onrender="g__week_query" onitemdblclick="" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="周报信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png" onclick="f_week_save" />
				<aos:dockeditem text="批量删除" icon="del.png" onclick="g_week_del" />
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:plugins>
					<%-- clicksToEdit可以控制是单击还是双击进入编辑模式 --%>
					<aos:editing id="id_plugin"   clicksToEdit="1" onedit="fn_edit" autoCancel="false" onbeforeedit="fn_beforeedit" />
				</aos:plugins>
			<aos:column type="rowno" />
			<!-- 隐藏的内容 -->
		    <aos:column header="周报ID" dataIndex="weekly_id"   hidden="true" />
		    <!-- 显示内容 -->
		    <aos:column header="周报编码" dataIndex="test_code" fixedWidth="100" align="center" />
			<aos:column header="开始时间" dataIndex="begin_date" fixedWidth="100" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="结束时间" dataIndex="end_date" fixedWidth="100" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="测试组长" dataIndex="test_leader" fixedWidth="100" align="center">
			<aos:textfield allowBlank="false" />
			</aos:column>
			<aos:column header="记录人" dataIndex="add_name" fixedWidth="100" align="center"/>
			<aos:column header="记录时间" dataIndex="create_time" fixedWidth="150"  align="center"/>
			<aos:column header="删除" rendererFn="fn_button_del" align="center" fixedWidth="50" />
		</aos:gridpanel>
   </aos:tab>
	</aos:tabpanel>
	</aos:viewport>

	<script type="text/javascript">
	
			//加载表格数据
			function g_account_query() {
				var params = AOS.getValue('f_query_d');
				g_account_store.getProxy().extraParams = params;
			//	g_account_store.loadPage(1);
			}
			
			//生成数据
			function f_account_save(){
				var test_code='0001';
					AOS.ajax({
						params:{
							test_code: test_code
						},
						url : 'weeklyDetailService.create',
						ok : function(data) {
							 AOS.tip(data.appmsg);
							g_account_store.reload();
						}
				});
			}
			//弹出选择项目窗口
			function w_account_find_show() {
				w_account_find.show();
			}
			//账户表格双击事件
			function g_account_dbclick(obj, record) {
				AOS.setValue('f_query_d.proj_code',record.raw.proj_code);
				AOS.setValue('f_query_d.proj_name',record.raw.proj_name);
				w_account_find.hide();
			}
			//加载项目表格数据
			function g_account_query_porj() {
				var params = {
						proj_name : proj_name.getValue()
				};
				g_account_proj_store.getProxy().extraParams = params;
				g_account_proj_store.load();
			}
			
			//监听修改窗口弹出
			function w_account2_onshow(){
				//这里演示的是直接从表格行中加载数据，也可以发一个ajax请求查询数据(见misc1.jsp有相关用法)
				var record = AOS.selectone(g_account, true);
				f_account2.loadRecord(record);
			}
			
			//修改账户保存
			function f_account2_update(){
					AOS.ajax({
						forms : f_account2,
						url : 'weeklyDetailService.update',
						ok : function(data) {
							AOS.tip(data.appmsg);
							g_account_store.reload();
							w_account2.hide();
						}
				});
			}
			//加载表格数据
			function g__week_query() {
				var params = AOS.getValue('f_query');
				g_account_week_store.getProxy().extraParams = params;
				g_account_week_store.loadPage(1);
			}
			
			//明细新增
			function f_week_save(){
					AOS.ajax({
						url : 'weeklyService.create',
						ok : function(data) {
							 AOS.tip(data.appmsg);
							g_account_week_store.reload();
							w_account_week.hide();
						}
				});
			}
			
			//监听行编辑事件
			function fn_edit(editor, e) {
				if (!e.record.dirty) {
					AOS.tip('数据没变化，提交操作取消。');
					return;
				}
				AOS.ajax({
					params : e.record.data,
					url : 'weeklyService.update',
					ok : function(data) {
						AOS.tip(data.appmsg);
						g_accoun_weekt_store.reload();
					}
				});
			}
			//触发编辑前事件
			function fn_beforeedit(obj, e) {
				var editing = g_account_week.getPlugin('id_plugin');
				var rowEditor = editing.getEditor();
				//这行是修复行编辑的一个bug，当数据校验时候如果初始时数据不合法，则数据纠正后保存按钮也不能用的bug。
				rowEditor.on('fieldvaliditychange', rowEditor.onFieldChange,
						rowEditor);
			}
			//导出excel
			function fn_export_excel(){
				//juid需要再这个页面的初始化方法中赋值,这里才引用得到
				AOS.file('do.jhtml?router=weeklyDetailService.exportExcel&juid=${juid}');
			}
			
		    //删除账户信息
		 	function g_acount_del(){
					var selection = AOS.selection(g_account, 'test_id');
					if(AOS.empty(selection)){
						AOS.tip('删除前请先选中数据。');
						return;
					}
					var rows = AOS.rows(g_account);
					var msg =  AOS.merge('确认要删除选中的{0}个账户吗？', rows);
					AOS.confirm(msg, function(btn){
						if(btn === 'cancel'){
							AOS.tip('删除操作被取消。');
							return;
						}
						AOS.ajax({
							url : 'weeklyDetailService.alldelete',
							params:{
								aos_rows: selection
							},
							ok : function(data) {
								AOS.tip(data.appmsg);
								g_account_store.reload();
							}
						});
					});
				}

		    //明细删除账户信息
		 	function g_week_del(){
					var selection = AOS.selection(g_account_week, 'weekly_id');
					if(AOS.empty(selection)){
						AOS.tip('删除前请先选中数据。');
						return;
					}
					var rows = AOS.rows(g_account_week);
					var msg =  AOS.merge('确认要删除选中的{0}个账户吗？', rows);
					AOS.confirm(msg, function(btn){
						if(btn === 'cancel'){
							AOS.tip('删除操作被取消。');
							return;
						}
						AOS.ajax({
							url : 'weeklyService.alldelete',
							params:{
								aos_rows: selection
							},
							ok : function(data) {
								AOS.tip(data.appmsg);
								g_account_week_store.reload();
							}
						});
					});
				}
			
			//按钮列转换
			function fn_button_render(value, metaData, record) {
				return '<input type="button" value="修改" class="cbtn" onclick="w_account2_show();" />';
			}
			
			//按钮列转换
			function fn_button_del(value, metaData, record) {
				return '<input type="button" value="删除" class="cbtn" onclick="fn_del();" />';
			}
			//按钮列转换
			function fn_button_del_w(value, metaData, record) {
				return '<input type="button" value="删除" class="cbtn" onclick="fn_del_week();" />';
			}
			
			
			
		</script>
		</aos:onready>
		
		<script type="text/javascript">
		//弹出修改窗口
		function w_account2_show(){
		AOS.get('w_account2').show();
		}
		
		function fn_del(){
		//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
		var record = AOS.selectone(AOS.get('g_account'));
		var msg =  AOS.merge('确认要删除账户【{0}】吗？', record.data.proj_code);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				AOS.tip('删除操作被取消。');
				return;
			}
			AOS.ajax({
				url : 'weeklyDetailService.delete',
				params:{
					test_id: record.data.test_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					AOS.get('g_account').getStore().reload();
				}
			});
		});
		}
		//删除数据
		function fn_del_week(){
			//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
			var record = AOS.selectone(AOS.get('g_account_week'));
			var msg =  AOS.merge('确认要删除账户【{0}】吗？', record.data.test_code);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					AOS.tip('删除操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'weeklyService.delete',
					params:{
						weekly_id: record.data.weekly_id
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						AOS.get('g_account_week').getStore().reload();
					}
				});
			});
			}
		
</script>
