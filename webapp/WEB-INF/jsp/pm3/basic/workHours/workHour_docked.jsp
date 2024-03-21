<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="工时信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="导出" icon="add.png"  	onclick="fn_export_excel_detail" />
</aos:docked>