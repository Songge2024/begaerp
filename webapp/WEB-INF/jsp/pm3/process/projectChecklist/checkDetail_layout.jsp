<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_check_detail" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="checkDetail_grid.jsp"%>
	</aos:viewport>
	<%@ include file="checkDetail_win.jsp"%>
	<%@ include file="checkDetail_handler.jsp"%>
</aos:onready>