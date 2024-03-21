<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
			<aos:column type="rowno" />
			<aos:column header="合同id" dataIndex="ct_id" width="100" hidden="true"/>
			<aos:column header="合同状态" dataIndex="state" width="100" align="center" rendererFn="fn_ct_state"/>
			<aos:column header="合同编码" dataIndex="ct_code" width="100" align="center"/>
			<aos:column header="合同名称" dataIndex="ct_name" width="150" />
			<aos:column header="合同类型" dataIndex="ct_type" width="150" />
			<aos:column header="甲方名称" dataIndex="partya_name" width="150" />
			<aos:column header="乙方名称" dataIndex="partyb_name" width="150" />
			<aos:column header="丙方名称" dataIndex="partyc_name" width="150" />
			<aos:column header="关联项目" dataIndex="proj_names" width="150" />
			<aos:column header="合同总金额" dataIndex="ct_total_amount" width="150" align="right"
				rendererFn="fn_money"/>
			<aos:column header="合同签订时间" dataIndex="ct_sign_date" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="合同生效日期" dataIndex="ct_begin_date" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="合同终止日期" dataIndex="ct_end_date" type="date" format="Y-m-d" width="100" align="center"/>
			<aos:column header="合同备注" dataIndex="ct_remark" width="150" />
			<aos:column header="创建人" dataIndex="create_user_name" width="100" align="center"/>
			<aos:column header="创建日期" dataIndex="create_date" width="150" align="center"/>
			<aos:column header="修改人" dataIndex="update_user_name" width="100" align="center"/>
			<aos:column header="修改日期" dataIndex="update_date" width="150" align="center" />