<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
  <aos:gridpanel id="projWorkloadUserMonth_grid" url="projWorkloadUserMonthService.page"
					 hidePagebar="true" anchor="100% 50%" forceFit="false"
					border="true" margin="5">
	<aos:column type="rowno" />
	<%@ include file="projWorkloadUserMonth_columns.jsp"%>
</aos:gridpanel>