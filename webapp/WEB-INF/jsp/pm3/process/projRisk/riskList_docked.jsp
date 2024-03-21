<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目风险信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="riskList_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="riskList_win_show('update');" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="riskList_delete" />
</aos:docked>