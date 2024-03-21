<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="联系人ID" dataIndex="cont_id" hidden="true" fixedWidth="100"/>
	<aos:column header="项目名称" dataIndex="proj_id" fixedWidth="100" align="center" hidden="true"/>
	<aos:column header="项目名称" dataIndex="proj_name" fixedWidth="120" align="center"/>
	<aos:column header="联系人姓名" dataIndex="cont_name"  align="center"/>
	<aos:column header="联系人电话" dataIndex="cont_phone"  align="right"/>
	<aos:column header="联系人邮箱" dataIndex="cont_email"  align="center"/>
	<aos:column header="沟通说明" dataIndex="cont_remark"  align="left"/>
	<aos:column header="沟通频次" dataIndex="cont_frequency"  align="center"/>
	<aos:column header="联系人说明" dataIndex="cont_desc"  align="left"/>
