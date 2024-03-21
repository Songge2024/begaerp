<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="Id" dataIndex="result_id" hidden="true" />
<aos:column header="登记Id" dataIndex="register_id" hidden="true" />
<aos:column header="面试结果" dataIndex="interview_result" minWidth="140"
	maxWidth="150" align="center" rendererFn="fn_render_interview" />
<aos:column header="姓名" dataIndex="name" align="center" minWidth="140"
	maxWidth="140" />
<aos:column header="性别" dataIndex="sex" align="center"
	rendererField="sex" minWidth="60" maxWidth="140" />
		<aos:column header="通知面试时间" dataIndex="notify_interview_date"
	minWidth="140" maxWidth="150" align="center" />
	<aos:column header="实际面试时间" dataIndex="interview_date" minWidth="140"
	maxWidth="150" align="center" />
<aos:column header="面试官" dataIndex="interviewer" hidden="true" />
<aos:column header="面试官" dataIndex="interviewer_name" minWidth="140"
	maxWidth="140" align="center" />
<aos:column header="面试类型" dataIndex="interview_type" minWidth="140"
	maxWidth="140" align="center" hidden="true" />
<aos:column header="笔试分数" dataIndex="written_score" minWidth="140"
	maxWidth="140" align="right" />
<aos:column header="面试分数" dataIndex="interview_score" minWidth="140"
	maxWidth="140" align="right" />
	<aos:column header="人员基本情况" dataIndex="base_situation" minWidth="180"
	maxWidth="180" />
<aos:column header="结论说明" dataIndex="conclusion" minWidth="200"
	maxWidth="220" />

