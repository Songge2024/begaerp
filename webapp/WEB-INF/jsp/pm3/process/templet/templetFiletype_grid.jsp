<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="templetFiletype_grid" 
	url="templetFiletypeService.page" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	columnLines="true"
  	onitemdblclick="templetFiletype_win_show"	
  	  >
  	  <%-- onrender="templetFiletype_query"  --%>
	<%@ include file="templetFiletype_menu.jsp"%>
	<%@ include file="templetFiletype_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" align="center"/>
	<%@ include file="templetFiletype_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">

</script>