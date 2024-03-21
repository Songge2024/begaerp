<%@page import="aos.framework.core.utils.AOSJson"%>
<%@page import="com.bl3.pm.basic.service.ProjCommonsService"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.google.common.collect.Lists"%>
<%@page import="aos.framework.core.typewrap.Dto"%>
<%@page import="java.util.List"%>
<%
List<Dto> projTypesRender=Lists.newArrayList();
ProjCommonsService projCommonsService=(ProjCommonsService)AOSCxt.getBean("projCommonsService");
//项目类型
List<Dto> projTypes=Lists.newArrayList();
projTypes = projCommonsService.listGridRendererData("bs_proj_types");
request.setAttribute("projTypes", projTypes);
%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目ID" dataIndex="proj_id" hidden="true" fixedWidth="100" />
	<aos:column header="计划完成工作总量" dataIndex="plan_workload" hidden="true" fixedWidth="100" />
	<aos:column header="项目编码" dataIndex="proj_code" fixedWidth="120" />
	<aos:column header="项目名称" dataIndex="proj_name" width="250" align="left" minWidth="150"/>
	<aos:column header="项目简称" dataIndex="project_for_short" fixedWidth="100" align="left"/>
	<aos:column header="项目类型" dataIndex="type_code"   align="center" hidden="true"/>
	<aos:column header="项目类型" dataIndex="type_name"  fixedWidth="120" align="center"/>
	<aos:column header="状态" dataIndex="state_name" fixedWidth="100" rendererFn="fn_balance_render"  align="center"/>
	<aos:column header="项目经理" dataIndex="pm_user_id" fixedWidth="100" align="center" hidden="true"/>
	<aos:column header="项目经理" dataIndex="pm_user_name" fixedWidth="130" align="center"/>
	<aos:column header="开发经理" dataIndex="pm2_user_name" fixedWidth="130" align="center"/>
	<aos:column header="开发经理" dataIndex="pm2_user_id" fixedWidth="100" align="center" hidden="true"/>
	<aos:column header="项目启动时间" dataIndex="begin_date"  fixedWidth="120" type="date" format="Y-m-d"  align="center"/>
	<aos:column header="计划周期" dataIndex="period" fixedWidth="100" align="center"/>
	<aos:column header="计划完成时间" dataIndex="plan_completion_time"  fixedWidth="100" type="date" format="Y-m-d"/>
	<aos:column header="项目验收时间" dataIndex="accept_date"  fixedWidth="100" type="date" format="Y-m-d" align="center"/>
	<aos:column header="客户名称" dataIndex="client_name" width="150" align="left" minWidth="120"/>
	<aos:column header="客户项目责任人姓名" dataIndex="client_out_name" width="180" minWidth="150" align="left"/>
	
	<aos:column header="合同id" dataIndex="for_ct_id" width="130" align="center" hidden="true"/>
	<aos:column header="合同name" dataIndex="for_ct_name" width="130" align="center" hidden="true"/>
	
	<aos:column header="客户项目责任人电话" dataIndex="client_out_phone" width="180" minWidth="150"  align="left"/>
	<aos:column header="客户地址" dataIndex="client_address" width="180" minWidth="150" align="left"/>
	<aos:column header="合同号" dataIndex="ct_code" fixedWidth="100" align="center" hidden="true"/>
	<aos:column header="合同金额" dataIndex="ct_money" fixedWidth="100" align="right" rendererFn="fn_money" hidden="true"/>
	<aos:column header="付款条件说明" dataIndex="pt_desc" fixedWidth="100" align="left" hidden="true"/>
	<aos:column header="回款说明" dataIndex="rt_desc" fixedWidth="100" align="left" hidden="true"/>
	<aos:column header="状态" dataIndex="state" fixedWidth="100" hidden="true" align="center"/>
	<aos:column header="创建人" dataIndex="create_user_id" hidden="true" fixedWidth="100" />
	<aos:column header="创建时间" dataIndex="create_time" hidden="true" fixedWidth="100" />
	<aos:column header="更新人" dataIndex="update_user_id" hidden="true" fixedWidth="100" />
	<aos:column header="更新时间" dataIndex="update_time" hidden="true" fixedWidth="100" />
	
<script type="text/javascript">
var projTypesData=<%=AOSJson.toJson(projTypes)%>;
//单元格的颜色转换
function fn_type_code_render(value, metaData, record) {
		var b = projTypesData.length;
// 		for(int i==0;i<b;i++){
			if(projTypesData[0].TYPE_CODE==value){
				return projTypesData[0].TYPE_NAME;
			}else{
				return value;
			}
// 		}
}
//单元格的颜色转换
function fn_balance_render(value, metaData, record) {
	if (value =="已关闭") {
		metaData.style = 'color:#CC0000';
	} else {
		metaData.style = 'color:green';
	}
	return value;
}
</script>