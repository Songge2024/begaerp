<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
		//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("proj_teams_columnWidth", ".5");
		if(AOSUtils.isEmpty(pageContext.getAttribute("proj_teams_columnWidth"))){
		    pageContext.setAttribute("proj_teams_columnWidth", "1");
		};
		//过滤项目id  如果需要过滤，请在主页面设置 pageContext.setAttribute("proj_code", "1");
		if(AOSUtils.isEmpty(pageContext.getAttribute("proj_id"))){
		    pageContext.setAttribute("proj_id", "");
		};
%>
	<aos:combobox fieldLabel="项目人员" id="pp_project"  name="project_personnel" multiSelect="true" allowBlank="true"  editable="false" margin="5" columnWidth="${proj_teams_columnWidth}" 
	url="projCommonsService.listComboBoxProjId&proj_id=${proj_id}" />
