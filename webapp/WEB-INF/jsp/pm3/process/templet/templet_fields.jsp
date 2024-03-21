<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="templet_id" fieldLabel="模板id" />	
	<aos:textfield msgTarget="qtip" name="templet_name" fieldLabel="模板名称" allowBlank="false" maxLength="50"/>
	<aos:textfield name="templet_comment" fieldLabel="说明" allowBlank="false" maxLength="100"/>
