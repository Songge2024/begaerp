<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
	//form行占比      如果需要调整请在主页面设置 pageContext.setAttribute("type_code_columnWidth", ".5"); 如果未设置默认为：1
	if(AOSUtils.isEmpty(pageContext.getAttribute("type_code_columnWidth"))){
		pageContext.setAttribute("type_code_columnWidth", "1");
	};
%>
	<aos:combobox fieldLabel="项目类型" name="type_code" allowBlank="true" editable="false" columnWidth="${type_code_columnWidth}" 
	 url="projCommonsService.listComboBoxData&cb_id=type_code&cd_name=type_name&cb_table=bs_proj_types&queryDate=state=1" />
