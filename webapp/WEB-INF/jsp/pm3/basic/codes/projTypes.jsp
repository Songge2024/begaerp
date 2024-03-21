<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="../../public/public_method.jsp"%>
<%@page import="aos.system.common.model.UserModel"%>
<aos:html title="项目类型维护" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel enableColumnHide="true" id="projTypes_grid"  url="projTypesService.page" onrender="projTypes_query" region="center" onitemdblclick="projTypes_uwin_show">
			<aos:docked forceBoder="0 0 1 0">
	              <aos:dockeditem xtype="tbseparator" />
	              <aos:dockeditem text="新增" icon="add.png"  		
	              onclick="projTypes_win_show" />
	              <aos:dockeditem text="修改" icon="edit.png" 		
	               onclick="projTypes_uwin_show" />
	              <aos:dockeditem text="删除" icon="del.png"   
	              onclick="projTypes_delete" />
	              <aos:dockeditem text="停用" onclick="projTypes_upstate" icon="stop.gif" />
	              <aos:dockeditem text="启用" onclick="projTypes_submit" icon="go.gif" />
	              <aos:dockeditem xtype="tbtext" text="类型名称:" />
	              <aos:triggerfield emptyText="类型名称" id="type_name_query" onenterkey="projTypes_query" trigger1Cls="x-form-search-trigger"
					onTrigger1Click="projTypes_query" width="180" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增" onclick="projTypes_win_show" icon="add.png" />
	            <aos:menuitem text="修改" onclick="projTypes_win_show" icon="edit.png" />
				<aos:menuitem text="删除" onclick="projTypes_delete" icon="del.png" />
				 <aos:menuitem text="停用" onclick="projTypes_upstate" icon="stop.gif" />
				  <aos:menuitem text="启用" onclick="projTypes_submit" icon="go.gif" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="#projTypes_grid_store.reload();" icon="refresh.png" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
	<aos:column header="类型code" dataIndex="type_code" fixedWidth="70" align="center" />
	<aos:column header="类型名称" dataIndex="type_name" fixedWidth="200"/>
	<aos:column header="类型描述" dataIndex="type_desc"/>
	<aos:column header="开发模型" dataIndex="model" fixedWidth="200" hidden="true"/>
	<aos:column header="开发模型" dataIndex="dic_desc" fixedWidth="120"/>
	<aos:column header="状态" dataIndex="state"  fixedWidth="120" hidden="true"/>
	<aos:column header="状态" dataIndex="state_name" align="center" rendererFn="fn_balance_render" fixedWidth="100" />
	<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="100" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_name" fixedWidth="100" hidden="true" />
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="180" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" hidden="true" />
	<aos:column header="更新人" dataIndex="update_user_name" fixedWidth="100"  hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="180" hidden="true"/>
	<aos:column header="修改" rendererFn="fn_button_render" align="center" fixedWidth="100" hidden="true"/>
	<aos:column header="删除" rendererFn="fn_button_del" align="center" fixedWidth="100" hidden="true"/>
		</aos:gridpanel>
	</aos:viewport>

	<aos:window id="projTypes_create_win"  title="新增项目类型" >
		<aos:formpanel id="projTypes_create_form" width="400" layout="column" labelWidth="65" msgTarget="qtip">
		<aos:hiddenfield name="type_code" fieldLabel="类型CODE" />
	<aos:textfield name="type_name" fieldLabel="类型名称" allowBlank="false" maxLength="150" columnWidth=".5"/>
	<aos:combobox name="model" fieldLabel="开发模型" dicField="pro_module" emptyText="开发模型"  columnWidth=".5" width="180" allowBlank="false" />
	<aos:hiddenfield name="state" fieldLabel="状态" value="0"/>
	<aos:fieldset title="类型描述" >
			<aos:htmleditor name="type_desc"  allowBlank="true"
			columnWidth="1" padding="5 5 5 5" />
		   </aos:fieldset>
	</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="projTypes_create"  text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#projTypes_create_win.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	<aos:window id="projTypes_update_win" title="修改项目类型"  onshow="projTypes_uwin_show">
		<aos:formpanel id="projTypes_update_form" width="400" layout="column" labelWidth="65" msgTarget="qtip">
			<aos:hiddenfield name="type_code" fieldLabel="类型CODE" />
	<aos:textfield name="type_name" fieldLabel="类型名称" allowBlank="false" columnWidth=".5" maxLength="150"/>
	<aos:combobox id="model" name="model" fieldLabel="开发模型" columnWidth=".5" dicField="pro_module" emptyText="开发模型"   width="180" allowBlank="false" />
	<aos:fieldset title="类型描述" >
			<aos:htmleditor name="type_desc"  allowBlank="true"
			columnWidth="1" padding="5 5 5 5" />
		   </aos:fieldset>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="projTypes_update" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#projTypes_update_win.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>

	<script type="text/javascript">
	//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
	//显示修改窗口
	function projTypes_uwin_show(){
		AOS.reset(projTypes_update_form);
		var selection = AOS.selection(projTypes_grid, 'type_code');
		var rows = AOS.rows(projTypes_grid);
		if(AOS.empty(selection)||rows>1){
			AOS.tip('请选择一条需要修改的数据');
			return;
		}
		var record = AOS.selectone(projTypes_grid);
		projTypes_update_form.loadRecord(record);
		var model=record.data.model;
		AOS.setValue('projTypes_update_form.model',model);
		projTypes_update_win.show();
}
	//显示新增窗口
	function projTypes_win_show(){
			AOS.reset(projTypes_create_form);
			projTypes_create_win.show();
	}
	//查询
	function projTypes_query() {
	    var params = {
				type_name: type_name_query.getValue()
		};
		projTypes_grid_store.getProxy().extraParams = params;
		projTypes_grid_store.loadPage(1);
	}
	//新增
	function projTypes_create() {
		AOS.ajax({
			forms : projTypes_create_form,
			url : 'projTypesService.create',
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTypes_grid_store.reload();
				projTypes_create_win.hide();
			}
		});
	}
	function projTypes_upstate(){
		var selection = AOS.selection(projTypes_grid, 'type_code');
		var rows = AOS.rows(projTypes_grid);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要停用的数据！');
			return;
		}
		var rows = AOS.rows(projTypes_grid);
		var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
		AOS.ajax({
			url : 'projTypesService.updateProjTypeState',
			params:{
				aos_rows: selection,
				state:"0"
			},
			ok : function(data) {
				AOS.tip("已停用");
				projTypes_grid_store.reload();
				}
			});
		});
	}
	//启用
	function projTypes_submit(){
		var selection = AOS.selection(projTypes_grid, 'type_code');
		var rows = AOS.rows(projTypes_grid);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要启用的数据！');
			return;
		}
		var rows = AOS.rows(projTypes_grid);
		var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
		AOS.ajax({
			url : 'projTypesService.updateProjTypeState',
			params:{
				aos_rows: selection,
				state:"1"
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTypes_grid_store.reload();
			}
		});
		});
	}
	//修改
	function projTypes_update() {
		AOS.ajax({
			forms : projTypes_update_form,
			url : 'projTypesService.update',
			ok : function(data) {
				AOS.tip(data.appmsg);
				projTypes_grid_store.reload();
				projTypes_update_win.hide();
			}
		});
	}
	//删除
	function projTypes_delete(){
		var selection = AOS.selection(projTypes_grid, 'type_code');
		var rows = AOS.rows(projTypes_grid);
		if(AOS.empty(selection)){
			AOS.tip('请选择需要删除的数据！');
			return;
		}
		var rows = AOS.rows(projTypes_grid);
		var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				return;
			}
			AOS.ajax({
				url : 'projTypesService.delete',
				params:{
					aos_rows: selection,
					state:"-1"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					projTypes_grid_store.reload();
				}
			});
		});
	}
	//按钮列转换
	function fn_button_render(value, metaData, record) {
		return '<input type="button" value="修改" class="cbtn"  onclick="proj_update_show();" />';
	}
	
	//按钮列转换
	function fn_button_del(value, metaData, record) {
		return '<input type="button" value="删除" class="cbtn" onclick="fn_del();" />';
	}
	
	</script>
</aos:onready>
<script type="text/javascript">
function proj_update_show(){
	var record = AOS.selectone(AOS.get('projTypes_grid'));
	if(record.data.state=="1"){
		AOS.tip('无法修改已启用的记录,请重新选择!');
		return;
	}
	AOS.get('projTypes_update_win').show();
}
function fn_del(){
	//由于是列按钮对应的函数，下面获取对象的的写法和onready代码段里的js有些不同
	var record = AOS.selectone(AOS.get('projTypes_grid'));
	if(record.data.state=="1"){
		AOS.tip('无法删除已启用的记录,请重新选择!');
		return;
	}
	var msg =  AOS.merge('确认要该项目类型【{0}】吗？', record.data.type_name);
	AOS.confirm(msg, function(btn){
		if(btn === 'cancel'){
			return;
		}
		AOS.ajax({
			url : 'projTypesService.delProjInfo',
			params:{
				type_code: record.data.type_code
			},
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('projTypes_grid').getStore().reload();
			}
		});
	});
}
</script>
