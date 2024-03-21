<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="检查明细项ID" dataIndex="check_detail_id" width="100" hidden="true"/>
	<aos:column header="检查单ID" dataIndex="check_id" width="100" hidden="true"/>
	<aos:column header="项目ID" dataIndex="proj_id" width="100" hidden="true"/>
	<aos:column header="过程及产品" dataIndex="process_product" width="78" align="center" rendererField="process_product"/>
	<aos:column header="问题等级" dataIndex="problem_level" width="70" align="center" rendererField="problem_level"/>
	<aos:column header="扣分标准" dataIndex="deduct_point" width="70" align="center"/>
	<aos:column header="解决时限扣分标准" dataIndex="solve_deduct_point" width="80" align="center"/>
	<aos:column header="问题解决时限（天）" dataIndex="solve_times" width="70" align="center"/>
	<aos:column header="检查项内容" dataIndex="check_detail_name" width="250" celltip="true"/>
	<aos:column header="检查项状态" dataIndex="state"  width="78" align="center" rendererFn="fn_check_state">
		<aos:combobox dicField="check_state"/>
	</aos:column>
	<aos:column header="排序号" dataIndex="sort_no" width="55" align="center"/>
	<aos:column header="是否转问题" dataIndex="is_problem" width="80" rendererFn="fn_is_problem" align="center">
		<aos:combobox>
			<aos:option value="0" display="否" />
			<aos:option value="-1" display="是" />
		</aos:combobox>
	</aos:column>
	<aos:column header="跟踪情况" dataIndex="trace_status" width="1000" celltip="true">
		<aos:textfield allowBlank="true" maxLength="1000"/>
	</aos:column>
	<aos:column header="设计人" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>
	
	<script type="text/javascript">
		function fn_is_problem(value, metaData, record){
			if(value =='0'){
				return "<span style='color:#39E639; font-weight:bold'>否</span>";
			}else if(value =='-1'){
				return "<span style='color:#FF1E00; font-weight:bold'>是</span>";
			}else{
				return null;
			}
		}
		
		function fn_check_state(value, metaData, record){
			if(value =='1'){
				return "<span style='color:blue; font-weight:bold'>不适用</span>"; 
			}else if(value == '2'){
				return "<span style='color:green; font-weight:bold'>符合</span>"; 
			}else if(value == '3'){
				return "<span style='color:red; font-weight:bold'>不符合</span>"; 
			}else{
				return null;
			}
		}
	</script>