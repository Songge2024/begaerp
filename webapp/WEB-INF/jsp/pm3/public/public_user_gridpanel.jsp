<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("type_code_columnWidth", ".5");
	if(AOSUtils.isEmpty(pageContext.getAttribute("proj_id_columnWidth"))){
		pageContext.setAttribute("proj_id_columnWidth", "1");
	}
%>

<aos:gridpanel id="public_user_gridpanel" url="projCommonsService.queryUnProjRoleTypes" displayInfo="false" 
			region="center">
			<aos:docked forceBoder="0 0 0 0">
				<aos:dockeditem xtype="tbtext" text="人员信息"/>
				<aos:triggerfield emptyText="姓名" id="comm_username" onenterkey="query_username" trigger1Cls="x-form-search-trigger" margin="0 5 0 0"
					onTrigger1Click="query_username" width="180" />
			</aos:docked>
			<aos:menu>
				<aos:menuitem xtype="menuseparator" />
				<aos:menuitem text="添加" onclick="role_user_save" icon="add.png" />
			</aos:menu>
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column type="rowno" align="center"/>
			<aos:column header="用户流水号" dataIndex="id" fixedWidth="150" hidden="true" />
			<aos:column header="所属组织流水号" dataIndex="org_id" fixedWidth="150" hidden="true" />
			<aos:column header="登录帐号" dataIndex="account" fixedWidth="120" hidden="true"/>
			<aos:column header="员工编号" dataIndex="id" fixedWidth="80"   align="center"/>
			<aos:column header="姓名" dataIndex="name" fixedWidth="80" align="center"/>
			<aos:column header="所属组织" dataIndex="org_name" fixedWidth="140" align="center"/>
			<aos:column header="所属角色" dataIndex="roles" celltip="true" minWidth="100" hidden="true" align="center"/>
			<aos:column header="性别" dataIndex="sex" fixedWidth="60" rendererField="sex" hidden="true" align="center"/>
</aos:gridpanel>