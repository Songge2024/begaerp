<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="过程模板维护" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >
	
		<aos:panel  region="north"  height ="180"  bodyBorder="1 0 1 0">
		<%@ include file="templet_grid.jsp"%>
		</aos:panel>
		
		<aos:panel  region="west" headerBorder="0 0 0 1"  width="600" bodyBorder="0 0 0 1"  >
		<%@ include file="templetProcess_grid.jsp"%>
		</aos:panel>
		
		<aos:panel   region="center" headerBorder="0 0 0 1" width="300"  bodyBorder="0 0 0 1" >
		<%@ include file="templetFiletype_grid.jsp"%>
		</aos:panel>

	</aos:viewport>
	
 <%-- 	<aos:viewport layout="column" >
	
		
		<aos:panel columnWidth="0.30" height="-0" border="true">
		<%@ include file="templet_grid.jsp"%>
		</aos:panel>
		<aos:panel columnWidth="0.40" height="-0" border="true">
		<%@ include file="templetProcess_grid.jsp"%>
		</aos:panel>
		<aos:panel columnWidth="0.30" height="-0" border="true">
		<%@ include file="templetFiletype_grid.jsp"%>
		</aos:panel>

	</aos:viewport>  --%>
	<%@ include file="templet_create_win.jsp"%>
	<%@ include file="templet_update_win.jsp"%>
	<%@ include file="templet_handler.jsp"%>
	<%@ include file="templetProcess_handler.jsp"%>
	<%@ include file="templetProcess_win.jsp"%>
	<%@ include file="templetProcess_update_win.jsp"%>
	<%@ include file="templetFiletype_handler.jsp"%>
	<%@ include file="templetFiletype_win.jsp"%>
</aos:onready>