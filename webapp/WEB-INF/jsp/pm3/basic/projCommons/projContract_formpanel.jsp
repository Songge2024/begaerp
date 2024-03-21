<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:gridpanel 
	id="projContractformpanel_grid"
	columnWidth="0.5"
	forceFit="false"
	flex="1"
	border="true"
	height="330"
	hidePagebar="true"
	autoScroll="false"
	features="summary"
	url="contractStageService.page">
			<aos:docked >
				<aos:dockeditem xtype="tbtext" text="支付阶段信息" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="合同ID" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="阶段ID" dataIndex="ct_stage_id" width="100" hidden="true"/>
			<aos:column header="阶段编码" dataIndex="stage_code" width="100" hidden="true"/>
			<aos:column header="阶段名称" dataIndex="stage_name" width="150" summaryType="count"
				summaryRenderer="function(v){return '共 '+ v +' 条'}"/>
			<aos:column header="支付百分比(%)" dataIndex="percentage" width="100" align="center"/>
			<aos:column header="应收金额" dataIndex="rece_amount" width="150" align="right" rendererFn="fn_money" summaryType="sum" 
				summaryRenderer="function(v){if(v>=10000){
				return '合计:'+ Ext.util.Format.number(v/10000,'0,000.00')+'  (万)';
			} return '合计:'+ Ext.util.Format.number(v,'0,000.00')+'(元)' }"/>
			<aos:column header="实收金额" dataIndex="pay_amount" width="150" align="right" rendererFn="fn_money" summaryType="sum"
				summaryRenderer="function(v){if(v>=10000){
				return '合计:'+ Ext.util.Format.number(v/10000,'0,000.00')+'  (万)';
			} return '合计:'+ Ext.util.Format.number(v,'0,000.00')+'(元)' }"/>
			<aos:column header="备注" dataIndex="stage_remark" width="150" />
			<aos:column header="创建人" dataIndex="create_user_name" width="100" align="center"/>
			<aos:column header="创建时间" dataIndex="create_time" width="150" align="center"/>
			<aos:column header="更新人" dataIndex="update_user_name" width="100" align="center"/>
			<aos:column header="更新时间" dataIndex="update_time" width="150" align="center"/>
		</aos:gridpanel>