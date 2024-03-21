<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:fieldset title="项目基本信息" labelWidth="100" columnWidth="1" border="true" autoScroll="true">
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" />
	<%@ include file="../../public/public_projTypes_fields.jsp"%>
<%-- 	<aos:textfield name="type_code" fieldLabel="项目类型" allowBlank="false" maxLength="12" columnWidth=".5" /> --%>
	<aos:textfield name="proj_code" fieldLabel="项目编码" allowBlank="false" maxLength="50" columnWidth=".45" />
	<aos:textfield name="proj_name" fieldLabel="项目名称" allowBlank="false" maxLength="100" columnWidth=".95" />
	<aos:textfield name="project_for_short" fieldLabel="项目简称" allowBlank="false" maxLength="100" columnWidth=".45" />
	<aos:combobox fieldLabel="项目经理" multiSelect="true" name="pm_user_id"  editable="false" columnWidth=".45"
				url="projCommonsService.listComboBoxData&cb_id=id&cd_name=concat(id,name) &cb_table=aos_user&queryDate=id>0"  hidden="true"/>
	<aos:combobox fieldLabel="开发经理" hidden="true" multiSelect="true" name="pm2_user_id"  editable="false" columnWidth=".5"
				url="projCommonsService.listComboBoxData&cb_id=id&cd_name=concat(id,name)&cb_table=aos_user&queryDate=id>0" />
	<aos:datefield name="begin_date" fieldLabel="项目启动时间" editable="false" allowBlank="false" columnWidth=".5" />
	<aos:textfield name="period" fieldLabel="计划周期(周)" allowBlank="true" maxLength="10" columnWidth=".45" />
	<aos:datefield name="plan_completion_time" fieldLabel="计划完成时间" editable="false" allowBlank="false" columnWidth=".5" format="Y-m-d"/>
	<aos:hiddenfield name="for_ct_id" id="ct_id"/>
		<aos:triggerfield fieldLabel="来源合同" name="for_ct_name" id="ct_name" editable="false" trigger1Cls="x-form-search-trigger" onTrigger1Click="contract_grid_show" columnWidth=".65" />
		<aos:numberfield fieldLabel="计划工作总量" name="plan_workload" allowBlank="false" columnWidth="0.3" editable="true" step="0.1" decimalPrecision="1"  minValue="0" maxValue="10000" />
	<aos:htmleditor name="rt_desc" fieldLabel="备注" allowBlank="true" height="100" columnWidth="1" />
</aos:fieldset>


<aos:fieldset title="客户基本信息" labelWidth="120" columnWidth="1" border="true" autoScroll="true">
	<aos:textfield name="client_name" labelWidth="100" fieldLabel="客户名称" allowBlank="true" maxLength="50" columnWidth=".5" />
	<aos:textfield name="client_out_name" fieldLabel="客户项目责任人姓名" allowBlank="true" maxLength="20" columnWidth=".45" />
	<aos:textfield name="client_address" labelWidth="100" fieldLabel="客户地址" allowBlank="true" maxLength="200" columnWidth=".5" />
	<aos:textfield name="client_out_phone" fieldLabel="客户项目责任人电话" allowBlank="true" maxLength="50" columnWidth=".45" />
</aos:fieldset>
	<aos:hiddenfield name="state" fieldLabel="状态" value="0"/>

