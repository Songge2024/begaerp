<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<%-- <aos:gridpanel 
	id="templetProcess_grid" 
	url="templetProcessService.page" 
	
	forceFit="true"
 	region="center"
  	bodyBorder="1 0 1 0"
  	onitemclick="process_grid_click"
  	columnLines="true"
  	onitemdblclick="templetProcess_win_show"
  >
  <!-- onrender="templetProcess_query"  -->
	<%@ include file="templetProcess_menu.jsp"%>
	<%@ include file="templetProcess_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
	<aos:column type="rowno" align="center" />
	<%@ include file="templetProcess_columns.jsp"%>
</aos:gridpanel> --%>


<aos:treepanel id="templet_module" region="west" bodyBorder="0 1 0 0" singleClick="false" rootVisible="false"  
	url="templetProcessService.getProcessListTreeData" onitemclick="processFiletype_query" cascade="true">
	<%@ include file="templetProcess_menu.jsp"%>
	<%@ include file="templetProcess_docked.jsp"%>
	<aos:selmodel type="checkbox" mode="multi" />
</aos:treepanel>
 
<script type="text/javascript">
//单击
function process_grid_click() {
	var select = AOS.select(templet_grid);
	//var selectProcess = AOS.select(templetProcess_grid);
	var templet_id = select[0].data.templet_id;
	var temp_proc_id = AOS.selectone(templet_module).raw.id;
	var rootdir_id = AOS.selectone(templet_module).raw.parentId;
	var subdir_id = AOS.selectone(templet_module).raw.a;
	var	params={templet_id : templet_id,temp_proc_id : temp_proc_id};
	templetFiletype_grid_store.getProxy().extraParams = params;
	templetFiletype_grid_store.loadPage(1);
	filetype_id_store.getProxy().extraParams = {
		rootdir_id : rootdir_id,
		subdir_id : subdir_id
	};
	filetype_id_store.load();
}


//根据选择项目名称刷新树和grid
 function tree_grid_refresh() {
	//获取选中的项目ID
	var templet_id = AOS.select(templet_grid)[0].data.templet_id;
	if(AOS.empty(templet_id)){
		return;
	}
	templet_module_store.load({
		params:{
			templet_id : templet_id
		},
		callback : function() {
			templet_module.getSelectionModel().select(templet_module.getRootNode());
			processFiletype_query();
		}
	});
	
	//加载文件类型列表
	
	
}


//文件类型查询
function processFiletype_query() {
	//获取项目ID
	var templet_id = AOS.select(templet_grid)[0].data.templet_id;
	if(AOS.empty(templet_id)){ 
		return; 
	}
	
	//获取项目过程树节点
	var record = AOS.selectone(templet_module);
	if(!AOS.empty(record)){
		if(record.raw.a==undefined&&record.raw.b==undefined){
			var params={templet_id : templet_id}
		}else if(record.raw.a==undefined&&record.raw.b!=undefined){
			var params={templet_id : templet_id}
			params.rootdir_id = record.raw.b;
		}else{
		var params = { templet_id : templet_id };
 		params.subdir_id = record.raw.a;
 		params.temp_proc_id = record.raw.id;
		}
	}
	var rootdir_id = AOS.selectone(templet_module).raw.parentId;
	var subdir_id = AOS.selectone(templet_module).raw.a;
	templetFiletype_grid_store.getProxy().extraParams = params;
	templetFiletype_grid_store.loadPage(1);
	filetype_id_store.getProxy().extraParams = {
		rootdir_id : rootdir_id,
		subdir_id : subdir_id
	};
	filetype_id_store.load();
  	//加载文件列表
	//processFileUploadByProc_query();
} 
</script>