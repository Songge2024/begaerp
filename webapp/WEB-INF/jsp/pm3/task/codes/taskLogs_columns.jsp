<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="任务ID" dataIndex="task_id" width="100" hidden="true"/>
<aos:column header="序号" dataIndex="serial_no" width="80" />
<aos:column header="描述" dataIndex="content" width="100" flex="1" />
<aos:column header="时间" dataIndex="update_time" width="150" format="Y-m-d h:i:s"/>
<aos:column header="状态" dataIndex="state" width="150" rendererField="task_state"/>
