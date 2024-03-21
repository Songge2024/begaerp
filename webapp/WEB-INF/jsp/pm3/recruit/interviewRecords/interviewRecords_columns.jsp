<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="Id" dataIndex="result_id" fixedWidth="100"
	hidden="true" />
<aos:column header="登记Id" dataIndex="register_id" fixedWidth="100"
	hidden="true" />
<aos:column header="姓名" dataIndex="name" align="center" fixedWidth="80"
	summaryType="count" summaryRenderer="function(v){return '共 '+ v +' 条'}" />
<aos:column header="性别" dataIndex="sex" align="center"
	rendererField="sex" fixedWidth="60" />
<aos:column header="人员基本情况" dataIndex="base_situation" fixedWidth="100" />
<aos:column header="面试类型" dataIndex="interview_type" fixedWidth="80"
	align="center" hidden="true" />
<aos:column header="笔试分数" dataIndex="written_score" fixedWidth="80"
	align="right" />
<aos:column header="面试分数" dataIndex="interview_score" fixedWidth="80"
	align="right" />
<aos:column header="面试官" dataIndex="interviewer" fixedWidth="100"  align="center" />
<aos:column header="约定面试时间" dataIndex="interview_date" fixedWidth="100" align="center"
	hidden="true" />
<aos:column header="实际面试时间" dataIndex="real_interviewer_time" align="center"
	minWidth="110" maxWidth="150" />
<aos:column header="面试结果" dataIndex="interview_result" fixedWidth="100" align="center"
	rendererFn="fn_render_result" />
<aos:column header="结论说明" dataIndex="conclusion" fixedWidth="100" />
<aos:column header="创建人Id" dataIndex="create_user_id" fixedWidth="100" align="center"
	hidden="true" />
<aos:column header="更新人id" dataIndex="update_user_id" fixedWidth="100" align="center"
	hidden="true" />
<aos:column header="创建时间" dataIndex="create_time" fixedWidth="100" align="center"
	hidden="true" />
<aos:column header="更新时间" dataIndex="update_time" fixedWidth="100" align="center"
	hidden="true" />
