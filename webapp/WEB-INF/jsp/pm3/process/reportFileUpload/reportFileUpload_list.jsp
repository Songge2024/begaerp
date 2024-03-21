<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="年度总结文档管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="fit">
		<%@ include file="codes/reportFileUpload_grid.jsp"%>
	</aos:viewport>
</aos:onready>