<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:window id="projMilestone_create_win" title="新增里程碑维护">
	<aos:formpanel id="projMilestone_create_form" width="700"
		layout="column" labelWidth="100" msgTarget="qtip">
		<%@ include file="projMilestone_fields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projMilestone_create" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projMilestone_create_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window id="projMilestone_update_win" title="修改里程碑维护">
	<aos:formpanel id="projMilestone_update_form" width="700"
		layout="column" labelWidth="100" msgTarget="qtip">
		<%@ include file="projMilestone_ufields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projMilestone_update" text="保存" icon="ok.png" />
		<aos:dockeditem onclick="#projMilestone_update_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window id="projMilestone_over_win" title="结束里程碑">
	<aos:formpanel id="projMilestone_over_form" width="700"
		layout="column" labelWidth="100" msgTarget="qtip">
		<%@ include file="projMilestone_ofields.jsp"%>
	</aos:formpanel>
	<aos:docked dock="bottom" ui="footer">
		<aos:dockeditem xtype="tbfill" />
		<aos:dockeditem onclick="projMilestone_over" text="确认结束" icon="ok.png" id="projMilestone_over_id" />
		<aos:dockeditem onclick="#projMilestone_over_win.hide();" text="关闭"
			icon="close.png" />
	</aos:docked>
</aos:window>
<aos:window id="w_org_find" x="0" y="30" title="项目树[单击选择]"  bodyBorder="0 1 0 0"  width="350" height="-30" layout="fit" autoScroll="true">
			<aos:docked forceBoder="0 0 0 0" >
				<aos:dockeditem xtype="tbtext" text="项目名称查询 :" />
				<aos:triggerfield  id="proj_name" onenterkey="proj_name_query" trigger1Cls="x-form-search-trigger"
						onTrigger1Click="proj_name_query" width="180" />
			</aos:docked>
			<aos:treepanel id="t_org_find" singleClick="false"  bodyBorder="0 0 0 0" url="projCommonsService.listTreeUerid&team_user_id=${team_user_id}" rootVisible="false"  onitemclick="t_org_find_select" />
</aos:window>

<script type="text/javascript">
function proj_name_query(){
	var proj_name = AOS.getValue('proj_name');
	t_org_find_store.load({
		params:{
			proj_name : proj_name
		}
	})
}
</script>
