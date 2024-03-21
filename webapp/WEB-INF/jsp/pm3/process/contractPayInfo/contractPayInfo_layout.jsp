<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_contract_pay_info" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="contractPayInfo_grid.jsp"%>
	</aos:viewport>
	<%@ include file="contractPayInfo_win.jsp"%>
	<%@ include file="contractPayInfo_handler.jsp"%>
</aos:onready>