<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="ct_id" fieldLabel="合同ID" />
	<aos:hiddenfield name="ct_code" fieldLabel="合同编码" readOnly="true" />
	<aos:textfield name="ct_name" fieldLabel="合同名称" readOnly="true" columnWidth="0.3"/>
	<aos:textfield name="ct_type" fieldLabel="合同类型" readOnly="true" columnWidth="0.3"/>
	<aos:hiddenfield name="state" fieldLabel="合同状态"  />
	<aos:textfield name="state_name" fieldLabel="合同状态"  readOnly="true" columnWidth="0.3"/>
	<aos:textfield name="partya_name" fieldLabel="甲方名称" readOnly="true" columnWidth="0.3"/>
	<aos:textfield name="partyb_name" fieldLabel="乙方名称" readOnly="true" columnWidth="0.3"/>
	<aos:hiddenfield name="partyc_name" fieldLabel="丙方名称" readOnly="true" columnWidth="0.3"/>
	<aos:textfield name="ct_begin_date" fieldLabel="合同生效日期" readOnly="true"  columnWidth="0.3"/>
	<aos:textfield name="ct_total_amount" fieldLabel="合同总金额(元)" readOnly="true"  columnWidth="0.3"/>
	<aos:textfield name="ct_total_payment" fieldLabel="合同实收金额(元)"  readOnly="true" columnWidth="0.3"/>
	<aos:textfield name="ct_sign_date" fieldLabel="合同签订时间" readOnly="true"  columnWidth="0.3"/>
	<aos:hiddenfield name="ct_end_date" fieldLabel="合同终止日期" readOnly="true" />
	<aos:hiddenfield name="ct_remark" fieldLabel="合同备注" readOnly="true" columnWidth="0.3" />
	<aos:hiddenfield name="create_user_id" fieldLabel="创建人" readOnly="true" />
	<aos:hiddenfield name="create_date" fieldLabel="创建日期" readOnly="true" />
	<aos:hiddenfield name="update_user_id" fieldLabel="修改人" readOnly="true" />
	<aos:hiddenfield name="update_date" fieldLabel="修改日期" readOnly="true" />
	
