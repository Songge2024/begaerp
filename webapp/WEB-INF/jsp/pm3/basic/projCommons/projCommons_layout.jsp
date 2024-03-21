<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.bl3.pm.basic.service.ProjCommonsService"%>
<%@page import="aos.framework.core.typewrap.Dto"%>
<%@page import="java.util.List"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="com.google.common.collect.Lists"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%
	//设置type_code_columnWidth
	pageContext.setAttribute("type_code_columnWidth", ".5");
%>
<aos:html title="bs_proj_commons" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:tabpanel id="proj_commons_tabpanel" region="center"
			bodyBorder="0 0 0 0">
			<aos:tab title="项目基础信息" id="proj_commons_tab_org" >
				<%@ include file="projCommons_grid.jsp"%>
			</aos:tab>
			<aos:tab title="项目团队信息" id="projTeams_tab_org" layout="anchor"
				disabled="true" autoScroll="true">
				<aos:formpanel id="projTeams_tab_projCommons_form" margin="0 0 -8 0"
					layout="column" border="false" anchor="100% 6%" height="95" bodyBorder="1 0 1 0"
					autoScroll="false">
					<%@ include file="projCommons_fields_readOnly.jsp"%>
				</aos:formpanel>
				<aos:panel title="项目角色设置" layout="column" anchor="100%" height="400" >
					<aos:panel columnWidth='0.22'  height="375">
						<%@ include file="../../public/public_projRoleTypes_gridpanel.jsp"%>
					</aos:panel>
					<aos:panel columnWidth='0.40' border='true' layout="border"
						height="375">
						<%@ include file="projTeams_grid.jsp"%>
					</aos:panel>
					<aos:panel columnWidth='0.06' layout="border" height="375">
						<aos:layout type="vbox" align="center" pack="center" />
						<aos:button onclick="role_user_save" text="添加" tooltip="选中添加"
							iconVec="fa-angle-double-left" iconVecAlign="left"
							iconVecSize="16" />
						<aos:button onclick="role_user_delete" margin="20 0 0 0" text="撤消"
							tooltip="撤消授权" iconVec="fa-angle-double-right" iconVecSize="16" />
					</aos:panel>
					<aos:panel columnWidth='0.32' border='true' layout="border"
						height="375" bodyBorder="1 1 1 1">
				<%@ include file="../../public/public_user_gridpanel.jsp"%>
					</aos:panel>
				</aos:panel>
				<aos:panel title="项目联系人" layout="border" anchor="100%" height="300"
					bodyBorder="1 1 1 1">
					<%@ include file="projClientContacts_grid.jsp"%>
				</aos:panel>
			</aos:tab>
			<aos:tab title="项目合同信息" id="projContract_tab_org" layout="anchor"
				disabled="true" autoScroll="false">
				<aos:formpanel id="projContract_tab_projCommons_form" region="north" 
				layout="column"	anchor="100% 6%" height="88" bodyBorder="1 0 1 0">
					<%@ include file="projCommons_fields_readOnly.jsp"%>
				</aos:formpanel>
				<aos:panel region="north" height="230" anchor="100%">
					<%@ include file="contractStage_grid.jsp"%>
				</aos:panel>
				<aos:panel  headerBorder="0 0 0 1" layout="hbox" anchor="100% 100%" 
					bodyBorder="0 0 0 1">
					<%@ include file="projContract_formpanel.jsp"%>
					<%@ include file="projContract_grid.jsp"%>
				</aos:panel>

			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>
	<%@ include file="projCommons_win.jsp"%>
	<%@ include file="projCommons_handler.jsp"%>
	<%@ include file="projTeams_win.jsp"%>
	<%@ include file="projTeams_handler.jsp"%>
	<%@ include file="projCommons_contract_win.jsp"%>
	<%@ include file="projContract_handler.jsp"%>
	<%@ include file="contractStage_win.jsp"%>
	<%@ include file="contractStage_handler.jsp"%>
	<%@ include file="projClientContacts_win.jsp"%>
	<%@ include file="projClientContacts_handler.jsp"%>
	<%@ include file="projContract_win.jsp"%>

</aos:onready>