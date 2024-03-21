<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="组织机构管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<!-- 部门树形导航 -->
		<aos:treepanel 
			id="org_tree" 
			region="west" 
			bodyBorder="0 1 0 0" 
			width="250" 
			singleClick="false" 
			url="orgService.getTreeData" 
			nodeParam="parent_id" 
			rootVisible="true" 
			rootId="${rootPO.id}" 
			rootText="${rootPO.name}"
			rootIcon="${rootPO.icon_name}" 
			rootAttribute="a:'${rootPO.cascade_id}'" 
			onitemclick="org_tree_selectchange"
		>
			<aos:docked forceBoder="0 1 1 0">
				<aos:dockeditem xtype="tbtext" text="组织部门树" />
			</aos:docked>
		</aos:treepanel>
		<!-- 部门详情 -->
		<aos:panel 
			region="center" 
			layout="anchor" 
			border="false"  
			collapsible="false"
		>
			<!-- 下级部门 -->
			<aos:gridpanel 
				id="org_grid"
				url="orgService.listOrgs" 
				anchor="100% 40%"  
				margin="5" 
				bodyBorder="1 1 1 1" 
				border="true"
			>
				<aos:docked forceBoder="1 1 1 1">
					<aos:dockeditem xtype="tbtext" text="下级部门"/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:triggerfield 
						id="org_name_id"
						emptyText="部门名称" 
						onenterkey="org_grid_query" 
						onTrigger1Click="org_grid_query"
						trigger1Cls="x-form-search-trigger"
						width="180"
					/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="新增" icon="add.png" onclick="org_insert_win_show"/>
					<aos:dockeditem text="修改" icon="edit.png" onclick="org_update_win_show"/>
					<aos:dockeditem text="删除" icon="del.png" onclick="org_grid_delete"/>
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				<aos:column type="rowno" />
				<aos:column header="流水号" dataIndex="id" fixedWidth="150" hidden="true" />
				<aos:column header="上级部门流水号" dataIndex="parent_id" fixedWidth="150" hidden="true" />
				<aos:column header="节点语义ID" dataIndex="cascade_id" fixedWidth="150" hidden="true" />
				<aos:column header="部门名称" dataIndex="name" fixedWidth="200" />
				<aos:column header="排序号" dataIndex="sort_no" fixedWidth="60" />
				<aos:column header="图标" dataIndex="icon_name" fixedWidth="150" />
				<aos:column header="热键" dataIndex="hotkey" hidden="true" />
				<aos:column header="自动展开" dataIndex="is_auto_expand" rendererField="is" fixedWidth="80" />
				<aos:column header="叶子节点" dataIndex="is_leaf" rendererField="is" fixedWidth="80" />
				<aos:column header="部门类型" dataIndex="type" rendererField="org_type" fixedWidth="80" />
				<aos:column header="扩展码" dataIndex="biz_code" fixedWidth="150" />
				<aos:column header="备注" dataIndex="remark" celltip="true" />
			</aos:gridpanel>
			<!-- 部门人员 -->
			<aos:gridpanel 
				id="user_grid" 
				url="userService.listUsers"
				anchor="100% 60%" 
				bodyBorder="1 1 1 1" 
				margin="5"
				border="true"
			>
				<aos:docked forceBoder="1 1 1 1">
				<aos:dockeditem xtype="tbtext" text="部门人员"/>
					<aos:triggerfield 
						id="user_name_id"
						emptyText="登录账号|姓名" 
						onenterkey="user_grid_query" 
						onTrigger1Click="user_grid_query"
						trigger1Cls="x-form-search-trigger"
						width="180"
					/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="新增" icon="add.png" onclick="user_insert_win_show"/>
					<aos:dockeditem text="修改" icon="edit.png" onclick="user_update_win_show"/>
					<aos:dockeditem text="删除" icon="del.png" onclick="user_grid_delete"/>
					<aos:dockeditem text="重置密码" icon="key.png" onclick="AOS.reset(user_form_repassword);user_win_repassword.show()"/>
					<aos:dockeditem text="撤销删除" iconVec="fa-wrench" onclick="user_grid_undelete"/>
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				  <aos:plugins>
				<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1" />
				</aos:plugins>
				<aos:column type="rowno" />
				<aos:column header="用户流水号" dataIndex="id" fixedWidth="150" hidden="true" />
				<aos:column header="所属组织流水号" dataIndex="org_id" fixedWidth="150" hidden="true" />
				<aos:column header="登录帐号" dataIndex="account" fixedWidth="120" />
				<aos:column header="姓名" dataIndex="name" fixedWidth="100" />
				<aos:column header="所属组织" dataIndex="org_name" fixedWidth="150" />
				<aos:column header="所属角色" dataIndex="roles" celltip="true" minWidth="100" />
				<aos:column header="人员考核人" dataIndex="check_user_name" fixedWidth="100" align="center"   >
		        <aos:combobox allowBlank="false" url="userService.listComboBoxcheckUserId"  name="check_user_id"     >
		        <aos:on fn="fn_check_user" event="select" />
		        </aos:combobox>
			</aos:column>
				<aos:column header="性别" dataIndex="sex" fixedWidth="60" rendererField="sex" />
				<aos:column header="用户状态" dataIndex="status" fixedWidth="80" rendererField="user_status" />
				<aos:column header="用户类型" dataIndex="type" fixedWidth="80" rendererField="user_type" />
				<aos:column header="皮肤" dataIndex="skin" fixedWidth="80" />
				<aos:column header="扩展码" dataIndex="biz_code" minWidth="100" />
				<aos:column header="联系地址" dataIndex="address" fixedWidth="150" hidden="true" />
				<aos:column header="备注" dataIndex="remark" fixedWidth="150" hidden="true" />
				<aos:column header="创建人" dataIndex="create_by" fixedWidth="150" hidden="true" />
				<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150" hidden="true" />
			</aos:gridpanel>
		</aos:panel>
		<!-- 部门选择窗口 -->
		<aos:window id="org_find_win" title="所属部门[双击选择]" height="-10" autoScroll="true" onshow="org_find_tree_load">
			<aos:treepanel id="org_find_tree" singleClick="false" width="330" bodyBorder="0 0 0 0" url="userService.getTreeData"
				nodeParam="parent_id" rootId="${rootPO.id}" rootText="${rootPO.name}" rootVisible="true" rootExpanded="false"
				rootIcon="${rootPO.icon_name}" onitemdblclick="org_find_tree_select">
				<aos:menu>
					<aos:menuitem text="选择" icon="ok1.png" onclick="org_find_tree_select" />
					<aos:menuitem xtype="menuseparator" />
					<aos:menuitem text="关闭" onclick="#org_find_win.hide();" icon="del.png" />
				</aos:menu>
			</aos:treepanel>
		</aos:window>
		<!-- 新增部门窗口 -->
		<aos:window id="org_insert_win" title="新增部门">
			<aos:formpanel id="org_insert_form" width="400" layout="anchor" labelWidth="65">
				<aos:hiddenfield name="parent_id" fieldLabel="上级部门流水号" />
				<aos:textfield name="parent_name" fieldLabel="上级部门" allowBlank="false" readOnly="true" />
				<aos:textfield name="name" fieldLabel="部门名称" allowBlank="false" maxLength="50" />
				<aos:textfield name="hotkey" fieldLabel="热键" maxLength="50" />
				<aos:combobox name="type" fieldLabel="部门类型" allowBlank="false" dicField="org_type" value="1" emptyText="请选择..." />
				<aos:combobox name="is_auto_expand" fieldLabel="自动展开" allowBlank="false" value="0" dicField="is" />
				<aos:textfield name="icon_name" fieldLabel="图标" maxLength="50" />
				<aos:textfield name="biz_code" fieldLabel="扩展码" maxLength="50" />
				<aos:numberfield name="sort_no" fieldLabel="排序号" value="1" minWidth="0" maxValue="9999" />
				<aos:textareafield name="remark" fieldLabel="备注" maxLength="500" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="org_insert_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#org_insert_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<!-- 修改部门 -->
		<aos:window id="org_update_win" title="修改部门">
			<aos:formpanel id="org_update_form" width="400" layout="anchor" labelWidth="65">
				<aos:hiddenfield fieldLabel="部门流水号" name="id" />
				<aos:hiddenfield fieldLabel="上级部门流水号" name="parent_id" />
				<aos:textfield name="name" fieldLabel="部门名称" allowBlank="false" maxLength="50" />
				<aos:textfield name="hotkey" fieldLabel="热键" maxLength="50" />
				<aos:combobox name="type" fieldLabel="部门类型" allowBlank="false" dicField="org_type" value="1" emptyText="请选择..." />
				<aos:combobox name="is_auto_expand" fieldLabel="自动展开" allowBlank="false" value="0" dicField="is" />
				<aos:textfield name="icon_name" fieldLabel="图标" maxLength="50" />
				<aos:textfield name="biz_code" fieldLabel="业务对照码" maxLength="50" />
				<aos:numberfield name="sort_no" fieldLabel="排序号" value="1" minWidth="0" maxValue="9999" />
				<aos:textareafield name="remark" fieldLabel="备注" maxLength="500" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="org_update_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#org_update_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		
		<!-- 新增人员 -->
		<aos:window id="user_insert_win" title="新增用户" onshow="user_insert_win_show">
			<aos:formpanel id="user_insert_form" width="650" labelWidth="65">
				<aos:hiddenfield fieldLabel="所属部门流水号" name="org_id" />
				<aos:fieldset title="基础信息" labelWidth="75" columnWidth="1">
					<aos:textfield name="org_name" fieldLabel="所属部门" allowBlank="false" readOnly="true" columnWidth="0.5" />
					<aos:textfield name="name" fieldLabel="姓名" allowBlank="false" maxLength="20" columnWidth="0.49" />
					<aos:textfield name="account" fieldLabel="登录帐号" allowBlank="false" maxLength="20" columnWidth="0.5" />
					<aos:textfield name="password" fieldLabel="登录密码" allowBlank="false" maxLength="20" columnWidth="0.49" />
					<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex" value="3" columnWidth="0.5" />
					<aos:textfield name="email" fieldLabel="电子邮件" vtype="email" maxLength="50" columnWidth="0.49" />
					<aos:textfield name="mobile" fieldLabel="联系电话" maxLength="50" columnWidth="0.5" />
					<aos:textfield name="idno" fieldLabel="身份证号" maxLength="50" columnWidth="0.49" />
					<aos:combobox name="type" fieldLabel="用户类型" allowBlank="false" value="1" dicField="user_type" columnWidth="0.5" />
					<aos:combobox name="status" fieldLabel="用户状态" allowBlank="false" value="1" dicField="user_status"
						columnWidth="0.49" />
					<aos:textfield name="address" fieldLabel="联系地址" maxLength="500" columnWidth="0.99" />
					<aos:textareafield name="remark" fieldLabel="备注" maxLength="4000" height="60" columnWidth="0.99" />
				</aos:fieldset>
				<aos:fieldset title="配置信息" labelWidth="75" columnWidth="1">
					<aos:combobox name="skin" fieldLabel="界面皮肤" allowBlank="false" dicField="skin" value="blue" columnWidth="0.5" />
					<aos:textfield name="biz_code" fieldLabel="扩展码" maxLength="200" columnWidth="0.49" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="user_insert_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#user_insert_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<!-- 修改人员 -->
		<aos:window id="user_update_win" title="修改用户" onshow="user_update_win_show">
			<aos:formpanel id="user_update_form" width="650" labelWidth="65">
				<aos:hiddenfield fieldLabel="用户流水号" name="id" />
				<aos:hiddenfield fieldLabel="所属部门流水号" name="org_id" />
				<aos:hiddenfield fieldLabel="所属部门流水号" name="old_org_id" />
				<aos:fieldset title="基础信息" labelWidth="75" columnWidth="1">
					<aos:triggerfield fieldLabel="所属部门" name="org_name" allowBlank="false" editable="false" onfocus="org_find_win_show"
						trigger1Cls="x-form-search-trigger" onTrigger1Click="org_find_win_show" columnWidth="0.5" />
					<aos:textfield name="name" fieldLabel="姓名" allowBlank="false" maxLength="20" columnWidth="0.49" />
					<aos:textfield name="account" fieldLabel="登录帐号" allowBlank="false" maxLength="20" columnWidth="0.5" />
					<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex" value="3" columnWidth="0.49" />
					<aos:textfield name="email" fieldLabel="电子邮件" vtype="email" maxLength="50" columnWidth="0.5" />
					<aos:textfield name="mobile" fieldLabel="联系电话" maxLength="50" columnWidth="0.49" />
					<aos:textfield name="idno" fieldLabel="身份证号" maxLength="50" columnWidth="0.5" />
					<aos:combobox name="type" fieldLabel="用户类型" allowBlank="false" value="1" dicField="user_type" columnWidth="0.49" />
					<aos:combobox name="status" fieldLabel="用户状态" allowBlank="false" value="1" dicField="user_status"
						columnWidth="0.5" />
					<aos:textfield name="address" fieldLabel="联系地址" maxLength="500" columnWidth="0.99" />
					<aos:textareafield name="remark" fieldLabel="备注" maxLength="4000" height="60" columnWidth="0.99" />
				</aos:fieldset>
				<aos:fieldset title="配置信息" labelWidth="75" columnWidth="1">
					<aos:combobox name="skin" fieldLabel="界面皮肤" allowBlank="false" dicField="skin" value="blue" columnWidth="0.5" />
					<aos:textfield name="biz_code" fieldLabel="扩展码" maxLength="200" columnWidth="0.49" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="user_update_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#user_update_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<aos:window id="user_win_repassword" title="重置密码">
			<aos:formpanel id="user_form_repassword" width="400" layout="anchor" labelWidth="75">
				<aos:hiddenfield name="aos_rows" fieldLabel="已选中的用户ID集合" />
				<aos:textfield name="password" fieldLabel="新密码" allowBlank="false" inputType="password" maxLength="20" />
				<aos:textfield name="re_password" fieldLabel="确认新密码" allowBlank="false" inputType="password" maxLength="20" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="user_win_repassword_save_button_click" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#user_win_repassword.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<!-- 撤销删除窗口 -->
		<aos:window id="user_grid_undelete_win" title="撤销删除" width="800" height="500" onshow="user_grid_undelete">
			<aos:gridpanel 
				id="user_undelete_grid" 
				url="userService.listDeleteUsers"
				anchor="100% 60%" 
				bodyBorder="1 1 1 1" 
				margin="5"
				border="true"
			>
				<aos:docked forceBoder="1 1 1 1">
				<aos:dockeditem xtype="tbtext" text="部门人员"/>
					<aos:triggerfield 
						id="user_name_id_undelete"
						emptyText="登录账号|姓名" 
						onenterkey="user_undelete_grid_query" 
						onTrigger1Click="user_undelete_grid_query"
						trigger1Cls="x-form-search-trigger"
						width="180"
					/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="撤销" iconVec="fa-wrench" onclick="user_undelete"/>
				</aos:docked>
				<aos:selmodel type="checkbox" mode="multi" />
				  <aos:plugins>
				<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="1" />
				</aos:plugins>
				<aos:column type="rowno" />
				<aos:column header="用户流水号" dataIndex="id" fixedWidth="150" hidden="true" />
				<aos:column header="所属组织流水号" dataIndex="org_id" fixedWidth="150" hidden="true" />
				<aos:column header="登录帐号" dataIndex="account" fixedWidth="120" />
				<aos:column header="姓名" dataIndex="name" fixedWidth="100" />
				<aos:column header="所属组织" dataIndex="org_name" fixedWidth="100" />
				<aos:column header="所属角色" dataIndex="roles" celltip="true" minWidth="100" />
				<aos:column header="人员考核人" dataIndex="check_user_name" fixedWidth="100" align="center"   >
		        <aos:combobox allowBlank="false" url="userService.listComboBoxcheckUserId"  name="check_user_id"     >
		        <aos:on fn="fn_check_user" event="select" />
		        </aos:combobox>
			</aos:column>
				<aos:column header="性别" dataIndex="sex" fixedWidth="60" rendererField="sex" />
				<aos:column header="删除状态" dataIndex="is_del" fixedWidth="80" rendererField="is" />
				<aos:column header="用户类型" dataIndex="type" fixedWidth="80" rendererField="user_type" />
				<aos:column header="皮肤" dataIndex="skin" fixedWidth="80" />
				<aos:column header="扩展码" dataIndex="biz_code" minWidth="100" />
				<aos:column header="联系地址" dataIndex="address" fixedWidth="150" hidden="true" />
				<aos:column header="备注" dataIndex="remark" fixedWidth="150" hidden="true" />
				<aos:column header="创建人" dataIndex="create_by" fixedWidth="150" hidden="true" />
				<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150" hidden="true" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="#user_grid_undelete_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	</aos:viewport>
	<script type="text/javascript">
		//查询部门列表
		function org_grid_query() {
			var params = {
				name : org_name_id.getValue(),
				cascade : false
			};
			var record = AOS.selectone(org_tree);
			if(!AOS.empty(record)){
				params.id = record.raw.id;
				params.cascade_id = record.raw.a;
			}
			org_grid_store.getProxy().extraParams = params;
			org_grid_store.loadPage(1);
		}
		
		//查询人员列表
		function user_grid_query() {
			var params = {
				name : user_name_id.getValue(),
				cascade : true
			};
			var record = AOS.selectone(org_tree);
			if(!AOS.empty(record)){
				params.org_id = record.raw.id;
				params.org_cascade_id = record.raw.a;
			}
			user_grid_store.getProxy().extraParams = params;
			user_grid_store.loadPage(1);
		}
		
		//部门树选择改变
		function org_tree_selectchange(){
			org_grid_query();
			user_grid_query();
		}
		
		//自动选中根节点
		AOS.job(function(){
			org_tree.getSelectionModel().select(org_tree.getRootNode());
			org_tree_selectchange();
		}, 10);
		
		
		//刷新部门树  flag:parent 刷新父节点；root：刷新根节点
		function org_tree_refresh(flag) {
			var refreshnode = AOS.selectone(org_tree);
			if (!refreshnode) {
				refreshnode = org_tree.getRootNode();
			}
			if (refreshnode.isLeaf() || (flag=='parent' && !refreshnode.isRoot())) {
				refreshnode = refreshnode.parentNode;
			}
			//参数标记为刷新根节点
			if(flag == 'root'){
				refreshnode = org_tree.getRootNode();
			}
			org_tree_store.load({
				node : refreshnode,
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					refreshnode.collapse();
					refreshnode.expand();
					org_tree.getSelectionModel().select(refreshnode);
				}
			});
		}
		
		
		//显示新增部门窗口
		function org_insert_win_show(){
			AOS.reset(org_insert_form);
			var record = AOS.selectone(org_tree);
			if(!AOS.empty(record)){
				AOS.setValue('org_insert_form.parent_id', record.raw.id); 
				AOS.setValue('org_insert_form.parent_name', record.raw.text); 
			} 
			org_insert_win.show();
		}
		
		   //弹出修改部门窗口
		function org_update_win_show(){
			AOS.reset(org_update_form);
			var record = AOS.selectone(org_grid);
			if(record){
				org_update_win.show();
				org_update_form.loadRecord(record);
		    }
		}	
		//监听单元格编辑事件人员考核
		  function fn_check_user(me) {
		            var record= AOS.selectone(user_grid,true);
					AOS.ajax({
						params : {
								id : record.data.id,
								check_user_id:  me.getValue()
						},
						url : 'userService.updateCheckUser',
						ok : function(data) {
							AOS.tip(data.appmsg);
							user_grid_store.reload();
							 me.fireEvent('blur');
						}
					});
				}
		//新增部门保存
		function org_insert_form_save(){
				AOS.ajax({
					forms : org_insert_form,
					url : 'orgService.saveOrg',
					ok : function(data) {
						org_insert_win.hide();
						org_grid_store.reload();
						org_tree_refresh();
						AOS.tip(data.appmsg);	
					}
			});
		}
		
		//修改部门保存
		function org_update_form_save(){
				AOS.ajax({
				forms : org_update_form,
				url : 'orgService.updateOrg',
				ok : function(data) {
					AOS.tip(data.appmsg);	
					org_update_win.hide();
					org_tree_refresh('parent');
					org_grid_store.reload();
					if(AOS.getValue('org_update_form.parent_id') == '0'){
						org_tree.getRootNode().set('text',AOS.getValue('org_update_form.name'));
					}
				}
			});
		}
		//删除部门
		function org_grid_delete(){
			var selection = AOS.selection(org_grid, 'id');
			if(AOS.empty(selection)){
				AOS.tip('删除前请先选中数据。');
				return;
			}
			var rows = AOS.rows(org_grid);
			var msg =  AOS.merge('确认要删除选中的{0}个部门及其可能包含的子部门吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					AOS.tip('删除操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'orgService.deleteOrg',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						if(data.appcode == '1'){
							AOS.tip(data.appmsg);
							org_grid_store.reload();
							org_tree_refresh('root');
						}else{
							AOS.err(data.appmsg);
						}
					}
				});
			});
		}
		
		//弹出新增人员窗口
		function user_insert_win_show(){
			AOS.reset(user_insert_form);
			var record = AOS.selectone(org_tree);
			if(!AOS.empty(record)){
				AOS.setValue('user_insert_form.org_id', record.raw.id); 
				AOS.setValue('user_insert_form.org_name', record.raw.text); 
			}
			user_insert_win.show();
		}
		//弹出修改人员窗口
		function user_update_win_show(){
			AOS.reset(user_update_form);
			var record = AOS.selectone(user_grid);
			AOS.ajax({
				params:{
					id : record.data.id
				},
                url: 'userService.getUser',
                ok: function (data) {
                	AOS.setValues(user_update_form, data);
                }
            }); 
			user_update_win.show();
		}
		//新增用户保存
		function user_insert_form_save(){
			AOS.ajax({
				forms : user_insert_form,
				url : 'userService.saveUser',
				ok : function(data) {
					if(data.appcode=='1'){
						AOS.tip(data.appmsg);
						user_insert_win.hide();
						user_grid_store.reload();
					}else{
						AOS.get('user_insert_form.account').markInvalid(data.appmsg);
						AOS.err(data.appmsg);
					}
				}
			});
		}	
		//修改用户保存
		function user_update_form_save(){
			console.log(user_update_form.getValues());
			AOS.ajax({
				forms : user_update_form,
				url : 'userService.updateUser',
				ok : function(data) {
					if(data.appcode == '1'){
						user_update_win.hide();
						user_grid_store.reload();
						AOS.tip(data.appmsg);
					}else{
						AOS.get('user_update_form.account').markInvalid(data.appmsg);
						AOS.err(data.appmsg);
					}
				}
			});
		}
		
		//刷新所属部门选择树
		function org_find_tree_load() {
		    var refreshnode = AOS.selectone(org_find_tree);
		    if (!refreshnode) {
		        refreshnode = org_find_tree.getRootNode();
		    }
		    if (refreshnode.isLeaf()) {
		        refreshnode = refreshnode.parentNode;
		    }
		    org_find_tree_store.load({
		        node: refreshnode,
		        callback: function () {
		            //收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
		            refreshnode.collapse();
		            refreshnode.expand();
		        }
		    });
		}
	  	//弹出部门选择窗口
	  	function org_find_win_show(){
	   		org_find_win.show();
	  	}
		//所属组织树节点双击事件
		function org_find_tree_select() {
		     var record = AOS.selectone(org_find_tree);
		     AOS.setValue('user_update_form.org_id', record.raw.id);
		     AOS.setValue('user_update_form.org_name', record.raw.text);
		     org_find_win.hide();
		}
		//重置密码
		function user_win_repassword_save_button_click(){
			var selection = AOS.selection(user_grid, 'id');
            if (AOS.empty(selection)) {
                AOS.tip('请先选中需要重置密码的用户。');
                return;
            }
            AOS.setValue('user_form_repassword.aos_rows', selection);
			if (AOS.getValue('user_form_repassword.password') !== AOS.getValue('user_form_repassword.re_password')) {
	         	var msg = '两次输入密码不一致, 请重新输入。';
	         	AOS.get('user_form_repassword.re_password').markInvalid(msg);
	         	AOS.err(msg);
             	return;
	         }
	         var msg = AOS.merge('确认要重置选中[{0}]个用户的密码吗？', AOS.rows(user_grid));
	         AOS.confirm(msg, function (btn) {
	             if (btn === 'cancel') {
	                 AOS.tip('重置密码操作被取消。');
	                 return;
	             }
	             AOS.ajax({
	                 forms: user_form_repassword,
	                 url: 'userService.resetPassword',
	                 ok: function (data) {
	                 	user_win_repassword.hide();
	                     AOS.tip(data.appmsg);
	                 }
	             });
	         });
		}
		
       //删除用户
	 	function user_grid_delete(){
			var selection = AOS.selection(user_grid, 'id');
			if(AOS.empty(selection)){
				AOS.tip('删除前请先选中数据。');
				return;
			}
			var rows = AOS.rows(user_grid);
			var msg =  AOS.merge('确认要删除选中的{0}个用户吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn == 'cancel'){
					AOS.tip('删除操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'userService.deleteUser',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						user_grid_store.reload();
					}
				});
			});
		}
	 	 //撤销删除用户
	 	function user_undelete(){
			var selection = AOS.selection(user_undelete_grid, 'id');
			if(AOS.empty(selection)){
				AOS.tip('请先选中数据进行恢复。');
				return;
			}
			var rows = AOS.rows(user_undelete_grid);
			var msg =  AOS.merge('确认要恢复选中的{0}个用户吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn == 'cancel'){
					AOS.tip('操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'userService.undeleteUser',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						user_undelete_grid_store.reload();
					}
				});
			});
		}
	 	//弹出撤销删除窗口
		function user_grid_undelete(){
			AOS.reset(user_insert_form);
			user_grid_undelete_win.show();
			
			var params = {
					name : user_name_id_undelete.getValue(),
					cascade : true
				};
				var record = AOS.selectone(org_tree);
				if(!AOS.empty(record)){
					params.org_id = record.raw.id;
					params.org_cascade_id = record.raw.a;
				}
				user_undelete_grid_store.getProxy().extraParams = params;
				user_undelete_grid_store.loadPage(1);
			user_undelete_grid_store.getProxy().extraParams = params;
			user_undelete_grid_store.loadPage(1);
		}
		//查询人员列表
		function user_undelete_grid_query() {
			var params = {
				name : user_name_id_undelete.getValue(),
				cascade : true
			};
			var record = AOS.selectone(org_tree);
			if(!AOS.empty(record)){
				params.org_id = record.raw.id;
				params.org_cascade_id = record.raw.a;
			}
			user_undelete_grid_store.getProxy().extraParams = params;
			user_undelete_grid_store.loadPage(1);
		}
	</script>
</aos:onready>
