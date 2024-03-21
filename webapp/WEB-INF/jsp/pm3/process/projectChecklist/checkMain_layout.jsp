<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_check_main" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="checkMain_grid.jsp"%>
	</aos:viewport>
	<%@ include file="checkMain_win.jsp"%>
	<%@ include file="checkMain_handler.jsp"%>
</aos:onready>