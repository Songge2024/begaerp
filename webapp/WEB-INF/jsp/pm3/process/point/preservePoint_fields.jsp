<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="id" fieldLabel="扣分标准ID" />
	<aos:combobox name="problem_level" fieldLabel="问题等级" dicField="problem_level" allowBlank="false" />
	<aos:textfield name="deduct_point" fieldLabel="扣分标准" allowBlank="false" maxLength="11"/>
	<aos:textfield name="solve_deduct_point" fieldLabel="解决时限扣分标准" allowBlank="false" maxLength="11"/>
	<aos:textfield name="solve_times" fieldLabel="问题解决时限" allowBlank="false" maxLength="11"/>
