<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:menu>
	<aos:menuitem text="修改" onclick="projMilestone_win_show('update');"
		icon="edit.png" />
	<aos:menuitem text="删除" onclick="projMilestone_delete" icon="del.png" />
	<aos:menuitem text="停用" onclick="projMilestone_grid_upstate"  hidden="true"
		icon="stop.gif" />
	<aos:menuitem text="启用" onclick="projMilestone_grid_submit"  hidden="true"
		icon="go.gif" />
</aos:menu>