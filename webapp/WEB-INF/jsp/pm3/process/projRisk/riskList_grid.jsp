<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:gridpanel 
	id="riskList_grid" 
	url="riskListService.page" 
	columnLines="true"
	forceFit="false"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemdblclick="riskList_win_show"
  >
 <!--  onrender="riskList_query"  -->
	<%@ include file="riskList_menu.jsp"%>
	<%@ include file="riskList_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" />
	<%@ include file="riskList_columns.jsp"%>
</aos:gridpanel>

<script type="text/javascript">
//启用状态颜色改变
function fn_probability_render(value, metaData, record) {
	var val = value;
	return val;
	
}

//启用状态颜色改变
function fn_open_render(value, metaData, record) {
	if (value == '1'){
		metaData.style = 'color:green';
		return '开放';
	}
	if (value == '0'){
		metaData.style = 'color:#CC0000';
		return '关闭';
	}
	
}

function fn_influe_render(value, metaData, record) {
	if (value == '4'){
		metaData.style = 'color:#CD5C5C';
		return '极大';
	}
	if (value == '3'){
		metaData.style = 'color:red';
		return '大';
	}
	if (value == '2'){
		metaData.style = 'color:blue';
		return '中';
	}
	
	if (value == '1'){
		metaData.style = 'color:green';
		return '小';
	}
	
}

function fn_level_render(value, metaData, record) {
	
	if (value == '3'){
		metaData.style = 'color:red';
		return '高';
	}
	if (value == '2'){
		metaData.style = 'color:blue';
		return '中';
	}
	
	if (value == '1'){
		metaData.style = 'color:green';
		return '低';
	}
	
}
</script>