<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_client_contacts" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projClientContacts_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projClientContacts_win.jsp"%>
	<%@ include file="projClientContacts_handler.jsp"%>
</aos:onready>