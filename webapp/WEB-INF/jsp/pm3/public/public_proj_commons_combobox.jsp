<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
		//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("proj_comm_columnWidth", ".5");
		if(AOSUtils.isEmpty(pageContext.getAttribute("proj_comm_columnWidth"))){
		    pageContext.setAttribute("proj_comm_columnWidth", "1");
		};
		//过滤人员id  如果需要过滤，请在主页面设置 pageContext.setAttribute("team_user_id", "1");
		if(AOSUtils.isEmpty(pageContext.getAttribute("team_user_id"))){
		    pageContext.setAttribute("team_user_id", "");
		};
		
		//下拉框名字
		if(AOSUtils.isEmpty(pageContext.getAttribute("pc_fieldLabel"))){
				pageContext.setAttribute("pc_fieldLabel", "项目列表");
		};
		
		//是否必填
		if(AOSUtils.isEmpty(pageContext.getAttribute("pc_allowBlank"))){
				pageContext.setAttribute("pc_allowBlank", "true");
		};
		//combobox 传type=all为查询所有开始项目，不传值，为查询当前登录用户下的项目
%>
	<aos:combobox fieldLabel="${pc_fieldLabel}" id="pp_list" name="project_list"  allowBlank="${pc_allowBlank}" margin="5" editable="false" columnWidth="${proj_comm_columnWidth}" 
	 url="projCommonsService.listComboBoxUerid&type=all"/>
	 
