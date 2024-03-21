<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID"/>
	<aos:hiddenfield name="proj_name" fieldLabel="项目名称" columnWidth="0.33" readOnly="true"/>
	<aos:hiddenfield name="type_code" columnWidth="0.33" fieldLabel="项目类型id"/>
	<aos:textfield name="type_code_name" columnWidth="0.33" fieldLabel="项目类型" readOnly="true" />
	<aos:textfield name="pm_user_name" columnWidth="0.33" fieldLabel="项目经理" readOnly="true" />
	<aos:textfield name="pm2_user_name" columnWidth="0.33" fieldLabel="开发经理" readOnly="true"/>
	<aos:textfield name="client_name" columnWidth="0.33" fieldLabel="客户名称" readOnly="true"/>
	<aos:hiddenfield name="client_address" columnWidth="0.33" fieldLabel="客户地址" readOnly="true" />
	<aos:textfield name="begin_date" columnWidth="0.33" fieldLabel="启动时间" readOnly="true"/>
	<aos:combobox name = "state" columnWidth="0.33" fieldLabel="项目状态" dicField="global_state" readOnly="true" />
	<script type="text/javascript">

	</script>