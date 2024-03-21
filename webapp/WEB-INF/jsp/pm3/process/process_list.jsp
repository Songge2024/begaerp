<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="过程目录维护" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="column">
		<aos:panel columnWidth="0.33" height="-0" border="true">
		<%@ include file="codes/rootdir_grid.jsp"%>
		</aos:panel>
		<aos:panel columnWidth="0.34" height="-0" border="true">
		<%@ include file="codes/subdir_grid.jsp"%>
		</aos:panel>
		<aos:panel columnWidth="0.33" height="-0" border="true">
		<%@ include file="codes/filetype_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	<%@ include file="codes/rootdir_create_win.jsp"%>
	<%@ include file="codes/rootdir_update_win.jsp"%>
	<%@ include file="codes/rootdir_handler.jsp"%>
	<%@ include file="codes/subdir_handler.jsp"%>
	<%@ include file="codes/subdir_create_win.jsp"%>
	<%@ include file="codes/subdir_update_win.jsp"%>
	<%@ include file="codes/filetype_handler.jsp"%>
	<%@ include file="codes/filetype_create_win.jsp"%>
	<%@ include file="codes/filetype_update_win.jsp"%>
</aos:onready>