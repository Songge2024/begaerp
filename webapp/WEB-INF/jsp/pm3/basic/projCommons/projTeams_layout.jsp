<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_proj_teams" base="http" lib="ext">
<aos:body>
	<%@ include file="../task/model/TaskPage.jsp"%>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<%@ include file="projTeams_grid.jsp"%>
	</aos:viewport>
	
	<%@ include file="projTeams_win.jsp"%>
	<%@ include file="projTeams_handler.jsp"%>

</aos:onready>