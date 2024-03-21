<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="check_detail_id" fieldLabel="检查明细项ID" />
	<aos:textfield name="check_id" fieldLabel="检查单ID" allowBlank="false" maxLength="10"/>
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="false" maxLength="10"/>
	<aos:textfield name="check_detail_name" fieldLabel="检查明细项名称" allowBlank="true" maxLength="300"/>
	<aos:textfield name="process_product" fieldLabel="过程及产品" allowBlank="true" maxLength="33"/>
	<aos:textfield name="problem_level" fieldLabel="问题等级" allowBlank="true" maxLength="33"/>
	<aos:textfield name="deduct_point" fieldLabel="扣分标准" allowBlank="true" maxLength="33"/>
	<aos:textfield name="solve_deduct_point" fieldLabel="解决时限扣分标准" allowBlank="true" maxLength="33"/>
	<aos:textfield name="solve_times" fieldLabel="问题解决时限" allowBlank="true" maxLength="33"/>
	<aos:textfield name="state" fieldLabel="状态 1 不适用 2 符合 3 不符合" allowBlank="true" maxLength="12"/>
	<aos:textfield name="is_problem" fieldLabel="是否转问题-1是转，0是不转" allowBlank="true" maxLength="12"/>
	<aos:textfield name="trace_status" fieldLabel="跟踪情况" allowBlank="true" maxLength="3000"/>
	<aos:textfield name="create_user_id" fieldLabel="设计人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
