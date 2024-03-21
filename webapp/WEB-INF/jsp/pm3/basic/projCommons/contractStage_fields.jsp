<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="stage_id" fieldLabel="合同支付阶段ID" />
	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" allowBlank="true"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" allowBlank="true"/>
	<aos:textfield name="stage_code" fieldLabel="阶段编码" allowBlank="false" maxLength="20"/>
	<aos:textfield name="stage_name" fieldLabel="阶段名称" allowBlank="false" maxLength="20"/>
	<aos:numberfield name="percentage" fieldLabel="支付百分比" allowBlank="false" minValue="0" maxValue="99999999"/>
	<aos:numberfield name="rece_amount" fieldLabel="应收金额" allowBlank="false" minValue="0" maxValue="99999999"/>
	<aos:hiddenfield name="pay_amount" fieldLabel="实收金额" allowBlank="true" />
	<aos:fieldset title="回款说明" >
			<aos:htmleditor name="stage_desc"  allowBlank="true" 
			columnWidth="1"  />
	</aos:fieldset>

