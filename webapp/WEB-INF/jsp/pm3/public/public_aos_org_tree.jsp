<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%
%>


<aos:treepanel id="aos_user_tree" flex="1" title="员工列表树" singleClick="false" cascade="true" rootVisible="false"
				url="projTeamsService.queryDepartmentTree" border="true" >
</aos:treepanel>