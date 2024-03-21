<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="合同支付阶段ID" dataIndex="stage_id" hidden="true" fixedWidth="100" />
	<aos:column header="合同ID" dataIndex="ct_id" hidden="true" fixedWidth="100" />
	<aos:column header="项目ID" dataIndex="proj_id" hidden="true" fixedWidth="100" />
	<aos:column header="阶段编码" dataIndex="stage_code" fixedWidth="100" align="center" hidden="true"/>
	<aos:column header="阶段名称" dataIndex="stage_name" fixedWidth="150" align="center"/>
	<aos:column header="支付百分比" dataIndex="percentage" fixedWidth="90" align="right" format="{0:p}"/>
	<aos:column header="应收金额" dataIndex="rece_amount" fixedWidth="100" align="right" format="0,000.00" type="number"/>
	<aos:column header="实收金额" dataIndex="pay_amount" fixedWidth="100" align="right" format="0,000.00" type="number"/>
	<aos:column header="状态" dataIndex="state" hidden="true" fixedWidth="100" align="center"/>