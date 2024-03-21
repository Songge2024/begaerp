<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window 
	id="checkDetail_grid_win" 
	title="检查单"
	width="1400"
	height="600"
>
	<aos:gridpanel 
		id="new_checkdetail_grid" 
		url="checkDetailService.page" 
		forceFit="true"
	 	region="center"
	  	bodyBorder="1 0 1 0"
	  	hidePagebar="true"
	  >
		<aos:column type="rowno" />
		<%@ include file="checkDetail_columns.jsp"%>
	</aos:gridpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="#checkDetail_grid_win.hide();" text="关闭" icon="close.png" />
	</aos:docked>
</aos:window>

