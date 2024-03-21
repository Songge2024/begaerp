<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="角色管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="anchor">
		<aos:gridpanel 
			id="role_grid"
			url="roleService.listRole"
			onrender="role_grid_query"
			anchor="100% 35%"
			onselectionchange="role_selected_change" 
			border="false"
			hidePagebar="true"
			
			bodyBorder="0 0 0 0"
			margin="0 0 5 0"
		>
			<aos:docked forceBoder="0 0 0 0">
				<aos:dockeditem xtype="tbtext" text="角色列表" />
				<aos:dockeditem xtype="tbseparator" />	
				<aos:dockeditem text="新增" icon="add.png"  onclick="#role_add_win.show();"/>
				<aos:dockeditem text="修改" icon="edit.png" onclick="role_update_win_show"/>
				<aos:dockeditem text="删除" icon="del.png" onclick="role_grid_delete"/>
				<aos:dockeditem xtype="tbseparator" />
				<aos:triggerfield 
					id="role_name_id"
					emptyText="角色名称"  
					onenterkey="role_grid_query" 
					onTrigger1Click="role_grid_query" 
					trigger1Cls="x-form-search-trigger"
					width="180" 
				/>
			</aos:docked>
			<aos:selmodel type="row" mode="single" />
			<aos:column type="rowno" />
			<aos:column header="流水号" dataIndex="id" fixedWidth="150" hidden="true" />
			<aos:column header="角色名称" dataIndex="name" celltip="true" width="200" />
			<aos:column header="是否启用" dataIndex="is_enable" rendererField="is" fixedWidth="100" />
			<aos:column header="角色类型" dataIndex="type" rendererField="role_type" fixedWidth="100" />
			<aos:column header="扩展码" dataIndex="biz_code" minWidth="100" />
			<aos:column header="创建人" dataIndex="create_name" fixedWidth="150"/>
			<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150" />
			<aos:column header="备注" dataIndex="remark" celltip="true" />
		</aos:gridpanel>
		<aos:tabpanel 
			id="tabs" 
			anchor="100% 65%" 
			tabPosition="top" 
			bodyBorder="0 1 1 1"
			border="true"
		>
			<aos:tab title="角色用户列表" layout="border" id="user_list">
				<aos:panel
					id="role_user_choose"
					region="west" 
					width="650" 
					layout="border" 
					collapsible="true"
					collapsed="true"
				 	split="true" 
				 	collapseMode="mini" 
					header="false" 
				 	minWidth="220"
				 >
					<aos:treepanel 
						id="org_tree"
					 	region="west" 
					 	bodyBorder="0 1 0 0"
					  	width="230" 
					  	singleClick="false"
					  	expandAll="false"
						onitemclick="user_grid_query"
						url="orgService.getTreeData"
						nodeParam="parent_id" 
						rootId="${orgPO.id}"
						rootText="${orgPO.name}"
						rootVisible="true" 
						rootIcon="${orgPO.icon_name}" 
						rootExpanded="false"
						rootAttribute="a:'${orgPO.cascade_id}'"
					>
						<aos:docked forceBoder="0 1 1 0">
							<aos:dockeditem xtype="tbtext" text="组织部门树" />
							<aos:dockeditem xtype="tbfill" />
							<aos:checkbox boxLabel="级联显示" id="org_cascade_id" onchange="user_grid_query" checked="true" />
						</aos:docked>
						<aos:menu>
							<aos:menuitem text="刷新" onclick="#user_grid_store.reload();" icon="refresh.png" />
						</aos:menu>
					</aos:treepanel>
					<aos:gridpanel 
						id="user_grid"
						region="center" 
						forceFit="false"
						autoLoad="false"
						url="roleService.listUsers"
						displayInfo="false"
					>
						<aos:docked forceBoder="0 1 0 0">
							<aos:dockeditem xtype="tbtext" text="待选用户列表" />
							<aos:dockeditem xtype="tbseparator" />
							<aos:triggerfield 
								emptyText="姓名|登录帐号" 
								name="hotkey" id="user_name_id"
								onenterkey="user_grid_query"
								trigger1Cls="x-form-search-trigger"
								onTrigger1Click="user_grid_query"
								width="180" 
							/>
						</aos:docked>
						<aos:menu>
							<aos:menuitem xtype="menuseparator" />
							<aos:menuitem text="刷新" onclick="#user_grid_store.reload();" icon="refresh.png" />
						</aos:menu>
						<aos:selmodel type="checkbox" mode="simple" />
						<aos:column type="rowno" />
						<aos:column header="用户流水号" dataIndex="id" hidden="true" />
						<aos:column header="姓名" dataIndex="name" fixedWidth="70" />
						<aos:column header="登录帐号" dataIndex="account" fixedWidth="100" />
						<aos:column header="所属部门" dataIndex="org_name" celltip="true" flex="1" />
					</aos:gridpanel>	
					<aos:panel bodyBorder="0 1 0 1" bodyPadding="3" width="65" region="east">
						<aos:layout type="vbox" align="center" pack="center" />
						<aos:button onclick="role_user_save" text="授权" tooltip="选中授权" iconVec="fa-angle-double-right" iconVecAlign="right"
							iconVecSize="16" />
						<aos:button onclick="role_user_delete" margin="20 0 0 0" text="撤消" tooltip="撤消授权" iconVec="fa-angle-double-left"
							iconVecSize="16" />
					</aos:panel>			
				</aos:panel>
				<aos:gridpanel 
					id="role_user_grid"
				 	forceFit="false"
				 	region="center" 
				  	url="roleService.listSelectedUsers"
				  	width="340" bodyBorder="1 0 1 0" 
				  	displayInfo="false"
				>
				<aos:docked forceBoder="0 0 1 0">
					<aos:dockeditem xtype="tbtext" text="角色人员列表" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:triggerfield 
						emptyText="姓名或登录帐号" 
						id="role_user_name_id" 
						onenterkey="role_user_grid_query"
						trigger1Cls="x-form-search-trigger"
						onTrigger1Click="role_user_grid_query" 
						width="180" 
					/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="展开授权" icon="add.png" onclick="#role_user_choose.toggleCollapse();"/>
				</aos:docked>
				<aos:selmodel type="checkbox" mode="simple" />
				<aos:column type="rowno" />
				<aos:column header="授权流水号" dataIndex="user_role_id" hidden="true" />
				<aos:column header="姓名" dataIndex="name" fixedWidth="70" />
				<aos:column header="登录帐号" dataIndex="account" fixedWidth="100" />
				<aos:column header="所属部门" dataIndex="org_name" celltip="true" flex="1" />
			</aos:gridpanel>
			</aos:tab>
			<aos:tab title="菜单权限" layout="column" id="module_list" autoScroll="true">
				<aos:docked dock="top" forceBoder="0 0 1 0">
					<aos:dockeditem onclick="role_module_save" text="保存" icon="ok.png" />
					<aos:dockeditem onclick="module_tree_query"  text="刷新" icon="refresh.png" />
				</aos:docked>
				<aos:treepanel id="module_tree"
				 	rootText="经办权限[导航菜单]" 
				 	headerBorder="0 1 0 0" 
				 	bodyBorder="0 1 0 0"
				 	columnWidth="0.5"
					url="roleService.getTreeData"
					singleClick="false" 
					rootIcon="icon140.png" 
					cascade="true" 
					rootExpanded="true"
					rootVisible="true" 
				>
				</aos:treepanel>
				<aos:treepanel 
					id="module_tree_admin" 
					rootText="管理权限[授权时待选菜单]"
					columnWidth="0.5"
					bodyBorder="0 0 0 0"
					url="roleService.getAdminTreeData" 
					singleClick="false" 
					rootIcon="icon146.png" 
					cascade="true" 
					rootExpanded="true"
					rootVisible="true" 
				>
				</aos:treepanel>
			</aos:tab>
			<aos:tab title="按钮权限" layout="column" id="button_list">

			</aos:tab>
			<aos:tab title="数据行权限" layout="" id="rowsFilter_list">
				<aos:layout type="hbox" align="stretch" />
				<aos:gridpanel 
					id="role_rowsFilter_grid"
				 	url="dataFilterService.queryRoleRowsFilterPage" 
				 	onrender="role_rowsFilter_grid_query"
				 	forceFit="true" 
				 	border="true"
				 	flex="2"
				 	bodyBorder="0 0 0 1"
				 >
					<aos:docked forceBoder="0 0 0 1">
						<aos:dockeditem xtype="tbtext" text="配置信息" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem onclick="role_rowsFilter_save" text="保存" icon="ok.png" />
						<aos:dockeditem text="新增" icon="add.png"  onclick="role_rowsFilter_add"/>
						<aos:dockeditem text="删除" icon="del.png" onclick="role_rowsFilter_delete"/>
					</aos:docked>
					<aos:plugins>
						<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="2" />
					</aos:plugins>
					<aos:selmodel type="checkbox" mode="simple" />
					<aos:column type="rowno" />
					<aos:column header="配置" dataIndex="filter" fixedWidth="200" celltip="true">
						<aos:textareafield maxLength="4000" />
					</aos:column>
					<aos:column header="查询键" dataIndex="sqlid" fixedWidth="200" celltip="true"/>
					<aos:column header="路径" dataIndex="path" fixedWidth="350" celltip="true" />
					<aos:column header="编码" dataIndex="id" fixedWidth="50" hidden="true"/>
					<aos:column header="角色编码" dataIndex="role_id" fixedWidth="50" hidden="true"/>
					<aos:column header="查询编码" dataIndex="data_filter_id" fixedWidth="50" hidden="true"/>
					</aos:gridpanel>
				<aos:gridpanel 
					id="rowsFilter_grid"
				 	url="dataFilterService.queryRowsFilterPage" 
				 	onrender="rowsFilter_grid_query"
				 	forceFit="true" 
				 	border="true"
				 	flex="3"
				 	bodyBorder="0 0 0 1"
				 >
					<aos:docked forceBoder="0 0 0 1">
						<aos:dockeditem xtype="tbtext" text="待选配置信息" />
						<aos:dockeditem xtype="tbseparator" />
						<aos:dockeditem onclick="rowsFilter_save" text="保存" icon="ok.png" />
					</aos:docked>
					<aos:plugins>
						<aos:editing id="id_plugin" ptype="cellediting" clicksToEdit="2" />
					</aos:plugins>
					<aos:column type="rowno" />
					<aos:column header="名称" dataIndex="name" fixedWidth="200" celltip="true">
						<aos:textfield maxLength="50" />
					</aos:column>
					<aos:column header="编码" dataIndex="id" fixedWidth="50" hidden="true"/>
					<aos:column header="查询键" dataIndex="sqlid" fixedWidth="200" celltip="true"/>
					<aos:column header="路径" dataIndex="path" fixedWidth="350" celltip="true" />
					<aos:column header="备注" dataIndex="remark" fixedWidth="350" celltip="true" >
						<aos:textareafield maxLength="4000" />
					</aos:column>
				</aos:gridpanel>
			</aos:tab>
			<aos:tab title="数据列权限" layout="fit" id="columnsFilter_list">
			
			</aos:tab>
		</aos:tabpanel>
		<!-- 新增角色 -->
		<aos:window id="role_add_win" title="新增角色" onshow="AOS.reset(role_add_form);">
			<aos:formpanel id="role_add_form" width="500" layout="anchor" labelWidth="65">
				<aos:textfield name="name" fieldLabel="角色名称" allowBlank="false" maxLength="50" />
				<aos:combobox name="type" fieldLabel="角色类型" allowBlank="false" dicField="role_type" value="1" />
				<aos:combobox name="is_enable" fieldLabel="是否启用" allowBlank="false" dicField="is" value="1" />
				<aos:textfield name="biz_code" fieldLabel="业务对照码" maxLength="50" />
				<aos:textareafield name="remark" fieldLabel="备注" maxLength="4000" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="role_add_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#role_add_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
		<aos:window id="role_update_win" title="修改角色">
			<aos:formpanel id="role_update_form" width="500" layout="anchor" labelWidth="65">
				<aos:hiddenfield name="id" />
				<aos:textfield name="name" fieldLabel="角色名称" allowBlank="false" maxLength="50" />
				<aos:combobox name="type" fieldLabel="角色类型" allowBlank="false" dicField="role_type" />
				<aos:combobox name="is_enable" fieldLabel="是否启用" allowBlank="false" dicField="is" />
				<aos:textfield name="biz_code" fieldLabel="业务对照码" maxLength="50" />
				<aos:textareafield name="remark" fieldLabel="备注" maxLength="4000" />
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="role_update_form_save" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#role_update_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
	</aos:viewport>

	<script type="text/javascript">
	     //查询角色列表
	     function role_grid_query() {
	         var params = {
	             name: role_name_id.getValue()
	         };
	         role_grid_store.getProxy().extraParams = params;
	         role_grid_store.loadPage(1);
	     }
         //弹出修改角色窗口
         function role_update_win_show() {
             var record = AOS.selectone(role_grid);
             if (record) {
                 role_update_win.show();
                 role_update_form.loadRecord(record);
             }
         }
	     //新增角色窗口保存
	     function role_add_form_save(){
	    	 AOS.ajax({
                 forms: role_add_form,
                 url: 'roleService.saveRole',
                 ok: function (data) {
                     role_add_win.hide();
                     role_grid_store.reload();
                     AOS.tip(data.appmsg);
                 }
             });
	     }
	   	//新增角色窗口保存
	     function role_update_form_save(){
	    	 AOS.ajax({
                 forms: role_update_form,
                 url: 'roleService.updateRole',
                 ok: function (data) {
                     role_update_win.hide();
                     role_grid_store.reload();
                     AOS.tip(data.appmsg);
                 }
             });
	     }
	   	//删除角色
         function role_grid_delete() {
             var selectionIds = AOS.selection(role_grid, 'id');
             if (AOS.empty(selectionIds)) {
                 AOS.tip('删除前请先选中数据。');
                 return;
             }
             var rows = AOS.rows(role_grid);
             var msg = AOS.merge('确认要删除选中的[{0}]条数据吗？', rows);
             AOS.confirm(msg, function (btn) {
                 if (btn === 'cancel') {
                     AOS.tip('删除操作被取消。');
                     return;
                 }
                 AOS.ajax({
                     url: 'roleService.deleteRole',
                     params: {
                         aos_rows: selectionIds
                     },
                     ok: function (data) {
                         AOS.tip(data.appmsg);
                         role_grid_store.reload();
                     }
                 });
             });

         }
	   	 //角色选择改变
         function role_selected_change(){
        	var tab_id= tabs.getActiveTab().getId();
        	if(tab_id=="user_list") role_user_grid_query();
        	if(tab_id=="module_list") module_tree_query();
        	if(tab_id=="rowsFilter_list") role_rowsFilter_grid_query();
         }
	     //查询部门人员列表
	     function user_grid_query(){
	    	user_grid_store.loadPage(1);
	     }
	     user_grid_store.on("beforeload",function(store){
    	 	var record=AOS.selectone(role_grid);
    	 	if(AOS.empty(record)){
    	 		 user_grid.view.loadMask.hide();
    	 		return false;
    	 	}
    	 	var record=AOS.selectone(org_tree);
	    	if(AOS.empty(record)){
	    		user_grid.view.loadMask.hide();
		    	return false;
		    }
    	 	var params = {
    			role_id :  record.data.id,
    			cascade : org_cascade_id.getValue(),
    			name : user_name_id.getValue()
	  		};
	    	params.org_id = record.raw.id;
    		params.org_cascade_id = record.raw.a;
	    	user_grid_store.getProxy().extraParams = params;
	    	return true;
	     });
	     
	     role_user_grid_store.on("beforeload",function(){
	    	 var record = AOS.selectone(role_grid);
	    	 if(AOS.empty(record)){
	    		 role_user_grid.view.loadMask.hide();
	    		 return false;
	    	 }
	    	 var params = {
    			role_id : record.data.id,
    			name : role_user_name_id.getValue()
	  		 };
	    	 role_user_grid_store.getProxy().extraParams = params;
	     });
	     //查询角色人员列表
	     function role_user_grid_query(){
	    	 role_user_grid_store.loadPage(1);		
	     }

	     //保存角色用户授权信息
		 function role_user_save(){
			var role_record = AOS.selectone(role_grid);
			var user_records = AOS.rows(user_grid);
			if(user_records == 0){
				AOS.tip('操作被取消，请先选中要授权的用户。');
				return;
			}
			var params = {
				role_id : role_record.data.id,
				aos_rows : AOS.selection(user_grid, 'id')
			};
			AOS.ajax({
				params:params,
				url : 'roleService.saveRoleUserGrantInfo',
				ok : function(data) {
					AOS.tip(data.appmsg);
					user_grid_store.reload();
					role_user_grid_query();
				}
	  		});
		}
		//取消角色用户授权
		function role_user_delete(){
			var rows = AOS.rows(role_user_grid);
			if(rows === 0){
				AOS.tip('操作被取消，请先选中要撤消授权的用户。');
				return;
			}
			AOS.ajax({
				url : 'roleService.deleteRoleUserGrantInfo',
				params:{
					aos_rows: AOS.selection(role_user_grid, 'user_role_id')
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					role_user_grid_store.reload();
					user_grid_store.reload();
				}
			});
		}
		//保存菜单授权
		var init_grant_rows;
		var init_admin_rows;
		   
	   //保存角色菜单授权数据
	   function role_module_save(){
		  	var record = AOS.selectone(role_grid);
		  	var params = {
				role_id : record.data.id,
				save_biz : true,
				save_admin: true
			};
		  var grant_rows = AOS.selection(module_tree, 'id');
		  	if(init_grant_rows != grant_rows){
			  params.grant_rows = grant_rows;
		  	}
		  	var admin_rows = AOS.selection(module_tree_admin, 'id');
		  	if(init_admin_rows != admin_rows){
			  params.admin_rows = admin_rows;
		  	}
		  	if(record.data.id_ == '${super_role_id}'){
			  if(init_grant_rows == grant_rows){
				  AOS.tip("授权数据无变化，不需要保存。");
				  return;
			  }
			  //角色管理菜单为必选的内置菜单，不能取消授权
			  if(grant_rows.indexOf('${role_module_id}') == -1){
				  AOS.warn("操作被取消。【角色管理】是超级用户角色内置必选菜单,不能取消授权。请重新选择。");
				  return;
			  }
		 	}else{
			  	if(init_grant_rows == grant_rows){
				  params.save_biz=false;
			  	}
              	if(init_admin_rows == admin_rows){
               	  params.save_admin=false;
			  	}
			  	if(!params.save_biz && !params.save_admin){
				  AOS.tip("授权数据无变化，不需要保存。");
				  return;
			  }
		  	}
		 	AOS.ajax({
				params:params,
				url : 'roleService.saveGrantInfo',
				ok : function(data) {
					AOS.tip(data.appmsg);
					module_tree_query(true);
			 	}
 			});
		}
	 	//加载业务经办授权菜单树
		function module_tree_query(flag) {
			refreshnode = module_tree.getRootNode();
			var record = AOS.selectone(role_grid);
			if(AOS.empty(record)){
				return;
			}
			var params = {
				role_id : record.data.id,
				grant_type : '1'
			};
			module_tree_store.getProxy().extraParams = params;
			module_tree_store.load({
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					refreshnode.collapse();
					refreshnode.expand();
					init_grant_rows = AOS.selection(module_tree, 'id');
					if(record.data.id != '${super_role_id}'){
						//防止两棵树同时加载显示有问题
						//if(flag) 
						module_tree_admin_query();
					}
				}
			});
		}
		
		//加载管理权限授权菜单树
		function module_tree_admin_query() {
			refreshnode = module_tree_admin.getRootNode();
			var record = AOS.selectone(role_grid);
			var params = {
					role_id : record.data.id,
					grant_type : '2'
			};
			module_tree_admin_store.getProxy().extraParams = params;
			module_tree_admin_store.load({
				callback : function() {
					//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
					refreshnode.collapse();
					refreshnode.expand();
					init_admin_rows = AOS.selection(module_tree_admin, 'id');
				}
			});
		}
		//待选数据过滤配置查询
		function rowsFilter_grid_query(){
			rowsFilter_grid_store.loadPage(1);
		}
		//指定角色行级数据配置规则查询
		function role_rowsFilter_grid_query(){
			var record=AOS.selectone(role_grid);
			if(AOS.empty(record))return;
			var params = {
				role_id : record.data.id
			};
			role_rowsFilter_grid_store.getProxy().extraParams = params;
			role_rowsFilter_grid_store.loadPage(1);		
		}
		//保存角色配置信息
		function role_rowsFilter_save(){
			var record=AOS.selectone(role_grid);
			if(AOS.empty(record))return;
			if(AOS.mrows(role_rowsFilter_grid)>0){
				AOS.ajax({
					params:{
						role_id:record.data.id,
						role_rowsFilter:AOS.mrs(role_rowsFilter_grid)
					},
					url : 'dataFilterService.saveRoleRowsFilter',
					ok : function(data) {
						AOS.tip(data.appmsg);
						role_rowsFilter_grid_query();
				 	}
	 			});
			}
		}
		//保存配置信息
		function rowsFilter_save(){
			if(AOS.mrows(rowsFilter_grid)>0){
				AOS.ajax({
					params:{
						rowsFilter:AOS.mrs(rowsFilter_grid)
					},
					url : 'dataFilterService.saveRowsFilter',
					ok : function(data) {
						AOS.tip(data.appmsg);
						rowsFilter_grid_query();
				 	}
	 			});
			}
		}
		//新增配置信息
		function role_rowsFilter_add(){
			var role_record=AOS.selectone(role_grid);
			var rowsFilter_record=AOS.selectone(rowsFilter_grid);
			if(AOS.empty(role_record)){
				AOS.tip('请选择角色');
				return;
			}
			if(AOS.empty(rowsFilter_record)){
				AOS.tip('请选择待配置的查询');
				return;
			};
			if(!AOS.empty(AOS.find(role_rowsFilter_grid,"sqlid",""+rowsFilter_record.data.sqlid))){
				AOS.tip('配置已经存在，请选择其他查询配置');
				return;
			}
			editing = role_rowsFilter_grid.getPlugin('id_plugin');
			role_rowsFilter_grid_store.insert(0, {
				role_id : role_record.data.id,
				data_filter_id : rowsFilter_record.data.id,
				sqlid : rowsFilter_record.data.sqlid,
				path : rowsFilter_record.data.path
			});
			editing.startEdit(0, 2);
		}
		//删除配置
		function role_rowsFilter_delete(){
			var rows = AOS.rows(role_rowsFilter_grid);
			if(rows === 0){
				AOS.tip('操作被取消，请先选中要删除的配置。');
				return;
			}
			AOS.ajax({
				url : 'dataFilterService.deleteRoleRowsFilter',
				params:{
					aos_rows: AOS.selection(role_rowsFilter_grid, 'id')
				},
				ok : function(data) {
					AOS.tip(data.appmsg);
					role_rowsFilter_grid_store.reload();
				}
			});
		}
    </script>
</aos:onready>