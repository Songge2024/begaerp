<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%
		//form列占比      如果需要调整请在主页面设置 pageContext.setAttribute("pr_process_columnWidth", ".5");
		if(AOSUtils.isEmpty(pageContext.getAttribute("pr_process_columnWidth"))){
		    pageContext.setAttribute("pr_process_columnWidth", "1");
		};
		////过滤评审文档
		if(AOSUtils.isEmpty(pageContext.getAttribute("proj_id"))){
		    pageContext.setAttribute("proj_id", "1");
		};
%>
	<aos:combobox fieldLabel="评审文档" id="pp_review" name="review_document"  allowBlank="true"  editable="false" margin="5" columnWidth="${pr_process_columnWidth}" 
	url="processService.listComboBoxPr_PRocess&proj_id=${proj_id}" />
