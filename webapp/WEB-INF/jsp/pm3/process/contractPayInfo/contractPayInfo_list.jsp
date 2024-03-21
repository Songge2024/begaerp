<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="合同回款管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	
		<aos:panel region="north" border="false" height="130">
			<%@ include file="projCommons_formpanel.jsp"%>
		</aos:panel>
		
		<aos:panel region="west" width="500" border="0 1 0 0">
			<aos:layout type="vbox" align="stretch" />
			<aos:panel height = "180" >
				<%@ include file="projContract_grid.jsp"%>
			</aos:panel>
			<aos:panel layout="fit">
				<%@ include file="contractStage_grid.jsp"%>
			</aos:panel>
		</aos:panel>
		
		<aos:panel region="center" border="false" layout="border">
				<%@ include file="contractPayInfo_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	
	
	<%@ include file="contractPayInfo_handler.jsp"%>
	<%@ include file="contractPayInfo_create_win.jsp"%>
	<%@ include file="contractPayInfo_update_win.jsp"%>
</aos:onready>
