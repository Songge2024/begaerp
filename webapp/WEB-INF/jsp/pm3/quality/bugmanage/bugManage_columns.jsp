<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:column header="消息记录ID" dataIndex="log_id" fixedWidth="100" />
	<aos:column header="项目ID" dataIndex="proj_id" fixedWidth="100" />
	<aos:column header="模块ID" dataIndex="stand_id" fixedWidth="100" />
	<aos:column header="缺陷名称" dataIndex="bug_name" fixedWidth="100" />
	<aos:column header="缺陷详情" dataIndex="bug_detail" fixedWidth="100" />
	<aos:column header="当前状态" dataIndex="state" fixedWidth="100" />
	<aos:column header="优先级" dataIndex="priority" fixedWidth="100" />
	<aos:column header="严重程度" dataIndex="severity" fixedWidth="100" />
	<aos:column header="bug位置(问题类别)" dataIndex="bug_addr" fixedWidth="100" />
	<aos:column header="出现频率" dataIndex="rate" fixedWidth="100" />
	<aos:column header="来源方" dataIndex="source" fixedWidth="100" />
	<aos:column header="发现时间" dataIndex="find_time" fixedWidth="100" />
	<aos:column header="类型(是否缺陷)" dataIndex="bug_type" fixedWidth="100" />
	<aos:column header="新增人" dataIndex="create_name" fixedWidth="100" />
	<aos:column header="新增时间" dataIndex="create_time" fixedWidth="100" />
	<aos:column header="问题关闭人" dataIndex="close_name" fixedWidth="100" />
	<aos:column header="关闭时间" dataIndex="close_time" fixedWidth="100" />
	<aos:column header="当前处置人" dataIndex="deal_man" fixedWidth="100" />
