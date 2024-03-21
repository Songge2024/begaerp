<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_week" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projWeek_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projWeek_win.jsp"%>
	<%@ include file="projWeek_handler.jsp"%>
</aos:onready>