<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="result_id" fieldLabel="主键id" />
<aos:hiddenfield name="register_id" fieldLabel="登记Id" />
<aos:textfield name="name" fieldLabel="姓名" allowBlank="false"
	maxLength="10" readOnly="true" columnWidth=".5" />
<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex"
	 readOnly="true" columnWidth=".5" />
	 <aos:datefield name="notify_interview_date" fieldLabel="通知面试时间" format="Y-m-d" readOnly="true"
	 columnWidth=".5" />
	 <aos:datefield name="interview_date" fieldLabel="实际面试时间" format="Y-m-d" value="${time}"
	 columnWidth=".5" />
<aos:textareafield name="base_situation" fieldLabel="人员基本情况" height="100" columnWidth="1" maxLength="255" />
<aos:numberfield name="interview_score" fieldLabel="面试分数"
	 minValue="0" maxValue="120" columnWidth=".5" />
<aos:numberfield name="written_score" fieldLabel="笔试分数"
	allowBlank="true" minValue="0" maxValue="120" columnWidth=".5" />
	<aos:combobox name="interview_result" fieldLabel="面试结果" allowBlank="false" dicField="interviewer_result"
	 columnWidth=".5" />
<aos:textfield name="interviewer_name" fieldLabel="面试官" allowBlank="true" value="${name}" columnWidth=".5"
	/>
	<aos:hiddenfield name="interviewer" fieldLabel="面试官"  value="${userid}"
	/>
<aos:textareafield name="conclusion" fieldLabel="结论说明" height="100" columnWidth="1" maxLength="255" />
