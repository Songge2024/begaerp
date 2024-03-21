<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="msg_id" fieldLabel="消息ID" />
	<aos:textfield name="msg_note" fieldLabel="消息内容" allowBlank="true" maxLength="765"/>
	<aos:textfield name="begin_date" fieldLabel="接收时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="end_date" fieldLabel="评审结束时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="mang_id" fieldLabel="评审入口" allowBlank="true" maxLength="765"/>
	<aos:textfield name="user_id" fieldLabel="接收人ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="user_name" fieldLabel="接收人名称" allowBlank="true" maxLength="765"/>
	<aos:textfield name="send_id" fieldLabel="发送者ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="send_name" fieldLabel="发送者名称" allowBlank="true" maxLength="765"/>
	<aos:textfield name="msg_state" fieldLabel="消息状态" allowBlank="true" maxLength="765"/>
	<aos:textfield name="create_time" fieldLabel="创建时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="create_id" fieldLabel="创建人ID" allowBlank="true" maxLength="10"/>
	<aos:textfield name="create_name" fieldLabel="创建人名称" allowBlank="true" maxLength="765"/>
