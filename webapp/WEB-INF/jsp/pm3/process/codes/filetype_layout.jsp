<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_filetype" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="filetype_grid.jsp"%>
	</aos:viewport>
	<%@ include file="filetype_win.jsp"%>
	<%@ include file="filetype_handler.jsp"%>
</aos:onready>