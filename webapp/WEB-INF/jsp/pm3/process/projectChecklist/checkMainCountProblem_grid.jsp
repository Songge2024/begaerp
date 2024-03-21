<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="checkMainCountProblem_grid" 
	url="checkMainService.problemCount" 
 	region="center"
  	bodyBorder="1 0 1 0"
  	features="summary"
  >
    <aos:docked forceBoder="1 0 1 0">
		<aos:dockeditem xtype="tbtext" text="检查单汇总表" />
		<aos:dockeditem xtype="tbseparator" />
	</aos:docked>
	<aos:plugins>
	</aos:plugins> 
	<aos:column type="rowno" />
	<%@ include file="checkMainCountProblem_columns.jsp"%>
</aos:gridpanel>