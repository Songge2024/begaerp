<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_check_item" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="checkItem_grid.jsp"%>
	</aos:viewport>
	<%@ include file="checkItem_win.jsp"%>
	<%@ include file="checkItem_handler.jsp"%>
</aos:onready>