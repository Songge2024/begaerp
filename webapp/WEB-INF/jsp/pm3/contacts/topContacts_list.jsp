<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	String userid = userModel.getId().toString();
%>
<aos:html title="常用联系人" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel id="topContacts_grid" url="topContactsService.page" onrender="topContacts_query" forceFit="true" region="center" bodyBorder="1 0 1 0">
			<aos:menu>
				<aos:menuitem text="新增" onclick="topContacts_win_show" icon="add.png" />
				<aos:menuitem text="删除" onclick="topContacts_delete" icon="del.png" />
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="刷新" onclick="#topContacts_grid_store.reload();" icon="refresh.png" />
			</aos:menu>
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="常用联系人信息" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增" icon="add.png"  onclick="topContacts_win_show" />
				<aos:dockeditem text="删除" icon="del.png" onclick="topContacts_delete" />
			</aos:docked>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" />
				<aos:column header="常用联系人ID" dataIndex="top_id" fixedWidth="100" hidden="true"/>
				<aos:column header="常用联系人" dataIndex="top_name" fixedWidth="100" />
				<aos:column header="用户ID" dataIndex="user_id" fixedWidth="100" hidden="true"/>
				<aos:column header="创建人id" dataIndex="create_id" fixedWidth="100" hidden="true"/>
				<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" hidden="true"/>
				<aos:column header="常用联系人所属部门" dataIndex="top_org_name_id" fixedWidth="150" hidden="true"/>
				<aos:column header="常用联系人所属部门" dataIndex="top_org_name" fixedWidth="150" />
				<aos:column header="常用联系人角色" dataIndex="top_role_name" fixedWidth="150" />
				<aos:column header="常用联系人性别" dataIndex="top_sex" fixedWidth="150" rendererFn="fn_sex"/>
		</aos:gridpanel>
	</aos:viewport>
	
	<aos:window id="topContacts_create_win" title="常新增用联系人">
		<aos:formpanel  id="topContacts_create_form" width="450" layout="anchor" labelWidth="70" >
			<aos:hiddenfield name="top_id" fieldLabel="常用联系人ID"/>
			<aos:textfield  fieldLabel="常用联系人姓名" name="top_name" allowBlank="false"  margin="5" columnWidth="1" />
<%-- 			<aos:combobox id="top_org_name" fieldLabel="常用联系人所属部门" name="top_org_name_id" allowBlank="false" editable="false" width="150" queryMode="local"  --%>
<%-- 						url="topContactsService.listPrincipalOrg" />   --%>
			<aos:hiddenfield fieldLabel="创建人id" name="create_id"/>
			<aos:hiddenfield fieldLabel="创建时间" name="create_time"/>
			<aos:hiddenfield fieldLabel="用户ID" name="user_id"/>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="topContacts_create" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#topContacts_create_win.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	
	<script type="text/javascript">
		//显示新增窗口
		function topContacts_win_show(type){
			AOS.reset(topContacts_create_form);
			topContacts_create_win.show();
		}
		//查询
		function topContacts_query() {
			var params = AOS.getValue('query_form');
			var user_id = ${user.id};
		    topContacts_grid_store.getProxy().extraParams = {
		    	create_id : user_id
		    };
		    topContacts_grid_store.loadPage(1);
		}
		//新增
		function topContacts_create() {
			AOS.ajax({
				forms : topContacts_create_form,
				url : 'topContactsService.create',
				ok : function(data) {
					AOS.tip(data.appmsg);
					topContacts_grid_store.reload();
					topContacts_create_win.hide();
				}
			});
		}
		//修改
		function topContacts_update() {
			AOS.ajax({
				forms : topContacts_update_form,
				url : 'topContactsService.update',
				ok : function(data) {
					AOS.tip(data.appmsg);
					topContacts_grid_store.reload();
					topContacts_update_win.hide();
				}
			});
		}
		//删除
		function topContacts_delete(){
			var selection = AOS.selection(topContacts_grid, 'top_id');
			if(AOS.empty(selection)){
				AOS.tip('删除前请先选中数据。');
				return;
			}
			var rows = AOS.rows(topContacts_grid);
			var msg =  AOS.merge('确认要删除选中的{0}条联系人记录吗？', rows);
			AOS.confirm(msg, function(btn){
				if(btn === 'cancel'){
					AOS.tip('删除操作被取消。');
					return;
				}
				AOS.ajax({
					url : 'topContactsService.delete',
					params:{
						aos_rows: selection
					},
					ok : function(data) {
						AOS.tip(data.appmsg);
						topContacts_grid_store.reload();
					}
				});
			});
		}
		
		//性别值转换
		function fn_sex(value, metaData, record, rowIndex, colIndex,
				store) {
			if(value=='1'){
				value='男'
			}
			if(value=='2'){
				value='女'
			}
			if(value=='3'){
				value='未知'
			}
			return value
		}
	</script>
</aos:onready>