<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:column header="ID" dataIndex="msg_id"  hidden="true" />
<aos:column header="消息内容" dataIndex="msg_note"   fixedWidth="100"  hidden="true"/>
	<aos:column header="接收时间" dataIndex="begin_date" fixedWidth="100" hidden="true" />
	<aos:column header="评审结束时间" dataIndex="end_date" fixedWidth="100"  hidden="true"/>
	<aos:column header="评审入口" dataIndex="mang_id" fixedWidth="100" hidden="true"/>
	<aos:column header="接收人ID" dataIndex="user_id" fixedWidth="100" hidden="true"/>
	<aos:column header="接收人名称" dataIndex="user_name" fixedWidth="100" hidden="true"/>
	<aos:column header="发送者ID" dataIndex="send_id" fixedWidth="100" hidden="true"/>
	<aos:column header="发送者名称" dataIndex="send_name" fixedWidth="100" hidden="true"/>
	<aos:column header="" dataIndex="msg_state"  rendererFn="fn_msg_state" fixedWidth="50" align="center" />
	<aos:column header="创建人ID" dataIndex="create_id" fixedWidth="100" hidden="true"/>
	<aos:column header="意见入口" dataIndex="opinion_code" fixedWidth="100" hidden="true"/>
	<aos:column header="有效标志" dataIndex="flag" hidden="true" />
	<aos:column header="消息内容" dataIndex="remarks" width="600" rendererFn="fn_remarks" />
	<aos:column header="发起人名称" dataIndex="create_name" width="100" />
	<aos:column header="发起时间" dataIndex="create_time" width="160" />
	<aos:column header="评审状态" dataIndex="state_flag" fixedWidth="100"  hidden="true"/>
	<aos:column header="是否通过" dataIndex="pass_flag" fixedWidth="100" hidden="true"/>
	<aos:column header="图标" dataIndex="ico" fixedWidth="100" hidden="true"/>
		
