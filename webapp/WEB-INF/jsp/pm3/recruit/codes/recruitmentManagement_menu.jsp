<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="登记"  onclick="recruitmentManagement_win_show('1');" icon="user20.png" />
	<aos:menuitem text="通知"  onclick="recruitmentManagement_win_show('2');" icon="message_yd.png" />
	<aos:menuitem text="面试"  onclick="recruitmentManagement_win_show('3');" icon="user6.png" />
	<aos:menuitem text="入职"  onclick="recruitmentManagement_win_show('4');" icon="ok.png" />
	<aos:menuitem text="拒绝"  onclick="recruitmentManagement_win_show('5');" icon="del2.png" />
	<aos:menuitem xtype="menuseparator" />
	<aos:menuitem text="刷新" onclick="#recruitmentManagement_grid_store.reload();" icon="refresh.png" />
</aos:menu>