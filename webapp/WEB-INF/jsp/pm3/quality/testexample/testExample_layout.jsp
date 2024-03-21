<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="qa_test_example" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="testExample_grid.jsp"%>
	</aos:viewport>
	<%@ include file="testExample_win.jsp"%>
	<%@ include file="testExample_handler.jsp"%>
</aos:onready>