<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
	<aos:textfield name="proj_code" fieldLabel="项目编码" allowBlank="true" maxLength="50" readOnly="true" columnWidth=".3" />
	<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="true" maxLength="100"  readOnly="true"  columnWidth=".4" />
	<aos:hiddenfield fieldLabel="项目经理" name="pm_user_name" columnWidth=".3"/>
	<aos:hiddenfield fieldLabel="程序经理" name="pm2_user_name"   columnWidth=".3"/>
	<aos:datefield name="begin_date" fieldLabel="项目启动时间" editable="true" allowBlank="true" readOnly="true"  columnWidth=".3" />

