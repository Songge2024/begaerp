<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="合同ID" dataIndex="ct_stage_id" width="100" hidden="true"/>
	<aos:column header="合同ID" dataIndex="ct_id" width="100" hidden="true"/>
	<aos:column header="阶段编码" dataIndex="stage_code" width="100" hidden="true" />
	<aos:column header="阶段名称" dataIndex="stage_name" width="100" summaryType="count" summaryRenderer="function(v){return '共 ' + v + ' 条'}"  />
	<aos:column header="支付百分比(%)" dataIndex="percentage" width="100"  align="right" rendererFn="render_percent"/>
	<aos:column header="应收金额(元)" dataIndex="rece_amount" width="120" align="right"  summaryType="sum" type="number"  summaryRenderer="function(v){if(v>10000){return '合计:' + Ext.util.Format.number(v/10000,'0,000.00') +'万元'}else{return '合计:' + Ext.util.Format.number(v,'0,000.00') +'元'}}" rendererFn="render_money"/>
	<aos:column header="实收金额(元)" dataIndex="pay_amount" width="120"  align="right"  summaryType="sum" type="number"  summaryRenderer="function(v){if(v>10000){return '合计:' + Ext.util.Format.number(v/10000,'0,000.00') +'万元'}else{return '合计:' + Ext.util.Format.number(v,'0,000.00') +'元'}} " rendererFn="render_money"/>
	<aos:column header="备注" dataIndex="stage_remark" width="300" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden="true" />
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
	<script type="text/javascript">
	function render_percent(value){
		return value
	}
	function render_money(value){
		if(value ==''){
			return '0'
		}else{
		return Ext.util.Format.number(value,'0,000.00');
		}
	}
	</script>
