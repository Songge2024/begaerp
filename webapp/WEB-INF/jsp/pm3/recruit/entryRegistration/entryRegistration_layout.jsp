<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="bs_entry_registration" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	<aos:formpanel id="f_query_enterRegistration" margin="0 0 -4 0"
			height="80" labelWidth="80" header="false" region="north"
			border="false" anchor="100% 15%">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield name="name" fieldLabel="姓名" columnWidth="0.15">
			</aos:textfield>
			<aos:textfield name="link_phone" fieldLabel="联系方式" columnWidth="0.17">
			</aos:textfield>
			
			<aos:datefield name="notify_entry_time" fieldLabel="入职时间"
				columnWidth="0.17" editable="false" />
			<aos:dockeditem xtype="button" text="查询"
				onclick="recruiterInformation_query" icon="query.png"
				columnWidth="0.07" margin="0 0 10 10" />
			<aos:dockeditem xtype="button" text="重置"
				onclick="AOS.reset(f_query_enterRegistration);" icon="refresh.png"
				columnWidth="0.07" margin="0 0 10 10" />
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		<%@ include file="entryRegistration_grid.jsp"%>
		<%@ include file="recruiterInformation_grid.jsp"%>
	</aos:viewport>
	<%@ include file="entryRegistration_win.jsp"%>
	<%@ include file="entryRegistration_handler.jsp"%>
</aos:onready>