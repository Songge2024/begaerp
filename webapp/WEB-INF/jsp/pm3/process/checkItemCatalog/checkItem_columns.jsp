<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="检查单目录ID" dataIndex="check_item_id" width="100" hidden="true"/>
	<aos:column header="项目类型ID" dataIndex="type_code" width="100" hidden="true"/>
	<aos:column header="检查单目录ID" dataIndex="check_cata_id" width="100" hidden="true"/>
	<aos:column header="过程及产品" dataIndex="process_product" width="100" rendererField="process_product" />
	<aos:column header="状态" dataIndex="state" width="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state_name" width="100" rendererFn="fn_state_item"/>
	<aos:column header="问题等级" dataIndex="problem_level" width="100" rendererField="problem_level" align="center"/>
	<aos:column header="排序号" dataIndex="sort_no" width="70" />
	<aos:column header="检查项内容" dataIndex="check_item_name" width="440" celltip="true"/>
	<aos:column header="备注" dataIndex="remark" width="100" celltip="true"/>
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true"/>

	<script type="text/javascript">
		function fn_state_item(value, metaData, record){
			if (value =="未启用") {
				metaData.style = 'color:#CC0000';
			} else {
				metaData.style = 'color:green';
			}
			return value;
		}
	</script>