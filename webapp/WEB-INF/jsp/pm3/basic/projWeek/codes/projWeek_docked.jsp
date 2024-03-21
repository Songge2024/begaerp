<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text="bs_proj_week信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem xtype="tbtext" text="选择项目:" />
	<aos:combobox  name="proj_id" id="query_form" dicField="proj_name" emptyText="选择项目" 
		onchange="projWeek_query"	selectAll="true"	width="200" allowBlank="false" url="projCommonsService.listComboBoxUerid&team_user_id=${team_user_id}"
					/>
	<aos:dockeditem text="新增" icon="add.png"  		onclick="projWeek_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="projWeek_win_show('update');" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="projWeek_delete" />
	<aos:dockeditem text="停用" onclick="g_module_upstate" icon="stop.gif" />
	<aos:dockeditem text="启用" onclick="g_module_submit" icon="go.gif" />
</aos:docked>