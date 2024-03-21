<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目类型管理" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  	hidden="true"	onclick="checkProjType_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 	hidden="true"	onclick="checkProjType_win_show('update');" />
	<aos:dockeditem text="批量删除" icon="del.png"  hidden="true"  onclick="checkProjType_delete" />
</aos:docked>