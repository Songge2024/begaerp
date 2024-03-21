<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="riskCatalog_grid" 
	url="riskCatalogService.page" 
	onrender="riskCatalog_query" 
	forceFit="true"
 	region="center"
 	onitemdblclick="riskCatalog_win_show"
  	bodyBorder="1 0 1 0"
  	columnLines="true"
  >
	<%@ include file="riskCatalog_menu.jsp"%>
	<%@ include file="riskCatalog_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="riskCatalog_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">
//启用状态颜色改变
function fn_state_render(value, metaData, record) {
	if (value == '0') {
		metaData.style = 'color:#CC0000';
		return '未启用';
	} else if (value == '1') {
		metaData.style = 'color:green';
		return '已启用';
	} else if (value == '-1'){
		return '已作废';
	}
}
</script>