<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="type_code" fieldLabel="类型CODE" />
	<aos:textfield name="type_name" fieldLabel="类型名称" allowBlank="true" maxLength="150"/>
	<aos:textfield name="type_desc" fieldLabel="类型描述" allowBlank="true" maxLength="65535"/>
	<aos:textfield name="model" fieldLabel="开发模型" allowBlank="true" maxLength="3"/>
	<aos:textfield name="state" fieldLabel="状态" allowBlank="true" maxLength="12"/>
	<aos:textfield name="create_user_id" fieldLabel="创建人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
