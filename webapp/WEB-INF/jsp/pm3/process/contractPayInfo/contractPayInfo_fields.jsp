<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="pay_id" fieldLabel="支付ID" />
	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" allowBlank="true"  readOnly="true"/>
	<aos:hiddenfield name="proj_id" fieldLabel="项目ID" allowBlank="true"  readOnly="true"/>
	<aos:hiddenfield name="stage_id" fieldLabel=" 阶段名称ID" allowBlank="true"  readOnly="true"/>
	<aos:textfield name="pay_name" fieldLabel="支付名称" allowBlank="false" maxLength="60" msgTarget="qtip"/>
	<aos:numberfield name="pay_money" fieldLabel="支付金额" allowBlank="false" minValue="0" maxValue="99999999" msgTarget="qtip"
	emptyText="请输入支付金额"/>
	<aos:textfield name="pay_condition" fieldLabel="支付条件" allowBlank="false" maxLength="60" msgTarget="qtip"/>
	<aos:datefield name="pay_time" fieldLabel="支付时间" allowBlank="false" editable="false" msgTarget="qtip"/>
	<aos:textfield name="pay_object" fieldLabel="支付人" allowBlank="false" maxLength="20" msgTarget="qtip"/>
	<aos:textfield name="remark" fieldLabel="备注" allowBlank="true" maxLength="60" msgTarget="qtip"/>
	<aos:hiddenfield name="create_user_id" fieldLabel="创建人" allowBlank="true"  />
	<aos:hiddenfield name="create_time" fieldLabel="创建时间" allowBlank="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="更新人" allowBlank="true"  />
	<aos:hiddenfield name="update_time" fieldLabel="更新时间" allowBlank="true"  />
	<aos:hiddenfield name="state" fieldLabel="状态" allowBlank="true" />
