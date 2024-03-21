<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="年度总结文档管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="column">
		<aos:panel columnWidth='0.25' height='-0'  border='true'>
			<%@ include file="codes/userList_tree.jsp"%>
		</aos:panel>
		<aos:panel columnWidth='0.75' height='-0' border='true'>
			<%@ include file="codes/reportFileManage_grid.jsp"%>
		</aos:panel>

	</aos:viewport>

</aos:onready>