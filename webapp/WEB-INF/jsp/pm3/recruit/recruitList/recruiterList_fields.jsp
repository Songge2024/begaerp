<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="register_id" fieldLabel="register_id" />
<%-- <aos:fieldset title="用户头像"  columnWidth=".2" contentEl="div_photo" height="250" /> --%>
<aos:fieldset title="人员基本信息" columnWidth="1" height="80">
	<aos:textfield name="name" fieldLabel="姓名" maxLength="100"
		columnWidth=".5" allowBlank="false" />
	<aos:combobox name="sex" fieldLabel="性别" columnWidth=".5"
		dicField="sex" value="1" margin="0 10 0 0" allowBlank="false" />
	<aos:textfield name="source" fieldLabel="来源" allowBlank="true"
		maxLength="100" columnWidth=".5" />
	<aos:textfield name="link_phone" fieldLabel="联系方式" maxLength="20"
		columnWidth=".5" margin="0 10 0 0" allowBlank="false" />
	<aos:hiddenfield name="register_user_name" fieldLabel="登记人"
		allowBlank="true" value="${name}" />
	<aos:hiddenfield name="register_user_id" fieldLabel="登记人"
		allowBlank="true" value="${userid}" />
	<aos:hiddenfield name="register_date" fieldLabel="登记日期"
		allowBlank="true" />
</aos:fieldset>
<aos:fieldset title="人员联系情况" columnWidth="1" height="150">
	<aos:textfield name="contact_user_name" fieldLabel="联系人"
		allowBlank="true" readOnly="true" columnWidth=".5" value="${name}" maxLength="20"/>
	<aos:hiddenfield name="contact_user_id" fieldLabel="联系人"
		value="${userid}" />
	<aos:datefield name="contact_date" fieldLabel="联系日期" allowBlank="false"
		columnWidth=".5" margin="0 10 0 0" />
	<aos:textfield name="register_remark" fieldLabel="登记备注"
		allowBlank="true" maxLength="100" columnWidth=".5" />
	<aos:textfield name="contact_information" fieldLabel="联系情况"
		allowBlank="true" maxLength="100" columnWidth=".5" margin="0 10 0 0" />
	<aos:datefield name="interview_date" fieldLabel="约定面试日期"
		columnWidth=".5" allowBlank="false" />
	<aos:datefield name="notify_entry_time" fieldLabel="通知入职时间"
		allowBlank="true" columnWidth=".5" margin="0 10 0 0" />
	<aos:textfield name="contact_result" fieldLabel="联系结果"
		allowBlank="true" margin="0 10 0 0" maxLength="100" columnWidth="1"
		msgTarget="qtip" />
</aos:fieldset>