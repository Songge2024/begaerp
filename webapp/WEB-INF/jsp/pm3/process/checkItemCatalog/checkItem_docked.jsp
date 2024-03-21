<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="检查单目录管理：" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="checkItem_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="checkItem_win_show('update');" />
	<aos:dockeditem text="启用" icon="go.gif"        onclick="checkItem_delete(1)"/>
	<aos:dockeditem text="停用" icon="stop.gif"      onclick="checkItem_delete(0)"/>
	<aos:dockeditem text="删除" icon="del.png"    onclick="checkItem_delete(-1)" />
<%-- 	<aos:dockeditem text="上传"   onclick="checkItem_show_excel_win"  icon="icon70.png" margin="0 0 0 0"/> --%>
	<aos:dockeditem text="下载导入模板"  onclick="import_excel_upload"  icon="icon70.png" margin="0 0 0 0"/>
	<aos:dockeditem text="导入"   icon="up.png"     onclick="checkItem_import"/>
</aos:docked>