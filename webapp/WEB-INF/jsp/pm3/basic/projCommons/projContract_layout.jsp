<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_contract" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projContract_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projContract_win.jsp"%>
	<%@ include file="projContract_handler.jsp"%>
</aos:onready>