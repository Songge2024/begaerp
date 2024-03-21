<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_preserve_point" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="preservePoint_grid.jsp"%>
	</aos:viewport>
	<%@ include file="preservePoint_create_win.jsp"%>
	<%@ include file="preservePoint_update_win.jsp"%>
	<%@ include file="preservePoint_handler.jsp"%>
</aos:onready>