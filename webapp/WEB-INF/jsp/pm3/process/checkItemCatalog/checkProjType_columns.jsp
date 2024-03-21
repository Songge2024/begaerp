<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="类型code" dataIndex="type_code" fixedWidth="70" align="center" hidden="true"/>
	<aos:column header="类型名称" dataIndex="type_name" fixedWidth="245" />
	<aos:column header="类型描述" dataIndex="type_desc" fixedWidth="100" hidden="true"/>
	<aos:column header="开发模型" dataIndex="model" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state" fixedWidth="100" hidden="true"/>
	<aos:column header="状态" dataIndex="state_name" fixedWidth="99" align="center" rendererFn="fn_balance_render"/>
	<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" hidden="true"/>
