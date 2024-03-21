<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="根目录ID" dataIndex="rootdir_id" fixedWidth="100" hidden="true"/>
	<aos:column header="子目录ID" dataIndex="subdir_id" fixedWidth="100" hidden="true"/>
	<aos:column header="活动名称" dataIndex="subdir_name" fixedWidth="211" />
	<aos:column header="排序号" dataIndex="sort_no" fixedWidth="53" align="center"/>
	<aos:column header="创建人" dataIndex="create_user_name" fixedWidth="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_date" fixedWidth="100" type="date" format="Y-m-d" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_date" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" fixedWidth="60" rendererFn="fn_state_render" align="center"/>

	
	<script type="text/javascript">
	
	//state状态转换
	function fn_state_render(value, metaData, record) {
			if (value == '0') {
				metaData.style = 'color:#CC0000';
				return '未启用';
			} else if (value == '1') {
				metaData.style = 'color:green';
				return '已启用';
			} else if (value == '-1'){
				return '已作废';
			}
	}
	</script>