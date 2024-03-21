<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="cont_id" fieldLabel="联系人ID" />
	<aos:textfield name="cont_name" fieldLabel="联系人姓名" allowBlank="false" columnWidth=".5" maxLength="20"/>
	<aos:textfield name="cont_phone" fieldLabel="联系人电话"  columnWidth=".5" maxLength="20"/>
	<aos:textfield name="cont_email" fieldLabel="联系人邮箱" allowBlank="true" columnWidth=".5" maxLength="10"/>
	<aos:textfield name="cont_remark" fieldLabel="沟通说明" allowBlank="true" columnWidth=".5" maxLength="10"/>
	<aos:textfield name="cont_frequency" fieldLabel="沟通频次" allowBlank="true" columnWidth=".5" maxLength="10"/>
	<aos:textfield name="cont_desc" fieldLabel="联系人说明" allowBlank="true" columnWidth=".5" maxLength="200"/>
