<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem text="新增" icon="add.png"  		onclick="interviewRecords_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="interviewRecords_win_show('update');" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="interviewRecords_delete" />
</aos:docked>