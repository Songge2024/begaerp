<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="系统角色id" dataIndex="aos_role_id" fixedWidth="120" hidden="true" />
	<aos:column header="系统角色名称" dataIndex="aos_role_name" fixedWidth="120" hidden="true"  />
	<aos:column header="角色id" dataIndex="trp_code" fixedWidth="120" hidden="true" />
	<aos:column header="项目角色名称" dataIndex="trp_name" fixedWidth="230" />
	<aos:column header="排序号" dataIndex="sort_no" fixedWidth="60" align="center" />
	<aos:column header="描述" dataIndex="trp_remark"  />
	<aos:column header="状态" dataIndex="state" fixedWidth="150" hidden="true"/>
	<aos:column header="状态" dataIndex="state_name" align="center" rendererFn="fn_balance_render" fixedWidth="100" />
	<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="120" hidden="true" />
	<aos:column header="创建人" dataIndex="create_user_name" fixedWidth="120"  hidden="true"/>
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="150" hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_name" fixedWidth="120"  hidden="true"/>
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="150" hidden="true" />
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="150" hidden="true"/>
	<aos:column header="修改" rendererFn="fn_button_render" align="center" fixedWidth="150" hidden="true"/>
	<aos:column header="删除" rendererFn="fn_button_del" align="center" fixedWidth="150" hidden="true"/>
