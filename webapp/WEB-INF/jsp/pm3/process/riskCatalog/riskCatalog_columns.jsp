<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="风险目录id" dataIndex="risk_cata_id"  width="100" hidden="true" />
	<aos:column header="风险目录名称" dataIndex="risk_cata_name" width="260" />
	<aos:column header="状态" dataIndex="state" width="40" align="center" rendererFn="fn_state_render"/>
	<aos:column header="说明" dataIndex="comment" width="260" />
	<aos:column header="创建人" dataIndex="create_user_name" width="100"  hidden = "true"/>
	<aos:column header="创建人" dataIndex="create_user_id" width="100" hidden = "true" />
	<aos:column header="创建时间" dataIndex="create_time" width="100" type="date" format="Y-m-d" hidden = "true"/>
	