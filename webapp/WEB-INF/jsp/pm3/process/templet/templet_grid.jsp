<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="templet_grid" 
	url="templetMainService.page" 
	onrender="templet_query" 
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="tree_grid_refresh"
  	onitemdblclick="templet_win_show"
  	columnLines="true"
  	autoLoad="true"
  	hidePagebar="true"
  >
	<%@ include file="templet_menu.jsp"%>
	<%@ include file="templet_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" align="center" />
	<%@ include file="templet_columns.jsp"%>
</aos:gridpanel>
<script type="text/javascript">

//单击
function templet_grid_click() {
	var select = AOS.select(templet_grid);
	var templet_id = select[0].data.templet_id;
	var params={templet_id : templet_id };
	templetProcess_grid_store.getProxy().extraParams = params;
	templetProcess_grid_store.loadPage(1);
	templetFiletype_grid_store.getProxy().extraParams = params;
	templetFiletype_grid_store.loadPage(1);
}



//state状态转换
	function fn_state_render(value, metaData, record) {
			if (value == '1') {
				metaData.style = 'color:#CC0000';
				return '未启用';
			} else if (value == '2') {
				metaData.style = 'color:green';
				return '已启用';
			} else if (value == '0'){
				return '已作废';
			}
}

</script>