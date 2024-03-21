<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 0 1 0">
	<aos:dockeditem xtype="tbtext" text=" 项目基础信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="新增" icon="add.png"  		onclick="projCommons_win_show('create');" />
	<aos:dockeditem text="修改" icon="edit.png" 		onclick="projCommons_win_show('update');" />
	<aos:dockeditem text="启用" onclick="projCommons_delete('1')" icon="go.gif" />
	<aos:dockeditem text="停用" onclick="projCommons_delete('0')" icon="stop.gif" />
	<aos:dockeditem text="验收" onclick="projCommons_delete('2')" icon="ok1.png" />
	<aos:dockeditem text="关闭" onclick="projCommons_delete('3')" icon="close.png" />
	<aos:dockeditem text="删除" icon="del.png"    onclick="projCommons_delete('-1')" />
	<aos:dockeditem text="导出" icon="icon70.png" onclick="exportAll" />
	<aos:dockeditem xtype="tbtext" text="项目名称:" />
	<aos:triggerfield id="proj_name"
		onenterkey="projCommons_name_query" trigger1Cls="x-form-search-trigger"
		onTrigger1Click="projCommons_name_query" width="180" />
</aos:docked>