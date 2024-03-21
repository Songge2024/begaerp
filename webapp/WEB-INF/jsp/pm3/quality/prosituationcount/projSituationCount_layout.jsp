<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_situation_count" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projSituationCount_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projSituationCount_win.jsp"%>
	<%@ include file="projSituationCount_handler.jsp"%>
</aos:onready>