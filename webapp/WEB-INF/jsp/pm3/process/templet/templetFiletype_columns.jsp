<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="模板文件类型ID" dataIndex="temp_filetype_id" width="100" hidden="true" align ="center"/>
	<aos:column header="模板明细ID" dataIndex="temp_proc_id" width="100" hidden="true" align ="center"/>
	<aos:column header="模板Id" dataIndex="templet_id" width="100" hidden="true" align ="center"/>
	<aos:column header="模板过程文档文件类型ID" dataIndex="filetype_id" width="100" hidden="true" align ="center"/>
	<aos:column header="输出文档名称" dataIndex="temp_filetype_name" width="300" align ="left"/>
	<aos:column header="排序号" dataIndex="sort_no" width="80" align ="center"/>
	<aos:column header="是否必须流程 " dataIndex="flow_state" type="check" width="100" align ="center"/>
	<aos:column header="创建人id" dataIndex="create_user_id" width="100" align ="center" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_name" width="100" hidden="true"  align ="center"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" type="date" format="Y-m-d" hidden="true"  align ="center"/>
	<aos:column header="更新人" dataIndex="update_user_id" width="100" hidden="true" align ="center"/>
	<aos:column header="更新时间" dataIndex="update_time" width="100" hidden="true" align ="center"/>
	<aos:column header="状态" dataIndex="state" width="100" hidden="true" align ="center"/>
