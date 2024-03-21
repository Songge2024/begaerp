<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
  <aos:groupingPanel 	id="projWorkloadMonth_grid"  	url="projWorkloadMonthService.page"  hidePagebar="true"
					  forceFit="false" onload="_g_grid_onload"  onitemdblclick="projWorkloadUserMonth_click"
					 anchor="100% 50%" border="true" margin="5"  groupField="month" 
					 property="month"  	 startCollapsed="true"  groupHeaderTpl="年月"
					    >
	<aos:selmodel type="checkbox" mode="multi"   />
	<aos:column type="rowno"  />
	<%@ include file="projWorkloadMonth_columns.jsp"%>
</aos:groupingPanel>
<aos:treepanel    ></aos:treepanel>