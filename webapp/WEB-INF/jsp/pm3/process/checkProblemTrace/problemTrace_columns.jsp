<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="QA问题跟踪ID" dataIndex="check_problem_id" width="100" hidden="true"/>
	<aos:column header="检查单目录ID" dataIndex="check_id" width="100" hidden="true"/>
	<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true"/>
	<aos:column header="检查单类型" dataIndex="check_name" width="90" align="center"/>
	<aos:column header="检查项编码" dataIndex="check_code" width="100" hidden="true"/>
	<aos:column header="问题来源" dataIndex="problem_sources" width="90" rendererFn="fn_problem_sources">
		<aos:combobox dicField="problem_sources"/>
	</aos:column>
	<aos:column header="过程及产品" dataIndex="process_product" width="90" rendererField="process_product" align="center"/>
	<aos:column header="检查项内容" dataIndex="check_detail_name" width="100" celltip="true"/>
	<aos:column header="问题等级" dataIndex="problem_level" width="70" rendererField="problem_level" align="center"/>
	<aos:column header="检查日期" dataIndex="check_time" width="100" celltip="true" format="Y-m-d" />
	<aos:column header="问题状态" dataIndex="problem_state" width="70" align="center" rendererFn="fn_problem_state">
		<aos:combobox dicField="problem_state"/>
	</aos:column>
	
	<aos:column header="负责人部门" dataIndex="principal_org" width="100" align="center" hidden="true" />
	<aos:column header="负责人部门" dataIndex="principal_org_name" width="100" align="center" >
		<aos:combobox url="problemTraceService.listPrincipalOrg" 
			typeAhead="true" forceSelection="true" selectOnFocus="true"
			editable="true" queryMode="local" name="principal_org" 
			 />
	</aos:column>
	
	
	<aos:column header="负责人" dataIndex="principal" width="70" align="center" hidden="true" />
	<aos:column header="负责人" dataIndex="principal_name" width="70" align="center">
		<aos:combobox url="problemTraceService.listPrincipal" typeAhead="true" forceSelection="true" selectOnFocus="true"
			editable="true" queryMode="local" name="principal" id="list_principal"/>
	</aos:column>
	
	<aos:column header="处理人" dataIndex="deal_man" width="140" align="center" celltip="true">
		<aos:combobox url="problemTraceService.listDealMan" typeAhead="true" forceSelection="true" selectOnFocus="true"
			editable="true" queryMode="local" name="deal_man" id="list_deal_man" multiSelect="true"/>
	</aos:column>
	
	<aos:column header="跟踪情况" dataIndex="trace_status" width="220" celltip="true" >
		<aos:textfield />
	</aos:column>
	<aos:column header="解决日期" dataIndex="solve_time" width="100" format="Y-m-d"  type="date">
		<aos:datefield format="Y-m-d" />
	</aos:column>
	<aos:column header="问题解决用时" dataIndex="solve_day" width="105" align="center" />
		
	
	<aos:column header="扣分标准" dataIndex="deduct_point" width="70" align="center" hidden="true"/>
	<aos:column header="解决时限扣分标准" dataIndex="solve_deduct_point" width="120" align="center" hidden="true"/>
	<aos:column header="问题解决时限（天）" dataIndex="solve_times" width="130" align="center" hidden="true"/>
	<aos:column header="解决时限扣分" dataIndex="solve_time_point" width="100" align="center" />
		
	
	<aos:column header="备注" dataIndex="remark" width="130" celltip="true">
		<aos:textfield />
	</aos:column>
	<aos:column header="设计人" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	
	<script type="text/javascript">
		function fn_problem_sources(value, metaData, record){
			if(value == '1001'){
				return "项目组内部"; 
			}else if(value == '1002'){
				return "项目组外部"; 
			}else{
				return null;
			}
		}
		
		function fn_problem_state(value, metaData, record){
			if(value == '1001'){
				return "<span style='color:red; font-weight:bold'>未解决</span>"; 
			}else if(value == '1002'){
				return "<span style='color:green; font-weight:bold'>已解决</span>"; 
			}else if(value == '1003'){
				return "<span style='color:blue; font-weight:bold'>跟进中</span>";
			}else if(value == '1004'){
				return "<span style='color:purple; font-weight:bold'>处理中</span>";
			}else if(value == '1005'){
				return "<span style='color:red; font-weight:bold'>强制关闭</span>";
			}else{
				return null;
			}
		}
		
	</script>
