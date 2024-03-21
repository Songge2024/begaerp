<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("type_code_columnWidth", ".5");
	if(AOSUtils.isEmpty(pageContext.getAttribute("proj_id_columnWidth"))){
		pageContext.setAttribute("proj_id_columnWidth", "1");
	}
%>
<aos:gridpanel  id="public_projRoleTypes_gridpanel" url="projRoleTypesService.queryPage" onitemclick="public_user_gridpanel_query"
	onrender="projRoleTypes_query" displayInfo="false" forceFit="true" region="center" >
	<aos:docked forceBoder="0 0 0 0" >
		<aos:dockeditem xtype="tbtext" text="项目角色信息" />
			<aos:dockeditem text="刷新" icon="refresh.png"    onclick="refresh_team" />
	</aos:docked>
	<aos:menu>
	<aos:menuitem xtype="menuseparator" />
		<aos:menuitem text="刷新" onclick="#public_projRoleTypes_gridpanel_store.reload();" icon="refresh.png" />
	</aos:menu>
	<aos:column type="rowno" align="center" />
	<aos:column header="角色id" dataIndex="trp_code" fixedWidth="80" hidden="true" />
	<aos:column header="角色名称" dataIndex="trp_name" fixedWidth="90" align="center"/>
	<aos:column header="描述" dataIndex="trp_remark" fixedWidth="120" align="left"/>
	<aos:column header="统计人数" dataIndex="count_role" fixedWidth="62" align="left"/>
	<aos:column header="系统角色" dataIndex="aos_role_id" hidden="true" fixedWidth="120" align="center"/>
</aos:gridpanel>