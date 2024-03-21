<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="trp_code" fieldLabel="TRP_CODE" />
	<aos:hiddenfield name="state" fieldLabel="状态" value="0"/>
	<%--<aos:combobox  fieldLabel="系统角色" name="aos_role_id" dicField="system_role" emptyText="系统角色名称" --%>
			<%--selectAll="true" columnWidth="1" allowBlank="false" url="projRoleTypesService.listComboBoxRoleData&length=9"--%>
					<%--/>--%>
	<aos:textfield name="trp_name" fieldLabel="项目角色" allowBlank="false" maxLength="150" columnWidth="1"/>
	<aos:numberfield name="sort_no" fieldLabel="排序号" allowBlank="false" allowDecimals="false" minValue="0" maxValue="2147483647" columnWidth="1" />
	<aos:fieldset title="描述" >
			<aos:htmleditor name="trp_remark"  allowBlank="true"
			columnWidth="1" padding="5 5 5 5" />
	</aos:fieldset>
