<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="register_id" fieldLabel="register_id" />
<aos:hiddenfield name="state" fieldLabel="状态" />
<aos:fieldset title="人员基本信息" columnWidth="1" height="140"
	msgTarget="qtip" >
	<aos:textfield name="name" fieldLabel="姓名" maxLength="100"
		columnWidth=".5" allowBlank="false" />
	<aos:combobox name="sex" fieldLabel="性别" columnWidth=".5"
		dicField="sex" value="1" margin="0 10 0 0" allowBlank="false" />
	<aos:textfield name="source" fieldLabel="来源" allowBlank="true"
		maxLength="100" columnWidth=".5" />
	<aos:textfield name="link_phone" fieldLabel="联系方式" maxLength="20"
		columnWidth=".5" margin="0 10 0 0" allowBlank="false" />
	<aos:textfield name="register_user_name" fieldLabel="登记人" readOnly="true"
		allowBlank="true" value="${name}" columnWidth=".5"/>
	<aos:hiddenfield name="register_user_id" fieldLabel="登记人"
		allowBlank="true" value="${userid}" />
	<aos:datefield name="register_date" fieldLabel="登记日期" readOnly="true"
		allowBlank="true" value="${time}" columnWidth=".5"  margin="0 10 0 0"/>
		 <aos:textfield name="register_remark" fieldLabel="登记备注"
		allowBlank="true" maxLength="100" columnWidth="1" margin="0 10 0 0"/>
</aos:fieldset>
<aos:hiddenfield name="create_user_id" fieldLabel="创建人Id" value="${userid}"/>
<aos:hiddenfield name="create_user_name" fieldLabel="创建人" value="${name}"/>
<aos:hiddenfield name="update_user_id" fieldLabel="更新人id" />
<aos:hiddenfield name="create_time" fieldLabel="创建时间" value="${time}"/>
<aos:hiddenfield name="update_time" fieldLabel="更新时间" />