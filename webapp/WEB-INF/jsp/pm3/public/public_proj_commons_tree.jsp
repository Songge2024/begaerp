<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%
	//项目列表人员过滤     如果需要调整请在主页面设置 pageContext.setAttribute("team_user_id", "1"); 如果未设置默认查询所有项目
	//项目列表人员过滤     如果需要调整请在主页面设置 pageContext.setAttribute("state", "1"); 如果未设置默认查询项目状态为0
	if(AOSUtils.isEmpty(pageContext.getAttribute("team_user_id"))){
		pageContext.setAttribute("team_user_id", "");
	};
	if(AOSUtils.isEmpty(pageContext.getAttribute("state"))){
		pageContext.setAttribute("state", "0");
	};
%>


<aos:treepanel id="public_tree"  title="项目列表" singleClick="false" collapsible="true"  
split="true" region="west"   width="280" 
	cascade="true" rootVisible="false"
 url="projTypesService.getTreeData&team_user_id=${team_user_id}&state=${state}" 
				border="true" onitemclick="on_public_tree">
</aos:treepanel>