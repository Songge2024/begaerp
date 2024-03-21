<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_role_types" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projRoleTypes_grid.jsp"%>
	</aos:viewport>
	<%@ include file="projRoleTypes_win.jsp"%>
	<%@ include file="projRoleTypes_handler.jsp"%>
</aos:onready>