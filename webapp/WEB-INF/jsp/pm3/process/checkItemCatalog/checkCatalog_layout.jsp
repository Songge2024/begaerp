<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_check_catalog" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="checkCatalog_grid.jsp"%>
	</aos:viewport>
	<%@ include file="checkCatalog_win.jsp"%>
	<%@ include file="checkCatalog_handler.jsp"%>
</aos:onready>