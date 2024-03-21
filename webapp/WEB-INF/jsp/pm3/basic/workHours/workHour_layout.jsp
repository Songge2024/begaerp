<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>
<aos:html title="ta_work_hour" base="http" lib="ext">

<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	<aos:formpanel id="query_form" layout="column" labelWidth="70"
			header="false" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
		        <aos:datefield name="begin_date" fieldLabel="开始时间" format="Y-m-d "
					columnWidth=".2" editable="false" margin="0 -10 0 0" onchange="changeweekBdt" />
				<aos:datefield name="end_date" fieldLabel="结束时间" format="Y-m-d "
					columnWidth=".2" editable="false" margin="0 -10 0 0" onchange="changeweekBdt" />
			<aos:dockeditem xtype="button" text="查询" margin="0 10 0 60"
				onclick="query_button_click" icon="query.png" />
			<aos:dockeditem xtype="button" text="重置" margin="0 10 0 0"
				onclick="AOS.reset(query_form);" icon="refresh.png" />
		
		</aos:formpanel>
		<aos:treepanel id="public_tree"  title="项目列表" singleClick="false" collapsible="true"  
			split="true" region="west"   width="280" 
				cascade="true" rootVisible="false"
			       url="workHourService.listTreeUerid"
					border="true" onitemclick="on_public_tree">
		</aos:treepanel>
		<%@ include file="workHour_grid.jsp"%>
	</aos:viewport>
	<%@ include file="workHour_win.jsp"%>
	<%@ include file="workHour_handler.jsp"%>
</aos:onready>