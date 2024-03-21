<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
		//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("proj_teams_columnWidth", ".5");
		if(AOSUtils.isEmpty(pageContext.getAttribute("proj_teams_columnWidth"))){
		    pageContext.setAttribute("proj_teams_columnWidth", "1");
		};
		
		//下拉框名字
		if(AOSUtils.isEmpty(pageContext.getAttribute("md_fieldLabel"))){
			pageContext.setAttribute("md_fieldLabel", "项目模块");
		};
		
		//是否必填
		if(AOSUtils.isEmpty(pageContext.getAttribute("md_allowBlank"))){
			pageContext.setAttribute("md_allowBlank", "true");
		};
%>
	<aos:combobox fieldLabel="${md_fieldLabel}" id="md_module" name="module" allowBlank="${md_allowBlank}"  margin="5" editable="false" columnWidth="${proj_teams_columnWidth}" 
	url="moduleDivideService.listModuleDivideComboBox&proj_id=${proj_id}" />
