<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%%>
<!-- 公共查询表格 -->
<aos:formpanel id="query_form" layout="column" labelWidth="70" header="false" border="false">
	<aos:textfield name="keyWords" columnWidth="0.5" emptyText="请输入关键字"/>
	<aos:button text="查询" id="query_button" icon="query.png" margin="0 10 0 10" />
	<aos:button text="重置" onclick="AOS.reset(query_form);" icon="refresh.png" />
</aos:formpanel>
