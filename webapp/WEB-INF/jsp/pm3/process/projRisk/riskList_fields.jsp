<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="risk_id" fieldLabel="风险ID" />
	<aos:combobox name="risk_cata_id" id="risk_cata_id" fieldLabel="风险目录" editable="true" 
		url="riskListService.listComboBoxRiskCata"
		allowBlank="false" 
		onselect="risk_onselect" 
		columnWidth="1" 
		queryMode="local"
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true"  />
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" allowBlank="false" />
	<aos:textareafield name="risk_cata_name" id="risk_cata_name"  height="50" fieldLabel="风险描述"   columnWidth="1" maxLength="1000" allowBlank="false"  />
	<aos:combobox name="influe_degree" 
		fieldLabel="影响程度" 
		dicField="influe_degree" 
		allowBlank="false" 
		columnWidth="0.5" 
		queryMode="local"
		editable="true" 
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true" />
		<aos:numberfield name="happ_probability" fieldLabel="发生概率(%)" emptyText ="百分比(0-100)" allowBlank="false" minValue="0" maxValue="100" columnWidth="0.5"/>
	<aos:combobox name="risk_level"
		fieldLabel="风险等级" 
	 	dicField="risk_state" 
		allowBlank="false"
	 	columnWidth="0.5"
	 	queryMode="local"
		editable="true" 
		typeAhead="true"
		forceSelection="true"
		selectOnFocus="true"  />
	<aos:textfield name="risk_owner" fieldLabel="责任人" allowBlank="false" maxLength="50" columnWidth="0.5"/>
	<aos:textareafield name="risk_resp_plan" height="100" fieldLabel="风险响应计划" allowBlank="false" maxLength="1000" columnWidth="1"/>
	<aos:radioboxgroup fieldLabel="开放/关闭" columns="2" columnWidth="0.3">
		<aos:radiobox name="open_close" checked="true" boxLabel="开放" inputValue="1" />
		<aos:radiobox name="open_close" boxLabel="关闭" inputValue="0" />
	</aos:radioboxgroup>
	<aos:hiddenfield name="create_user_id" fieldLabel="设计人" allowBlank="true"/>
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true" />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true" />
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" />
	<script type="text/javascript">
function risk_onselect(obj){
	AOS.ajax({
		url : 'riskListService.riskComment',
		params:{
			risk_cata_id: obj.value
		},
		ok : function(data) {
			//AOS.tip(data[0].comment);
			AOS.setValue('risk_cata_name',data[0].comment);
		}
	});
	
}
</script>
