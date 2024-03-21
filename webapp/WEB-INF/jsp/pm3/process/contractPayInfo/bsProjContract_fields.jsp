<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" />
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="cont_name" fieldLabel="合同名称" allowBlank="true" maxLength="300"/>
	<aos:textfield name="cont_type" fieldLabel="合同类型" allowBlank="true" maxLength="60"/>
	<aos:textfield name="pt_desc" fieldLabel="付款条件" allowBlank="true" maxLength="600"/>
	<aos:numberfield name="total_money" fieldLabel="总金额" allowBlank="true" minValue="0" maxValue="99999"/>
	<aos:textfield name="sign_time" fieldLabel="签订时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="create_user_id" fieldLabel="创建人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="update_user_id" fieldLabel="更新人" allowBlank="true" maxLength="10"/>
	<aos:textfield name="update_time" fieldLabel="更新时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="state" fieldLabel="状态" allowBlank="true" maxLength="12"/>
	<aos:textfield name="cont_desc" fieldLabel="合同描述" allowBlank="true" maxLength="600"/>
