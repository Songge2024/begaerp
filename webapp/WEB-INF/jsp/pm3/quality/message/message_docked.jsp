<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="消息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="未读"  onclick="on_read_" />
	<aos:dockeditem text="已读" 	 onclick="y_read_" />
	<aos:dockeditem text="删除"    onclick="message_delete" />
</aos:docked>