<!-- 系统功能模块维护 -->
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ include file="../../public/public_method.jsp"%>
<%@page import="aos.system.common.model.UserModel"%>
<aos:html title="系统功能模块管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
			<!-- 把treepanel属性rootExpanded="false"，则tree不会自动加载数据，需要调用这个api实现灵活的数据加载控制 -->
			<aos:treepanel id="t_module" region="west" bodyBorder="0 1 0 0" width="300" rootText="系统功能模块"
 				singleClick="false" url="moduleDivideService.getTreeData" nodeParam="dm_parent_code" rootId="1" rootExpanded="false"
 			 	onitemclick="g_module_query" >
				<aos:docked>
					<aos:dockeditem xtype="tbtext" text="选择项目:" />
					<aos:triggerfield  id="tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="proj_tree_show" width="170" />
						<aos:hiddenfield id="id_proj_name" name="id_proj_name"/>
						<%-- <aos:dockeditem xtype="button" text="导入" onclick="fn_import_excel" icon="up.png" margin="0 0 0 0"/> --%>
				</aos:docked>
				<aos:window id="importExcle_win" title="导入系统功能模块">
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
				<aos:docked >
					<aos:dockeditem xtype="tbtext" text="功能模块树" />
					<aos:dockeditem xtype="tbfill" />
				</aos:docked>
				<aos:menu>
					<aos:menuitem text="新增模块" onclick="w_module_show" icon="add.png" />
					<aos:menuitem xtype="menuseparator" />
					<aos:menuitem text="刷新" onclick="t_module_refresh" icon="refresh.png" />
				</aos:menu>
		</aos:treepanel>
		<aos:gridpanel id="g_module" url="moduleDivideService.listModules" region="center" onitemdblclick="w_module_u_show">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem text="新增" onclick="w_module_show" icon="add.png" />
				<aos:dockeditem text="修改" onclick="w_module_u_show" icon="edit.png" />
				<aos:dockeditem text="删除" onclick="g_module_del" icon="del.png" />
				<aos:dockeditem text="停用" onclick="g_module_upstate" icon="stop.gif" />
				<aos:dockeditem text="启用" onclick="g_module_submit" icon="go.gif" />
				<aos:dockeditem text="统一保存" onclick="g_module_save" icon="save.png" />
				<aos:dockeditem text="全部导出" onclick="exportAll" icon="icon70.png" />
				<aos:dockeditem text="模块复制" onclick="copy_proj" icon="copy.png"/>
				
				<aos:dockeditem xtype="tbfill" />
				<aos:triggerfield emptyText="模块名称/项目名称" id="id_name" onenterkey="g_module_query" trigger1Cls="x-form-search-trigger"
				onTrigger1Click="g_module_query" width="180" /> 
			</aos:docked>
			<aos:menu>
				<aos:menuitem text="新增" onclick="w_module_show" icon="add.png" />
				<aos:menuitem text="修改" onclick="w_module_u_show" icon="edit.png" />
				<aos:menuitem text="删除" onclick="g_module_del" icon="del.png" />
				<aos:menuitem text="停用" onclick="g_module_upstate" icon="stop.gif" />
				<aos:menuitem text="启用" onclick="g_module_submit" icon="go.gif" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="#g_module_store.reload();" icon="refresh.png" />
			</aos:menu>
			<aos:plugins>
				<aos:editing id="id_plugin" clicksToEdit="1" ptype="cellediting" />
			</aos:plugins>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
			<aos:column header="项目id" dataIndex="proj_id" fixedWidth="120" hidden="true" />
			<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="200" />
			<aos:column header="状态" dataIndex="state_name" align="center" rendererFn="fn_balance_render" fixedWidth="100"  />
			<aos:column header="测试用例code" dataIndex="test_code" fixedWidth="200" hidden="true"/>
			<aos:column header="功能模块id" dataIndex="dm_code" fixedWidth="150" hidden="true" />
			<aos:column header="模块名称" dataIndex="dm_name" fixedWidth="150" />
			<aos:column header="父节点" dataIndex="dm_parent_code" fixedWidth="150" hidden="true" />
			<aos:column header="是否子节点" dataIndex="dm_is_leaf" fixedWidth="150" hidden="true" />
			<aos:column header="排序号" dataIndex="dm_sort_no" align="center" fixedWidth="80" />
			<aos:column header="开发负责人" dataIndex="coding_user_name" fixedWidth="120"  celltip="true" align="center"/>
			<aos:column header="开发完成百分比" dataIndex="coding_complete" fixedWidth="120" celltip="true" align="center" rendererFn="render_percent">
				<aos:textfield />
			</aos:column>
			<aos:column header="测试负责人" dataIndex="test_user_name" fixedWidth="120" celltip="true" align="center"/>
			<aos:column header="测试完成百分比" dataIndex="test_complete" fixedWidth="120" celltip="true" align="center" rendererFn="render_percent">
				<aos:textfield />
			</aos:column>
			<aos:column header="备注" dataIndex="remarks" fixedWidth="200" celltip="true">
				<aos:textfield />
			</aos:column>
			<aos:column header="描述" dataIndex="dm_remark"  fixedWidth="300" />
			<aos:column header="新增人" dataIndex="create_user_id"  fixedWidth="90" hidden="true" />
			<aos:column header="新增人" dataIndex="create_user_name" fixedWidth="100" hidden="true"  />
			<aos:column header="新增时间" dataIndex="create_time"  fixedWidth="150" hidden="true"  />
			<aos:column header="修改人" dataIndex="update_user_id"  fixedWidth="90" hidden="true" />
			<aos:column header="修改人" dataIndex="update_user_name"  fixedWidth="100" hidden="true" />
			<aos:column header="修改时间" dataIndex="update_time"  fixedWidth="150" hidden="true" />
			<aos:column header="状态" dataIndex="state"  fixedWidth="150" hidden="true" />
		
		</aos:gridpanel>
	</aos:viewport>
	<aos:window id="w_module" title="新增功能模块" >
		<aos:formpanel id="f_module" width="900" layout="column" labelWidth="65" msgTarget="qtip">
		<aos:hiddenfield name="proj_id" fieldLabel="项目id" />
		<aos:textfield  fieldLabel="项目名称" name="proj_name"  readOnly="true" allowBlank="false" columnWidth=".5"/>
		<aos:hiddenfield name="dm_parent_code" fieldLabel="上级模块流水号" />
		<aos:textfield name="dm_parent_name" fieldLabel="上级模块" readOnly="true" allowBlank="false" columnWidth=".5"/>
		<aos:textfield name="dm_name" fieldLabel="模块名称"   maxLength="50" allowBlank="false" columnWidth=".5"/>
		<aos:textfield name="test_code" fieldLabel="测试编码"   maxLength="50"  allowBlank="false" columnWidth=".5"/>
		<aos:numberfield name="dm_sort_no" fieldLabel="排序号" minValue="0"    minWidth="0" columnWidth=".5" maxValue="99999999" />
		<aos:hiddenfield name="state" fieldLabel="状态" value="0"/>
		<aos:fieldset title="描述" >
			<aos:htmleditor name="dm_remark"  allowBlank="true"  height="100"
			columnWidth="1" padding="5 5 5 5" />
		</aos:fieldset>
		<aos:fieldset title="备注"  >
			<aos:htmleditor name="remarks"  allowBlank="true"  height="100"
			columnWidth="1" padding="5 5 5 5" />
		</aos:fieldset>
		
		
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer" >
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="f_module_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#w_module.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	<aos:window id="w_module_u" title="修改功能模块" >
		<aos:formpanel id="f_module_u" width="900" layout="column" labelWidth="65" msgTarget="qtip">
			<aos:hiddenfield name="dm_code" fieldLabel="模块流水号" />
			<aos:hiddenfield name="dm_parent_code" fieldLabel="上级模块模块流水号" />
			<aos:hiddenfield id="proj_id" name="proj_id" fieldLabel="项目id" />
			<aos:textfield id="proj_name" fieldLabel="项目名称" allowBlank="false" name="proj_name"  readOnly="true" columnWidth=".5"/>
			<aos:textfield name="dm_name" fieldLabel="模块名称"   allowBlank="false" maxLength="50" columnWidth=".5"/>
			<aos:textfield name="test_code" fieldLabel="测试编码"  allowBlank="false"  maxLength="50"  columnWidth=".5"/>
			<aos:numberfield name="dm_sort_no" fieldLabel="排序号" minValue="0"  minWidth="0" maxValue="99999999" columnWidth=".5"/>
			<aos:fieldset title="描述" >
			<aos:htmleditor name="dm_remark"  allowBlank="true" columnWidth="1" padding="5 5 5 5" />
		   </aos:fieldset>
		<aos:fieldset title="备注"  >
			<aos:htmleditor name="remarks"  allowBlank="true"  height="100"
			columnWidth="1" padding="5 5 5 5" />
		</aos:fieldset>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="f_module_u_update" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#w_module_u.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	
	<aos:window id="copy_win" title="项目模块复制" height="-30" width="800">
		<aos:gridpanel id="copy_form" autoScroll="true"  forceFit="false"  width="300" height="-30"  url="moduleDivideService.copyListModules" 
				border="true" hidePagebar="true">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext"  />
				<aos:triggerfield fieldLabel="选择项目" id="copy_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="copy_proj_tree_show" columnWidth="0.99" />
				<aos:hiddenfield id="copy_id_proj_name" name="id_proj_name"/>
			</aos:docked>
		    <aos:selmodel type="checkbox" mode="multi" />
		    <aos:column type="rowno" header="序号" align="center" fixedWidth="60"/>
			<aos:column header="语义id" dataIndex="dm_id"  hidden="true"/>
			<aos:column header="模块名称" dataIndex="dm_name" align="center" fixedWidth="300"/>
			<aos:column header="功能模块ID" dataIndex="dm_code" fixedWidth="200"/>
			<aos:column header="父节点" dataIndex="dm_parent_code"  fixedWidth="200"/>
			<aos:column header="项目ID" dataIndex="proj_id"  hidden="true"/>
		</aos:gridpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="copy_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#copy_win.hide();" text="关闭"
				icon="close.png" />
		</aos:docked>
	</aos:window> 
	
	<%-- <aos:window id="copy_win" title="项目模块复制">
		<aos:formpanel id="copy_form" width="450" layout="anchor"
			labelWidth="70">
			<aos:triggerfield fieldLabel="选择项目" id="copy_tree_proj_name" name="tree_proj_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="copy_proj_tree_show" columnWidth="0.99" />
			<aos:hiddenfield id="copy_id_proj_name" name="id_proj_name"/>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="copy_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#copy_win.hide();" text="关闭"
				icon="close.png" />
		</aos:docked>
	</aos:window> --%>
	
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" layout="fit"   width="300" autoScroll="true" >
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false" bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	
	<aos:window id="copyw_org_find" title="项目树[单击选择]" height="-60" width="320" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="copy_proj_name" onenterkey="copy_proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="copy_proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="copyt_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="copy_org_find_select" />
	</aos:window>

	<script type="text/javascript">
	//完成百分比
	function render_percent(value){
		if(value)return value+"%";
		return "0%";
	}
	//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
	//修改下拉监听
	function moduleUpOnselect(me,records){
		//alert('abad');
		var proj_id = me.getValue();
		AOS.setValue('f_module_u.proj_id',proj_id); 
	}
	//一级节点选择事件监听函数
	function module1Onselect(me, records) {
		//alert('一级节点选择事件监听函数');
		var proj_id = me.getValue();
		AOS.setValue('f_module.proj_id',proj_id); 
	}
	//根据选择项目名称刷新树和grid
	function tree_grid_query() {

		var params = {
				key_name: id_name.getValue(),
				proj_id:id_proj_name.getValue()
		};
		var record = AOS.selectone(t_module);
		if(!AOS.empty(record)){
			params.dm_code = record.raw.id;
			params.root=record.data.root;
		}
		g_module_store.getProxy().extraParams = params;
		g_module_store.loadPage(1);
		t_module_refresh('root');
	}
		
	function proj_name_query(){
		var proj_name = AOS.getValue('proj_name');
		t_org_find_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	
	function copy_proj_name_query(){
		var proj_name = AOS.getValue('copy_proj_name');
		copyt_org_find_store.load({
			params:{
				proj_name : proj_name
			}
		})
	}
	    //模块查询
		function g_module_query() {
			var params = {
					key_name: id_name.getValue(),
					proj_id:id_proj_name.getValue()
			};
			var record = AOS.selectone(t_module);
			if(!AOS.empty(record)){
				params.dm_code = record.raw.id;
				params.root=record.data.root;
			}
			g_module_store.getProxy().extraParams = params;
			g_module_store.loadPage(1);
		}
		
		//自动选中根节点
		AOS.job(function(){
			t_module.getSelectionModel().select(t_module.getRootNode());
			g_module_query();
		},10);
	
		//弹出新增功能模块菜单
		function w_module_show(){
			AOS.reset(f_module);
			var record = AOS.selectone(t_module);
			if(AOS.empty(id_proj_name.getValue())){
				AOS.tip('请选择一个项目名称！');
				return;
			}
			if(!AOS.empty(record)){
				var proj_name=tree_proj_name.getValue();
				var proj_id=id_proj_name.getValue();
				AOS.setValue('f_module.proj_name',proj_name); 
				AOS.setValue('f_module.proj_id',proj_id); 
				AOS.setValue('f_module.dm_parent_code',record.raw.id); 
				AOS.setValue('f_module.dm_parent_name',record.raw.text); 
			} 
			w_module.show();
		}
		
	    //弹出修改功能模块菜单窗口
		function w_module_u_show(){
			    AOS.reset(f_module_u);
				var recordTree = AOS.selectone(t_module);
				var selection = AOS.selection(g_module, 'dm_code');
				var rows = AOS.rows(g_module);
				if(AOS.empty(selection)||rows>1){
					AOS.tip('请选择一条需要修改的数据');
					return;
				}
				var record = AOS.selectone(g_module);
				if(record.data.state=='1'){
					AOS.tip('该数据已启用，无法修改！');
					return;
				}
				var record = AOS.selectone(g_module);
				if(!AOS.empty(selection)){
					f_module_u.loadRecord(record);
				}
					w_module_u.show();
		}
	    
		//导入excel
		function fn_import_excel(){
			importExcle_win.show();
		}
		//导入保存
		function importExcle_save(){
			var filenPath = AOS.getValue('importExcle_form.excel_file');
			if(filenPath==''){
				AOS.tip("请选择一个文件！");
				return;
			}
			var params = new Object();
			var record = AOS.selectone(t_module);
			var proj_id = id_proj_name.getValue();
			params.proj_id = proj_id; 
			fileExtension = filenPath.substring(filenPath.lastIndexOf('.')).toLowerCase();
			if (fileExtension != ".xls") {
				AOS.tip('请选择后缀名为xls的excel文件进行导入!');
				return;
			}
			importExcle_form.getForm().fileUpload = true;
			importExcle_form.getForm().submit({
				type : 'POST',
				params : params,
				url:'do.jhtml?router=moduleDivideService.importFile&juid=${juid}',
				waitMsg:'文件导入中...',
				success: function(form, action) {
					AOS.tip(action.result.msg);
					importExcle_win.hide(); 
					t_module_store.reload();
				},
				failure: function() {
					importExcle_win.hide();
					AOS.tip("数据导入失败！");
				} 
			});
		}
	    
		//新增功能模块保存
		function f_module_save(){
			var recordTree = AOS.selectone(t_module);
				AOS.ajax({
				forms : f_module,
				url : 'moduleDivideService.saveModule',
				params:{
					id:recordTree.raw.id
				},
				ok : function(data) {
					w_module.hide();
					g_module_store.reload();
					t_module_refresh();
					AOS.tip(data.appmsg);	
				}
			});
		}
		//停用
		function g_module_upstate(){
			var selection = AOS.selection(g_module, 'dm_code');
			var rows = AOS.rows(g_module);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要停用的数据！');
				return;
			}
			var rows = AOS.rows(g_module);
			var msg =  AOS.merge('确认要停用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			AOS.ajax({
				url : 'moduleDivideService.updateModuleState',
				params:{
					aos_rows: selection,
					state:"0"
				},
				ok : function(data) {
					AOS.tip("已停用");	
					g_module_store.reload();
				}
				});
			});
		}
		function g_module_submit(){
			var selection = AOS.selection(g_module, 'dm_code');
			var rows = AOS.rows(g_module);
			if(AOS.empty(selection)){
				AOS.tip('请选择需要启用的数据！');
				return;
			}
			var rows = AOS.rows(g_module);
			var msg =  AOS.merge('确认要启用选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
			AOS.ajax({
				url : 'moduleDivideService.updateModuleState',
				params:{
					aos_rows: selection,
					state:"1"
				},
				ok : function(data) {
					AOS.tip(data.appmsg);	
					g_module_store.reload();
				}
			});
			});
		 }
		//统一保存
		function g_module_save(){
			if (AOS.mrows(g_module) == 0) {
				AOS.tip('数据没变化，提交操作取消。');
				return;
			}
			AOS.ajax({
				params : {
					aos_rows:AOS.mrs(g_module)
				},
				url : 'moduleDivideService.saveGrid',
				ok : function(data){
					AOS.tip(data.appmsg);
					g_module_store.reload();
					t_module_refresh('root');
				}
			});
		}
		//全部导出
		function exportAll(){
			var record = AOS.selectone(t_module);
			var proj_id = AOS.getValue('id_proj_name');
			var start = 0;
			var limit = 50;
			var	key_name = id_name.getValue();
			var dm_code = record.raw.id;
			//alert(record.raw.id);
			//var records = AOS.selectone(t_module);
			if(!AOS.empty(record)){
				dm_code = record.raw.id;
				root= record.data.root;
			}
			
			if(key_name === undefined){
				id_name="";
			}
			AOS.file('do.jhtml?router=moduleDivideService.exportALLExcel&juid=${juid}&proj_id='+proj_id
				+'&dm_code=' + dm_code
				+'&key_name='+key_name
				+'&start='+start
				+'&limit='+limit
			);
		}
		
		
		//复制窗口
		function copy_proj(){
			copy_win.show();
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
		  	copy_tree_grid_refresh();
		  	copyw_org_find.hide();
		}
		
		function copy_tree_grid_refresh(){
			var proj_id = copy_id_proj_name.getValue();
			if(AOS.empty(proj_id)){ 
				return; 
			}
			var params = { proj_id : proj_id };
			copy_form_store.getProxy().extraParams = params;
			copy_form_store.loadPage(1);
		}
		
		//复制
		function copy_save(){
			var proj_id = copy_id_proj_name.getValue();  //来源
			var copy_proj_id = id_proj_name.getValue();  //当前
			var selection = AOS.selection(copy_form,'dm_code');
			AOS.ajax({
				params:{
					proj_id : proj_id,
					copy_proj_id : copy_proj_id,
					aos_rows: selection
				},
				url : 'moduleDivideService.copyCreate',
				ok : function(data){
					AOS.tip(data.appmsg);
					t_module_store.reload();
					copy_win.hide();
				}
			});
		}
		
		/* function copy_org_find_select(){
			var record = AOS.selectone(copyt_org_find);
		  	if(record.raw.a=="1"){
			  	AOS.setValue('copy_id_proj_name',record.raw.id);
			  	AOS.setValue('copy_tree_proj_name',record.raw.text);
		  	}
		  	copyw_org_find.hide();
		}
		
		//复制
		function copy_save(){
			var record = AOS.selectone(t_module);
			var proj_id = copy_id_proj_name.getValue();  //来源
			var copy_proj_id = id_proj_name.getValue();  //当前
			AOS.ajax({
				forms : copy_form, 
				params:{
					proj_id : proj_id,
					copy_proj_id : copy_proj_id
				},
				url : 'moduleDivideService.copyCreate',
				ok : function(data){
					t_module_store.reload();
					copy_win.hide();
				}
			});
		} */
		
		
	   //修改功能模块保存
		function f_module_u_update(){
				AOS.ajax({
				forms : f_module_u,
				url : 'moduleDivideService.update',
				ok : function(data) {
					if(data.appcode == -1){
						AOS.tip(data.appmsg);
					}else{
						w_module_u.hide();
						t_module_refresh('dm_parent_code');
						g_module_store.reload();
						if(AOS.getValue('f_module_u.dm_parent_code') == '0'){
							t_module.getRootNode().set('text',AOS.getValue('f_module_u.dm_name'));
						}
					}
				}
			});
		}
	   
        //删除功能模块菜单
		function g_module_del(){
			var selection = AOS.selection(g_module, 'dm_code');
			if(AOS.empty(selection)){
				AOS.tip('请选择需要删除的数据。');
				return;
			}
			var record = AOS.selectone(g_module);
			if(record.data.state=='1'){
				AOS.tip('该数据已启用，无法删除！');
				return;
			}
			var rows = AOS.rows(g_module);
			var msg =  AOS.merge('确认要删除选中的{0}条数据吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					return;
				}
				AOS.ajax({
					url : 'moduleDivideService.deleteModule',
					params:{
						aos_rows: selection,
						state:"-1",
						dm_if_leaf:record.data.dm_if_leaf
					},
					ok : function(data) {
						if(data.appcode == '1'){
							AOS.tip(data.appmsg);
							g_module_store.reload();
							t_module_refresh('root');
						}else{
							AOS.err(data.appmsg);
						}
					}
				});
			});
			}
	    
		//刷新菜单树  flag:parent 刷新父节点；root：刷新根节点
		function t_module_refresh(flag){
			var refreshnode = AOS.selectone(t_module);
			var proj_id=id_proj_name.getValue();
			if (!refreshnode) {
				refreshnode = t_module.getRootNode();
			}
			if (refreshnode.isLeaf() || (flag=='dm_parent_code' && !refreshnode.isRoot())) {
				refreshnode = refreshnode.parentNode;
			}
			//参数标记为刷新根节点
			if(flag == 'root'){
				refreshnode = t_module.getRootNode();
			}
			t_module_store.load({
				node : refreshnode,
				params:{
					proj_id:proj_id
				},
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					refreshnode.collapse();
					refreshnode.expand();
					t_module.getSelectionModel().select(refreshnode);
				}
			});
		}
		//弹出选择上级模块窗口
		  function proj_tree_show() {
		  	w_org_find.show();
		  }
		
		  //系统功能模块自动选择默认项目
		  window.onload = function(){
				var proj_id = '${proj_id}';
				console.log("proj_id:"+proj_id);
				var proj_name = '${proj_name}';
				if(proj_id !=null && proj_id!=''){
					AOS.setValue('id_proj_name',proj_id);
					AOS.setValue('tree_proj_name',proj_name);
					/* coding_user_name.getStore().getProxy().extraParams = {
						proj_id : proj_id
					}
					coding_user_name.getStore().load();
					test_user_name.getStore().getProxy().extraParams = {
						proj_id : proj_id
					}
					test_user_name.getStore().load(); */
					var params = {
						key_name: id_name.getValue(),
						proj_id:id_proj_name.getValue()
					};
					var records = AOS.selectone(t_module);
					if(!AOS.empty(records)){
						params.dm_code = records.raw.id;
						params.root=records.data.root;
					}
					g_module_store.getProxy().extraParams = params;
					g_module_store.loadPage(1);
					t_module_refresh('root');
				}
		 }
		
		//系统功能模块点击选择项目
		  function t_org_find_select() {
		  	var record = AOS.selectone(t_org_find);
			if(record.raw.a=="1"){
			  	AOS.setValue('id_proj_name',record.raw.id);
			  	AOS.setValue('tree_proj_name',record.raw.text);
				var params = {
						key_name: id_name.getValue(),
						proj_id:id_proj_name.getValue()
				};
				//console.log(params);
				//AOS.tip('-----------------');
				var records = AOS.selectone(t_module);
				if(!AOS.empty(records)){
					params.dm_code = records.raw.id;
					params.root=records.data.root;
				}
				//AOS.tip(params.dm_code);
				//AOS.tip(params.root);
				g_module_store.getProxy().extraParams = params;
				g_module_store.loadPage(1);
				t_module_refresh('root');
				w_org_find.hide();
			}else{
				//AOS.tip("请选择项目!");
				return;
				//w_org_find.hide();
			}
		  }
		  //刷新上级模块树
			function t_org_find_refresh() {
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
			

	</script>
</aos:onready>
