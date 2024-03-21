<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="合同ID" dataIndex="ct_pay_id" width="100"  hidden="true"/>
	<aos:column header="合同ID" dataIndex="ct_id" width="100"  hidden="true"/>
	<aos:column header="支付名称" dataIndex="pay_name" width="120" summaryType="count" summaryRenderer="function(v){return '共 ' + v + ' 条'}" />
	<aos:column header="支付金额(元)" dataIndex="pay_money" width="140" summaryType="sum"  summaryRenderer="function(v){if(v>10000){return '合计:' + Ext.util.Format.number(v/10000,'0,000.00') +'万元'}else{return '合计:' + Ext.util.Format.number(v,'0,000.00') +'元'}} "  align="right" rendererFn="render_money" />
	<aos:column header="支付条件" dataIndex="pay_condition" width="120" />
	<aos:column header="支付时间" dataIndex="pay_time" type="date" format="Y-m-d" width="100" />
	<aos:column header="支付人" dataIndex="pay_object" width="100" />
	<aos:column header="备注" dataIndex="pay_remark" width="100" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden="true" />
	<aos:column header="创建时间" dataIndex="create_time" width="100"  hidden="true" />
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"  />
	<aos:column header="更新人" dataIndex="update_user_name" width="100"  />
	<aos:column header="更新时间" dataIndex="update_time" width="100"  />
	<aos:column header="状态" dataIndex="state" width="100"  hidden = "true"/>
