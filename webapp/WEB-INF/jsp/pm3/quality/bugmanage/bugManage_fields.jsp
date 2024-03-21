<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
	<aos:hiddenfield name="bug_id" fieldLabel="缺陷ID" />
	<aos:textfield name="log_id" fieldLabel="消息记录ID" allowBlank="true" maxLength="60"/>
	<aos:textfield name="proj_id" fieldLabel="项目ID" allowBlank="true" maxLength="60"/>
	<aos:textfield name="stand_id" fieldLabel="模块ID" allowBlank="true" maxLength="60"/>
	<aos:textfield name="bug_name" fieldLabel="缺陷名称" allowBlank="true" maxLength="60"/>
	<aos:textfield name="bug_detail" fieldLabel="缺陷详情" allowBlank="true" maxLength="65535"/>
	<aos:textfield name="state" fieldLabel="当前状态" allowBlank="true" maxLength="30"/>
	<aos:textfield name="priority" fieldLabel="优先级" allowBlank="true" maxLength="5"/>
	<aos:textfield name="severity" fieldLabel="严重程度" allowBlank="true" maxLength="5"/>
	<aos:textfield name="bug_addr" fieldLabel="bug位置(问题类别)" allowBlank="true" maxLength="5"/>
	<aos:textfield name="rate" fieldLabel="出现频率" allowBlank="true" maxLength="5"/>
	<aos:textfield name="source" fieldLabel="来源方" allowBlank="true" maxLength="5"/>
	<aos:textfield name="find_time" fieldLabel="发现时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="bug_type" fieldLabel="类型(是否缺陷)" allowBlank="true" maxLength="6"/>
	<aos:textfield name="create_name" fieldLabel="新增人" allowBlank="true" maxLength="60"/>
	<aos:textfield name="create_time" fieldLabel="新增时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="close_name" fieldLabel="问题关闭人" allowBlank="true" maxLength="60"/>
	<aos:textfield name="close_time" fieldLabel="关闭时间" allowBlank="true" maxLength="19"/>
	<aos:textfield name="deal_man" fieldLabel="当前处置人" allowBlank="true" maxLength="60"/>
