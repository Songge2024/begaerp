<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="支付ID" dataIndex="pay_id" fixedWidth="100" hidden="true" />
	<aos:column header="合同ID" dataIndex="ct_id" fixedWidth="100" hidden="true" />
	<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100" hidden="true" />
	<aos:column header=" 阶段名称ID" dataIndex="stage_id" fixedWidth="100" hidden="true"/>
	<aos:column header="支付名称" dataIndex="pay_name" fixedWidth="130" align="center"/>
	<aos:column header="支付金额" dataIndex="pay_money" fixedWidth="100" align="right" format="0,000.00" type="number"/>
	<aos:column header="支付条件" dataIndex="pay_condition" fixedWidth="130" align="center"/>
	<aos:column header="支付时间" type="date"dataIndex="pay_time" format='Y-m-d' fixedWidth="100" align="center"/>
	<aos:column header="支付人" dataIndex="pay_object" fixedWidth="80" align="center"/>
	<aos:column header="备注" dataIndex="remark" fixedWidth="120" align="center"/>
	<aos:column header="创建人" dataIndex="create_user_name" fixedWidth="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" fixedWidth="100" hidden="true"/>
