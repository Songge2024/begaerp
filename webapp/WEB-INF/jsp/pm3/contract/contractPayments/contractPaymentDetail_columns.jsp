<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="合同ID" dataIndex="ct_id" width="100"  hidden="true"/>
	<aos:column header="支付ID" dataIndex="ct_pay_id" width="100" hidden="true" />
	<aos:column header="支付名称" dataIndex="ct_pay_name" width="120"  summaryType="count" summaryRenderer="function(v){return '共 ' + v + ' 条'}"  />
	<aos:column header="合同支付阶段ID" dataIndex="ct_stage_id" width="100"  hidden="true"/>
	<aos:column header="阶段名称ID" dataIndex="stage_id" width="100" hidden="true" />
	<aos:column header="阶段名称" dataIndex="ct_stage_name" width="120" />
	<aos:column header="阶段支付金额(元)" dataIndex="pay_money" width="120" summaryType="sum" type="number"  summaryRenderer="function(v){if(v>10000){return '合计:' + Ext.util.Format.number(v/10000,'0,000.00') +'万元'}else{return '合计:' + Ext.util.Format.number(v,'0,000') +'元'}} " rendererFn="render_money" />
	<aos:column header="备注" dataIndex="pay_remark" width="120" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden = "true" />
	<script type="text/javascript">
	
</script>
