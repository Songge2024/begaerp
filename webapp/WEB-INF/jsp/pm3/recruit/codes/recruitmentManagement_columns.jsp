<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="状态" dataIndex="state" fixedWidth="100"
	rendererFn="fn_render_result" align="center" />
<aos:column header="姓名" dataIndex="name" fixedWidth="100" />
<aos:column header="性别" dataIndex="sex" fixedWidth="100"
	rendererField="sex" align="center" />
<aos:column header="联系方式" dataIndex="link_phone" minWidth="100"
	maxWidth="120" />
<aos:column header="登记id" dataIndex="register_id" hidden="true" />
<aos:column header="登记日期" dataIndex="register_date" minWidth="100"
	maxWidth="120" align="center" />
<aos:column header="登记人" dataIndex="register_user_name" minWidth="100"
	maxWidth="120" />
<aos:column header="登记人" dataIndex="register_user_id" hidden="true" />
<aos:column header="登记备注" dataIndex="register_remark" hidden="true" />
<aos:column header="联系日期" dataIndex="contact_date" align="center"
	minWidth="100" maxWidth="120" />
<aos:column header="联系人" dataIndex="contact_user_id" hidden="true" />
<aos:column header="联系人" dataIndex="contact_user_name" minWidth="100"
	hidden="true" maxWidth="120" />
<aos:column header="联系结果" dataIndex="contact_result" align="center"
	minWidth="100" maxWidth="120" rendererFn="fn_contact_result" />
<aos:column header="联系情况" hidden="true" dataIndex="contact_information" />
<aos:column header="约定面试日期" dataIndex="notify_interview_date"
	minWidth="100" maxWidth="120" align="center" />
<aos:column header="实际面试时间" dataIndex="interview_date" hidden="true" minWidth="100"
	align="center" />
<aos:column header="面试结果" dataIndex="interview_result" minWidth="100" hidden="true" rendererFn="fn_render_interview" align="center" />
<aos:column header="通知入职时间" dataIndex="notify_entry_time" hidden="true" />
<aos:column header="实际入职时间" dataIndex="entry_date" minWidth="100" hidden="true"
	maxWidth="120" align="center" />
<aos:column header="入职类型" dataIndex="entry_type" minWidth="80"
	align="center" maxWidth="100" rendererField="entry_type" />
<aos:column header="入职岗位" dataIndex="entry_post" minWidth="100"
	align="center" maxWidth="120" rendererField="entry_post" />
<aos:column header="来源" dataIndex="source" minWidth="100" maxWidth="120"
	hidden="true" />
<aos:column header="经验" dataIndex="experience" minWidth="160"
	maxWidth="180" />
<aos:column header="培训情况" dataIndex="train_situation" minWidth="100"
	maxWidth="120" />
<aos:column header="备注" dataIndex="result_remark" minWidth="100"
	maxWidth="120" />
<aos:column header="创建人Id" dataIndex="create_user_id" hidden="true"
	fixedWidth="100" />
<aos:column header="创建人" dataIndex="create_user_name" hidden="true" />
<aos:column header="更新人id" dataIndex="update_user_id" hidden="true"
	fixedWidth="100" />
<aos:column header="更新人" dataIndex="update_user_name" hidden="true"
	fixedWidth="100" />
<aos:column header="创建时间" dataIndex="create_time" hidden="true"
	fixedWidth="100" />
<aos:column header="更新时间" dataIndex="update_time" hidden="true"
	fixedWidth="100" />

