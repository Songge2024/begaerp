<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<aos:html title="合同管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="query_form" region="north" layout="column">
			<aos:textfield name="keyWords" fieldLabel="输入条件" allowBlank="true" maxLength="20" emptyText="合同编码/名称/客户(甲方)"
				columnWidth="0.3" margin="4"/>
			<%-- <aos:textfield name="ct_name" fieldLabel="合同名称"  maxLength="100"
				columnWidth="0.3" margin="4"/>
				<aos:textfield name="partya_name" fieldLabel="客户(甲方)"  maxLength="100"
				columnWidth="0.3" margin="4"/>
				--%>
			<aos:combobox fieldLabel="关联项目" name="proj_id"  editable="false" columnWidth="0.3" multiSelect="true" emptyText="可多选"
	 					url="projCommonsService.listComboBoxUerid&type=all"  margin="4" />
			<aos:combobox name="state" dicField="re_cp_type" fieldLabel="合同状态" allowBlank="true" margin="4" columnWidth="0.2" />
			<aos:button text="查询" onclick="contract_query" icon="query.png"
					margin="4 4 4 50" />
			<aos:button text="重置" onclick="AOS.reset(query_form);" icon="refresh.png"
				margin="4 4 4 20" />
		</aos:formpanel>
		<aos:gridpanel id="contract_grid" region="north" height="250" forceFit="false" 
			url="contractService.page" onrender="contract_query" onitemclick="on_item_contract_grid">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="合同信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png"  		onclick="contract_win_show('create');" />
				<aos:dockeditem text="修改" icon="edit.png" 		onclick="contract_win_show('update');" />
				<aos:dockeditem text="启用" icon="go.gif"    onclick="contract_enable" />
				<aos:dockeditem text="暂停" icon="stop.gif"    onclick="contract_stop" />
				<aos:dockeditem text="作废" icon="pause.gif"    onclick="contract_disable" />
				<aos:dockeditem text="删除" icon="del.png"    onclick="contract_delete" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增"
					onclick="contract_win_show('create');"
					icon="add.png" />
				<aos:menuitem text="修改"
					onclick="contract_win_show('update');"
					icon="edit.png" />
				<aos:menuitem text="启用" icon="go.gif"    onclick="contract_enable" />
				<aos:menuitem text="暂停" icon="stop.gif"    onclick="contract_stop" />
				<aos:menuitem text="作废" icon="pause.gif"    onclick="contract_disable" />
				<aos:menuitem text="删除" onclick="contract_delete" icon="del.png" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="合同id" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="合同编码" dataIndex="ct_code" width="100" align="center"/>
			<aos:column header="合同名称" dataIndex="ct_name" width="200" />
			<aos:column header="合同性质" dataIndex="ct_properties" width="120" rendererField="ct_properties_code"/>
			<aos:column header="合同类型" dataIndex="ct_type" width="100" rendererField="ct_type_code"/>
			<aos:column header="合同状态" dataIndex="state" width="100" align="center" rendererFn="fn_ct_state"/>
			<aos:column header="关联项目" dataIndex="proj_names" width="150" />
			<aos:column header="销售代表" dataIndex="sales_leader" width="100" />
			<aos:column header="客户(甲方)" dataIndex="partya_name" width="150" />
			<aos:column header="乙方" dataIndex="partyb_name" width="150"/>
			<aos:column header="其他相关方" dataIndex="partyc_name" width="150" />
			<aos:column header="合同总金额(元)" dataIndex="ct_total_amount" width="150" align="right"
				rendererFn="fn_money"/>
			<aos:column header="作废原因" dataIndex="reason" width="150" align="left" />
			<aos:column header="签订时间" dataIndex="ct_sign_date" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="生效日期" dataIndex="ct_begin_date" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="终止日期" dataIndex="ct_end_date" type="date" format="Y-m-d" hidden="true" width="100" align="center"/>
			<aos:column header="合同备注" dataIndex="ct_remark" width="150" />
			<aos:column header="创建人" dataIndex="create_user_name" width="100" align="center"/>
			<aos:column header="创建日期" dataIndex="create_date" width="150" align="center"/>
			<aos:column header="修改人" dataIndex="update_user_name" width="100" align="center"/>
			<aos:column header="修改日期" dataIndex="update_date" width="150" align="center" />
		</aos:gridpanel>
		<aos:gridpanel id="contractStage_grid" region="west" width="700" forceFit="false"
			features="summary" url="contractStageService.page">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="支付阶段信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png"  		onclick="contractStage_win_show('create');" />
				<aos:dockeditem text="修改" icon="edit.png" 		onclick="contractStage_win_show('update');" />
				<aos:dockeditem text="删除" icon="del.png"    onclick="contractStage_delete" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增"
					onclick="contractStage_win_show('create');"
					icon="add.png" />
				<aos:menuitem text="修改"
					onclick="contractStage_win_show('update');"
					icon="edit.png" />
				<aos:menuitem text="删除" onclick="contractStage_delete" icon="del.png" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="合同ID" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="阶段ID" dataIndex="ct_stage_id" width="100" hidden="true"/>
			<aos:column header="阶段编码" dataIndex="stage_code" width="100" hidden="true"/>
			<aos:column header="阶段名称" dataIndex="stage_name" width="150" summaryType="count"
				summaryRenderer="function(v){return '共 '+ v +' 条'}"/>
			<aos:column header="支付百分比(%)" dataIndex="percentage" width="120" align="center"/>
			<aos:column header="应收金额(元)" dataIndex="rece_amount" width="120" align="right" rendererFn="fn_money" summaryType="sum" 
				summaryRenderer="function(v){
				 return '合计:'+ Ext.util.Format.number(v,'0,000.00')+'(元)' }"/>
			<aos:column header="实收金额(元)" dataIndex="pay_amount" width="120" align="right" 
				defaultValue="0.00" rendererFn="fn_money" summaryType="sum"
				summaryRenderer="function(v){ return '合计:'+ Ext.util.Format.number(v,'0,000.00')+'(元)' }"/>
			<aos:column header="备注" dataIndex="stage_remark" width="150" />
			<aos:column header="创建人" dataIndex="create_user_name" width="100" align="center"/>
			<aos:column header="创建时间" dataIndex="create_time" width="150" align="center"/>
			<aos:column header="更新人" dataIndex="update_user_name" width="100" align="center"/>
			<aos:column header="更新时间" dataIndex="update_time" width="150" align="center"/>
		</aos:gridpanel>
		<aos:gridpanel id="contractFile_grid" region="center" border="true" forceFit="false" url="contractFileService.page">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="上传文件信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="上传" icon="add.png" onclick="show_excel_win" />
				<aos:dockeditem text="删除" icon="del.png"    onclick="contractFile_delete" />
				<aos:dockeditem text="下载" icon="down.png"  onclick="g_acount_down" />
				<aos:dockeditem text="批量打包下载" icon="zipdown.png"  onclick="g_zip_down" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="下载" onclick="g_acount_down" icon="down.png" />
				<aos:dockeditem text="删除" icon="del.png"    onclick="contractFile_delete" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="合同ID" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="路径" dataIndex="ct_file_path" width="100" hidden="true"/>
			<aos:column header="文件ID" dataIndex="ct_file_id" width="100" hidden="true"/>
			<aos:column header="文件标题" dataIndex="ct_file_title" width="150" />
			<aos:column header="大小" dataIndex="ct_file_size" width="60" align="center"/>
			<aos:column header="上传人" dataIndex="create_user_name" width="80" align="center"/>
			<aos:column header="上传时间" dataIndex="create_time" width="150" align="center"/>
			<aos:column header="备注" dataIndex="ct_file_remark" width="150" />
		</aos:gridpanel>
		<aos:window id="contract_win">
			<aos:formpanel id="contract_form" width="900" height="380" autoScroll="false"
				layout="column" labelWidth="100" msgTarget="qtip" columnWidth="1" border="true" >
				<aos:fieldset title="合同基本信息" center="true" labelWidth="100">
					<aos:hiddenfield name="ct_id" fieldLabel="合同ID" margin="0 15 0 0"/>
					<aos:textfield name="ct_name" fieldLabel="合同名称" allowBlank="false" maxLength="100" columnWidth=".5" margin="0 15 0 0"/>
					<aos:combobox name="ct_type" dicField="ct_type_code" fieldLabel="合同类型"   columnWidth=".5" margin="0 15 0 0"/>
					<aos:combobox name="ct_properties" dicField="ct_properties_code" fieldLabel="合同性质" value="1" onselect="showCtUser" allowBlank="false" columnWidth=".5" margin="0 15 0 0"/>
					<aos:textfield name="sales_leader" fieldLabel="销售代表"  maxLength="100" columnWidth=".5" margin="0 15 0 0"/>
					<aos:numberfield name="ct_total_amount" fieldLabel="总金额(元)" allowBlank="false" minValue="0" maxValue="9999999999" 
						margin="0 15 0 0" columnWidth=".5"/>
					<aos:combobox fieldLabel="关联项目" name="proj_id"  editable="false" columnWidth="1" multiSelect="true"
	 					url="projCommonsService.listComboBoxUerid&type=all"  margin="0 15 0 0" />
					<aos:textareafield name="ct_remark" fieldLabel="合同描述" allowBlank="true" maxLength="200" columnWidth="1" padding="0 15 0 0" height="70" />
				</aos:fieldset>
				<aos:fieldset  title="合同日期信息" center="true" labelWidth="100">
					<aos:datefield name="ct_sign_date" fieldLabel="合同签订日期"   format="Y-m-d" editable="false" allowBlank="false" columnWidth=".5"
						margin="0 15 0 0" onselect="ct_sign_date_onselect"/>
					<aos:datefield name="ct_begin_date" fieldLabel="合同生效日期"  editable="false" format="Y-m-d" allowBlank="false" columnWidth=".5"
						margin="0 15 0 0" />
					<aos:hiddenfield name="ct_end_date" fieldLabel="合同终止日期"  editable="false" 
						margin="0 15 0 0"  />
				</aos:fieldset>
				<aos:fieldset title="参与方" center="true">
					<aos:textfield name="partya_name" id="id_users" fieldLabel="客户(甲方)" allowBlank="false"  readOnly="true" maxLength="100"
						margin="0 15 0 0" columnWidth=".5"/>
					<aos:textfield name="partyb_name"  fieldLabel="乙方"  maxLength="100" 
						margin="0 15 0 0" columnWidth=".5" />
					<aos:textfield name="partyc_name" fieldLabel="其他相关方"  maxLength="100" 
						margin="0 15 0 0" columnWidth=".5"/>
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="contract_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="contract_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<aos:window id="contractStage_win" title="新增支付阶段">
			<aos:formpanel id="contractStage_form" width="450" layout="anchor" 
				labelWidth="90" msgTarget="qtip">
				<aos:hiddenfield name="stage_id" fieldLabel="合同支付阶段ID" />
				<aos:hiddenfield name="ct_id" fieldLabel="合同ID" allowBlank="true"/>
				<aos:hiddenfield name="proj_id" fieldLabel="项目ID" allowBlank="true"/>
				<aos:hiddenfield name="ct_stage_id" fieldLabel="阶段ID" allowBlank="true"/>
				<aos:textfield name="ct_name" fieldLabel="合同名称" allowBlank="false" readOnly="true"/>
				<aos:hiddenfield name="stage_code" fieldLabel="阶段编码" allowBlank="false" />
				<aos:textfield name="stage_name" fieldLabel="阶段名称" allowBlank="false" maxLength="20" />
				<aos:numberfield name="percentage" fieldLabel="百分比(%)" allowBlank="false" 
					onchange="on_percentage_change" minValue="0" maxValue="100"/>
				<aos:numberfield name="rece_amount" fieldLabel="应收金额(元)" readOnly="true"  allowBlank="false" minValue="0" maxValue="99999999"/>
				<aos:hiddenfield name="pay_amount" fieldLabel="实收金额" allowBlank="true" />
				<aos:textfield name="stage_remark" fieldLabel="备注"  maxLength="200"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="contractStage_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="contractStage_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
			<%-- 上传窗口 --%>
			<aos:window id="excel_win" title="上传文件">
				<aos:formpanel id="excel_win_form" width="450" layout="column" labelWidth="60">
						
					<aos:filefield id="excel_file" name = "excel_file" fieldLabel="文件路径" buttonText="选择" labelWidth="60" allowBlank="false" columnWidth="0.99"/>
					<aos:textfield name="ct_file_remark" fieldLabel="备注" columnWidth="0.99"/>
					<aos:hiddenfield name="ct_id" fieldLabel="合同id"/>
					
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="excel_win_save" text="上传" icon="ok.png" />
					<aos:dockeditem onclick="excel_win.hide();" text="关闭" icon="close.png" />
				</aos:docked>
			</aos:window>
			<%--作废窗口 --%>
			<aos:window id="reason_win" title="作废窗口">
				<aos:formpanel id="reason_win_form" width="450" msgTarget="qtip" layout="column" labelWidth="60">
					<aos:textareafield name="reason" fieldLabel="作废原因" allowBlank="false" columnWidth="0.99" height="100"/>
					<aos:hiddenfield name="ct_id" fieldLabel="合同id"/>
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="reason_win_save" text="保存" icon="ok.png" />
					<aos:dockeditem onclick="reason_win.hide();" text="关闭" icon="close.png" />
				</aos:docked>
			</aos:window>
		<script type="text/javascript">
		//合同状态渲染
		function fn_ct_state(value, metaData, record){
			if(value == 2){
				return "<span style='color:green; font-weight:bold'>执行中</span>"; 
			}else if(value == 1){
				return "<span style='color:blue; font-weight:bold'>未启用</span>"; 
			}else if(value == 0){
				return "<span style='color:red; font-weight:bold'>已作废</span>"; 
			}else if(value == 3){
				return "<span style='color:green; font-weight:bold'>执行完成</span>"; 
			}else if(value == 4){
				return "<span style='color:red; font-weight:bold'>暂停</span>"; 
			}
		}
		//改变合同信息改变相应的参与方
		function showCtUser(){
			var ct_properties=contract_form.down('combobox[name=ct_properties]').getValue();
			var partya_name=contract_form.down('textfield[name=partya_name]');
			var partyb_name=contract_form.down('textfield[name=partyb_name]');
			if(ct_properties=='1'){
				partya_name.setValue("湖南贝加科技有限公司");
				partyb_name.setValue('');
				AOS.reads(contract_form,'partya_name');
			}else if(ct_properties=='2'){
				partyb_name.setValue("湖南贝加科技有限公司");
				partya_name.setValue('');
				partya_name.setReadOnly(false);
				AOS.reads(contract_form,'partyb_name');
			}else{
				AOS.edits(contract_form,'partyb_name,partya_name');
				partya_name.setValue('');
			}
		}
		//合同阶段新增form应收金额显示
		function on_percentage_change (value){
			var ct_total_amount = AOS.select(contract_grid)[0].data.ct_total_amount;
			var ct_id = AOS.selection(contract_grid, 'ct_id');
			var ct_stage_id = AOS.selection(contractStage_grid, 'ct_stage_id');
			var percentage=	contractStage_form.down('numberfield[name=percentage]').getValue();
			AOS.ajax({
				url : 'contractService.queryOtherPercent',
						params:{
						ct_id:ct_id,
						percentage:percentage,
						ct_stage_id:ct_stage_id
						},
				ok : function(data) {
					 if(data.appmsg =='总百分比不能超过百分之百'){
					     	AOS.tip(data.appmsg);
					     	contractStage_form.down('numberfield[name=percentage]').setValue('');
					     	contractStage_form.down('numberfield[name=rece_amount]').setValue('');
							 return;
					}else if(data.rece_amount>0){
						AOS.setValue('contractStage_form.rece_amount',data.rece_amount);
						return;
					}
						var rece_amount=ct_total_amount*value.value*0.01;
						AOS.setValue('contractStage_form.rece_amount',rece_amount);
					
				}
			});
			value.focus();
		}
		//启用
		function contract_enable(){
		var selection = AOS.selection(contract_grid, 'ct_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要启用的数据。');
			return;
		}
		var grid = AOS.select(contract_grid);
		var state = grid[0].data.state;
		
		if(state != 1 && state !=4){
			AOS.tip('当前状态下不能进行启用操作。');
			return;
		}
		var records = AOS.get('contractStage_grid').getStore().getRange();
		var percentage = 0;
		for ( var int = 0; int < records.length; int++) {
			percentage +=  records[int].data.percentage;
		}
		if(percentage != 100){
			AOS.tip('支付阶段信息未录入完整，不能进行启用操作。');
			return;
		}
		var selection_state = AOS.selection(contract_grid, 'state');
		var rows = AOS.rows(contract_grid);
		var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'contractService.enable',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					contract_grid_store.reload();
				}
			});
		});
		
		}
		
		//暂停
		function contract_stop(){
		var selection = AOS.selection(contract_grid, 'ct_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要暂停的数据。');
			return;
		}
		var grid = AOS.select(contract_grid);
		var state = grid[0].data.state;
		if(state != 2){
			AOS.tip('当前状态下不能进行暂停操作!。');
			return;
		}
		var selection_state = AOS.selection(contract_grid, 'state');
		var rows = AOS.rows(contract_grid);
		var msg =  AOS.merge('确认要暂停选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'contractService.stop',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					contract_grid_store.reload();
				}
			});
		});
		
		}
		//作废
		function contract_disable(){
		var selection = AOS.selection(contract_grid, 'ct_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要作废的数据。');
			return;
		}
		var grid = AOS.select(contract_grid);
		var state = grid[0].data.state;
		 if(state != 2 && state != 4){
			AOS.tip('当前状态下不能进行作废操作!。');
			return;
		} 
		AOS.reset(reason_win_form);
		AOS.setValue('reason_win_form.ct_id',grid[0].data.ct_id);
		reason_win_form.type = 'update';
		reason_win.show();
		
		}
		//显示新增或修改窗口
		function contract_win_show(type){
			contract_form.type=type;
			if(type=="create"){
				AOS.reset(contract_form);
				contract_win.setTitle("新增合同信息");
				AOS.edits(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				AOS.get('id_users').setValue("湖南贝加科技有限公司");
				AOS.reads(contract_form,'partya_name');
				contract_win.show();
			}else{
				AOS.reset(contract_form);
				var record = AOS.selectone(contract_grid, true);
				if(AOS.empty(record)){
					AOS.tip('请选择要修改的记录。');
					return;
				}
				if(record.data.state == 3){
					AOS.reads(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				}else if(record.data.state == 2){
					AOS.reads(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				}else if(record.data.state == 0){
					AOS.reads(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				}else if(record.data.state == 1){
					AOS.edits(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				}else if(record.data.state == 4){
					AOS.reads(contract_form,'ct_name,ct_type,ct_total_amount,proj_id,ct_remark,ct_sign_date,ct_begin_date,ct_end_date,partya_name,partyb_name,partyc_name,ct_properties,sales_leader');
				}
				contract_win.setTitle("修改合同信息");
				contract_form.loadRecord(record);
				contract_win.show();
				var proj_ids = record.raw.proj_ids;
				if(!AOS.empty(proj_ids)){
					var projIds = proj_ids.split(",");
					for(var i=0;i<projIds.length;i++){
						projIds[i]=Number(projIds[i]);
					}
					AOS.setValue('contract_form.proj_id',projIds);
				}
			}
		}
		
		//项目合同开始时间change事件
		function ct_sign_date_onselect(){
			var value=contract_form.down('datefield[name=ct_sign_date]').getValue();
			if(AOS.empty(value)){
					return;
				}
			contract_form.down('datefield[name=ct_begin_date]').setMinValue(value);
		}
		//金额渲染
		function fn_money(value, metaData, data) {
			/* if(value>=10000){
				return Ext.util.Format.number(value/10000,'0,000.00')+'  (万)';
			} */ 
			return Ext.util.Format.number(value,'0,000.00');
		}
		//项目合同开始时间change事件
		function ct_begin_date_onselect(v){
			if(AOS.empty(v.rawValue)){
					return;
				}
			contract_form.down('datefield[name=ct_end_date]').setMinValue(v.rawValue);
		}
				
		//查询
		function contract_query() {
			var params = AOS.getValue('query_form');
		    contract_grid_store.getProxy().extraParams = params;
		    contract_grid_store.loadPage(1,{ 
		    	callback: function(records, operation, success) {
        			AOS.get('contract_grid').getSelectionModel().select(0);
        			on_item_contract_grid();
    		}});
		    
		}
		//合同grid行单击事件
		function on_item_contract_grid(){
			contractStage_query();
			contractFile_query();
		}
		//新增
		function contract_form_save() {
			AOS.ajax({
				forms : contract_form,
				url : contract_form.type=='create' ? 'contractService.create':'contractService.update',
				ok : function(data) {
					AOS.tip(data.appmsg);
					var record = AOS.select(contract_grid,true)[0];
					contract_grid_store.reload({
							callback : function(records, operation, success) {
								contract_grid.getSelectionModel().select(contract_form.type=="update" ? record.index:0);
							}
						}); 
					contract_win.hide();
				}
			});
		}
		//删除
		function contract_delete(){
			var records = AOS.select(contract_grid);
			if(AOS.empty(records)){
				AOS.tip('请选择需要删除的数据。');
				return;
			};
			if(records[0].data.state != 1 ){
				AOS.tip('当前状态下不能进行删除操作。');
				return;
			}else if(records[0].data.state == 0 || records[0].data.state == 1){
				var msg =  AOS.merge('确认要删除选中的1条记录吗？');
				AOS.confirm(msg, function(btn){
					if(btn === 'cancel'){
						return;
					}
					AOS.ajax({
						url : 'contractService.delete',
						params:{
							ct_id: records[0].data.ct_id
						},
						ok : function(data) {
							AOS.tip(data.appmsg);
							contract_grid_store.reload();
						}
					});
				});
			}
		}
		
	//作废
	function reason_win_save(){
		// 表单验证
        if (!AOS.get("reason_win_form.reason").isValid()) {
            Ext.log('表单合法性校验未通过，Ajax请求取消。如果这和您的预期不符，请检查调用AOS.ajax()时是否多传或错传了forms参数。');
			return;
        }
		AOS.confirm("是否继续作废该合同。", function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
				forms : reason_win_form,
				url :  'contractService.reason',
				ok : function(data) {
					AOS.tip(data.appmsg);
					var record = AOS.select(contract_grid,true)[0];
					contract_grid_store.reload({
							callback : function(records, operation, success) {
								contract_grid.getSelectionModel().select(reason_win_form.type=="update" ? record.index:0);
							}
						}); 
					reason_win.hide();
				}
			});
			}
		)
	}
	//点击事件
	function projContract_grid_click(me, record){
		var selection = AOS.selection(projContract_grid, 'ct_id');
		if(AOS.empty(selection)){
			return;
		}
		contractStage_query(selection);
		projContract_formpanel.loadRecord(AOS.selectone(projContract_grid, true));
	}
	//项目合同开始时间change事件
	function cp_bengin_date_onselect(v){
		if(AOS.empty(v.rawValue)){
				return;
			}
		projContract_create_form.down('datefield[name=cp_end_date]').setMinValue(v.rawValue);
	}
	
	
	//显示阶段新增或修改窗口
	function contractStage_win_show(type){
		var record = AOS.selectone(contract_grid);
		if(record.data.state == 2 || record.data.state == 3){
			AOS.tip('当前合同状态，不可操作。');
			return;
		}
		contractStage_form.type = type;
		var total_moeny = AOS.selectone(contract_grid).data.ct_total_amount;
		var records = AOS.get('contractStage_grid').getStore().getRange();
		var rece_amount = 0;
		var min_percentage = 100;
		for ( var int = 0; int < records.length; int++) {
			rece_amount += records[int].data.rece_amount;
			min_percentage -=  records[int].data.percentage;
		}
		var min_money = total_moeny-rece_amount;
		/* contractStage_form.down('numberfield[name=rece_amount]').setMaxValue(min_money);
		contractStage_form.down('numberfield[name=percentage]').setMaxValue(min_percentage); */
		if(type=="create"){
			var records = AOS.select(contract_grid);
			if(records.length != 1 ){
				AOS.tip('请选择一条合同信息添加数据。');
				return;   
			}
			AOS.reset(contractStage_form);
			AOS.setValue('contractStage_form.ct_name',records[0].data.ct_name);
			AOS.setValue('contractStage_form.ct_id',records[0].data.ct_id);
			var ct_id=records[0].data.ct_id;
			var percentage=	contractStage_form.down('numberfield[name=percentage]').getValue();
			AOS.ajax({
				url : 'contractService.queryCreatePercent',
						params:{
						ct_id:ct_id,
						percentage:percentage
						},
				ok : function(data) {
					 if(data.appmsg =='总百分比已达到百分之百'){
					     	AOS.tip(data.appmsg);
							 return;
					}else{
						AOS.setValue('contractStage_form.percentage',data.percentage);
						contractStage_win.setTitle("新增支付阶段");
						contractStage_win.show();
					}
				}
			});
			
		}else{
			AOS.reset(contractStage_form);
			var records = AOS.select(contract_grid);
			AOS.setValue('contractStage_form.ct_name',records[0].data.ct_name);
			var record = AOS.selectone(contractStage_grid, true);
			if(AOS.empty(record)){
				AOS.tip('请选择一条需要修改的数据。');
				return;
			}
			contractStage_form.loadRecord(record);
			contractStage_win.setTitle("修改支付阶段");
			contractStage_win.show();
		}
	}
	
	//查询
	function contractStage_query() {
		var params = AOS.select(contract_grid)[0].data;
	    contractStage_grid_store.getProxy().extraParams = {
	    	ct_id:params.ct_id
	    };
	    contractStage_grid_store.loadPage(1);
	}
	//新增
	function contractStage_form_save() {
		AOS.ajax({
			forms : contractStage_form,
			url : contractStage_form.type == 'create' ? 'contractStageService.create':'contractStageService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				contractStage_grid_store.reload();
				contractStage_win.hide();
			}
		});
	}
	//删除
	function contractStage_delete(){
		var record = AOS.selectone(contract_grid);
		if(record.data.state == 2 || record.data.state == 3){
			AOS.tip('当前合同状态，不可操作。');
			return;
		}
		var selection = AOS.selection(contractStage_grid, 'ct_stage_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
		var rows = AOS.rows(contractStage_grid);
		var msg =  AOS.merge('确认要删除选中的{0}条记录吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'contractStageService.delete',
				params:{
					aos_rows: selection
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					contractStage_grid_store.reload();
				}
			});
		});
	}
	
	//查询
	function contractFile_query(){
		var params = AOS.select(contract_grid)[0].data;
	    contractFile_grid_store.getProxy().extraParams = {
	    	ct_id:params.ct_id
	    };
	    contractFile_grid_store.loadPage(1);
	}
	//下载
	function g_acount_down(){
		var selection = AOS.selection(contractFile_grid, 'file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要下载的文件!');
			return;
		}
		var rows = AOS.rows(contractFile_grid);
		if(rows > 1){
			AOS.tip('请只选择一条需要下载的文件!');
		return;
		}
		var ct_file_path = AOS.selection(contractFile_grid, 'ct_file_path');
		var ct_file_title = AOS.selection(contractFile_grid, 'ct_file_title');
		var ct_file_id = AOS.selection(contractFile_grid, 'ct_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择要下载的文件!');
			return;
		}
		console.log(ct_file_path+"  "+ct_file_title+"  "+ct_file_id)
		AOS.file('do.jhtml?router=contractFileService.downloadFile&juid=${juid}&ct_file_path='+ct_file_path+'&ct_file_title='+ct_file_title+'&ct_file_id='+ct_file_id);
	}
	
	//批量压缩下载
	function g_zip_down(){
		var record = AOS.select(contract_grid,true)[0];
       	var ct_name = record.data.ct_name;
		var selection = AOS.selection(contractFile_grid, 'ct_file_id');
		if(AOS.empty(selection)){
			AOS.tip('请选择需要批量打包下载的文件!');
			return;
		}
		
		var rows = AOS.rows(contractFile_grid);
		var msg =  AOS.merge('确认要批量打包下载选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.file('do.jhtml?router=contractFileService.downloadFileByZip&juid=${juid}&ct_name='+ct_name+'&aos_rows='+selection);
		});
		
	}
	
	//删除
	function contractFile_delete(){
		var record = AOS.selectone(contract_grid);
		
		var proj_ids = record.raw.proj_ids;
		if(!AOS.empty(proj_ids)){
			var projIds = proj_ids.split(",");
			for(var i=0;i<projIds.length;i++){
				projIds[i]=Number(projIds[i]);
			}
		}
		/* if(record.data.state == 2 || record.data.state == 3){
			AOS.tip('当前合同状态，不可做删除操作。');
			return;
		} */
		var selection = AOS.selection(contractFile_grid, 'ct_file_id');
		var recordFile= AOS.selectone(contractFile_grid);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据。');
			return;
		}
		var rows = AOS.rows(contractFile_grid);
		var msg =  AOS.merge('确认要删除选中的{0}条记录吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'contractFileService.delete',
				params:{
					aos_rows: selection,
					proj_id:proj_ids,
					create_user_id:recordFile.raw.create_user_id
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					contractFile_grid_store.reload();
				}
			});
		});
	}
	
	//显示上传文件窗口
	function show_excel_win(){
		var records = AOS.select(contract_grid);
		if(records.length != 1 ){
			AOS.tip('请选择一条合同信息上传文件。');
			return;   
		}
		AOS.reset(excel_win_form);
		AOS.setValue('excel_win_form.ct_id',records[0].data.ct_id);
		excel_win.show();
	}
	
	//上传保存
	function excel_win_save(){
		var params = AOS.getValue('excel_win_form');
		
		   var filenPath = AOS.getValue('excel_win_form.excel_file');
		    fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
		    if (fileExtension != ".xls" && fileExtension != ".xlsx" && fileExtension != ".doc" && fileExtension != ".docx" && fileExtension != ".pdf" && fileExtension != ".rar"&& fileExtension != ".zip")
		     {
					AOS.tip('选择的文件必须是doc，docx、xls、xlsx、pdf、rar、zip格式的');
					return;
		    }
		    excel_win_form.getForm().fileUpload = true;
		    excel_win_form.getForm().submit({
		    		type : 'POST', 
					url:'do.jhtml?router=contractService.importFile&juid=${juid}',
					waitMsg:'文件上传中...',
					success: function(form, action) {
							AOS.tip(action.result.msg);
							excel_win.hide(); 
							contractFile_grid_store.reload();
			    	},
					 failure: function() {
						 	excel_win.hide();
							AOS.tip("文件上传失败！");
					 },
					 params : params
			 });
	}
		</script>
	</aos:viewport>
</aos:onready>