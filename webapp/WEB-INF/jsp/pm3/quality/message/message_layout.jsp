<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="消息" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="message_grid.jsp"%>
	</aos:viewport>
	<%@ include file="message_win.jsp"%>
	<%@ include file="message_handler.jsp"%>
</aos:onready>