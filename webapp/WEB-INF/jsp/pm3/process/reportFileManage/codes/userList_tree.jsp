<%@page import="aos.framework.core.utils.AOSUtils"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<%
	//项目列表人员过滤     如果需要调整请在主页面设置 pageContext.setAttribute("team_user_id", "1"); 如果未设置默认查询所有项目
	//项目列表人员过滤     如果需要调整请在主页面设置 pageContext.setAttribute("state", "1"); 如果未设置默认查询项目状态为0
	if(AOSUtils.isEmpty(pageContext.getAttribute("team_user_id"))){
		pageContext.setAttribute("team_user_id", "");
	};
	if(AOSUtils.isEmpty(pageContext.getAttribute("state"))){
		pageContext.setAttribute("state", "0");
	};
%>

<aos:treepanel id="aos_user_tree" flex="1"  singleClick="false" cascade="true" rootVisible="false"   border="true"  bodyBorder="0 1 0 0"
				url="projTeamsService.queryDepartmentTree" onitemclick="reportFileManage_query" >

	<aos:docked >
			<aos:dockeditem xtype="tbtext" text="员工列表树" />
			<aos:dockeditem xtype="tbfill" />
	</aos:docked>
	<aos:menu>
		<aos:menuitem text="刷新" onclick="#reportFileManage_grid_store.reload();" icon="refresh.png" />
	</aos:menu>
</aos:treepanel>

<script type="text/javascript">	

	
</script>