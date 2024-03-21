<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="demand_look_win" title="查看需求信息" autoScroll="true">
	<aos:formpanel id="demand_look_form" width="800" height="410"
		layout="column" labelWidth="120" autoScroll="true" msgTarget="qtip">
		<aos:fieldset title="需求基本信息" labelWidth="100" columnWidth="1"
			autoScroll="true">
			<aos:combobox fieldLabel="项目名称" name="proj_id" allowBlank="true"
				editable="false" columnWidth=".33" readOnly="true"
				url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}" />
			<aos:triggerfield fieldLabel="功能模块" name="dm_code_name"
				editable="false" trigger1Cls="x-form-search-trigger" readOnly="true"
				onTrigger1Click="proj_tree_show" columnWidth="0.33" />
			<aos:hiddenfield name="dm_code" />
			<aos:combobox name="ad_type" fieldLabel="需求类型" readOnly="true"
				dicField="ad_type_id" emptyText="需求类型" columnWidth=".33" value="1"
				onchange="demandLook_fields_ad_type_change" />
			<aos:textfield name="ad_name" fieldLabel="需求名称"   columnWidth=".33" readOnly="true" />
			<aos:combobox name="ad_source" fieldLabel="需求来源" readOnly="true"
				dicField="re_ad_source" columnWidth=".33" value="1" />
			<aos:datetimefield name="ad_raise_date" readOnly="true"
				fieldLabel="提出时间" editable="false" columnWidth=".33" value="${time}"
				onchange="on_ad_raise_date" />
			<aos:datefield name="ad_claim_finish_date" fieldLabel="要求完成时间"
				readOnly="true" editable="false" columnWidth=".33" />
			<aos:datefield name="ad_plan_finish_date" fieldLabel="计划完成时间"
				readOnly="true" editable="false" columnWidth=".33" />
			<aos:datefield name="ad_actual_finish_date" fieldLabel="实际完成时间"
				readOnly="true" editable="false" allowBlank="true" columnWidth=".33" />
			<aos:numberfield name="ad_workload" fieldLabel="估算工作量(天)"
				readOnly="true" maxValue="99999.99" columnWidth=".33" />
			<aos:combobox name="ad_difficulty" fieldLabel="难易程度" readOnly="true"
				dicField="re_ad_difficulty" columnWidth=".33" value="1" />
			<aos:combobox fieldLabel="优先级" name="ad_priority" value="3"
				readOnly="true" columnWidth="0.33">
				<aos:option value="1" display="特急" />
				<aos:option value="2" display="急" />
				<aos:option value="3" display="普通" />
				<aos:option value="4" display="不急" />
			</aos:combobox>
			<aos:htmleditor name="ad_content" readOnly="true" fieldLabel="需求内容"
				columnWidth=".99" />
			<aos:htmleditor name="ad_source_remark" readOnly="true"
				fieldLabel="来源说明" columnWidth=".99" />
			<aos:textfield name="ad_remark" fieldLabel="备注" readOnly="true"
				maxLength="200" columnWidth=".99" />
		</aos:fieldset>
		<aos:fieldset title="需求变更信息" id="demandLook_change_fields"
			labelWidth="100" columnWidth="1" border="true" hidden="true">
			<aos:combobox name="ad_chage_source" readOnly="true"
				fieldLabel="变更来源" dicField="re_ad_chage_source" columnWidth=".33" />
			<aos:textfield name="ad_chage_introducer" readOnly="true"
				fieldLabel="变更提出人" maxLength="100" columnWidth=".33" />
			<aos:textfield name="ad_chage_number" readOnly="true"
				fieldLabel="变更软件版本号" maxLength="20" columnWidth=".33" />
			<aos:htmleditor name="ad_chage_audit" readOnly="true"
				fieldLabel="变更审核意见" columnWidth=".99" />
		</aos:fieldset>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="#demand_look_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>


