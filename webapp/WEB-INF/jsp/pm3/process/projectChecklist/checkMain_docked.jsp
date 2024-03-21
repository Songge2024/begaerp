<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="pr_check_main信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="checkMain_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="checkMain_win_show('update');" />
	<aos:dockeditem text="批量删除" icon="del.png"    onclick="checkMain_delete" />
</aos:docked>