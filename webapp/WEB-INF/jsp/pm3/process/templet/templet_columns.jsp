<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="模板编码" dataIndex="templet_id" hidden="true" align ="center"/>
	<aos:column header="模板名称" dataIndex="templet_name" width="200" align ="left"/>
	<aos:column header="状态" dataIndex="state" width="200" rendererFn="fn_state_render"  align ="center"/>
	<aos:column header="说明" dataIndex="templet_comment" width="200"  align ="left"/>
	<aos:column header="创建人id" dataIndex="create_user_id" width="100" hidden="true"  align ="center"/>
	<aos:column header="创建人" dataIndex="create_user_name" width="100" hidden="true"  align ="center"/>
	<aos:column header="创建时间" dataIndex="create_time" width="100" type="date" format="Y-m-d" hidden="true"  align ="center"/>
	
