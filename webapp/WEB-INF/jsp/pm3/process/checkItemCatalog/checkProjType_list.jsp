<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="项目管理配置" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel  region="west" headerBorder="0 0 0 1" width="400" bodyBorder="0 1 0 1" split="true">
			<%@ include file="checkProjType_grid.jsp" %>
		</aos:panel>
		<aos:panel  region="center" headerBorder="0 0 0 1" width="400" bodyBorder="0 0 0 0" split="true">
			<%@ include file="checkCatalog_grid.jsp" %>
		</aos:panel>
		<aos:panel region="east" headerBorder="0 0 0 1"  width="900" bodyBorder="0 0 0 1" split="true">
			<%@ include file="checkItem_grid.jsp" %>
		</aos:panel>
	</aos:viewport>
	<%@ include file="checkProjType_handler.jsp" %>
	<%@ include file="checkCatalog_create_win.jsp" %>
	<%@ include file="checkCatalog_update_win.jsp" %>
	<%@ include file="checkCatalog_handler.jsp" %>
	<%@ include file="checkItem_create_win.jsp" %>
	<%@ include file="checkItem_update_win.jsp" %>
	<%@ include file="checkItem_importExcle_win.jsp" %>
	<%@ include file="checkItem_handler.jsp" %>
	<script type="text/javascript">
	function fn_balance_render(value, metaData, record) {
		if (value =="未启用") {
			metaData.style = 'color:#CC0000';
		} else {
			metaData.style = 'color:green';
		}
		return value;
	}
	
	//初始进入加载
	window.onload = function(){
		checkProjType_grid_store.getProxy().extraParams = {
		};
		checkProjType_grid_store.loadPage(1);
	}
	
	
	</script>
</aos:onready>