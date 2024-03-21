<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100" />
	<aos:column header="合同名称" dataIndex="cont_name" fixedWidth="100" />
	<aos:column header="合同类型" dataIndex="cont_type" fixedWidth="100" />
	<aos:column header="付款条件" dataIndex="pt_desc" fixedWidth="100" />
	<aos:column header="总金额" dataIndex="total_money" fixedWidth="100" format="0,000.00"/>
	<aos:column header="签订时间" dataIndex="sign_time" fixedWidth="100" />
	<aos:column header="创建人" dataIndex="create_user_id" fixedWidth="100" />
	<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" />
	<aos:column header="更新人" dataIndex="update_user_id" fixedWidth="100" />
	<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" />
	<aos:column header="状态" dataIndex="state" fixedWidth="100" />
	<aos:column header="合同描述" dataIndex="cont_desc" fixedWidth="100" />
