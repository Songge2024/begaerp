<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
	<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="true" maxLength="100" columnWidth=".33" readOnly="true"/>
	<aos:combobox fieldLabel="项目类型" name="type_code" allowBlank="true" editable="false" columnWidth=".33" url="projCommonsService.listComboBoxData&cb_id=type_code&cd_name=type_name&cb_table=bs_proj_types" readOnly="true"/>
	<aos:hiddenfield name="proj_code" fieldLabel="项目编码" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:combobox fieldLabel="项目经理" name="pm_user_id" allowBlank="true" editable="false" columnWidth=".33" readOnly="true"
				url="projCommonsService.listComboBoxData&cb_id=id&cd_name=concat(id,name) &cb_table=aos_user&queryDate=id>0" />
	<aos:combobox fieldLabel="开发经理" name="pm2_user_id" allowBlank="true" editable="false" columnWidth=".33" readOnly="true"
				url="projCommonsService.listComboBoxData&cb_id=id&cd_name=concat(id,name)&cb_table=aos_user&queryDate=id>0" />
	<aos:textfield name="client_name" fieldLabel="客户名称" allowBlank="true" maxLength="50" columnWidth=".33" readOnly="true"/>
	<aos:hiddenfield name="client_address" fieldLabel="客户地址" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:textfield name="client_out_name" fieldLabel="客户项目责任人" allowBlank="true" maxLength="20" columnWidth=".33" readOnly="true"/>
	<aos:hiddenfield name="client_out_phone" fieldLabel="客户项目责任人电话" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:datefield name="begin_date" fieldLabel="项目启动时间" editable="false" allowBlank="true" columnWidth=".33" readOnly="true"/>
	<aos:hiddenfield name="period" fieldLabel="项目计划周期" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:hiddenfield name="ct_code" fieldLabel="合同号" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:numberfield name="ct_money" fieldLabel="项目总金额" allowBlank="true" minValue="0" maxValue="99999999" columnWidth=".33" readOnly="true" allowDecimals="true" decimalPrecision="2" xtype="number"/>
	<aos:hiddenfield name="pt_desc" fieldLabel="付款条件说明" allowBlank="true"  columnWidth=".33" readOnly="true" />
	<aos:numberfield name="ct_pay_money" fieldLabel="项目回款总金额" allowBlank="true" minValue="0" maxValue="99999999" columnWidth=".33" readOnly="true" allowDecimals="true" decimalPrecision="2" xtype="number" />
	<aos:hiddenfield name="rt_desc" fieldLabel="回款说明" allowBlank="true"  columnWidth=".33" readOnly="true"/>
	<aos:hiddenfield name="state" fieldLabel="状态" value="0" readOnly="true"/>

