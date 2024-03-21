<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="work_id" fieldLabel="工期" />
	<aos:textfield name="user_id" fieldLabel="人员ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="true" maxLength="33"/>
	<aos:textfield name="test_code" fieldLabel="周报编码" allowBlank="true" maxLength="60"/>
	<aos:textfield name="work_hours" fieldLabel="基地工时" allowBlank="true" maxLength="30"/>
	<aos:textfield name="business_hours" fieldLabel="出差工时" allowBlank="true" maxLength="30"/>
