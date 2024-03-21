<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="ct_detail_id" fieldLabel="支付明细ID" />
	<aos:textfield name="ct_id" fieldLabel="合同ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="ct_pay_id" fieldLabel="支付ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="ct_stage_id" fieldLabel="合同支付阶段ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="stage_id" fieldLabel="阶段名称ID" allowBlank="true" maxLength="10"/>
	<aos:numberfield name="pay_money" fieldLabel="拆分到阶段的支付金额" allowBlank="true" minValue="0" maxValue="99999"/>
	<aos:textfield name="pay_remark" fieldLabel="备注" allowBlank="true" maxLength="600"/>
	<aos:textfield name="create_user_id" fieldLabel="创建人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态" allowBlank="true" maxLength="12"/>
