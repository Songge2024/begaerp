<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="合同ID" dataIndex="ct_id" hidden="true" fixedWidth="100"/>
	<aos:column header="项目ID" dataIndex="proj_id" hidden="true" fixedWidth="100" />
	<aos:column header="合同名称" dataIndex="cont_name" fixedWidth="110" align="center"/>
	<aos:column header="合同类型" dataIndex="cont_type" fixedWidth="110" align="center"/>
	<aos:column header="合同开始日期" dataIndex="cp_bengin_date" fixedWidth="100" type="date" format="Y-m-d" width="100" align="center"/>
	<aos:column header="合同结束日期" dataIndex="cp_end_date" fixedWidth="100" type="date" format="Y-m-d" width="100" align="center"/>
	<aos:column header="合同状态" dataIndex="cp_type" rendererField="re_cp_type" fixedWidth="100" align="center"/>
	<aos:column header="合同总金额" dataIndex="total_money" hidden="false" fixedWidth="100" align="right" format="0,000.00" type="number"/>
	<aos:column header="合同实付总金额" dataIndex="total_pay_money" hidden="false" fixedWidth="120" align="right" format="0,000.00" type="number"/>
	<aos:column header="签订时间" dataIndex="sign_time" hidden="true" fixedWidth="100" type="date" format="Y-m-d" width="100" align="center"/>
	<aos:column header="合同描述" dataIndex="cont_desc" hidden="true" fixedWidth="100" align="left"/>
