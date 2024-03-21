<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="pr_risk_list" base="http" lib="ext,filter">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north"  height ="135"  bodyBorder="1 0 1 0">
			<%@ include file="riskProject_form.jsp"%>
		</aos:panel>
		<aos:panel  region="center" headerBorder="0 0 0 1" width="200"  bodyBorder="0 0 0 1" >
				<%@ include file="riskList_grid.jsp"%>
		</aos:panel>
	</aos:viewport>
	<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]" height="-30" width="320" layout="fit" autoScroll="true">
		<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
		<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false" onitemclick="t_org_find_select" />
	</aos:window>
	<%@ include file="riskList_win.jsp"%>
	<%@ include file="riskList_handler.jsp"%>
</aos:onready>