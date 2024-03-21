<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:docked forceBoder="1 1 1 0">
	<aos:dockeditem xtype="tbtext" text="招聘人员信息" />
	<aos:dockeditem xtype="tbseparator" />
	<aos:dockeditem text="刷新"  onclick="#recruiterInformation_grid_store.reload();" icon="refresh.png"  		/>
</aos:docked>