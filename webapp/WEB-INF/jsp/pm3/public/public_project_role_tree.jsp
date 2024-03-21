<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%
	
%>

 
<aos:treepanel id="project_role_tree" title="项目角色树" collapsible="true" expandAll="true"
	split="true" region="west" collapseMode="mini"  width="350"
	cascade="true" rootVisible="false"
	url="projCommonsService.getProjectRoleTree" border="true"
	onitemclick="on_public_tree">
</aos:treepanel>
