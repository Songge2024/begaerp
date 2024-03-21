<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_check_proj_type" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="checkProjType_grid.jsp"%>
	</aos:viewport>
	<%@ include file="checkProjType_win.jsp"%>
	<%@ include file="checkProjType_handler.jsp"%>
</aos:onready>