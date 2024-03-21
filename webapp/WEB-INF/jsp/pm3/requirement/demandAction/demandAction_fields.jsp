<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:fieldset title="需求基本信息" id="Basic_requirement_information"
	labelWidth="100" columnWidth="1" autoScroll="true">
	<aos:hiddenfield name="ad_id" fieldLabel="需求表ID" />
	<aos:hiddenfield name="ad_code" fieldLabel="需求功能表ID" />
	<aos:combobox fieldLabel="项目名称" name="proj_id" allowBlank="true"
		editable="false" columnWidth=".33"
		url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
	<aos:triggerfield fieldLabel="功能模块" name="dm_code_name"
		editable="false" trigger1Cls="x-form-search-trigger"
		onTrigger1Click="proj_tree_show" columnWidth="0.33" />
	<aos:hiddenfield name="dm_code" />
	<aos:combobox name="ad_type" id="ad_type" fieldLabel="需求类型"
		dicField="ad_type_id" emptyText="需求类型" columnWidth=".33" value="1"
		allowBlank="false" onchange="demandAction_fields_ad_type_change" />
<%-- 	<aos:textfield name="demand_code" fieldLabel="需求编码" allowBlank="true" --%>
<%-- 		maxLength="50" columnWidth=".33" /> --%>
	<aos:textfield name="ad_name" fieldLabel="需求名称" allowBlank="false"
		maxLength="100" columnWidth=".33" />
	<aos:combobox name="ad_source" fieldLabel="需求来源" allowBlank="false"
		dicField="re_ad_source" columnWidth=".33" value="1" />
	<aos:datetimefield name="ad_raise_date" id="put_time" fieldLabel="提出时间"
		editable="false" allowBlank="false" columnWidth=".33"
		onchange="on_ad_raise_date" />
	<aos:datefield name="ad_claim_start_date" fieldLabel="要求开始时间"
		editable="false" columnWidth=".33" />
	<aos:datefield name="ad_claim_finish_date" fieldLabel="要求完成时间"
		editable="false" columnWidth=".33" />
	<aos:datefield name="ad_plan_finish_date" id="ad_plan_finish_date"
		fieldLabel="计划完成时间" editable="false" columnWidth=".33" />
	<aos:datefield name="ad_actual_finish_date" fieldLabel="实际完成时间"
		id="ad_actual_finish_date" editable="false" allowBlank="true"
		columnWidth=".33" />
	<aos:numberfield name="ad_workload" id="ad_workload" decimalPrecision="1"
		fieldLabel="估算工作量(天)" minValue="0.1" maxValue="9999.99" columnWidth=".33" />
	<aos:combobox name="ad_difficulty" fieldLabel="难易程度"
		dicField="re_ad_difficulty" columnWidth=".33" value="1" />
	<aos:combobox fieldLabel="优先级" name="ad_priority" value="3"
		columnWidth="0.33">
		<aos:option value="4" display="不急" />
		<aos:option value="3" display="普通" />
		<aos:option value="2" display="急" />
		<aos:option value="1" display="特急" />
	</aos:combobox>
	<aos:combobox fieldLabel="产品是否满足" name="is_product_satisfied" value="0"
		dicField="is_product_satisfied" columnWidth="0.33"/>
	<aos:combobox fieldLabel="状态" name="state" value="0"
		dicField="global_state" columnWidth="0.33" hidden="true">
	</aos:combobox>
	<aos:textfield name="development_member" fieldLabel="开发成员" allowBlank="true"
		maxLength="999" columnWidth=".33" />
</aos:fieldset>
<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="需求内容">
	<aos:panel columnWidth="0.9" margin="5" padding="5 0 5 5"
		contentEl="content_desc_div" />
</aos:fieldset>

<aos:fieldset labelWidth="70" columnWidth="1" border="true" title="来源说明">
	<aos:panel columnWidth="0.9" margin="5" padding="5 0 5 5"
		contentEl="demand_desc_div" />
</aos:fieldset>

<aos:textfield name="ad_remark" fieldLabel="备注" labelAlign="left"
	labelWidth="45" maxLength="200" columnWidth=".9" />


<aos:fieldset title="需求变更信息" id="demandAction_change_fields"
	labelWidth="100" columnWidth="1" border="true" hidden="true">
	<aos:combobox name="ad_chage_source" allowBlank="true"
		fieldLabel="变更来源" dicField="re_ad_chage_source" columnWidth=".33" />
	<aos:textfield name="ad_chage_introducer" allowBlank="true"
		fieldLabel="变更提出人" maxLength="100" columnWidth=".33" />
	<aos:textfield name="ad_chage_number" allowBlank="true"
		fieldLabel="变更软件版本号" maxLength="20" columnWidth=".33" />
	<aos:htmleditor name="ad_chage_audit" allowBlank="true"
		fieldLabel="变更审核意见" columnWidth=".99" />
</aos:fieldset>

