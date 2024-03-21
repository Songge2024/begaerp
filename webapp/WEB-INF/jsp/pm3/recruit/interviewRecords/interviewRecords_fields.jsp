<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="result_id" fieldLabel="主键id" />
<aos:hiddenfield name="register_id" fieldLabel="登记Id" />
<aos:textfield name="name" fieldLabel="姓名" allowBlank="false"
	maxLength="10" readOnly="true" columnWidth=".5" />
<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex"
	 readOnly="true" columnWidth=".5" />
	<aos:datefield name="interview_date" fieldLabel="约定面试时间"
	allowBlank="false" readOnly="true" columnWidth=".5" />
<aos:datefield name="real_interviewer_time" fieldLabel="实际面试时间"
	allowBlank="false" columnWidth=".5" />
	<aos:fieldset title="人员基本情况">
	<aos:htmleditor name="base_situation" allowBlank="true" height="100"
		columnWidth="1" padding="5 5 5 5" />
</aos:fieldset>
<aos:hiddenfield name="interview_type" fieldLabel="面试类型" />
<aos:numberfield name="interview_score" fieldLabel="面试分数"
	allowBlank="false" minValue="0" maxValue="120" columnWidth=".5" />
<aos:numberfield name="written_score" fieldLabel="笔试分数"
	allowBlank="true" minValue="0" maxValue="120" columnWidth=".5" />
<aos:textfield name="interviewer" fieldLabel="面试官" allowBlank="true"
	maxLength="10" columnWidth=".5" />
<aos:combobox name="interview_result" fieldLabel="面试结果" columnWidth=".5"
	dicField="interview_result" value="2"  allowBlank="false" />
	<aos:fieldset title="结论说明">
	<aos:htmleditor name="conclusion" allowBlank="true" height="100"
		columnWidth="1" padding="5 5 5 5" />
</aos:fieldset>
<aos:hiddenfield name="create_user_id" fieldLabel="创建人Id" />
<aos:hiddenfield name="update_user_id" fieldLabel="更新人id" />
<aos:hiddenfield name="create_time" fieldLabel="创建时间" />
<aos:hiddenfield name="update_time" fieldLabel="更新时间" />
