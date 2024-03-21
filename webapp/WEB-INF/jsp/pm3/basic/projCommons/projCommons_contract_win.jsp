<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%

%>
	<%-- 通过这个弹窗表单演示再查询一次DB加载数据的方法 --%>
		<aos:window id="contract_win"  anchor="100%"  title="来源合同详情"  width="600" height="500">
			<aos:panel layout="border">
				<aos:gridpanel title="已选择[双击撤销]" id="contract_grid1" onitemdblclick="del_contract_grid" hidePagebar="true"  height="200" url="contractService.querySaveContract"   region="north" >
						<aos:column header="合同id" dataIndex="ct_id" width="150" hidden="true"/>
						<aos:column header="合同名称" dataIndex="ct_name" width="150"/>
						<aos:column header="合同类型" dataIndex="ct_type" width="100" />
						<aos:column header="合同总金额(元)" dataIndex="ct_total_amount" width="100" />
						<aos:column header="合同签订日期" dataIndex="ct_sign_date"  type="date" width="100" format="Y-m-d" />
				</aos:gridpanel>
			
				<aos:gridpanel title="可选择[单击选中]" onitemclick="add_contract_grid" id="contract_grid"  hidePagebar="true"  height="400" url="contractService.page"   region="center" >
						<aos:selmodel type="checkbox" mode="multi" />
						<aos:column header="合同id" dataIndex="ct_id" width="150" hidden="true"/>
						<aos:column header="合同名称" dataIndex="ct_name" width="150"/>
						<aos:column header="合同类型" dataIndex="ct_type" width="100" />
						<aos:column header="合同总金额(元)" dataIndex="ct_total_amount" width="100" />
						<aos:column header="合同签订日期" dataIndex="ct_sign_date" type="date" width="100" format="Y-m-d"/>
				</aos:gridpanel>
			</aos:panel>	
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="personnel_save()" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#contract_win.hide();" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>
