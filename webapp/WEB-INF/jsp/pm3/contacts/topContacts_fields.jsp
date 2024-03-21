<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="top_id" fieldLabel="常用id" />
	<aos:textfield name="top_name" fieldLabel="常用联系人" allowBlank="true" maxLength="765"/>
	<aos:textfield name="user_id" fieldLabel="用户ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_id" fieldLabel="创建人id" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="top_org_name" fieldLabel="常用联系人所属部门" allowBlank="true" maxLength="765"/>
	<aos:textfield name="top_role_name" fieldLabel="常用联系人角色" allowBlank="true" maxLength="765"/>
	<aos:textfield name="top_sex" fieldLabel="常用联系人性别" allowBlank="true" maxLength="765"/>
