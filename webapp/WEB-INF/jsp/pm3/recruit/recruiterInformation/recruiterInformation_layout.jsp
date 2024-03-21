<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%@page import="aos.framework.core.utils.AOSCxt"%>
<%@page import="aos.system.common.model.UserModel"%>
	<%
	//获取当前登录信息
	String juid = request.getAttribute("juid").toString();
	UserModel userModel = AOSCxt.getUserModel(juid);
	request.setAttribute("user", userModel);
	int userid = userModel.getId();
	String name=userModel.getName();
	request.setAttribute("userid", userid);
	request.setAttribute("name", name);
%>
<aos:html title="bs_recruiter_information" base="http" lib="ext">
<aos:body>
<div id="div_photo" class="x-hidden" align="center">
		<img id="img_photo" class="app_cursor_pointer" src="${cxt}/static/image/empty_head_photo.png" width="200" height="200">
	</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
	<aos:formpanel id="f_query_recruiter" margin="0 0 -4 0" height="70" labelWidth="70"  autoScroll="false"  header="false" region="north" border="false" anchor= "100% 15%" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield  name="name" fieldLabel="姓名"   columnWidth="0.17"   > </aos:textfield>
			<aos:textfield  name="link_phone" fieldLabel="联系方式"   columnWidth="0.17"   > </aos:textfield>
			<aos:datefield  name="interview_date" fieldLabel="面试时间"    columnWidth="0.17"  editable="false" />
			<aos:datefield name="notify_entry_time" fieldLabel="入职时间"   columnWidth="0.17"  editable="false" />
		    <aos:dockeditem xtype="button" text="查询" onclick="recruiterInformation_query" icon="query.png" columnWidth="0.07" margin="0 0 10 10"/>
		    <aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(f_query_recruiter);" icon="refresh.png" columnWidth="0.07"  margin="0 0 10 10"/>
			<aos:dockeditem xtype="tbfill" />
		</aos:formpanel>
		<%@ include file="recruiterInformation_grid.jsp"%>
	</aos:viewport>
	<%@ include file="recruiterInformation_win.jsp"%>
	<%@ include file="recruiterInformation_handler.jsp"%>
</aos:onready>