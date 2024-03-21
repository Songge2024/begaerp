<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="re_demand_action_file" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="demandActionFile_grid.jsp"%>
	</aos:viewport>
	<%@ include file="demandActionFile_win.jsp"%>
	<%@ include file="demandActionFile_handler.jsp"%>
</aos:onready>