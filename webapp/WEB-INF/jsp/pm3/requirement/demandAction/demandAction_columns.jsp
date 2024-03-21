<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="主键ID" dataIndex="ad_id" fixedWidth="100" hidden="true" />
<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100" hidden="true" />
<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="100" hidden="true" align="center" />
<aos:column header="功能模块ID" dataIndex="dm_code" fixedWidth="100" hidden="true" /> 
<aos:column header="需求详情" rendererFn="fn_button_render" align="center" fixedWidth="70" />
<aos:column header="任务数"  dataIndex="task_count" align="center" width="70" rendererFn="fn_task_count"/>
<aos:column header="需求类型" dataIndex="ad_type" rendererField="ad_type_id" width="100" align="center" />
<aos:column header="需求编码" dataIndex="demand_code" width="120" hidden="true"/>
<aos:column header="状态" dataIndex="state_name" align="center" rendererFn="fn_balance_render" width="100" />
<aos:column header="需求名称" dataIndex="ad_name" width="260" />
<aos:column header="功能模块" dataIndex="dm_code_name" width="150" />
<aos:column header="需求ID" dataIndex="ad_code" hidden="true" fixedWidth="100" />
<aos:column header="优先级" dataIndex="ad_priority" align="center" rendererFn="fn_priority_render" width="100" />
<aos:column header="产品是否满足" dataIndex="is_product_satisfied" rendererField="is_product_satisfied" width="100" align="center" />
<aos:column header="提出时间" dataIndex="ad_raise_date" type="date" format="Y-m-d" width="100" align="center" />
<aos:column header="计划完成时间" dataIndex="ad_plan_finish_date" type="date" format="Y-m-d" width="100" align="center" />
<aos:column header="要求开始时间" dataIndex="ad_claim_start_date" type="date" format="Y-m-d" width="100" align="center" />
<aos:column header="要求完成时间" dataIndex="ad_claim_finish_date" type="date" format="Y-m-d" width="100" align="center" />
<aos:column header="估计工作量" dataIndex="ad_workload" width="100" align="right" />
<aos:column header="实际完成时间" dataIndex="ad_actual_finish_date" type="date" format="Y-m-d" width="100" align="center" />
<aos:column header="开发成员" dataIndex="development_member" width="260" align="center"/>
<aos:column header="内容" dataIndex="ad_content" width="100" align="left" hidden="true" />
<aos:column header="需求来源" dataIndex="ad_source" rendererField="re_ad_source" width="100" align="center" />
<aos:column header="来源说明" dataIndex="ad_source_remark" fixedWidth="100" align="left" hidden="true" />
<aos:column header="难易程度" dataIndex="ad_difficulty" rendererField="re_ad_difficulty" hidden="true" fixedWidth="100" align="center" />
<aos:column header="优先级" dataIndex="ad_priority" fixedWidth="100" hidden="true" align="center" />
<aos:column header="优先级" dataIndex="ad_priority_name" fixedWidth="100" align="center" hidden="true" />
<aos:column header="备注" dataIndex="ad_remark" fixedWidth="100" align="left" hidden="true" />
<aos:column header="修改人" dataIndex="update_user_name" fixedWidth="100" hidden="true" />
<aos:column header="修改人" dataIndex="update_user_id" fixedWidth="100" hidden="true" />
<aos:column header="修改时间" dataIndex="update_time" fixedWidth="100" hidden="true" />
<aos:column header="创建人" dataIndex="create_user_name" width="100" />
<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="100" hidden="true" />
<aos:column header="新增时间" dataIndex="create_time" fixedWidth="100" hidden="true" />
<aos:column header="状态" dataIndex="state" fixedWidth="100" align="center" hidden="true" />
<aos:column header="变更来源" dataIndex="ad_chage_source" rendererField="re_ad_chage_source" fixedWidth="100" align="center" hidden="true" />
<aos:column header="变更提出人" dataIndex="ad_chage_introducer" fixedWidth="100" align="center" hidden="true" />
<aos:column header="变更软件版本号" dataIndex="ad_chage_number" fixedWidth="100" align="center" hidden="true" />
<aos:column header="变更审核意见" dataIndex="ad_chage_audit" fixedWidth="100" align="left" hidden="true" />
<script type="text/javascript">
	//单元格的颜色转换
	function fn_balance_render(value, metaData, record) {
		if (value == "未启用") {
			metaData.style = 'color:#CC0000';
		} else if (value == "已作废") {
			metaData.style = 'color:blue';
		} else if (value == "已完成"){
			metaData.style = 'color:green';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
	
	function fn_priority_render(value, metaData, record) {
		if(value =='1'){
			return "<span style='color:red; font-weight:bold'>特急</span>"; 
		}else if(value == '2'){
			return "<span style='color:blue; font-weight:bold'>急</span>"; 
		}else if(value == '3'){
			return "<span style='color:green; font-weight:bold'>普通</span>"; 
		}else if(value == '4'){
			return "<span >不急</span>"; 
		}
	}
	
</script>
