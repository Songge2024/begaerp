<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="id" dataIndex="register_id" hidden="true" />
<aos:column header="姓名" dataIndex="name" summaryType="count"  align="center"
	summaryRenderer="function(v){return '共 '+ v +' 条'}" />
<aos:column header="性别" dataIndex="sex" rendererField="sex"
	align="center" fixedWidth="60" />
<aos:column header="联系方式" dataIndex="link_phone" />
<aos:column header="来源" dataIndex="source" hidden="true" />
<aos:column header="登记备注" dataIndex="register_remark" hidden="true" />
<aos:column header="登记日期" dataIndex="register_date" hidden="true" />
<aos:column header="登记人" dataIndex="register_user_id" hidden="true" />
<aos:column header="登记人" dataIndex="register_user_name" hidden="true" />
<aos:column header="联系日期" dataIndex="contact_date" hidden="true" />
<aos:column header="联系人" dataIndex="contact_user_id" hidden="true" />
<aos:column header="联系人" dataIndex="contact_user_name" hidden="true" />
<aos:column header="联系结果" dataIndex="contact_result" hidden="true" />
<aos:column header="联系情况" dataIndex="contact_information" hidden="true" />
<aos:column header="约定面试日期" dataIndex="interview_date" align="center" />
<aos:column header="通知入职时间" dataIndex="notify_entry_time" align="center" />
