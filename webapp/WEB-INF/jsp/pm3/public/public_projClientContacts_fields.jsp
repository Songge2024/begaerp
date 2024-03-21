<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("type_code_columnWidth", ".5");
	if(AOSUtils.isEmpty(pageContext.getAttribute("proj_id_columnWidth"))){
		pageContext.setAttribute("proj_id_columnWidth", "1");
	}
%>
	<aos:combobox fieldLabel="项目名称" name="proj_id" allowBlank="true" editable="false" columnWidth="${proj_id_columnWidth}"
		url="projCommonsService.listComboBoxData&cb_id=proj_id&cd_name=proj_name&cb_table=bs_proj_commons" />
