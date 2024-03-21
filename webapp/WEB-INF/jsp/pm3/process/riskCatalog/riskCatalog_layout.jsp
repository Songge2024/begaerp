<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_risk_catalog" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="riskCatalog_grid.jsp"%>
	</aos:viewport>
	<%@ include file="riskCatalog_win.jsp"%>
	<%@ include file="riskCatalog_update_win.jsp"%>
	<%@ include file="riskCatalog_handler.jsp"%>
</aos:onready>