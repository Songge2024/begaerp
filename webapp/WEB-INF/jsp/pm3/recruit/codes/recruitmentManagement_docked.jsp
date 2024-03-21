<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
<%-- 	<aos:dockeditem xtype="tbtext" text="bs_recruitment_management信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="recruitmentManagement_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="recruitmentManagement_win_show('update');" />
	<aos:dockeditem text="批量删除" icon="del.png"    onclick="recruitmentManagement_delete" /> --%>
	<aos:dockeditem  text="<b>招聘人员信息</b>" iconVec="fa-refresh" onclick="#recruitmentManagement_grid_store.reload();"/>
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="登记"  onclick="recruitmentManagement_win_show('1');" icon="user20.png" />
	<aos:dockeditem text="通知"  onclick="recruitmentManagement_win_show('2');" iconVec="fa-volume-up" />
	<aos:dockeditem text="面试"  onclick="recruitmentManagement_win_show('3');" icon="user6.png" />
	<aos:dockeditem text="入职"  onclick="recruitmentManagement_win_show('4');" icon="ok.png" />
	<aos:dockeditem text="拒绝"  onclick="recruitmentManagement_win_show('5');" icon="del2.png" />
</aos:docked>