<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" id="proj_common_ids"/>
	<aos:combobox fieldLabel="项目类型" name="type_code" allowBlank="true" editable="false" readOnly="true" columnWidth=".25" 
	url="projCommonsService.listComboBoxData&cb_id=type_code&cd_name=type_name&cb_table=bs_proj_types" />
<%-- 	<aos:textfield name="type_code" fieldLabel="项目类型" allowBlank="false" maxLength="12" columnWidth=".3" /> --%>
	<aos:textfield name="proj_code" fieldLabel="项目编码" allowBlank="true" maxLength="50" readOnly="true" columnWidth=".25" />
	<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="true" maxLength="100" id="proj_name_ids" readOnly="true"  columnWidth=".25" />
	<aos:hiddenfield fieldLabel="项目经理" name="pm_user_name" columnWidth=".3"/>
	<aos:hiddenfield fieldLabel="开发经理" name="pm2_user_name"   columnWidth=".3"/>
	<aos:datefield name="begin_date" fieldLabel="项目启动时间" editable="true" allowBlank="true" readOnly="true"  columnWidth=".23" />

