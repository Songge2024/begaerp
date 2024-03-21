<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_rootdir" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="rootdir_grid.jsp"%>
	</aos:viewport>
	<%@ include file="rootdir_win.jsp"%>
	<%@ include file="rootdir_handler.jsp"%>
</aos:onready>