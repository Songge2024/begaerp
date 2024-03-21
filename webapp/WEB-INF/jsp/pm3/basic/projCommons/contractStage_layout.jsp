<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_contract_stage" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="contractStage_grid.jsp"%>
	</aos:viewport>
	<%@ include file="contractStage_win.jsp"%>
	<%@ include file="contractStage_handler.jsp"%>
</aos:onready>