<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="项目里程碑信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"
		onclick="projMilestone_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png"
		onclick="projMilestone_win_show('update');" />
	<aos:dockeditem text="删除" icon="del.png" onclick="projMilestone_delete"  hidden="true"/>
	<aos:dockeditem text="停用" onclick="projMilestone_grid_upstate" hidden="true"
		icon="stop.gif" />
	<aos:dockeditem text="启用" onclick="projMilestone_grid_submit"  hidden="true"
		icon="go.gif" />
</aos:docked>