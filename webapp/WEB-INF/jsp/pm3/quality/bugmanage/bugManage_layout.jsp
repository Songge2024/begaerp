<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="qa_bug_manage" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="bugManage_grid.jsp"%>
	</aos:viewport>
	<%@ include file="bugManage_win.jsp"%>
	<%@ include file="bugManage_handler.jsp"%>
</aos:onready>