<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目情况汇总" />
	<aos:dockeditem xtype="tbseparator" />
<%-- 	<aos:dockeditem text="新增" icon="add.png"  		onclick="projSituationCount_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="projSituationCount_win_show('update');" />
	<aos:dockeditem text="批量删除" icon="del.png"    onclick="projSituationCount_delete" /> --%>
		<aos:dockeditem text="导出" icon="icon70.png" onclick="fn_export_excel_detail" />
</aos:docked>