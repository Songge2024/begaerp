<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="register_id" fieldLabel="register_id" />
<aos:hiddenfield name="state" fieldLabel="状态" />
<aos:fieldset title="人员基本信息" columnWidth="1" height="140"
	msgTarget="qtip" >
	<aos:textfield name="name" fieldLabel="姓名" maxLength="100" readOnly="true"
		columnWidth=".5" allowBlank="false" />
	<aos:combobox name="sex" fieldLabel="性别" columnWidth=".5" readOnly="true"
		dicField="sex" value="1" margin="0 10 0 0" allowBlank="false" />
	<aos:textfield name="source" fieldLabel="来源" allowBlank="true" readOnly="true"
		maxLength="100" columnWidth=".5" />
	<aos:textfield name="link_phone" fieldLabel="联系方式" maxLength="20" readOnly="true"
		columnWidth=".5" margin="0 10 0 0" allowBlank="false" />
	<aos:textfield name="register_user_name" fieldLabel="登记人" readOnly="true" 
		allowBlank="true" columnWidth=".5"/>
	<aos:hiddenfield name="register_user_id" fieldLabel="登记人" readOnly="true"
		allowBlank="true"  />
	<aos:datefield name="register_date" fieldLabel="登记日期" readOnly="true" 
		allowBlank="true"  columnWidth=".5"  margin="0 10 0 0"/>
		 <aos:textfield name="register_remark" fieldLabel="登记备注" readOnly="true"
		allowBlank="true" maxLength="100" columnWidth="1" margin="0 10 0 0"/>
</aos:fieldset>
<aos:fieldset title="人员通知情况" columnWidth="1" height="120"
	msgTarget="qtip" >
	<aos:datefield name="contact_date" fieldLabel="联系日期" allowBlank="false"
		value="${time}" columnWidth=".5" />
	<aos:textfield name="contact_user_name" fieldLabel="联系人" margin="0 10 0 0" 
		allowBlank="true" columnWidth=".5" value="${name}" maxLength="20" />
	<aos:hiddenfield name="contact_user_id" fieldLabel="联系人" 
		value="${userid}" />
		<aos:combobox name="contact_result" fieldLabel="联系结果" dicField="contact_result"
		allowBlank="false"   columnWidth=".5" />
	<aos:textfield name="contact_information" fieldLabel="联系情况(过程)" margin="0 10 0 0"
		allowBlank="true" maxLength="100" columnWidth=".5"  />
	<aos:datefield name="notify_interview_date" fieldLabel="约定面试日期" value="${time}"
		columnWidth=".5" />
	 <aos:datefield name="notify_entry_time" fieldLabel="通知入职时间" format="Y-m-d"  margin="0 10 0 0"
	 columnWidth=".5" />
</aos:fieldset>
