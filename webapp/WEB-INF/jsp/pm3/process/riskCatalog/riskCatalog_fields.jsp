<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="risk_cata_id" fieldLabel="风险目录ID" />
	<aos:textareafield name="risk_cata_name" fieldLabel="风险目录名称" allowBlank="false" height="100"  maxLength="1000"/>
	<aos:textareafield name="comment" fieldLabel="说明" allowBlank="true" height="100"  maxLength="1000"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="设计人" allowBlank="true" />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true" />
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" />
