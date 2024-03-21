<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_subdir" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="subdir_grid.jsp"%>
	</aos:viewport>
	<%@ include file="subdir_win.jsp"%>
	<%@ include file="subdir_handler.jsp"%>
</aos:onready>