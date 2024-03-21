<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_code_version" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projCodeVersion_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projCodeVersion_win.jsp"%>
	<%@ include file="projCodeVersion_handler.jsp"%>
</aos:onready>