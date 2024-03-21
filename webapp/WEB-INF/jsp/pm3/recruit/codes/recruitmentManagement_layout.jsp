<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_recruitment_management" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	<aos:formpanel id="f_query_recruitManage" margin="0 0 -4 0" height="140" labelWidth="120"  autoScroll="false"  header="false" region="north" border="false" anchor= "100% 15%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:combobox  name="state" fieldLabel="状态" dicField="recruit_state" columnWidth="0.25"  editable="false" onchange="recruitmentManagement_query" />
			<aos:textfield  name="name" fieldLabel="姓名"  onenterkey="recruitmentManagement_query" columnWidth="0.25"   > </aos:textfield>
			<aos:textfield  name="link_phone" fieldLabel="联系方式"   columnWidth="0.25"  onenterkey="" > </aos:textfield>
			<aos:combobox  name="interview_result" fieldLabel="面试结果" dicField="interviewer_result" columnWidth="0.25"  editable="false" onchange="recruitmentManagement_query"/>
			<aos:combobox  name="entry_type" fieldLabel="入职类型" dicField="entry_type" columnWidth="0.25"  editable="false" onchange="recruitmentManagement_query"/>
		   	<aos:combobox  name="entry_post" fieldLabel="入职岗位" dicField="entry_post" columnWidth="0.25"  editable="false" onchange="recruitmentManagement_query"/>
		   <aos:datefield  name="notify_interview_date_begin"  fieldLabel="约定面试开始时间"    columnWidth="0.25"  editable="false" />
			<aos:datefield  name="notify_interview_date_end"   columnWidth="0.25" fieldLabel="约定面试结束时间"  editable="false" />
			<aos:datefield name="entry_date_begin" fieldLabel="实际入职开始时间"   columnWidth="0.25"  editable="false" />
			<aos:datefield name="entry_date_end"  fieldLabel="实际入职结束时间"  columnWidth="0.25"  editable="false" />
		    <aos:dockeditem xtype="button"  text="查询" onclick="recruitmentManagement_query" icon="query.png"  />
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query_recruitManage);" icon="refresh.png"  />
		    <aos:dockeditem xtype="button" text="导出" onclick="print_list" icon="printer.png"  /> 
		</aos:formpanel>
		<%@ include file="interviewRecords_grid.jsp"%>
		<%@ include file="recruitmentManagement_grid.jsp"%>
	</aos:viewport>
	<%@ include file="recruitmentManagement_win.jsp"%>
	<%@ include file="recruitmentManagement_handler.jsp"%>
		<%@include file="notice_win.jsp"  %>
	<%@include file="interviewRecords_win.jsp"  %>
	<%@include file="entryRegistration_win.jsp"  %>
</aos:onready>