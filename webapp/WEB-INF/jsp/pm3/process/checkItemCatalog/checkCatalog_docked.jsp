<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="检查项目录管理：" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"    onclick="checkCatalog_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png"   onclick="checkCatalog_win_show('update');" />
	<aos:dockeditem text="启用" icon="go.gif"     onclick="checkCatalog_delete(1)"/>
	<aos:dockeditem text="停用" icon="stop.gif"   onclick="checkCatalog_delete(0)"/>
	<aos:dockeditem text="删除" icon="del.png"    onclick="checkCatalog_delete(-1)" />
</aos:docked>