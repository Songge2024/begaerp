<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:hiddenfield name="register_id" fieldLabel="登记Id" />
	<aos:fieldset title="人员基本情况" center="true">
	<aos:textfield name="name" fieldLabel="姓名" 	maxLength="10" readOnly="true" columnWidth=".3" />
	<aos:combobox name="sex" fieldLabel="性别" allowBlank="false" dicField="sex"
	 readOnly="true" columnWidth=".3" />
	<aos:datefield name="entry_date" fieldLabel="入职时间" format="Y-m-d"
	 columnWidth=".4" />
	</aos:fieldset>
	<aos:fieldset title="入职说明">
	<aos:combobox name="entry_type" fieldLabel="入职类型"  allowBlank="false" dicField="entry_type"
	  columnWidth=".5" />
	<aos:combobox name="entry_post" fieldLabel="入职岗位"  allowBlank="false" dicField="entry_post"
	  columnWidth=".5" />
	<aos:textfield name="experience" fieldLabel="经验" allowBlank="true" columnWidth=".5" maxLength="255"/>
	<aos:textfield name="train_situation" fieldLabel="培训情况"  columnWidth=".5" maxLength="255"/>
	<aos:textareafield name="result_remark" fieldLabel="备注" height="100" columnWidth="1" maxLength="255" />
	</aos:fieldset>
